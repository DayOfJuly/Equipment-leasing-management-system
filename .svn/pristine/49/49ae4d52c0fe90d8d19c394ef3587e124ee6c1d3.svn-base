app.controller('InfopubSaleScreeningequipmentController', function ($scope,$route,$timeout,proSvc,rentSvc, SaleSvc,partyConTactSvc , equipment, PicSvc, regionSvc, entSvc, category,PicUrl) {

	
	function qScc(rec){

		$scope.allequi=rec.content;
	};
	
	function qErr(){};
	
	equipment.post({Action:'GetEquName'},{pageNo:0,pageSize:20,orgCode:$scope.userInfo.orgCode,isProvider:1},qScc,qErr);
	
	
	$scope.Screen = function(obj){
		$scope.Info_List = obj;
		$scope.$emit('Info_List',{saveParm:$scope.Info_List});
		window.location.href="/WebSite/Mobile/Index.jsp#/InfopubSalepublish"; 
	}
});
