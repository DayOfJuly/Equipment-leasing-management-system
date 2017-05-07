app.controller('productionController', function($scope,$timeout,busEquParameterSvc,category,SYS_CODE_CON,sysCodeTranslateFactory) {


	/**
	 * 分页
	*/
	$scope.paginationConf = {
		
		currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10, 15,20, 30, 40, 50],
		onChange : function(parm1, parm2) {
			$scope.paginationConf.currentPage=parm1;
			$scope.queryCategoryData();
		}
	};
	
	//生产厂家列表
	$scope.queryCategoryData = function(){
		function qSucc(rec){
			$scope.productList = rec.content;
			$scope.paginationConf.totalItems = rec.totalElements;/*查询出来的数据总数*/
		}
		function qErr(rec){}
		busEquParameterSvc.unifydo({type:2,status:1,pageNo:$scope.paginationConf.currentPage-1,pageSize:$scope.paginationConf.itemsPerPage},qSucc,qErr);
	}
	
	
	$scope.openAddModal = function(){
		$('#productionModel').modal({backdrop: 'static', keyboard: false});
	}
	//保存
	$scope.saveProduction = function(){
		var name = $scope.name;
		function qSucc(rec){
			$.messager.popup("添加成功！");
			$scope.name = '';
			$scope.queryCategoryData();
			$("#productionModel").modal('hide');
			
		}
		function qErr(rec){
			$.messager.popup("添加失败！");
		}
		if(!name){
			$.messager.popup("请填写生产厂家名称！");
			return;
		}
		
		busEquParameterSvc.putUnifydo({type:2,name:name},qSucc,qErr);
	}
	
	//删除生产厂家
	$scope.delProduction = function(parameterId){
		$.messager.confirm("提示", "是否确认删除当前数据？", function() { 
			$scope.delec(parameterId);
			$scope.queryCategoryData();
		});
	}
	
	$scope.delec = function(parameterId){
		function qSucc(rec){
			$.messager.popup("删除成功！");
			$scope.queryCategoryData();
		}
		function qErr(rec){
			$.messager.popup("删除成功！");
		}
		busEquParameterSvc.delUnifydo({"urlPath":parameterId},qSucc,qErr);
	}
	
	
	$scope.closeWindow = function(){
		$scope.name = "";
		$("#productionModel").modal('hide');
	}
	
});