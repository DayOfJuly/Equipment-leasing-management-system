app.controller('ViewDemandSaleController', function ($scope,$timeout,$route,$interval,rentSvc,SaleSvc,PicSvc,published,regionSvc,busDealInfo,busPublishInfo,PicUrl,SYS_CODE_CON,sysCodeTranslateFactory,IssuSvc) {
        	
        	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
        	    
        	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
        	 
        	 $scope.id = $route.current.params.id;
        	 $scope.infoType = $route.current.params.infoType;
        	 $scope.back = function(){
        		 if($route.current.params.numb==1){
        			 var urlStr = "#/homePage/";
     				window.location.href = urlStr; 
	              }else{
	             	var urlStr = "/WebSite/Mobile/Index.jsp#/ViewDemandSaleList/4";
	     				window.location.href = urlStr; 
	              }   
        	 }
        	 
        	 
             $scope.queryviewData = function () {
            	 window.scrollTo(0,0);
                 function qSucc(rec){
                 	 $scope.addCount();
                    
                 	$scope.viewList = rec.issueInfo;
                 	
                     $scope.viewList.managerId = rec.issueInfo.managerId;
                 /*	if($scope.userCookies.loginUserId==$scope.viewList.managerId){
                 		   $scope.reveal=1;
                     }else{
                     	$scope.reveal=2;
                     }*/
                 	
                 	$scope.viewList.atCity = rec.issueInfo.atCity;
                 	//所在城市
                  	if(rec.issueInfo.atCity == null ){
                  		$scope.viewList.atCity = "全国";
                  	}
                 	
                 	$("#rePayMsg").get(0).innerHTML = $scope.viewList.detailedDescription;
                     
                     $scope.viewList.viewCount = rec.issueInfo.viewCount; //浏览次数 
                     if($scope.viewList.viewCount==null){
                     	  $scope.viewList.viewCount=1;
                     }
                     $scope.dealCount = rec.dealCount; //意向承租人数
                     $scope.depName = rec.depName;//最终承租人
                     $scope.equState = rec.equState; //设备状态
                     
                 	
                     if(rec.issueInfo.priceType==null){
                     	$scope.viewList.priceType=1;
                     }
                     
                 }
                 function qErr(rec) { } 
                 
                 published.unifydo({Action:"DemandSale"},{parm:$scope.id}, qSucc, qErr);
             };
             $scope.queryviewData();
            /* 浏览次数 */
             $scope.addCount = function(){   
            	 function success(rec) {}
                 function error(rec) {}
                 published.addViewCount({ urlPath:$scope.id },success,error);
            };
                
        });