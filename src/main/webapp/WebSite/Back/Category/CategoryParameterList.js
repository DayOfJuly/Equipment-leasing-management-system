app.controller('CategoryParameterListController', function($scope,category,busEquParameterSvc,$timeout,category,SYS_CODE_CON,sysCodeTranslateFactory) {

	/**
	 * 分页
	*/
	$scope.paginationConf = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 20,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [10,20, 40, 60, 80],
		onChange: function(currentPage){
			$scope.queryCategoryData(currentPage);
		}
	};
	
	/*
	 * 查询下拉框分类信息
	*/
	$scope.queryCategory=function(){
		function qSucc(rec){
			$scope.categorySelectList=rec.content;
//			$scope.categorySelectListUpd=rec.content;
		}
		function qErr(rec){}
		category.unifydo({
			Action:"EquCategory",
			pageNo:0,pageSize:99
		},qSucc,qErr);
	};
	$scope.queryCategory();
	//选中订单ID
	$scope.Select = function(c,index_){
		
		$scope.radioTrIndex = index_;
		$scope.radioSelectId = c.equCategoryId;
		
	};
	
	
	//查询设备列表
	$scope.equCategoryBean={};
	$scope.queryCategoryData = function(currentPage){
		
		if(currentPage){
			$scope.paginationConf.currentPage = currentPage;
		}
		
		function qSucc(rec){
			if(rec.content.length == 0){
				$.messager.popup("无相应记录");
				$scope.page = 2;
			}
			$scope.page = 1;
			$scope.categoryList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
			
		}
		function qErr(rec){}

		$scope.equ_List = {};
		$scope.equ_List.Action="ByEquCategoryName";
		$scope.equ_List.pageNo=$scope.paginationConf.currentPage-1;
		$scope.equ_List.pageSize=$scope.paginationConf.itemsPerPage;
		$scope.equ_List.equipmentName = $scope.name;
		$scope.equ_List.equCategoryId = $scope.equCategoryBean.equCategoryId;
		$scope.equ_List.relationType = 1;
		
		category.unifydo($scope.equ_List,qSucc,qErr);

	}
	
	//打开添加Model
	$scope.openAddModal = function(prarm){
		if($scope.radioTrIndex == undefined ){
			$.messager.popup("请选择一条记录！");
		}else{
			$scope.equipmentName = prarm[$scope.radioTrIndex].equName.equipmentName;
			
			//品牌
			function qSucc(rec){
				$scope.brandList = rec.content;
				
			}
			function qErr(rec){}
			busEquParameterSvc.unifydo({type:1,status:1,pageNo:0,pageSize:99},qSucc,qErr);
			
			//生产厂家
			function qSuc(rec){
				$scope.productionList = rec.content;
				
			}
			function qEr(rec){}
			busEquParameterSvc.unifydo({type:2,status:1,pageNo:0,pageSize:99},qSuc,qEr);
			
			//型号
			function succ(rec){
				$scope.typeList = rec.content;
				
			}
			function err(rec){}
			busEquParameterSvc.unifydo({type:3,status:1,pageNo:0,pageSize:99},succ,err);
			
			//规格
			function Succ(rec){
				$scope.standardList = rec.content;
				
			}
			function Err(rec){}
			busEquParameterSvc.unifydo({type:4,status:1,pageNo:0,pageSize:99},Succ,Err);
			
			
			$('#categoryParameter').modal({backdrop: 'static', keyboard: false});
		}
	}
	
	$scope.modelSelectShow = 1;
	$scope.typeSelectShow = 1;
	
	
	$scope.closeWindow = function(){
		$scope.modelSelectShow = 1;
		$scope.modelInputShow = 2;
		$scope.typeSelectShow = 1;
		$scope.typeInputShow = 2;
		$("#categoryParameter").modal('hide');
	}
	//保存
	$scope.addBusList = {};
	$scope.addCategory = function(prarm){
		
		if(!$scope.addBusList.manufactruerId){
			$.messager.popup("请选择生产厂家！");
			return;
		}
		if(!$scope.addBusList.brandId){
			$.messager.popup("请选择品牌！");
			return;
		}
		
		$scope.addBusList.equNameId = prarm[$scope.radioTrIndex].equName.equNameId;//设备小类的ID
		
		$scope.addBusList.manufactruerId = $scope.addBusList.manufactruerId;//生产厂家ID
		
		$scope.addBusList.brandId = $scope.addBusList.brandId;//品牌的ID
		
		if($scope.typeSelectShow==1){
			if(!$scope.typeList.parameterId){
				$.messager.popup("请选择型号！");
				return;
			}
			$scope.addBusList.modelId = $scope.typeList.parameterId;//型号ID
			$scope.addBusList.modelName = "";
		}
		if($scope.typeInputShow==1){
			if(!$scope.modelName){
				$.messager.popup("请填写型号！");
				return;
			}
			$scope.addBusList.modelName = $scope.modelName;//型号名称
			$scope.addBusList.modelId = "";
		}
		
		if($scope.modelSelectShow==1){
			if(!$scope.standardList.parameterId){
				$.messager.popup("请选择规格！");
				return;
			}
			$scope.addBusList.standardId = $scope.standardList.parameterId;//规格ID
			$scope.addBusList.standardName = "";
		}
		if($scope.modelInputShow==1){
			if(!$scope.standardName){
				$.messager.popup("请填写规格！");
				return;
			}
			$scope.addBusList.standardName = $scope.standardName;//规格名称
			$scope.addBusList.standardId = "";
		}
		
		function Succ(rec){
			$.messager.popup("添加成功！");
			$scope.modelSelectShow = 1;
			$scope.modelInputShow = 2;
			$scope.typeSelectShow = 1;
			$scope.typeInputShow = 2;
			$scope.modelName = "";
			$scope.standardName = "";
			$("#categoryParameter").modal('hide');
		}
		function Err(rec){
			$.messager.popup("添加失败！");
		}
		busEquParameterSvc.putUnifydo({action:"ADD_BUS_EQU_PARAMETER"},$scope.addBusList,Succ,Err);
	}
	
	//选择手动添加
	$scope.addManual = function(pram){
		if(pram == "type"){
			$scope.typeInputShow = 1;
			$scope.typeSelectShow = 2;
			$scope.modelName = "";
		}
		if(pram == "standard"){
			$scope.modelSelectShow = 2;
			$scope.modelInputShow = 1;
			$scope.standardName = "";
		}
		
	}
	//重新选择
	$scope.addSelect = function(pram){
		if(pram == "type"){
			$scope.typeInputShow = 2;
			$scope.typeSelectShow = 1;
		}
		if(pram == "standard"){
			$scope.modelSelectShow = 1;
			$scope.modelInputShow = 2;
		}
	}
	
});