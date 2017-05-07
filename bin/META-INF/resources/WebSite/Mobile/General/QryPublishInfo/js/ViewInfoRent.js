app.controller('ViewInfoRentController', function ($scope,$timeout,$route,$interval,rentSvc,SaleSvc,PicSvc,published,regionSvc,busDealInfo,busPublishInfo,PicUrl,SYS_CODE_CON,sysCodeTranslateFactory,IssuSvc) {
        	
        	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
        	    
        	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
        	 
        	 $scope.id = $route.current.params.id;
        	 $scope.infoType = $route.current.params.infoType;
        	 
        	 $scope.back = function(){
        		 if($route.current.params.numb==1){
        			var urlStr = "#/homePage/";
     				window.location.href = urlStr; 
                 }else{
                	var urlStr = "/WebSite/Mobile/Index.jsp#/ViewDemandRentList/3";
      				window.location.href = urlStr; 
                 }   
        	 }
            
            /*
             * 查询test数据
             */
            $scope.queryviewData = function () {
            	 window.scrollTo(0,0);
                function qSucc(rec) {
                    $scope.addCount();
                    $scope.viewList = rec.issueInfo;
                    $scope.viewList.managerId = rec.issueInfo.managerId;
                    
                	$scope.equipmentAscriptionTable = $scope.viewList.equipmentTable.equipmentAscriptionTable[0];
                	$scope.party = $scope.equipmentAscriptionTable.party;
                	$scope.viewList.name = $scope.party.name;
                	
                    
                    $scope.viewList.viewCount = rec.issueInfo.viewCount; 
                    if($scope.viewList.viewCount==null){
                    	$scope.viewList.viewCount = 1;
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
                	published.unifydo({Action:"Rent"},{ parm: $scope.id}, qSucc, qErr);
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
                
        });