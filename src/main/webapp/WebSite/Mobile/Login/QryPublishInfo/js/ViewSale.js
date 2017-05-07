app.controller('ViewSaleController', function ($scope,$timeout,$route,$interval,rentSvc,SaleSvc,PicSvc,published,regionSvc,busDealInfo,busPublishInfo,PicUrl,SYS_CODE_CON,sysCodeTranslateFactory,IssuSvc) {
	
	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
	    
	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	 
	 $scope.id = $route.current.params.id;
	 $scope.infoType = $route.current.params.infoType;
	 $scope.back = function(){
		 if($route.current.params.numb==1){
			 var urlStr = "#/homePage/";
				window.location.href = urlStr; 
		 	}else{
			 var urlStr = "/WebSite/Mobile/Index.jsp#/ViewSaleList/2";
				window.location.href = urlStr; 
		 }
	 }
	 
	  $scope.userInfo = {};
	    $scope.userInfo.orgCode=SYS_USER_INFO.code;
	    $scope.userInfo.orgId=SYS_USER_INFO.orgId;
	    $scope.userInfo.orgName =  SYS_USER_INFO.orgName;
	    $scope.userInfo.orgParentCode = SYS_USER_INFO.orgParentCode;
	    $scope.userInfo.loginUserId = SYS_USER_INFO.loginUserId;
	    $scope.userInfo.orgLevel =  SYS_USER_INFO.orgLevel;
      
     
    /*
     * 查询test数据
     */
    $scope.queryviewData = function () {
    	window.scrollTo(0,0);
        function qSucc(rec) {
            $scope.addCount();
            $scope.MyButton();
            $scope.viewList = rec.issueInfo;
            $scope.viewList.managerId = rec.issueInfo.managerId;
            
            $scope.viewList.viewCount = rec.issueInfo.viewCount; 
            if($scope.viewList.viewCount==null){
            	$scope.viewList.viewCount = 1;
            }
            
        	if($scope.userInfo.loginUserId==$scope.viewList.managerId){
		     		   $scope.reveal=1;
		         }else{
		         	$scope.reveal=2;
		         }
            
            $scope.dealCount = rec.dealCount; //意向承租人数
            $scope.depName = rec.depName;//最终承租人
            $scope.equState = rec.equState; //设备状态
            
            $("#rePayMsg").get(0).innerHTML = $scope.viewList.detailedDescription;
            if(rec.issueInfo.priceType==null){
            	$scope.viewList.priceType=1;
            }
            $scope.viewList.atCity = rec.issueInfo.atCity;
        	//所在城市
         	if(rec.issueInfo.atCity == null ){
         		$scope.viewList.atCity = "全国";
         	}
        	
        
            if($scope.viewList.equipmentPic){
            	
                $scope.pic = $scope.viewList.equipmentPic.split(',');//分割逗号，因本没逗号所以把整个值放入数组pic
                
                $scope.PicList = [];
                for ( var i = 0; i < $scope.pic.length; i++) {
                    var fullname = $scope.pic[i].split('.');//截去点号，为前半段图片名和后半段类型名
                    $scope.PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};//把两个值分别和一个key匹配放入一个对象内
                    $scope.PicList.push($scope.PicOne);
                    $scope.PicUrl = PicUrl;
                    $scope.PicSrc=$scope.PicUrl+"/"+$scope.PicList[i].PicName+"."+$scope.PicList[i].PicType; //拼出一个链接
                };
                $scope.PicSrc=$scope.PicUrl+"/"+$scope.PicList[0].PicName+"."+$scope.PicList[0].PicType; //拼出一个链接
            }
            
        }
        	function qErr(rec) {}
        	published.unifydo({Action:"Sale"},{ parm: $scope.id}, qSucc, qErr);
    }; 
    $scope.queryviewData();
    /* 浏览次数 */
     $scope.addCount = function()
    {   
    	 function success(rec) {
         }
         function error(rec) {}
         published.addViewCount({ urlPath:$scope.id },success,error);
    };
        

    /*
     *我想要交易事件
     */
    $scope.addClick=function(parm){
     	function qSucc(rec){
         		alert("操作成功，您可以在“我的鲁班-我想交易的信息”功能中查看");
        			$scope.addButton='true';
        		    window.location.reload();
        			function qSucc(rec){
        				$scope.dealCount = rec.dealCount; //意向承租人数
              	}
              	function qErr(){}
            	published.unifydo({Action:"Sale"},{ parm: $scope.id}, qSucc, qErr);
        		}
     
     	function qErr(){};
     	
     	busDealInfo.put({ dataId:parm.dataId },qSucc,qErr);
     }; 
     
     $scope.newList=[];
     $scope.newDataId="";
     $scope.MyButton=function(){
    	 
		    $scope.newDataId =  $scope.id;
        	function qSucc(rec){
            	$scope.msg = rec.msg
            	$scope.addButton = $scope.msg;
                 if($scope.addButton=="TRUE"){
                 	$scope.addButton = true;
                 }
                 else
                 {
                 	 $scope.addButton = '';
                 } 
         }
        	function qErr(){}
        	
        	published.unifydo({Action:"BusDealInfo",dataId:$scope.newDataId, loginUserId: $scope.userInfo.loginUserId},qSucc,qErr);
     };    
    
});