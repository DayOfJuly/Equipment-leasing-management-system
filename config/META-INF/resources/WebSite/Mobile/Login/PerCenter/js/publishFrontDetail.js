app.controller('publishFrontDetailController',function($scope,$route,published,busDealInfo){
	
	$scope.equList = eval("("+$route.current.params.parm+")");
	
});