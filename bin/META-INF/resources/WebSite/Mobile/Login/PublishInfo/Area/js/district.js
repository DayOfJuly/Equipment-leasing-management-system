app.controller('districtController', function($scope,$route,regionSvc) {
	$scope.submit_ ={};
	
	$scope.cityRegionId_ = $route.current.params.cityRegionId;
	$scope.cityName_ = $route.current.params.cityName;
	$scope.pId_ = $route.current.params.pId;
	$scope.pName_ = $route.current.params.pName;
	

	/*
	 *区县
	*/
	$scope.changeDis=function(parm,url_){
		var area = $route.current.params.cityName + "-" + parm;//拼接地区名字
		if(!$scope.submit_.type_){//判断是那种类别情况
			area_={saveParm:area};//出租出售情况下主页面显示的地区(所在城市）
		}else{
			if($scope.submit_.type_||$scope.submit_.type_.length == 1){
				area_Demand = {saveParm:area};//求租求购情况下主页面显示的地区（设备地点）
			}
		}
		window.location.href=url_;
	};
	
	
    $scope.initQueryDistrict=function(){
    	
    	$scope.submit_.url_= $route.current.params.parms_url;//用于返回使用路径
    	if($route.current.params.obj_type && $route.current.params.obj_type.length == 1){
    		$scope.submit_.type_ = $route.current.params.obj_type;
    	}
    	function aSucc(rec){
			$scope.districtList=[];
			$scope.districtList=rec;
		}
		function aErr(rec){}
		regionSvc.queryRegionArea({regionId:$route.current.params.cityRegionId}, aSucc,aErr);
    };

    
    
    $scope.toSelectDistrictFun = function(obj,url_){
    	$scope.changeDis(obj,url_);
    };
});