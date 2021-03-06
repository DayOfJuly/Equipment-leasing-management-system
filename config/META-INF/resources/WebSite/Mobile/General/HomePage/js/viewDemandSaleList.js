app.controller('ViewDemandSaleListController',function($scope,$route,published,IssuSvc){
	
	$scope.screenList = eval("("+$route.current.params.screenList+")");
	$scope.numb = $route.current.params.name;
	$scope.screenName = $route.current.params;
	$scope.formParms = {};//input框变量
	   $scope.pageNo=0;
	   $scope.pageSize = 5;
		$scope.search = function(prarm){
			$scope.screenName.buttonValue = document.getElementById('custNamePre').value
				$scope.saveParams = {};
					$scope.saveParams.dataType = 1;
					$scope.saveParams.equName = $scope.screenName.buttonValue;
					$scope.saveParams.priceOrder = 0;
				
				$scope.saveParams.pageSize = $scope.pageSize;
				$scope.saveParams.pageNo = $scope.pageNo;
				function qSucc(rec){
					$scope.DemandSaleList=rec.content;
					if($scope.DemandSaleList == 0){
						$scope.available = true;
					}
					$scope.getFirstPic($scope.DemandSaleList);
					setTimeout(function listenWord(){
						// 滑动监听 start 
						var sf = new scrollFactory();
						sf.loadData=function(){
							$scope.pageSize=$scope.pageSize+2;
							$scope.search(0);
						};
						sf.scrollListener(document.getElementById("demanList"));
						 //滑动监听 end 
						}, 500);
				}
				function qErr(rec){}
				IssuSvc.post({Action:"GetAll"},$scope.saveParams,qSucc,qErr);
		}
	
		//查询列表
		$scope.allList = function(pram){
			function qSucc(rec){
				$scope.DemandSaleList=rec.content;
				if(rec.content.length == 0){
					$.messager.popup("没有符合条件的纪录");
				}
				setTimeout(function listenWord(){
					
					// 滑动监听 start 
					var sf = new scrollFactory();
					sf.loadData=function(){
						$scope.pageSize=$scope.pageSize+2;
						$scope.allList(0);
					};
					sf.scrollListener(document.getElementById("demanList"));
					 //滑动监听 end 
					}, 500);
				
			}
			function qErr(rec){}
			IssuSvc.post({Action:"GetAll"},{dataType:4,priceOrder:pram,pageNo:$scope.pageNo,pageSize:$scope.pageSize},qSucc,qErr);
			}
	   
	if($scope.screenName.buttonValue){
		$scope.nameList = function(rec){
			$scope.price = rec;
			if($route.current.params.id && $route.current.params.buttonValue){
				$scope.formParms.dataType = $route.current.params.id;//如果有搜索传递参数就直接赋值在输入框变量
				$scope.formParms.queryName = $route.current.params.buttonValue;
				$scope.screenName = function(pram){
					function qSucc(rec){
						$scope.price = rec;
						$scope.DemandSaleList=rec.content;
						if($scope.DemandSaleList == 0){
							$scope.available = true;
						}
						setTimeout(function listenWord(){
							// 滑动监听 start 
							var sf = new scrollFactory();
							sf.loadData=function(){
								$scope.pageSize=$scope.pageSize+2;
								$scope.screenName($scope.price);
							};
							sf.scrollListener(document.getElementById("demanList"));
							 //滑动监听 end 
							}, 500);
					}
					function qErr(rec){}
					IssuSvc.post({Action:"GetAll"},{dataType:$scope.formParms.dataType,equName:$scope.formParms.queryName,pageNo:$scope.pageNo,pageSize:$scope.pageSize,priceOrder:pram},qSucc,qErr);
				}
				$scope.screenName($scope.price);
			}
		}
		$scope.nameList($scope.price);
	}else{
		if($scope.screenList){
			//筛选查询
			$scope.screen = function(pram){
				$scope.saveParams = {};
				if($scope.screenList.atCity){
					$scope.saveParams.onCity = $scope.screenList.atCity;
				}
					$scope.saveParams.brandNames = $scope.screenList.brand;
				if($scope.screenList.dataType){
					$scope.saveParams.dataType = $scope.screenList.dataType;
				}
				if($scope.screenList.equName_){
					$scope.saveParams.equName = $scope.screenList.equName_;
				}
				if($scope.screenList.maxPrice){
					$scope.saveParams.maxPrice = $scope.screenList.maxPrice;
				}
				if($scope.screenList.minPrice){
					$scope.saveParams.minPrice = $scope.screenList.minPrice;
				}
				$scope.saveParams.priceOrder = pram;
				$scope.saveParams.pageNo = $scope.pageNo;
				$scope.saveParams.pageSize = $scope.pageSize;
				function qSucc(rec){
					$scope.DemandSaleList=rec.content;
					if($scope.DemandSaleList == 0){
						$scope.available = true;
					}
					setTimeout(function listenWord(){
						// 滑动监听 start 
						var sf = new scrollFactory();
						sf.loadData=function(){
							$scope.pageSize=$scope.pageSize+2;
							$scope.screen(0);
						};
						sf.scrollListener(document.getElementById("demanList"));
						 //滑动监听 end 
						}, 500);
				}
				function qErr(rec){}
				IssuSvc.post({Action:"GetAll"},$scope.saveParams,qSucc,qErr);
			}
			$scope.screen(0);
		}else{
			$scope.allList(0);
		}
	}

		
	$scope.jump = function(parm){
		if(SYS_USER_INFO.orgId){
			var urlStr = "#/ViewDemandSaleInfo/" + parm.r.dataId + "/" + parm.r.dataType;
			window.location.href = urlStr; 
		}else{
			var urlStr = "#/ViewDemandSale/" + parm.r.dataId + "/" + parm.r.dataType;
			window.location.href = urlStr; 
		}
	}

	$scope.myVar = true;
	$scope.revel = false;
	$scope.toggle = function(parm) {
       $scope.id = parm;
      if($scope.id==1){
   	   var urlStr = "#/viewRentList/" + $scope.id ;
   	   window.location.href = urlStr; 
      }
      if($scope.id==3){
   	   var urlStr = "#/ViewDemandRentList/" + $scope.id ;
   	   window.location.href = urlStr; 
      }
      if($scope.id==2){
   	   var urlStr = "#/ViewSaleList/" + $scope.id ;
   	   window.location.href = urlStr; 
      }
       if($scope.id==4){
       	$scope.myVar=!$scope.myVar;
       	$scope.revel = !$scope.revel;
       }
   };	
	
	$scope.selection = function(){
		if($scope.numb == 4){
			$scope.screenStr = {};
			if($scope.screenList.atCity){
				$scope.screenStr.onCity = $scope.screenList.atCity;
			}
			if($scope.screenList.brand){
				$scope.screenStr.brand = $scope.screenList.brand;
			}
			if($scope.screenList.dataType){
				$scope.screenStr.dataType = 4;
			}
			if($scope.screenList.maxPrice){
				$scope.screenStr.maxPrice = $scope.screenList.maxPrice;
			}
			if($scope.screenList.minPrice){
				$scope.screenStr.minPrice = $scope.screenList.minPrice;
			}
			if($scope.screenList.equName_){
				$scope.screenStr.equName_ = $scope.screenList.equName_;
			}
			var scre = JSON.stringify($scope.screenStr); 
			var urlStr = "/WebSite/Mobile/Index.jsp#/Scree/"+scre;
			 window.location.href = urlStr; 
		}else{
			 var urlStr = "/WebSite/Mobile/Index.jsp#/Screen";
			 window.location.href = urlStr;
		}
	}
   
	 $scope.priceUp = false;
	 $scope.priceDown = true;
	$scope.priceOrder = function(rec){
		$scope.priceDown = !$scope.priceDown;
   	$scope.priceUp = !$scope.priceUp;
   	
   	if(rec == 1){
   		$scope.price = 1;
   	}
   	if(rec == 2){
   		$scope.price = 0;
   	}
 	if(document.getElementById('custNamePre').value){
		$scope.nameList($scope.price);
	}else{
		if(!$scope.screenList){
	   		$scope.allList($scope.price);
	   	}
	   	if($scope.screenList){
	   		$scope.screen($scope.price);
	   	}
	}
   	
   
	}
	
	$scope.returnList = function(){
		 if($scope.price==1||$scope.price==0){
				location.reload();
			}
		if($scope.numb==3 || $scope.screenList　|| $scope.screenName.buttonValue){
			window.location.href="/WebSite/Mobile/Index.jsp#/ViewDemandSaleList/4";
			}
		
	}
	$scope.goToSearch = function(){
		
		var parm_url = 'DemandSale';
		window.location.href="/WebSite/Mobile/Index.jsp#/search/"+parm_url;
	};
});