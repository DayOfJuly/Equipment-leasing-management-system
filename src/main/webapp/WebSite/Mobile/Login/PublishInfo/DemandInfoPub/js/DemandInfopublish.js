app.controller('DemandInfoPublishController', function ($scope,$timeout,$route,DemandRentSvc, regionSvc, category, published) {
	if($scope.equ_List){	
		function success(rec)
		{
			/*if(pageNo){
				$scope.paginationConf.currentPage=1;
			}*/
			if(rec.content.length == 0){
				$.messager.popup("无相应记录");
				$scope.equ_List=null;
				$scope.categoryList.length = 0;
				
				return;
			}
			$scope.equ_List= null;
			$scope.categoryList=rec.content;
			/*$scope.paginationConf.totalItems=rec.totalElements;*/
		}
        function error(rec){}
		
		$scope.equ_List.Action="ByEquCategoryName";
		$scope.equ_List.pageNo=0;
		$scope.equ_List.pageSize=99;
		$scope.equ_List.relationType = 1;
		category.unifydo($scope.equ_List,success,error);
	}else{
    function qSucc(rec)
	{
		if(rec.content.length == 0){
			$scope.queryCategoryData();
			$.messager.popup("无相应记录");
			return;
		}
		$scope.categoryList=rec.content;
	
		/*$scope.paginationConf.totalItems=rec.totalElements;*/
	}
	function qErr(rec){}
	
	category.unifydo({
		Action:"All",
	    relationType:1,
		/* equState:1, */
		pageNo : 0,// 当前页数
		pageSize : 10
	},qSucc,qErr);
	}
	$scope.Select=function(params,parm){
		
        $scope.equipmentName=params.equName.equipmentName; 
        $scope.inputModel={parm:params.equName.equipmentName};
        $scope.queryEquNameId=params.equName.equNameId;
        $scope.radioTrIndex=parm;
        $scope.equipment_obj = params;
        $scope.showFlag='';
    };
    $scope.selectList={};
    $scope.selectSubmit=function(obj,param,input){
		if($scope.queryEquNameId==null&&input==null){
			$.messager.popup("请您选择一条设备信息");
			return;
		}		
		$scope.input=input.parm;
		
	    $scope.openEquipmentUpdModal(obj.equName); 
		$scope.equipmentName = $scope.input;
		
		$scope.selectList.equipmentName = $scope.equipmentName;
		if($scope.queryEquNameId||$scope.input){
			//select下拉框选择项
			$scope.brandSelectShow=true;
			$scope.modelSelectShow=true;
			$scope.standardSelectShow=true;
			//input输入框
			$scope.brandInputShow=false;
			$scope.modelInputShow=false;  
			$scope.standardInputShow=false;
			$scope.ChoeDemandModule = false;
			$scope.queryEquBrand($scope.queryEquNameId);
			$('#ChoeDemandShopModel').modal('show');
		}else{
			
		}
		return;
		
		
		
	}
			
    $scope.openEquipmentUpdModal=function(obj){	
		function qSucc(rec){
			if(rec){
				$scope.Parm=rec;
			}
		};
		
		function qErr(){};
		
	    category.unifydo({urlPath:obj.equNameId,Action:"EquNameId"},qSucc,qErr);
	
	};	
	
		
		
	
    
	$scope.queryEquBrand=function(parm){
		function qSucc(rec){
			$scope.queryEquBrandList=rec.content;
			
		}
		function qErr(){}
		published.unifydo({Action:"queryEquBrand",id:parm,pageSize:20},qSucc,qErr);
	};
	/*
	*品牌点击效果
	*/
	$scope.queryEquBrandListCopy = {};
	$scope.brandChange=function(parm){
		for(var i=0;i<$scope.queryEquBrandList.length;i++){
			if(parm == $scope.queryEquBrandList[i].id){
				//$scope.queryEquBrandList.newBrandName=$scope.queryEquBrandList[i].name;
				$scope.queryEquBrandListCopy.newBrandName=$scope.queryEquBrandList[i].name;
			}
		}
		if(parm){
			$scope.queryEquModel(parm);
			$scope.queryEquStandard(parm);
		}
	};
	
	/*
	*型号
	*/
	$scope.queryEquModelList={};
	$scope.queryEquModel=function(parm){
		function qEmSucc(rec){
			$scope.queryEquModelList=rec.content;
		}
		function qEmErr(){}
		published.unifydo({Action:"queryEquModel",id:parm,pageSize:20},qEmSucc,qEmErr);
	};
	
	/*
	*型号点击效果
	*/
	$scope.modelChange=function(parm){
		for(var i=0;i<$scope.queryEquModelList.length;i++){
			if(parm == $scope.queryEquModelList[i].id){
				$scope.queryEquModelList.newModelName=$scope.queryEquModelList[i].name;
			}
		}
		
	};
	
	
	/*
	*规格
	*/
	$scope.queryEquStandardList={};
	$scope.queryEquStandard=function(parm){
		function qEsSucc(rec){
			$scope.queryEquStandardList=rec.content;
		}
		function qEsErr(){}
		published.unifydo({Action:"queryEquStandard",id:parm,pageSize:20},qEsSucc,qEsErr);
	}
	
	/*
	*规格点击效果
	*/
	$scope.standardChange=function(parm){
		for(var i=0;i<$scope.queryEquStandardList.length;i++){
			if(parm == $scope.queryEquStandardList[i].id){
				$scope.queryEquStandardList.newStandardName=$scope.queryEquStandardList[i].name;
			}
		}
	};
	/*
	*点击手动添加事件
	*/
	$scope.brandSelectShow=true;
	$scope.modelSelectShow=true;
	$scope.standardSelectShow=true;
	$scope.addManual=function(parm){
		if(parm == "Brand"){
			$scope.brandSelectShow=false;
			$scope.brandInputShow=true;
		}else if(parm == "Model"){
			$scope.modelSelectShow=false;
			$scope.modelInputShow=true;
		}
		else if(parm == "Standard"){
			$scope.standardSelectShow=false;
			$scope.standardInputShow=true;
		}
	};
	
	/*
	*点击重选添加事件
	*/
	$scope.addSelect=function(parm){
		if(parm == "Brand"){
			$scope.brandSelectShow=true;
			$scope.brandInputShow=false;
		}else if(parm == "Model"){
			$scope.modelSelectShow=true;
			$scope.modelInputShow=false;
		}
		else if(parm == "Standard"){
			$scope.standardSelectShow=true;
			$scope.standardInputShow=false;
		}
	}
	$scope.selectList.brandS="";
	$scope.selectList.brandI="";
	$scope.selectList.modelS="";
	$scope.selectList.modelI="";
	$scope.selectList.standardS="";
	$scope.selectList.satndardI="";
	$scope.addModelSubimt=function(){
		$('#ChoeDemandShopModel').modal('hide');
		setTimeout(function(){
			window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfoPub";
		},500)
		
		if($scope.brandInputShow){
			/*赋值品牌*/
			//$scope.queryEquBrandList.newBrandName=$scope.selectList.brandI;
			$scope.queryEquBrandListCopy.newBrandName=$scope.selectList.brandI;
		}
		if($scope.modelInputShow){
			/*赋值型号*/
			$scope.queryEquModelList.newModelName=$scope.selectList.modelI;
		}
		if($scope.standardInputShow){
			/*赋值规格*/
			$scope.queryEquStandardList.newStandardName=$scope.selectList.satndardI;
		}
		if($scope.brandSelectShow){
			/*赋值品牌*/
			//$scope.queryEquBrandList.newBrandName=$scope.queryEquBrandList.newBrandName;
			$scope.queryEquBrandListCopy.newBrandName = $scope.queryEquBrandListCopy.newBrandName;
		}
		if($scope.modelSelectShow){
			/*赋值型号*/
			$scope.queryEquModelList.newModelName=$scope.queryEquModelList.newModelName;
		}
		if($scope.standardSelectShow){
			/*赋值规格*/
			$scope.queryEquStandardList.newStandardName=$scope.queryEquStandardList.newStandardName;
		
		}
			//$scope.selectList.manufacturer=$scope.queryEquBrandList.newBrandName;
			$scope.selectList.manufacturer=$scope.queryEquBrandListCopy.newBrandName;
			$scope.selectList.modelNumber=$scope.queryEquModelList.newModelName;		
			$scope.selectList.specifications=$scope.queryEquStandardList.newStandardName;
			
		
			$scope.$emit('selectList',{saveParm:$scope.selectList});
		   
		
		    
	}
});