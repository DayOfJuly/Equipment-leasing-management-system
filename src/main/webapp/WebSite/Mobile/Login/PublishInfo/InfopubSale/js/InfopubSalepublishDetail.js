app.controller('InfopubSaleDetailController', function ($scope,$route,$timeout,proSvc,rentSvc, SaleSvc,partyConTactSvc , equipment, PicSvc, regionSvc, entSvc, category,PicUrl) {

	
	
	$scope.equList = eval("("+$route.current.params.detail+")");
	
	function qScc(rec){
		
		
		$scope.allequi=rec.content;
	
		 
	};
	
	function qErr(){};
	
	equipment.post({Action:'GetEquName'},{isProvider:1},qScc,qErr);
});
