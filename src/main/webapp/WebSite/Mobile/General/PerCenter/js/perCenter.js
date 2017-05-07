app.controller('percenterController', function($scope,sysUserSvc) {

	if($scope.userInfo){
		if($scope.userInfo.loginId!=null && $scope.userInfo.loginId!=""){
			$scope.v=true;
		}
	}else{
		$scope.v=false;
	};
	
	
	/* 退出登录*/
    $scope.logoutFun = function(){
        function success(rec){
        	$.messager.popup("注销成功");
        	$scope.userInfo="";
        	$scope.v=false;
        	window.location.href="/WebSite/Mobile/Index.jsp#/perCenter";
        	}

        function error(rec){
        	if(rec){
        		$.messager.popup( rec.data.message);
        		return;
        		}
        	}	 

        sysUserSvc.loginOut({Action:"Logout"},success,error);
	};
});