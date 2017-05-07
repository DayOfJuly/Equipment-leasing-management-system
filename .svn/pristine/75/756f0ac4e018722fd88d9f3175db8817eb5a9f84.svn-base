app.controller('screenController',function($scope,published,$route,$interval,$timeout){

	
	$scope.screenDetail = eval("("+$route.current.params.screenList+")");
	
	if($scope.atCity){
		if($scope.atCity=="undefined"){
			$scope.city = 1;
		}else{
			$scope.city = 2;
		}
	}else{
		$scope.city = 1;
	}
	
	
	
	$scope.brandShow = 1;
	$scope.brandNames = [];
	if($scope.screenDetail){
		if($scope.screenDetail.onCity){
			$scope.atCity = $scope.screenDetail.onCity
		}else{
			$scope.atCity = $scope.screenDetail.atCity;
		}
		$scope.minPrice = $scope.screenDetail.minPrice;
		$scope.maxPrice = $scope.screenDetail.maxPrice;
		$scope.myselect = $scope.screenDetail.myselect;
		
		if($route.current.params.id==1){
			$scope.brandName = $scope.screenDetail.brand;
			$scope.brandNames = $scope.brandName.split(",");
		}else{
			$scope.brandNames = $scope.screenDetail.brand;
		}
		
		if($scope.brandNames[0]){
			$scope.brandShow = 2;
		}
		$scope.equName_ = $scope.screenDetail.equName_;
		if($scope.equName_=undefined){
			$scope.equName_="";
		}
		$scope.dataType = $scope.screenDetail.dataType;
		document.getElementById('minPrice').value = $scope.minPrice;
		document.getElementById('maxPrice').value = $scope.minPrice;
		document.getElementById('priceTypeId').value = $scope.myselect;
	}
	
	
	if(minPrice_){
		$scope.minPrice = minPrice_;
	}
	
	if(maxPrice_){
		$scope.maxPrice = maxPrice_;
	}

	var screenList= {};
	$scope.type_ = '';
	
	if($route.current.params.buttonValue){
		$scope.equName_ = $route.current.params.buttonValue;
	}
	
	if($route.current.params.id){
	      $scope.id = $route.current.params.id;
	      $scope.dataType = $route.current.params.id;
	      
	}
	
		
    if($route.current.params.screenList){
    	$scope.dataType =$scope.screenDetail.dataType;
    }else{
    	$scope.dataType = 1;
    }
    
	$scope.checkPrice = function(plagParm,n){
		var reg="^\\d+$";
		if(n!=null&&!isNaN(n)){
			n=Number(n);
		}else{
			n=null;
		}
		if(plagParm){
			if(n == null || n ==""){
				$scope.minPrice = n;
				return;
			}
			if($scope.maxPrice == null || $scope.maxPrice == ""){
				$scope.minPrice = n;
			}else{
				if(n < $scope.maxPrice){
					$scope.minPrice = n;
					}else{
						$scope.minPrice = null;
						alert("不能大于等于上限");
					}
			}
		}else{
			if(n == null || n ==""){
				$scope.maxPrice = n;
				return;
			}
			if($scope.minPrice == null && $scope.minPrice == ""){
				$scope.maxPrice = n;
			}else{
				if(n > $scope.minPrice){
					$scope.maxPrice = n;
				}else{
					if($scope.minPrice!=null){
						$scope.maxPrice=null;
						alert("不能小于等于下限");
					}
				}
			}
		}
	}

	$scope.myVar = true;
	$scope.revel = false;
	$scope.facility = true;
	
	var gotoParm_ = '';//种类
	var parm_url = '';//url名字
	
	if(equipmentName_.atCity){
		$scope.atCity = equipmentName_.atCity;
	}
	if(equipmentName_.brand){
		$scope.brand = equipmentName_.brand;
	}
	
	if(equipmentName_.name){
		$scope.dataType = equipmentName_.name;
		$scope.id = equipmentName_.name;
	}
	//设备名称
	$scope.gotoQueryPageFun = function(param){
		 if(!$scope.id){
			 $scope.id = 1;	
		 }
		 if(param.atCity){
			  equipmentName_.atCity = param.atCity;
		}
	
		  if(param.brandNames){
			  equipmentName_.brand = param.brand;
			
		  }
	
		  if(param.dataType){
			  equipmentName_.name =  $scope.id;
			 
		  }
		  
		  if(param.minPrice){
			  minPrice_ = $scope.minPrice;
			  
		  }
		  
		  if(param.maxPrice){
			  maxPrice_ = $scope.maxPrice;
			  
		  }
		  if(param.myselect){
			  screenName.myselect = param.myselect;
		  }
		  
		  // var screenName = JSON.stringify(screenName); 
		   
		if($scope.id && $scope.id == 1){
			gotoParm_ = 1;
			parm_url = 'Screen';
			window.location.href="/WebSite/Mobile/Index.jsp#/search/"+parm_url+"/"+gotoParm_;
		}else if($scope.id &&  $scope.id == 2){
			gotoParm_ = 2;
			parm_url = 'Screen';
			window.location.href="/WebSite/Mobile/Index.jsp#/search/"+parm_url+"/"+gotoParm_;
		}else if($scope.id && $scope.id == 3){
			gotoParm_ = 3;
			parm_url = 'Screen';
			window.location.href="/WebSite/Mobile/Index.jsp#/search/"+parm_url+"/"+gotoParm_;
		}else if($scope.id && $scope.id == 4){
			gotoParm_ = 4;
			parm_url = 'Screen';
			window.location.href="/WebSite/Mobile/Index.jsp#/search/"+parm_url+"/"+gotoParm_;
		} 
	};
	//选择类型
	$scope.toggle = function(parm) {
       $scope.id = parm;
      if($scope.id==1){
    		$scope.myVar=!$scope.myVar;
           	$scope.revel = !$scope.revel;
           	$scope.facility = !$scope.facility;
    	  document.getElementById("valShow").innerHTML= "出租";
      }
      if($scope.id==3){
    		$scope.myVar=!$scope.myVar;
           	$scope.revel = !$scope.revel;
           	$scope.facility = !$scope.facility;
    	  document.getElementById("valShow").innerHTML = "求租";
      }
      if($scope.id==4){
    		$scope.myVar=!$scope.myVar;
           	$scope.revel = !$scope.revel;
    	  document.getElementById("valShow").innerHTML = "求购";
      }
       if($scope.id==2){
       	$scope.myVar=!$scope.myVar;
       	$scope.revel = !$scope.revel;
       	document.getElementById("valShow").innerHTML= "出售";
       }
   };	
	//选择城市
   $scope.selectAtCity = function(param){
	   if($scope.id){
		   $scope.dataType = $scope.id;
	   }else{
		   $scope.dataType = 1;
	   }
	   $scope.minPrice = document.getElementById('minPrice').value;
	   $scope.maxPrice = document.getElementById('maxPrice').value;
	   $scope.myselect = document.getElementById("priceTypeId").value;
	   var screenListStr = "";
	   screenListStr = screenListStr + ($scope.minPrice ? $scope.minPrice : "") + "~|~";
	   screenListStr = screenListStr + ($scope.maxPrice ? $scope.maxPrice : "") + "~|~";
	   screenListStr = screenListStr + ($scope.myselect ? $scope.myselect : "") + "~|~";
	   screenListStr = screenListStr + $scope.dataType + "~|~";
	   screenListStr = screenListStr + $scope.atCity + "~|~";
	   screenListStr = screenListStr + $scope.equName_+"~|~";
	   screenListStr = screenListStr + $scope.brandNames;
	   
	   
	   var urlStr = "/WebSite/Mobile/General/HomePage/Atcity.jsp?screenList="+screenListStr;
	   window.location.href = urlStr;
	  
   }
   //选择品牌
   $scope.selectBrand = function(param){
	   if($scope.id){
		   $scope.dataType = $scope.id;
	   }else{
		   $scope.dataType = 1;
	   }
	   $scope.minPrice = document.getElementById('minPrice').value;
	   $scope.maxPrice = document.getElementById('maxPrice').value;
	   $scope.myselect = document.getElementById("priceTypeId").value;
	   var screenBrand = "";
	   screenBrand = screenBrand + ($scope.minPrice ? $scope.minPrice : "") + "~|~";
	   screenBrand = screenBrand + ($scope.maxPrice ? $scope.maxPrice : "") + "~|~";
	   screenBrand = screenBrand + ($scope.myselect ? $scope.myselect : "") + "~|~";
	   screenBrand = screenBrand + $scope.dataType + "~|~";
	   screenBrand = screenBrand + $scope.atCity + "~|~";
	   screenBrand = screenBrand +($scope.equName_ ? $scope.equName_ : "")+"~|~";
	   screenBrand = screenBrand + $scope.brand;
		  var urlStr = "/WebSite/Mobile/General/HomePage/Brand.jsp?screenList="+screenBrand;
		  window.location.href = urlStr; 
}
   
   //清空
   $scope.empty = function(rec){
	   
	   var urlStr = "/WebSite/Mobile/Index.jsp#/Screen/";
	   window.location.href = urlStr; 
		   $scope.atCity = "";
	  
	   $scope.brand  = "";
	   
	   $scope.dataType  = 1;
	   
	   $scope.equName_  = "";
	   $scope.minPrice  = "";
	   $scope.maxPrice = "";
	
	   
   }
   
   //确定
   $scope.confirm = function(param){
	   if($scope.id){
		   $scope.dataType = $scope.id;
	   }else{
		   $scope.dataType = 1;
	   }
	   $scope.minPrice = document.getElementById('minPrice').value;
	   $scope.maxPrice = document.getElementById('maxPrice').value;
	   $scope.myselect = document.getElementById("priceTypeId").value;
	   screenList.minPrice = $scope.minPrice;
	   screenList.maxPrice = $scope.maxPrice;
	   screenList.myselect = $scope.myselect;
	   screenList.dataType = $scope.dataType;
	   screenList.atCity = $scope.atCity;
	   screenList.equName_ = $scope.equName_;
	   screenList.brand = $scope.brandNames;
	   
	   var screen = JSON.stringify(screenList); 
	   if(screenList.dataType==1){
		   var urlStr = "/WebSite/Mobile/Index.jsp#/viewRentList/"+screen+"/"+screenList.dataType+"/"+screenList.dataType;
		   window.location.href = urlStr; 
	   }
	   if(screenList.dataType==2){
		   var urlStr = "/WebSite/Mobile/Index.jsp#/ViewSaleList/"+screen+"/"+screenList.dataType+"/"+screenList.dataType;
		   window.location.href = urlStr; 
	   }
	   if(screenList.dataType==3){
		   var urlStr = "/WebSite/Mobile/Index.jsp#/ViewDemandRentList/"+screen+"/"+screenList.dataType+"/"+screenList.dataType;
		   window.location.href = urlStr; 
	   }
	   if(screenList.dataType==4){
		   var urlStr = "/WebSite/Mobile/Index.jsp#/ViewDemandSaleList/"+screen+"/"+screenList.dataType+"/"+screenList.dataType;
		   window.location.href = urlStr; 
	   }
   }
});