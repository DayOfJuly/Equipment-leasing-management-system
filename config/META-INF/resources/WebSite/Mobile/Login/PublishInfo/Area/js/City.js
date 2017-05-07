app.controller('CityController', function($scope,$route,regionSvc) {
	
	$scope.goBack={};//接收返回上一级
	
    $scope.initQueryCitiesFun=function(){
    	
    	if($route.current.params.obj_type && $route.current.params.obj_type.length == 1){
    		$scope.goBack.type_ =  $route.current.params.obj_type;//拿到返回用的种类
    	}
    	if($route.current.params.parms_url){
    		$scope.goBack.url_  =  $route.current.params.parms_url;//拿到返回用的url
    	}
    	
    	
    	function aSucc(rec){
			$scope.cityList=[];
			$scope.cityList=rec;
		}
		function aErr(rec){}
		regionSvc.queryRegionArea({regionId:$route.current.params.proRegionId}, aSucc,aErr);
    };
    /**
     * 点击某一城市携带参数跳转到区县页面
     */
    $scope.toSelectCityFun = function(parm,url_){
    	$scope.changeCity(parm,url_);
    };

    
    /*
	 *城市
	*/
	$scope.changeCity=function(parm,url_){
		
		var cityRegionId = "";
		var pId = $route.current.params.proRegionId;//省的id
		var pName =$route.current.params.provincesName;//省的name
		if($route.current.params.obj_type && $route.current.params.obj_type.length == 1){
			var obj_type = $route.current.params.obj_type;//保存的主页种类
		}
		
		var parms_url = $route.current.params.parms_url//保存的主页路径
		
		for(var i=0;i<$scope.cityList.length;i++){
			if($scope.cityList[i].name==parm){
				cityRegionId=$scope.cityList[i].regionId;
				var cityName = $route.current.params.provincesName + "-" + parm ;
				if($route.current.params.obj_type && $route.current.params.obj_type.length == 1){
					window.location.href=url_+"/"+cityRegionId+"/"+cityName+"/"+pId+"/"+pName+'/'+obj_type+'/'+parms_url;
				}else{
					window.location.href=url_+"/"+cityRegionId+"/"+cityName+"/"+pId+"/"+pName+'/'+parms_url;
				}
				break;
			}
		}
		
	};
});