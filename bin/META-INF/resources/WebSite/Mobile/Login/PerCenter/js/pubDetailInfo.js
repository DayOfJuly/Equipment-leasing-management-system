app.controller('pubDetailController',function($scope,$route,published,busPublishInfo){
	
	$scope.equList = eval("("+$route.current.params.parm+")");
	
});