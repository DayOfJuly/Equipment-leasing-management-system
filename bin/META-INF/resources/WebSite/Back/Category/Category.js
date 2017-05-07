/**
 * 
 */

app.controller('CategoryController', function($scope,$timeout,category,SYS_CODE_CON,sysCodeTranslateFactory) {
	
	//ie9下titile正确显示使用
	document.title="机械设备分类管理"
	
	
	
	$scope.userInfo = {};
	$scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
	
	
	/*
	 *分页标签参数配置
	*/
	$scope.paginationConf = {
       	//currentPage:1,/*当前页数*/
        //totalItems:1,/*数据总数*/
        //pageRecord:10,/*每页显示多少*/
        //pageNum:10,/*分页标签数量显示*/
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        currentPage: 1,		/*当前页数*/
        totalItems: 1,		/*数据总数*/
        itemsPerPage: 20,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [20, 30, 40, 50],
        onChange : function(parm1){
        	$scope.paginationConf.currentPage=parm1;
        	if($scope.queryData.searchParam=="" || $scope.queryData.searchParam==null){
        		$scope.queryCategoryData();
        	}else{
        		$scope.queryCategoryDataA(1);
        	}
        }
        /* queryList:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	if($scope.queryData.searchParam=="" || $scope.queryData.searchParam==null){
        		$scope.queryCategoryData();
        	}else{
        		$scope.queryCategoryDataA(1);
        	}
        } */
    };
	
	/*
	 * 查询数据
	*/
	$scope.queryData={};
	$scope.queryCategoryData=function(PageNo)
	{
		function success(rec)
		{
			if(rec.content.length == 0){
				$.messager.popup("没有符合条件的记录");
				$scope.categoryList = [];
			}else{
				$scope.categoryList=rec.content;
				$scope.paginationConf.totalItems=rec.totalElements;
			}
		}
		function error(){}
		category.unifydo({
			Action:"All",
			relationType:1,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
		},success,error);
	}; 
	
	/*
	 * 查询数据
	*/
 	$scope.queryData={};
 	$scope.showBtn_Flag = true;
	$scope.queryCategoryDataA=function(pageNo)
	{
		function success(rec)
		{
			if(pageNo){
				$scope.paginationConf.currentPage=1;
			}
			if(rec.content.length == 0){
				$.messager.popup("没有符合条件的记录");
				$scope.categoryList=rec.content;

				$scope.paginationConf.totalItems=rec.totalElements;
				$scope.showBtn_Flag = false;
				return;
			}else{
				$scope.categoryList=rec.content;
				$scope.paginationConf.totalItems=rec.totalElements;
				$scope.showBtn_Flag = true;
			}
			
		}
		function error(rec){}
		
		$scope.queryData.Action="All";
		//$scope.queryData.relationType=2;
		$scope.queryData.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryData.pageSize=$scope.paginationConf.pagesLength;
		$scope.queryData.relationType = 1;
		category.unifydo($scope.queryData,success,error);
	}; 
	/*
	 * 弹出添加页面模态框
	*/
	$scope.openAddModal=function(){
		$scope.queryCategory();//执行查询
		$scope.nameSelectList = null;
		$scope.formParms={};
		$scope.judge="add";
		$scope.titleMsg="分类添加";
		$scope.showFlag = '';
	/*	$("#categoryModalId").draggable();*/
		$('#categoryModalId').modal({backdrop: 'static', keyboard: false});
	};
	
	/*
	 * 添加
	*/
	$scope.addType=function(obj){
		if(!obj.$valid){
			if(!obj.typeNo.$valid){
				$scope.showFlag = 'typeNo';
				return;
			}
			if(!obj.equCategoryId.$valid){
				$scope.showFlag = 'equCategoryId';
				return;
			}
			if(!obj.equNameId.$valid){
				$scope.showFlag = 'equNameId';
				return;
			}
		}else{
			function aSucc(rec){
				$.messager.popup(rec.msg);
				$scope.queryCategoryData(1);
				$('#categoryModalId').modal('hide');
			}
			function aErr(){
				$.messager.popup("添加失败");
				$('#categoryModalId').modal('hide');
			}
			category.put($scope.formParms,aSucc,aErr);
		}
		
	};
	
	
	/*
	 * 弹出修改页面模态框
	*/
	$scope.formParms={};
	$scope.openUpdModal=function(obj){
		$scope.queryCategory();
		$scope.judge="upd";
		$scope.titleMsg="分类修改";
		function qSucc(rec){
			
			$scope.formParm ={
					categoryId:rec.categoryId,
					relationType:rec.relationType,
					typeNo:rec.typeNo,
					equCategoryId:rec.equCategory.equCategoryId,
					equNameId:rec.equName.equNameId
			}
			
			$scope.getEquNames(rec.equCategory.equCategoryId);
			
			
			$scope.showFlag = '';
		/*	$("#categoryUpdate").draggable();*/
			$("#categoryUpdate").modal({backdrop: 'static', keyboard: false});

		}
		function qErr(rec){}
		
		
		category.unifydo({urlPath:obj.categoryId},qSucc,qErr); 
		
	};
	
	/*
	 * 修改
	*/
	$scope.upd=function(obj){
		if(!obj.$valid){
			if(!obj.typeNo.$valid){
				$scope.showFlag = 'typeNo';
				return;
			}
			if(!obj.equCategoryId.$valid){
				$scope.showFlag = 'equCategoryId';
				return;
			}
			if(!obj.equNameId.$valid){
				$scope.showFlag = 'equNameId';
				return;
			}
			
		}else{
			function aSucc(rec){
				$.messager.popup(rec.msg);
				$scope.queryCategoryData();
				$('#categoryUpdate').modal('hide');
			}
			function aErr(rec){} 
			category.post({urlPath:$scope.formParm.categoryId},$scope.formParm,aSucc,aErr);
		}
	};
	
	/*
	* 取消删除
	*/
	$scope.DelClose = function(){
		$('#CategoryDelModal').modal('hide');
	};
	
	/*
	* 删除（新）
	*/
	$scope.del= function(obj){
/*		$scope.DId=obj.categoryId;
		$("#CategoryDelModal").draggable();
		$('#CategoryDelModal').modal({backdrop: 'static', keyboard: false});*/
		
			$.messager.confirm("提示", "是否确认删除当前数据？", function() { 
				$scope.DId=obj.categoryId;
				function dSucc(rec){
					$.messager.popup(rec.msg);
					$scope.queryCategoryData(1);
					$('#CategoryDelModal').modal('hide');
				}
				function dErr(rec){
					$.messager.popup(rec.data.message);
					return;
				}
				category.del({parm:$scope.DId},dSucc,dErr);
		    });
	};
	
	/*
	 * 删除
	*/
	$scope.DelConfirm=function(){
			function dSucc(rec){
				$.messager.popup(rec.msg);
				$scope.queryCategoryData(1);
				$('#CategoryDelModal').modal('hide');
			}
			function dErr(){}
			category.del({parm:$scope.DId},dSucc,dErr);
	};
	
	/*
	 * 查询下拉框分类信息
	*/
	$scope.queryCategory=function(){
		function qSucc(rec){
			$scope.categorySelectList=rec.content;
			$scope.categorySelectListUpd=rec.content;
			
		}
		function qErr(rec){}
		category.unifydo({
			Action:"EquCategory",
			pageNo:0,pageSize:99
		},qSucc,qErr);
	};
	
	/*
	 * 选择下拉框分类信息时，查询分类名称
	 */
	$scope.changeEquipmentCategoryName=function(parm){
		
		$scope.openProSelectChange();//调用改变方法
		var o = document.getElementById("attrTypeSelect");
		$scope.formParms.equipmentCategoryName=o.options[o.selectedIndex].text;//拿到选择选项的文字
	/*	for(var i=0;i<$scope.categorySelectList.length;i++){
			if($scope.categorySelectList[i].equipmentCategoryNo==parm){
				parm=$scope.categorySelectList[i].equCategoryId;
				break;
			}
		}*/
		function qSucc(rec){
			$scope.nameSelectList=rec.content;
		}
		function qErr(rec){}
		category.unifydo({
			Action:"EquName",
			equCategoryId:parm,
			pageNo:0,pageSize:99
		},qSucc,qErr);
	};
	
	/*
	 * 查询分类名称
	 */
	$scope.changeEquipmentName=function(){
		var o = document.getElementById("equipmentSelect");
		$scope.formParms.equipmentName=o.options[o.selectedIndex].text;
	};
	
	
    $scope.getEquNames = function(id,flag){
    	if(id){
    	  	function qSucc(reca){
    			$scope.nameSelectListUpd = reca.content;
    			if(flag){
    				$scope.formParm.equNameId = '';//后加的12.20
    			}
    			
    		}
    		function qErr(){}
    		category.unifydo({Action:"EquName",equCategoryId:id,pageNo:0,pageSize:99},qSucc,qErr);
        	
        	return id;
    	}else{
    		$scope.nameSelectListUpd = [];
    	}
    	
    };
	
	
	
	
	/*
	 * 选择下拉框分类信息时，查询分类名称Upd
	 */
	$scope.changeEquipmentCategoryNameUpd=function(){
		$scope.openProSelectChange();//调用改变方法
		$scope.getEquNames($scope.formParm.equCategoryId,1);

	};
	
	//查询分类名称-修改
	$scope.changeNameUpd = function(parm){
		var o = document.getElementById("equipment");
		$scope.formParm.equipmentName=o.options[o.selectedIndex].text;
	};
	
	/*
	* 关闭添加窗口
	*/
	$scope.closeWindowAdd = function(){
    	$('#categoryModalId').modal('hide');
	};
	
	/*
	* 关闭修改窗口
	*/
	$scope.closeWindowUpd = function(){
		$scope.queryCategoryData();
    	$('#categoryUpdate').modal('hide');
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 给下拉框定一个值展开
	 */
	var judgeSelect = true;
	$scope.openProSelect = function(obj,obj2,obj3){//按照1、2、3的顺序，点击下拉框（1），改变一个值（2），下拉框收回去(3),这是一个循环
		$scope.outClickFlag = false;//（1）先触发这里的select
		$scope.click_flag = obj3;//分辨点击的是哪一个select
		if(judgeSelect){//1
			$("#"+obj).attr("size",$scope[obj2].length); 
		}else{
			judgeSelect = true;//3
			$("#"+obj).attr("size",1);
		}
	};
	
	/**
	 * 给下拉框定一个值展开的改变方法（也就是点击具体值后，改变值的方法）
	 */
	$scope.openProSelectChange=function(){
		judgeSelect = false;//2
	};
	
	/**
	 * 点击外面的情况
	 */
	$scope.outClickFlag = true;
	$scope.click_BlurToInitFun = function(obj1,obj2,obj3,obj4){
		
		if($scope[obj3] && $scope[obj3].length > 10){
			

			if($scope.outClickFlag){//（3）当点击外面的时候触发的这里把select收回去这时因为之前转成了true所以成功进来了，也相当于恢复了初始状态
				if(obj1){
					$("#"+obj1).attr("size",1);
				}
				/*if(obj2){
					$("#"+obj2).attr("size",1);
				}*/
			}else{//(2)触发完外面的select紧接着触发的这里的点击事件进入这里恢复成true，相当于第一次点击什么事情都没发生
				if($scope.click_flag && $scope.click_flag == 'class_'){
					$scope.outClickFlag = true;
				}
			}
		}
		
		if($scope[obj4] && $scope[obj4].length > 10){//当数组长度大于时在执行，不足10个的时候得点两下
		

			if($scope.outClickFlag){//（3）当点击外面的时候触发的这里把select收回去这时因为之前转成了true所以成功进来了，也相当于恢复了初始状态
			/*	if(obj1){
					$("#"+obj1).attr("size",1);
				}*/
				if(obj2){
					$("#"+obj2).attr("size",1);
				}
			}else{//(2)触发完外面的select紧接着触发的这里的点击事件进入这里恢复成true，相当于第一次点击什么事情都没发生
				if($scope.click_flag && $scope.click_flag == 'name'){
					$scope.outClickFlag = true;
				}
			}
		}
	};
	/*	*//**
		 * 点击外面的情况
		 *//*
		$scope.outClickFlag = true;
		$scope.click_BlurToInitFun = function(obj1,obj2){
			if($scope.outClickFlag){//（3）当点击外面的时候触发的这里把select收回去这时因为之前转成了true所以成功进来了，也相当于恢复了初始状态
				$("#"+obj1).attr("size",1);
				$("#"+obj2).attr("size",1);
			}else{//(2)触发完外面的select紧接着触发的这里的点击事件进入这里恢复成true，相当于第一次点击什么事情都没发生
				$scope.outClickFlag = true;
			}
		};*/

	
	$scope.cleanDateFunEnd = function(obj,obj2,obj3,obj4,obj5,obj6){
		$scope[obj3][obj4] = '';
		if(obj6){
			$("#"+obj2).focus();
		}
		$scope['flagShow'+obj] = false;
		if(obj5 && $scope[obj5] == true){
			$scope[obj5] = false;
		}
	};
	
	$scope.clickInput = function(obj,obj2){//obj:输入参数;obj2：控制flag显示
		if(obj && obj.length > 0){//有输入值有叉号，反之没有
			$scope['flagShow'+obj2] = true;
		}else{
			$scope['flagShow'+obj2] = false;
		}
	};
	
	$scope.blurInput = function(obj,obj2,obj3,obj4,obj5){//obj：控制flag显示
		
		
		if(obj4 && obj4 == 'yesNo3'){
			
			function qSucc(rec){
				
				
				if(obj5 && obj5=="add"){
					if($scope.formParms.equNo && $scope.formParms.equNo.length>0 && rec.msg.length>0){
						$.messager.popup("设备编号不可以重复！");
						$("#_equNoId").val('');
						$scope.formParms.equNo = '';
						$("#_equNoId").focus();
						return;
					}
				}
				
				if(obj5 && obj5=="upd"){
					if($scope.formParms.equNo && $scope.formParms.equNo.length>0 &&rec.msg.length>0){
						if($scope.selectequip.id != rec.msg[0].equipmentId){
							$.messager.popup("设备编号不可以重复！");
							$("#_equNoId").val('');
							$scope.formParms.equNo = '';
							$("#_equNoId").focus();
							return;
						}
					}
				}
				
			};
			
			function qErr(){}
			
			equipment.unifydo({Action:'GetByEquNo',equNo:$scope.formParms.equNo},qSucc,qErr);
		}
		
		$timeout(function() { // 延迟0.15秒这样能优先执行清除日期的方法达到赋值，要不点击会直接清除叉号不会执行清除日期的方法不能赋值 
			$scope['flagShow'+obj] = false;
			$scope[obj2] = false;
			$scope[obj3] = [];
	     },150);
	};
	
	$scope.changeProFun = function(inputValue,showFlag,_equOutCom){
		if(!inputValue){//如果输入框没有值了，就隐藏下面的展示结果域
			if(showFlag){
				$scope[showFlag] = false;
			}
			$scope['flagShow'+_equOutCom] = false;
			//$scope.flagShow_equOutCom = false;
		}else{
			$scope['flagShow'+_equOutCom] = true;
		}
		if(inputValue && inputValue.length > 0){
			$scope.showFlag = '';
		}
		
		if(inputValue && inputValue.length > 11){
			$scope.showFlag = '';
		}
		
		var verify = /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)/;
		
		if(verify.test($scope.formParms.contactPersonPhone)){
			$scope.showFlag = '';
		}
	};
	
	setTimeout(function() {
	    $scope.$apply(function() {
	    	var inputs = document.getElementsByTagName("input");
	    	var pf=new window.placeholderFactory(); 
	    	pf.createPlaceholder(inputs);
	    	//document.getElementById("eeeee").value="asd";
	    });  
	}, 500);
	
});