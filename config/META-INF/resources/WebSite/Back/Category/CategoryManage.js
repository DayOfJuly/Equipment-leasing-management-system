app.controller('CategoryManageController', function($scope,$timeout,category,SYS_CODE_CON,sysCodeTranslateFactory) {
	
	//ie9下titile正确显示使用
	document.title="分类设备维护"
	
    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    
    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
    
    
	
	$scope.showTime = false;
	
	$scope.userInfo = {};
	$scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
	
	$scope.pagingFlag = ''; //对于展示哪个分页条做出的flag
	
	if($scope.userInfo.orgLevel == 1){
		$scope.pagingFlag = 1;
	}else{
		$scope.pagingFlag = 2;
	}
	
	/**
	 * 分页
	*/
	$scope.paginationConf = {
		//currentPage : 1,/* 当前页数 */
		//totalItems : 1,/* 数据总数 */
		//pageRecord : 10,/* 每页显示多少 */
		//pageNum : 10,/* 分页标签数量显示 */
		
		
		currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10, 15,20, 30, 40, 50],
		
		
		
		//parm1:当前选择页数 parm2:每页显示多少 屏幕加载运行
		//屏幕打开时加载多半用于打开时查询
		onChange : function(parm1, parm2) {
			$scope.paginationConf.currentPage=parm1;
			$scope.queryCategoryData();
			$scope.radioTrIndex=null;/*不在当前页时，去掉radio*/
		}
	};
	
	/*类别*/
	$scope.queryCategoryData=function(PageNo){
		$scope.equipmentList = [];
		$scope.showTime = false;
		function qSucc(rec){
			if(PageNo){
				$scope.paginationConf.currentPage = 1;
			}
			$scope.categoryList=rec.content;
			$scope.paginationConf.totalItems = rec.totalElements;/*查询出来的数据总数*/
			for(var i =0;i<$scope.categoryList.length;i++){
				$scope.categoryList[i].equipmentCategoryNoCopy = $scope.categoryList[i].equipmentCategoryNo;
				if($scope.categoryList[i].equipmentCategoryNo && $scope.categoryList[i].equipmentCategoryNo.length > 11){
					$scope.categoryList[i].equipmentCategoryNoCopy = $scope.categoryList[i].equipmentCategoryNoCopy.substring(0,11)+"...";
				}
				$scope.categoryList[i].equipmentCategoryNameCopy = $scope.categoryList[i].equipmentCategoryName;
				if($scope.categoryList[i].equipmentCategoryName && $scope.categoryList[i].equipmentCategoryName.length > 11){
					$scope.categoryList[i].equipmentCategoryNameCopy = $scope.categoryList[i].equipmentCategoryNameCopy.substring(0,11)+"...";
				}
			}
		}
		function qErr(rec){}
		
		category.unifydo({
			Action:"EquCategory",
			pageNo : $scope.paginationConf.currentPage - 1,// 当前页数
			pageSize : $scope.paginationConf.itemsPerPage
		},qSucc,qErr);
	};

	/*
	*添加类别-弹出
	*/
	$scope.openCategoryAddModal=function(){
		$scope.formParms={};/* 清空之前所填 */
		if($scope.formParms){
			$scope.formParms={};
		}
		$scope.upd='';
		$scope.judge="add";/* 共用页面的区分标记 */
		$scope.showFlag='';/* 清空错误提示 */
		$scope.titleMsg="分类添加";/* 显示为添加 */
	/*	$("#categoryModalId").draggable();
		$("#categoryModalId").draggable('disable');*/
		$('#categoryModalId').modal({backdrop: 'static', keyboard: false});
	};
	
	/*
	*--添加类别
	*/
	$scope.addCategory=function(categoryForm){
		if(!categoryForm.$valid){
			if(!categoryForm.equipmentCategoryName.$valid){/* 两个if判断看有没有不通过的，有就显示对应错误提示 */
				$scope.showFlag = 'equipmentCategoryName';
			}
			if(!categoryForm.equipmentCategoryNo.$valid){
				$scope.showFlag = 'equipmentCategoryNo';
			}
			return;
		}else{
			function aSucc(rec){/* 通过 */
				$.messager.popup("添加成功");
				$scope.queryCategoryData(1);/* 查询一遍 */
				$('#categoryModalId').modal('hide');
			}
			function aErr(){
				$.messager.popup("添加失败");
				$('#categoryModalId').modal('hide');
			}
			category.put({Action:"EquCategory"},$scope.formParms,aSucc,aErr);
		}
		
	};
	
	/*
	*修改类别--弹出
	*/
	$scope.openCategoryUpdModal=function(c){/* 这个参数是从页面拿到的所选对象 */
		
		$scope.judge="upd";/* 标志着修改 */
		$scope.upd='true';
		$scope.showFlag = '';/* 清空错误提示 */
		$scope.titleMsg="分类修改";
		

		function qSucc(rec){
			if(rec){
				$scope.formParms=rec;
				/*$("#categoryModalId").draggable();*/
				$('#categoryModalId').modal({backdrop: 'static', keyboard: false});
			}
		};
		
		function qErr(){};
		
	    category.unifydo({urlPath:c.equCategoryId,Action:"EquCategoryId"},qSucc,qErr);
		
		
		
		

	};
	
	/*
	*修改类别
	*/
	$scope.updCategory=function(obj){
		if(!obj.$valid){
			if(!obj.equipmentCategoryName.$valid){
				$scope.showFlag = 'equipmentCategoryName';
			}
			if(!obj.equipmentCategoryNo.$valid){
				$scope.showFlag = 'equipmentCategoryNo';
			}
			return;
		}else{
			var id=$scope.formParms.equCategoryId;
			function aSucc(rec){
				$.messager.popup("修改成功");
				$scope.queryCategoryData();
				$('#categoryModalId').modal('hide');
				$scope.radioTrIndex = null;
				$scope.radioSelectId = null;
			}
			function aErr(){
				$.messager.popup("修改失败");
				$('#categoryModalId').modal('hide');
			}
			category.post({Action:"EquCategory",parm:id},$scope.formParms,aSucc,aErr);
		}
	};
	
	/*
	*删除类别
	*/
	$scope.delCategory=function(obj){
		
		$scope.queryEquipmentData(obj);
		
		$timeout(function() {
			if($scope.equipmentList && $scope.equipmentList.length == 0){
				$.messager.confirm("提示", "是否确认删除当前数据？", function() {
					var id = obj.equCategoryId;
					function qSucc(rec){
						if(rec){
							$.messager.popup("请先清空该类别下的所有设备信息");
							return;
						}
					}
					function qErr(rec){}
					category.unifydo({
						Action:"EquName",
						equCategoryId:id,
						pageNo : $scope.paginationConf.currentPage - 1,// 当前页数
						pageSize : $scope.paginationConf.itemsPerPage
					},qSucc,qErr);
					function dSucc(rec){
						$.messager.popup("删除成功");
						$scope.queryCategoryData(1);
					}
					function dErr(){}
					category.del({Action:"EquCategory",parm:id},dSucc,dErr);
			    });
			}else{
				$.messager.popup("请先清空该类别下的所有设备信息");
				return;
			}
	     },150);
		

		

	};
	
	/*
	*关闭窗口--分类
	*/
	$scope.closeWindow = function(){
		$scope.formParms={};
		$scope.queryCategoryData();
		$('#categoryModalId').modal('hide');
	};
	
	
	
	
	/**
	 * 分页--设备
	 */
	$scope.paginationConfA = {
		//currentPage : 1,/* 当前页数 */
		//totalItems : 0,/* 数据总数 */
		//pageRecord : 10,/* 每页显示多少 */
		//pageNum : 10,/* 分页标签数量显示 */
		
		
		currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10,15, 20, 30, 40, 50],
		
		//parm1:当前选择页数 parm2:每页显示多少 屏幕加载运行
		//屏幕打开时加载多半用于打开时查询
		onChange : function(parm1, parm2) {
			$scope.paginationConfA.currentPage=parm1;
			$scope.queryEquipmentData($scope.formParm);
		}
	};
	
	
	/* 查询方法 */
	$scope.formParm={};
	$scope.queryEquipmentData=function(obj,PageNo){
	    $scope.saveObj = obj;//保存下点击左边时的对象，用于操作删除后的查询
		if(PageNo){
			$scope.paginationConfA.currentPage = 1;
		}
		$scope.formParm=obj;
		if(!$scope.radioSelectId){
			return;
		}else{
			function qSucc(rec){
				//设备大类的ID，用于判断设备的名称，在一个类型下面是否有重复的
				$scope.equCategoryId=obj.equCategoryId;
				
				$scope.equipmentList=[];//在IE10浏览器中，如果没有定义，走不通
				$scope.showTime = true;
				if(rec.content)
				{
					$scope.equipmentList=rec.content;
				}
				
				
				$scope.paginationConfA.totalItems = rec.totalElements;/*查询出来的数据总数*/

				for(var i =0;i<$scope.equipmentList.length;i++){
					$scope.equipmentList[i].equipmentNoCopy = $scope.equipmentList[i].equipmentNo;
					if($scope.equipmentList[i].equipmentNo && $scope.equipmentList[i].equipmentNo.length > 11){
						$scope.equipmentList[i].equipmentNoCopy = $scope.equipmentList[i].equipmentNoCopy.substring(0,11)+"...";
					}
					$scope.equipmentList[i].equipmentNameCopy = $scope.equipmentList[i].equipmentName;
					if($scope.equipmentList[i].equipmentName && $scope.equipmentList[i].equipmentName.length > 11){
						$scope.equipmentList[i].equipmentNameCopy = $scope.equipmentList[i].equipmentNameCopy.substring(0,11)+"...";
					}
				}
			}
			function qErr(rec){}
			category.unifydo({
				randomTemp:Math.random(),
				Action:"EquName",
				equCategoryId:obj.equCategoryId,
				pageNo : $scope.paginationConfA.currentPage - 1,// 当前页数
				pageSize : $scope.paginationConfA.itemsPerPage
			},qSucc,qErr);
		}
	};
	
	/*
	*添加设备--弹出
	*/
	$scope.openEquipmentAddModal=function(obj){
		if(!$scope.formParm){
			$.messager.popup("请选择一条类别");
			return;
		}else{
			$scope.formParm={};
		}
		$scope.judge="add";
		$scope.showFlag = '';
		$scope.titleMsg="设备添加";
		$scope.formParm={};
		$scope.formParm.equipmentNo = '';
		//$scope.queryCategoryData();
		$scope.formParm.equCategoryId=$scope.radioSelectId;
		
		if(obj && obj=='add'){
			$scope.flagName_ = 'add';
		}
	/*	$("#equipmentModalId").draggable();
		$("#equipmentModalId").draggable('disable');*/
		$('#equipmentModalId').modal({backdrop: 'static', keyboard: false});
	};
	
	/*
	*添加设备
	*/
	$scope.addEquipment=function(obj){
		if(!obj.$valid){
			 if(!obj.equipmentNo.$valid){
				$scope.showFlag = 'equipmentNo';
			}
			 else if(!obj.equipmentName.$valid){
				$scope.showFlag = 'equipmentName';
			}
			 else if(!obj.second.$valid){
					$scope.showFlag = 'second';
				}
			return;
		}else{
			$scope.formParm.equCategoryId=$scope.radioSelectId;
			function aSucc(rec){
				$.messager.popup(rec.msg);
				$('#equipmentModalId').modal('hide');
				$scope.queryEquipmentData($scope.formParm,1);
			}
			function aErr(rec){
				$.messager.popup(rec.msg);
				$('#equipmentModalId').modal('hide');
			}
			category.put({Action:"EquName"},$scope.formParm,aSucc,aErr);
		}
	};
	
	/*
	*修改设备--弹出
	*/
	$scope.openEquipmentUpdModal=function(obj,obj2){//obj对象,obj2 flag
		$scope.judge="upd";
		$scope.showFlag = '';
		$scope.titleMsg="设备修改";
		
		
		function qSucc(rec){
			if(rec){
				$scope.formParm=rec;
				//$scope.queryCategoryData();
				$scope.formParm.equCategoryId=$scope.radioSelectId;
				
				if(obj2 && obj2 == 'upd'){
					$scope.flagName_ = 'upd';
				}
				
			/*	$("#equipmentModalId").draggable();
				$("#equipmentModalId").draggable('disable');*/
				$('#equipmentModalId').modal({backdrop: 'static', keyboard: false});
			}
		};
		
		function qErr(){};
		
	    category.unifydo({urlPath:obj.equNameId,Action:"EquNameId"},qSucc,qErr);
		
		
		
		
		
		
	};
	
	/*
	*修改设备
	*/
	$scope.updEquipment=function(obj){
		if(!obj.$valid){
			if(!obj.equipmentNo.$valid){
				$scope.showFlag = 'equipmentNo';
				return;
			}
			if(!obj.equipmentName.$valid){
				$scope.showFlag = 'equipmentName';
				return;
			}
			if(!obj.second.$valid){
				$scope.showFlag = 'second';
				return;
			}
			
			
		}else{
			var id = $scope.formParm.equNameId;
			function aSucc(rec){
				$scope.queryEquipmentData($scope.saveObj);
				$('#equipmentModalId').modal('hide');
				$.messager.popup(rec.msg);
				
			}
			function aErr(rec){
				$.messager.popup(rec.msg);
				$('#equipmentModalId').modal('hide');
			}
			category.post({Action:"EquName",parm:id},$scope.formParm,aSucc,aErr);
		}
		
	};
	
	/*
	*删除设备
	*/
	$scope.delEquipment=function(obj){
		$.messager.confirm("提示", "是否确认删除当前数据？", function() { 
			var id = obj.equNameId;
			function dSucc(rec){
				$.messager.popup(rec.msg);
				$scope.queryEquipmentData($scope.saveObj,1);
			}
			function dErr(rec){
					$.messager.popup(rec.data.message);
					return;
			}
			category.del({Action:"EquName",parm:id},dSucc,dErr);
	    });
	};
	

	
/*	
	*关闭窗口--设备
	
	$scope.closeWindowA = function(parm){
		$scope.judge=='upd';
		function qSucc(rec){
			$scope.equipmentList=rec.content;
			$scope.paginationConfA.totalItems = rec.totalElements;查询出来的数据总数
		}
		function qErr(rec){}
		category.unifydo({
			Action:"EquName",
			equCategoryId:parm,
			pageNo : $scope.paginationConfA.currentPage - 1,// 当前页数
			pageSize : $scope.paginationConfA.itemsPerPage
		},qSucc,qErr);
		$('#equipmentModalId').modal('hide');
	};*/
	
	$scope.selectRow=function(obj){
		$scope.formParm=obj;
	};
	
	$scope.radioList={};
	//选中订单ID
	$scope.check = function(c,index_){
		$scope.radioTrIndex=index_;
		$scope.radioSelectId=c.equCategoryId;
		$scope.queryEquipmentData(c);
	};
	
	/**
	 * 检查设备名称是否重复
	 */
	$scope.checkName = function(obj){
		
		function qScc(rec){
			
			//添加
			if(obj && obj=="add"){
				if($scope.formParm.equipmentName && $scope.formParm.equipmentName.length > 0 && rec.msg.length > 0){
					$.messager.popup("设备名称不能重复！");
					$("#_equNameId").val("");
					$scope.formParm.equipmentName = '';
					$("#_equNameId").focus();
					return;
				}
			}
			
			if(obj && obj=="upd"){
				if(rec.msg.length > 0){
					
					if($scope.saveEquNameId != rec.msg[0].equName.equNameId){
						$.messager.popup("设备名称不能重复！");
						$("#_equNameId").val("");
						$scope.formParm.equipmentName = '';
						$("#_equNameId").focus();
						return;
					}
				}
			}
			
		}
		
		function qErr(){}
		
		category.unifydo({'equCategoryId':$scope.equCategoryId,'equipmentName':$scope.formParm.equipmentName,'Action':"GetByEquName"},qScc,qErr);
	};
   
/**
 * 小类点击方法取值
 */
   $scope.checkValueFun = function(obj){
	  $scope.saveEquNameId =obj.e.equNameId;
   };
	
	
	/**
	 * 校验类别号是否重复
	 */
   $scope.checkNoFun = function(){
	   
	   function qScc(rec){
		   if($scope.formParms.equipmentCategoryNo && $scope.formParms.equipmentCategoryNo.length>0 && rec.msg.length > 0){
			   $.messager.popup("类别号不可以重复！");
			   $scope.formParms.equipmentCategoryNo = '';
			   $("#_equipmentCategoryNoId").val('');
			   $("#_equipmentCategoryNoId").focus();
			   return;
		   }
	   };
	   
	   function qErr(){};
	   
	   category.unifydo({equipmentCategoryNo:$scope.formParms.equipmentCategoryNo,Action:"GetByEquCategoryNo"},qScc,qErr);
   };
	
	
});