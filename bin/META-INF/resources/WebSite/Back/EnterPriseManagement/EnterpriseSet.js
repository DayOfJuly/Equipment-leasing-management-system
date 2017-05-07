app.controller('EnterpriseController',function($scope,entSvc,regionSvc,SYS_CODE_CON,sysCodeTranslateFactory){

    //ie9下titile正确显示使用
	document.title="企业设置";
	
	/*水印信息*/
	$scope.placeholders={
		note_:"请输入字符在120个以内"
	};
	
	
	$scope.IEChange=function(obj,parm){
		if ((navigator.userAgent.indexOf('Firefox')<0) && (navigator.userAgent.indexOf('Chrome')<0) && (navigator.userAgent.indexOf('Safari')<0)  && (navigator.userAgent.indexOf('Opera')<0)){
				 $("#brandSelect__").blur();
		}
	};
	
    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    
    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
    
    $scope.userInfo = {};
    $scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
    
    
	/*
	 * 获取当前点击对象ID currOrgId--currOrgIdParm
	 */
	$scope.selectObj=function(obj){
		$scope.currOrgIdParm=obj;
	};	
	
	/*
	 * 分页
	 */
	$scope.paginationConf = {
        
        currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10, 15,20, 30, 40, 50],
        
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        onChange:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	$scope.queryPerson();
        	$scope.radioTrIndex=null;
        	if($scope.radioTrIndex==null){
        		$scope.currOrgIdParm=null;
        	}
        }
    };
	
	
	
	
	$scope.OpenEnterPriseAddPage = function(){
		$("#EnterPriseModal").modal({backdrop: 'static', keyboard: false});
	};
	
	/*
	 * 关闭窗口
	 */
	$scope.closeWindow = function(){
		//清空行政地区下拉框
		//$scope.areaList=[];
	//	$scope.pList=[];
	//	$scope.cList=[];
		//清楚验证信息
		$scope.showFlag = '';
		$scope.allparms={};
	};
	
	$scope.closeWindowQuery = function(){
		$("#EnterPriseQueryModal").modal('hide');
	};
	
	$scope.testFun = function(){
		
		$scope.changeListValue($scope.entityList,'code');
		$scope.changeListValue($scope.entityList,'name');
		$scope.changeListValue($scope.entityList,'parentCode');
		//$scope.changeListValue($scope.entityList,'updateTime'); 
	};
	
    /*
    * 查询列表
    */
	$scope.btnShow_ = true;//按钮显示初始化
	$scope.queryPerson = function(pageNo){
		if(pageNo){
			$scope.paginationConf.currentPage = 1;
		}
 		function qSucc(rec){
 			if(rec.content.length!=0){
 				$scope.entityList={};
 	 			$scope.entityList = rec.content;
 	 			$scope.testFun();
 	 			$scope.paginationConf.totalItems = rec.totalElements;
 	 			$scope.btnShow_ = true;
 			}else{
 				$scope.btnShow_ = false;
 				$scope.paginationConf.totalItems = rec.totalElements;
 			}
 		}
 		function qErr(rec){}
 		entSvc.queryPartyInstallList({
			currOrgId:SYS_USER_INFO.orgId,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
		},qSucc,qErr);
	};

	
	 /*
	 * 选择查询-查看
	 */
	$scope.queryPersonList=function(parm){
		$scope.judgeAddUpd = parm;
		if(!$scope.currOrgIdParm){
			$.messager.popup("请选择查询对象!");
			return;
		}
		function qSucc(rec){
			if(rec){
				$scope.allparms=rec;
				if($scope.allparms.name){
					$scope.allparms.nameCopy = $scope.allparms.name;
					
					if($scope.allparms.name && $scope.allparms.name.length > 18){
						$scope.allparms.nameCopy=$scope.allparms.nameCopy.substring(0,18)+'...';
					}
				}
				if(rec.district){
					$scope.allparms.pro=rec.province.name;
					$scope.allparms.cit=rec.city.name;
					$scope.allparms.dis=rec.district.name;
				}
				/*$("#EnterPriseQueryModal").draggable();
				$("#EnterPriseQueryModal").draggable('disable');*/
				$('#EnterPriseQueryModal').modal({backdrop: 'static', keyboard: false});
			}
		}
		function qErr(rec){}
		//查询对象
		entSvc.queryPartyInstallDetail({id:$scope.currOrgIdParm},qSucc,qErr);
	};	
	
	/*
	 * 弹出-添加-模态框
	*/
	$scope.areaList=[];
	$scope.recPro={};
	$scope.openAddModal=function(parm){

		$scope.showFlag = '';
		$scope.allparms={};
		$scope.allparms.orgParentCode = SYS_USER_INFO.orgCode;
		$scope.allparms.code = $scope.allparms.orgParentCode+'xxx';
		$scope.allparms.parentCode = SYS_USER_INFO.orgCode;
		$scope.judgeAddUpd = parm;/* 表示添加用的标识  */
		/*if($scope.allparms.note){
			$("#note").css('color','#000000');
		}else{
			$("#note").css('color','#A0A0A0');
		}*/
		
	/*	$("#EnterPriseModal").draggable();
		$("#EnterPriseModal").draggable('disable');*/
		$('#EnterPriseModal').modal({backdrop: 'static', keyboard: false});
		setTimeout(function() {
		    $scope.$apply(function() {
		    	var textareas = document.getElementsByTagName("textarea");
		    	var pf=new window.placeholderFactory(); 
		    	pf.createPlaceholder(textareas);
		    	//document.getElementById("eeeee").value="asd";
		    });  
		}, 10);
	};
	
	/*
	 *省份
	*/
	$scope.province="";//省份标识名
	$scope.changePro=function(obj){
		$scope.province = obj.recPro.regionId;
		if(obj.recPro.regionId == null){
			$scope.pList=[];
			$scope.cList=[];
		}else{
			function qSucc(rec){
				$scope.pList=[];
				$scope.pList=rec;
				$scope.cList={};
			}
			function qErr(rec){}
			regionSvc.queryRegionArea({regionId:$scope.province},qSucc,qErr);
		}
		if($scope.province){
			$scope.showFlag = 'city';
		}else{
			$scope.showFlag = '';
		}
	};
	
	/*
	 *城市
	*/
	$scope.city="";	//市区标识名
	$scope.changeCity=function(obj){
		$scope.city = obj.recC.regionId;
		function qSucc(rec){
			$scope.cList=[];
			$scope.cList=rec;
		}
		function qErr(rec){}
		regionSvc.queryRegionArea({regionId:$scope.city},qSucc,qErr);
		if($scope.city){
			$scope.showFlag = 'district';
		}else if(!$scope.province){
			$scope.showFlag = 'province';
		}else{
			$scope.showFlag = 'city';
		}
	};
	
	/*
	 *区县
	*/
	$scope.district="";//区县标识名
	$scope.changeDis=function(obj){
		$scope.district= obj.recD.regionId;
		if(!$scope.province){
			$scope.showFlag = 'province';
		}else if(!$scope.city){
			$scope.showFlag = 'city';
		}else{
			$scope.showFlag = '';
		}
		if($scope.district){
			$scope.showFlag = '';
		}
	};
	
	/*
	 * 添加企业设置                                                                                                              
	*/
	
	$scope.addLoanApply=function(obj){
		if(obj.$valid){
/*			$scope.allparms.parTypeId=4; */                                              
			//上级部门ID
			$scope.allparms.parentOrgId = SYS_USER_INFO.orgId;/* 修改这里就能修改整体的企业 */
			$scope.allparms.parentCode = SYS_USER_INFO.orgCode;
			function aSucc(rec){
				$scope.closeWindow();
				$scope.queryPerson(1);
				$.messager.popup("添加成功！");
				$('#EnterPriseModal').modal('hide');
				$scope.paginationConf.totalItems = rec.totalElements;
			}
			function aErr(rec){
				if(rec.data.message == "编号重复，请重新输入"){
					$.messager.popup("编号重复，请重新输入");
				}
				else if(rec.data.message == "名称重复，请重新输入"){
					$.messager.popup("名称重复，请重新输入");
				}
				else{
					$.messager.popup(rec.data.message);
				}
				//$scope.closeWindow();
			}
			entSvc.addPartyInstallDetail($scope.allparms,aSucc,aErr);
		}else{
			if($scope.allparms.code == '' || $scope.allparms.code == null){
				if(obj.code && !obj.code.$valid){
					$scope.showFlag = 'code';
				}
			}
			else if(!obj.name.$valid){
				$scope.showFlag = 'name';
			}
			else if(!obj.orgLevel.$valid){
				$scope.showFlag = 'orgLevel';
			}
			else if(!obj.note.$valid){
				$scope.showFlag = 'note';
			}
			return;
		}
	};
	/*
	 * 弹出-修改-模态框
	*/
	//$scope.recPro.regionId="";
	$scope.openUpdModal=function(parm){
		 if(!$scope.currOrgIdParm){
			$.messager.popup("请选择一条信息！");
			return;
		}
		 
		$scope.showFlag = '';
		$scope.allparms={};
		 
		$scope.judgeAddUpd = parm;
		function qSucc(rec){
		
			$scope.allparms=rec;
			$scope.allparms.orgParentCode = rec.parentCode;
			
	/*		$("#EnterPriseModal").draggable();
			$("#EnterPriseModal").draggable('disable');*/
			$('#EnterPriseModal').modal({backdrop: 'static', keyboard: false});
			setTimeout(function() {
			    $scope.$apply(function() {
			    	var textareas = document.getElementsByTagName("textarea");
			    	var pf=new window.placeholderFactory(); 
			    	pf.createPlaceholder(textareas);
			    	//document.getElementById("eeeee").value="asd";
			    });  
			}, 10);
		}
		function qErr(rec){}
		entSvc.queryPartyInstallDetail({id:$scope.currOrgIdParm},qSucc,qErr);
	};
	
	/*
	 * 修改企业设置
	*/
	$scope.updLoanApply=function(obj){
		if(obj.$valid){
			$scope.allparms.partyId=$scope.allparms.partyId;
			
			function uSucc(){
				$scope.queryPerson(1);
				$scope.radioTrIndex=1;
				$.messager.popup("修改成功！");
				$('#EnterPriseModal').modal('hide');
			}
			function uErr(){
				$.messager.popup("修改失败！");
				$('#EnterPriseModal').modal('hide');
			}
			entSvc.updatePartyInstallDetail({ id:$scope.currOrgIdParm },$scope.allparms,uSucc,uErr);
		}else{
			 if(!obj.name.$valid){
				$scope.showFlag = 'name';
			}
			else if(!obj.orgLevel.$valid){
				$scope.showFlag = 'orgLevel';
			}
			return;
		}
	};
	/*
	 * 删除借款申请
	*/
	$scope.deleteLoanApply=function(){
		if(!$scope.currOrgIdParm){
			$.messager.popup("请选择一条信息！");
			return;
		}
		$.messager.confirm("提示", "是否删除？", function() { 
			function dSucc(rec){
				$.messager.popup("删除成功!");
				$scope.closeWindow();
				$scope.queryPerson(1);
			}
			function dErr(rec){
				$.messager.popup(rec.data.message);
				$scope.closeWindow();
			}
			//删除方法
			entSvc.deletePartyInstallDetail({id:$scope.currOrgIdParm},dSucc,dErr);
	    });
	};
	
	/*//点击行选中radio
	$scope.radioList={};
	$scope.selectRadio = function(parm,obj){
		var num = 0;
		for(var rec in $scope.radioList){
			$scope.radioList['radioId'+num]=false;
		}
		$scope.radioList['radioId'+parm]=true;
		$scope.selectObj(obj);
	};*/
	
	$scope.radioList={};
	//选中订单ID
	$scope.check = function(params,varl){
		$scope.radioTrIndex=varl;
		$scope.selectObj(params.currOrgId);
	};
	
	//千位分隔符
	$scope.formData={};
	$scope.formatMoney=function(num){
		if(num==null||num==""){
			return;
		}
		//找到小数点
		var judge = num.indexOf(".");
		var cents=0;
		if(judge>0){
			num = "0";
		}
		num = num.toString().replace(/\,/g,'');
		if(isNaN(num))
		num = "0";
		sign = (num == (num = Math.abs(num)));
		num = Math.floor(num*100+0.50000000001);
		num = Math.floor(num/100).toString();
		for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
		num = num.substring(0,num.length-(4*i+3))+','+
		num.substring(num.length-(4*i+3));
		if(cents!=0){
			$scope.allparms.budget=(((sign)?'':'-') + num+cents);
		}else{
			$scope.allparms.budget=(((sign)?'':'-') + num );
		}
	};
	
	

	//截取字符串js，超出八位截取，不超出直接赋值给新变量
	$scope.changeListValue = function(objList,obj){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i][obj]&&objList[i][obj].length>15)
			{
				objList[i][obj+'Temp']=objList[i][obj].substr(0,15)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
			}
			else
			{
				
				objList[i][obj+'Temp']=objList[i][obj];
			}
			
		}

	};	
	
	/*$scope.copyList = [{name:'1234567890'}];
	$scope.changeListValue($scope.copyList,'name');*/
	
	
	
	
	
	/*//截取字符串js，超出八位截取，不超出直接赋值给新变量
	$scope.changeListValue = function(objList){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i].infoTitle&&objList[i].infoTitle.length>8)
			{
				objList[i].infoTitleTemp=objList[i].infoTitle.substr(0,8)+"..."; 将infoTitle截取长度后赋值给infoTitleTemp 
			}
			else
			{
				
				objList[i].infoTitleTemp=objList[i].infoTitle;
			}
			
		}

	};
	*/
	
	
	
	
	
	
	
	
	
	 $('html').bind('keyup', function(e)
				{
			          //当按下回车的时候
					  if(e.keyCode == 13)
					  {
						   //当焦点为输入框的id的时候
						  if(document.activeElement.id=="fuzzyData"){
							  //把ng-model的数值强制赋给输入框本身的value
							 //$("#purId").val($scope.fuzzyData);
							 //$scope.queryTemPartyList(1);
							  $("#qurId").click();
							 
						  } 
						 
						
					  
					  }
				});

	 
	   if(SYS_USER_INFO.orgLevel == 3){
		   $scope.btnShowAdd_ = false;//处级不显示添加按钮
	    	$.messager.popup("您的权限不足以操作此界面！！！");
	    	return;
	    }else{
	    	$scope.btnShowAdd_ = true;
	    }
	   
	   
	   $scope.loseFocus = function(){
		   $("#brandSelect__").blur();
	   };
	 
		
});