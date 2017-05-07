app.controller('InfopubdescriptionController', function ($scope,$route,$timeout,proSvc,rentSvc, SaleSvc,partyConTactSvc , equipment, PicSvc, regionSvc, entSvc, category,PicUrl) {
        
	$scope.form={};
	if($route.current.params.description=='请输入详细信息'){
		$scope.form.description = "";
	}else{
		if(publicParms.saveParm){
			$scope.form.description =publicParms.saveParm;//$route.current.params.description;
		}
	}
	
	$scope.Textrea = function(obj){
		$scope.description = obj;
		if($route.current.params.InfopubId==1){
			publicParms={saveParm:$scope.description};
			window.location.href="/WebSite/Mobile/Index.jsp#/Infopub";
		}
		if($route.current.params.InfopubId==2){
			publicParms={saveParm:$scope.description};
			window.location.href="/WebSite/Mobile/Index.jsp#/InfopubSale";
		  }
		if($route.current.params.InfopubId==3){
			publicParms={saveParm:$scope.description};
			window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfoPub";
		  }
		if($route.current.params.InfopubId==4){
			publicParms={saveParm:$scope.description};
			window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfoPubSale";
		  }
	}
	$scope.Back = function(){		
		if($route.current.params.InfopubId==1){
			
			window.location.href="/WebSite/Mobile/Index.jsp#/Infopub";
		}
		if($route.current.params.InfopubId==2){
			
			window.location.href="/WebSite/Mobile/Index.jsp#/InfopubSale";
		}
	    if($route.current.params.InfopubId==3){
			
		    window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfoPub";
		}
		if($route.current.params.InfopubId==4){
			
		    window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfoPubSale";
		}
	    
	}

});
