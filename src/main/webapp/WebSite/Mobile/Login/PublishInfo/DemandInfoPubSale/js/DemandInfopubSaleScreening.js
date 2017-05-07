app.controller('DemandInfoPubSaleScreeningController', function ($scope,$timeout,$route,DemandRentSvc, regionSvc, category, published) {
	function qSucc(rec){
		$scope.categorySelectList=rec.content;
		$scope.categorySelectListUpd=rec.content;
	}
	function qErr(rec){}
	category.unifydo({
		Action:"EquCategory",
		pageNo:0,pageSize:99
	},qSucc,qErr);
	$scope.equ_List={};
	$scope.equ={};
	$scope.queryClassify=function(obj){
		$scope.revel1 = false;
		$scope.myVar1 = true;
		$scope.equ_List.equNameId = "";
		$scope.equ_List.class_ = obj.equipmentCategoryName;//保存这个name值用于查询按钮的查询条件
		$scope.equ_List.equCategoryId = obj.equCategoryId;
			function qSucc(rec){
				$scope.equList=rec.content;
				//$scope.paginationConfQueryClassify.totalItems = rec.totalElements;/*查询出来的数据总数*/
			}
			function qErr(rec){}
			category.unifydo({
				Action:"EquName",
				equCategoryId:obj.equCategoryId,
				pageNo : 0,// 当前页数
				pageSize : 20
			},qSucc,qErr);
			$('#collapseOne').collapse('hide');
			$('#collapseOne').collapse('show');
	};
	  $scope.saveValueOfEquList = function(e){
			$scope.revel2 = false;
			$scope.myVar2 = true;
		    $scope.equ.Name = e.equipmentName;
			$scope.equ_List.equNameId = e.equNameId;//赋值后用于查询的条件			
			$('#collapseOne').collapse('hide');
		};
		
	 $scope.DubCofim = function(){
		 $scope.$emit('equ_List',{saveParm:$scope.equ_List});
		 window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfopubSalelish";
	 }
	 
	 $scope.toggle1 = function(parm) {
		  
		 
	       $scope.id = parm;
	      if($scope.id==1){
	   	   //var urlStr = "#/viewRentList/" + $scope.id ;
	   	   //window.location.href = urlStr; 
	      }
	      if($scope.id==3){
	    		$scope.myVar2=!$scope.myVar2;
		       	$scope.revel2 = !$scope.revel2;
	      }
	      if($scope.id==4){
	   	  // var urlStr = "#/ViewDemandSaleList/" + $scope.id ;
	   	   //window.location.href = urlStr; 
	      }
	       if($scope.id==2){
	       	$scope.myVar1=!$scope.myVar1;
	       	$scope.revel1 = !$scope.revel1;
	       }
	   };
	   
	   $scope.myVar1 = true;
	   $scope.revel1 = false;
	   $scope.myVar2 = true;
	   $scope.revel2 = false;
	   
	 $scope.ClearInput = function(){
		 $scope.equ_List = null;
		 $scope.equ.Name = null;
	 }
});
