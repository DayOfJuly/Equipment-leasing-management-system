app.controller('ViewSaleListController',function($scope,$route,published,PicUrl,IssuSvc){

	$scope.pageNo=0;
	$scope.pageSize=5;
	
	$scope.screenList = eval("("+$route.current.params.screenList+")");	
	$scope.numb = $route.current.params.name;
	$scope.screenName = $route.current.params;
	$scope.formParms = {};//input框变量
	
	
	$scope.allList = function(pram){
		function qSucc(rec){
			$scope.sresultList=rec.content;
			$scope.getFirstPic($scope.sresultList);
			setTimeout(function listenWord(){
				// 滑动监听 start 
				var sf = new scrollFactory();
				sf.loadData=function(){
					$scope.pageSize=$scope.pageSize+2;
					$scope.allList(0);
				};
				sf.scrollListener(document.getElementById("saleList"));
				 //滑动监听 end 
				}, 500);
		}
		function qErr(rec){}
		//初始化最新出租信息
		IssuSvc.post({Action:"GetAll"},{dataType:2,priceOrder:pram,pageNo:$scope.pageNo,pageSize:$scope.pageSize},qSucc,qErr);
	};
	
	if($scope.screenName.buttonValue){
		$scope.nameList = function(rec){
			$scope.price = rec;
			if($route.current.params.id && $route.current.params.buttonValue){
				$scope.formParms.dataType = $route.current.params.id;//如果有搜索传递参数就直接赋值在输入框变量
				$scope.formParms.queryName = $route.current.params.buttonValue;
				$scope.screenName = function(pram){
					function qSucc(rec){
						$scope.sresultList=rec.content;
						if($scope.sresultList == 0){
							$scope.available = true;
						}
						$scope.getFirstPic($scope.sresultList);
						setTimeout(function listenWord(){
							// 滑动监听 start 
							var sf = new scrollFactory();
							sf.loadData=function(){
								$scope.pageSize=$scope.pageSize+2;
								$scope.screenName(0);
							};
							sf.scrollListener(document.getElementById("saleList"));
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
		    $scope.screen = function(pram){
				$scope.saveParams = {};
				if($scope.screenList.atCity=undefined){
					$scope.saveParams.onCity ="";
				}
				
				if($scope.screenList.atCity){
					$scope.saveParams.onCity = $scope.screenList.atCity;
				}
				if($scope.screenList.equName_){
					$scope.saveParams.equName = $scope.screenList.equName_;
				}
					$scope.saveParams.brandNames = $scope.screenList.brand;
				if($scope.screenList.dataType){
					$scope.saveParams.dataType = $scope.screenList.dataType;
				}
				if($scope.screenList.maxPrice){
					$scope.saveParams.maxPrice = $scope.screenList.maxPrice;
				}
				if($scope.screenList.minPrice){
					$scope.saveParams.minPrice = $scope.screenList.minPrice;
				}
					$scope.saveParams.priceOrder = pram;
				
				$scope.saveParams.pageSize = $scope.pageSize;
				$scope.saveParams.pageNo = $scope.pageNo;
				function qSucc(rec){
					$scope.sresultList=rec.content;
					if($scope.sresultList == 0){
						$scope.available = true;
					}
					$scope.getFirstPic($scope.sresultList);
					setTimeout(function listenWord(){
						// 滑动监听 start 
						var sf = new scrollFactory();
						sf.loadData=function(){
							$scope.pageSize=$scope.pageSize+2;
							$scope.screen(0);
						};
						sf.scrollListener(document.getElementById("saleList"));
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
		if(!SYS_USER_INFO.orgId){
			var urlStr = "#/ViewInfoSale/" + parm.r.dataId + "/" + parm.r.dataType;
			window.location.href = urlStr; 
		}else{
			var urlStr = "#/ViewSale/" + parm.r.dataId + "/" + parm.r.dataType;
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
      if($scope.id==4){
   	   var urlStr = "#/ViewDemandSaleList/" + $scope.id ;
   	   window.location.href = urlStr; 
      }
       if($scope.id==2){
       	$scope.myVar=!$scope.myVar;
       	$scope.revel = !$scope.revel;
       }
   };	
   
	
	$scope.PicUrlName = PicUrl;
	//处理获取的list得到图片
	$scope.getFirstPic=function(list){
		if(list)/* 防止图片没刷出来的时候报length错误，当有list值的时候在执行下面的代码 */
		{
			for(var i=0;i<list.length;i++){
				if(list[i].equipmentPic!=null && list[i].equipmentPic!=""){
					var pic=list[i].equipmentPic.split(',');
					var fullname = pic[0].split('.');
					var PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};
					list[i].PicName=fullname[0];
					list[i].PicType=fullname[1];
				}else{
					list[i].PicName="18c07505-700d-4667-83df-cdf1465188ce";
					list[i].PicType="png";
				}
			}
		}
};
	
	$scope.selection = function(){
		if($scope.numb == 2){
			$scope.screenStr = {};
			if($scope.screenList.atCity){
				$scope.screenStr.onCity = $scope.screenList.atCity;
			}
			if($scope.screenList.brand){
				$scope.screenStr.brand = $scope.screenList.brand;
			}
			if($scope.screenList.dataType){
				$scope.screenStr.dataType = 2;
			}
			if($scope.screenList.maxPrice){
				$scope.screenStr.maxPrice = $scope.screenList.maxPrice;
			}
			if($scope.screenList.minPrice){
				$scope.screenStr.minPrice = $scope.screenList.minPrice;
			}
			if($scope.screenList.equName_){
				$scope.screenStr.equName = $scope.screenList.equName_;
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
			window.location.href="/WebSite/Mobile/Index.jsp#/ViewSaleList/2";
			}
		
	}
	
	
	$scope.search = function(prarm){
		$scope.screenName.buttonValue = document.getElementById('custNamePre').value
			$scope.saveParams = {};
				$scope.saveParams.dataType = 2;
				$scope.saveParams.equName = $scope.screenName.buttonValue;
				$scope.saveParams.priceOrder = 0;
			$scope.saveParams.pageSize = $scope.pageSize;
			$scope.saveParams.pageNo = $scope.pageNo;
			function qSucc(rec){
				$scope.sresultList=rec.content;
				if($scope.sresultList == 0){
					$scope.available = true;
				}
				$scope.getFirstPic($scope.sresultList);
				setTimeout(function listenWord(){
					// 滑动监听 start 
					var sf = new scrollFactory();
					sf.loadData=function(){
						$scope.pageSize=$scope.pageSize+2;
						$scope.search(0);
					};
					sf.scrollListener(document.getElementById("saleList"));
					 //滑动监听 end 
					}, 500);
			}
			function qErr(rec){}
			IssuSvc.post({Action:"GetAll"},$scope.saveParams,qSucc,qErr);
	}
	
	$scope.goToSearch = function(){
		var parm_url = 'Sale';
		window.location.href="/WebSite/Mobile/Index.jsp#/search/"+parm_url;
	};
	
});