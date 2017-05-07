app.controller('classifyController',function($scope,nonLoginCategory,published){
	
	$scope.typeVar = 0;
	$scope.typeName="出租";
	$scope.type=1;
	/*
	 * 类型-控制上下箭头
	 */
	$scope.toggleType = function(parm) {
		$scope.id = parm;
		if($scope.id==0){
			$scope.typeVar=1;
		}else{
			$scope.typeVar=0;
		};
	};
	
	/*
	 * 类型名称
	 */
	$scope.changeType = function(parm) {
		$scope.id = parm;
		if($scope.id==1){
			$scope.typeName="出租";
			$scope.typeVar=0;
			$scope.type=1;
		}else if($scope.id==2){
			$scope.typeName="出售";
			$scope.typeVar=0;
			$scope.type=2;
		}else if($scope.id==3){
			$scope.typeName="求租";
			$scope.typeVar=0;
			$scope.type=3;
		}else if($scope.id==4){
			$scope.typeName="求购";
			$scope.typeVar=0;
			$scope.type=4;
		};
//		$scope.screen.type=$scope.id;
	};
	

	
	
	//产品分类
	$scope.subscript=0;
	var a = [];
	$scope.queryProType=function(){
				
		function qSucc(rec){
	/*		for(var i =0;i<rec.length;i++){
				if(i<15){
					a.push(rec[i]);
				}
			} 只要15个值存进展示数组中
			$scope.proTypeList=rec;
			$scope.prpTypeListSave = rec;//记录原数组
			if($scope.proTypeList.length > 10){
				var subtractArrayLenth = $scope.proTypeList.length - 10; //要减去的长度
				$scope.proTypeList.splice(10,subtractArrayLenth);//扣除超过15个的部分留下数组中前15个元素
			}
			
			/*if($scope.proTypeList)
				$scope.showProType($scope.proTypeList[0].equCategoryId); *///2016.4.5
		/*	for(var i=0;i<$scope.proTypeList.length;i++){
				$scope.showProTypeList.push($scope.proTypeList[i].equNamaInfos);
			}*/
		}
		function qErr(){}
		//nonLoginCategory.unifydo({Action:"HomePage"},qSucc,qErr); 2016.4.5
		published.getEquNames({Action:"HomePage"},qSucc,qErr);
	};
	
/*	$scope.showProType = function(param){
		function qSucc(rec){
			$scope.equipmentName=rec;
		}
		function qErr(){}
		nonLoginCategory.unifydo({Action:"ByCategoryId",equCategoryId:param},qSucc,qErr); 2016.4.5
	}*/
	
	$scope.showProType = function(param){
		$scope.subscript=param;
		if($scope.proTypeList[$scope.subscript].equNameInfos.length > 15){//如果数组元素超过15个
			var subtractArrayEquNameInfosLenth = $scope.proTypeList[$scope.subscript].equNameInfos.length - 15;//得到超过的数目
			$scope.proTypeList[$scope.subscript].equNameInfos.splice(15,subtractArrayEquNameInfosLenth);//减去超过的数目留下前15个数组元素
		}
	};
	
	/*遍历展示各分类
	$scope.showProType=function(parm){
		$scope.subscript=parm;
	}*/
	
	$scope.type=1;

});