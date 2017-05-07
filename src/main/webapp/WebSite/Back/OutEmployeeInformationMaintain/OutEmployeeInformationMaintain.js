app.controller('OutEmployeeAppController', function($scope,$timeout,$upload,CheckEmployeeTrueOrFalseOutSvc,personSvc,roleSvc,entSvc,personMsgSvc,downloadSvc,authoritySvc,SYS_CODE_CON,sysCodeTranslateFactory,regionSvc,personOutSvc,published,proSvc,PicUrl,personOutSvc) {
	
	//ie9下titile正确显示使用
	document.title="外部员工信息维护"
	
	$scope.placeholders={
			note:"请输入字符在60个以内"
	}
	
	//111                                                 
    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    
    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	
	
	
    $scope.userInfo = {};
    $scope.userInfo.orgCode=SYS_USER_INFO.orgCode;
    $scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
    $scope.userInfo.orgLevel_show=SYS_USER_INFO.orgLevel;

	$scope.employeeEntity= {};
	
	$scope.employeeEntity = {'equipmentPic': ''};//声明图片初始路径
	
	$scope.showLevel = null;
	$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
	$scope.employeeEntity.orgId_ = SYS_USER_INFO.orgId;
	
	if($scope.employeeEntity.orgName && SYS_USER_INFO.orgId < 3){
		$scope.showLevel = true;
	}else if(!$scope.employeeEntity.orgName || SYS_USER_INFO.orgId > 2){
		$scope.showLevel = false;
	}
	/**
	 * 获取权限列表
	 */
	$scope.getAuthorityList = function(){
		authoritySvc.queryAuthorities({funType:2},function(rec){
			$scope.authorityList = rec.content;
		},function(){});
	};
	/**
	 * 页面加载的时候调用此方法，初始化用户的功能列表
	 */
	$scope.getAuthorityList();
	
	$scope.queryBtnState = true;//判断修改页面查询按钮的显示状态
	
	$scope.changeName = function(){//当修改员工名字的时候如果和之前同名则不可点击查询
		$scope.employeeEntity.loginId = $("#updId_").val();
		if($scope.employeeEntity.loginId != $scope.flagId){
			$scope.queryBtnState = false;
		}else if($scope.employeeEntity.loginId == $scope.flagId){
			$scope.queryBtnState = true;
		}
	};
	

	
/*	//假设当前登录的用户所在的企业ID是5
	if($scope.userCookies!=null||$scope.userCookies!=""){
		$scope.user={currOrgId:$scope.userCookies.orgId,orgName:$scope.userCookies.orgName};
	}*/
	
	
	//分页
	$scope.paginationConf = {
		
	 	currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10,15, 20, 30, 40, 50],
        
        
		/*
		 * parm1:当前选择页数
		 * parm2:每页显示多少
		 */
		 onChange : function(parm1, parm2) {
		/*	if($scope.fuzzyData){
				$scope.queryTemPartyList();
			}else{
				$scope.queryEmployeeList();
			}*/
			//$scope.queryEmployeeList();
			 $scope.queryTemPartyList();
			$scope.paginationConf.currentPage=parm1;
			$scope.radioTrIndex=null;
			if($scope.radioTrIndex==null){
				$scope.partyId=null;
			}
		}
	};
	$scope.btnShow_ = true;//按钮显示初始化

	//列表查询
	$scope.queryEmployeeList = function(PageNo){
		if(PageNo){
			$scope.paginationConf.currentPage = 1;
		}
		function qSucc(rec){
		    if(rec.content.length!=0){
				if($scope.enterpriseState=="1"||$scope.enterpriseState=="0"){
					$scope.enterpriseState=rec.content[0].state;
				}
				$scope.saveParams = rec;//这个值用于查询子企业的员工后，和他们拼接用
				$scope.entityList=[];
				$scope.entityListFirst=null;
				$scope.paginationConf.totalItems = rec.totalElements;
			    $scope.entityList = rec.content;
			    $scope.entityListFirst=$scope.entityList[0];// 把第一个值赋值给变量用于当作条件用做第二次点击停用启用按钮不选择新一行的情况给状态赋当前新的状态值   
				    if(rec.content.length>0){
					    if($scope.entityListFirst.state==0){// 如果当前状态值为0 
					    	  $scope.personState = 0;// 把person状态赋值为0用于点击停用启用按钮页面提交按钮的赋值 
					    }else if($scope.entityListFirst.state==1){// 同上 
					    	  $scope.personState = 1;
					    } 
				    }
					for (var i = 0; i < rec.content.length; i++) {
						if (rec.content[i].state == 0) {
							$scope.entityList[i].stateTemp = "正常";
							$scope.entityList[i].orgName = SYS_USER_INFO.orgName;
						} else if (rec.content[i].state == 1) {
							$scope.entityList[i].stateTemp = "停用";
							$scope.entityList[i].orgName = SYS_USER_INFO.orgName;
						}
					}
					
				$scope.btnShow_ = true;
		    }else{
		    	$scope.btnShow_ = false;	
		    }
		
		}
		function qErr(){}
		personOutSvc.queryPersonList({
			parTypeId:3,
			currOrgId:$scope.employeeEntity.orgId_,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
		},qSucc,qErr);
	};
	
	//条件查询
	$scope.formParm = {};
	$scope.queryTemPartyList = function(pageNo){
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function qSucc(rec){
			if(rec.content){
			/*	if(rec.content.length == 0){
					$scope.btnShow_ = false;	
					$scope.entityList=[];
					$.messager.popup("没有查询到相关数据");
					$scope.paginationConf.totalItems = rec.totalElements;
					//$scope.paginationConf.totalItems=0;
					return;
				}else{
					$scope.btnShow_ = true;	
					$scope.paginationConf.totalItems = rec.totalElements;
				}*/
				
				if(!pageNo){
					if(rec.content.length == 0){
						$scope.btnShow_ = false;	
						$scope.btnShowAdd_ = true;
						$scope.entityList=[];
						$.messager.popup("没有查询到相关数据");
						return;
					}else{
						$scope.btnShow_ = true;	
						$scope.btnShowAdd_ = true;
						$scope.paginationConf.totalItems = rec.totalElements;  
					}
				}
				
				if(pageNo){
					if(rec.content.length == 0){
						$scope.btnShow_ = false;	
						$scope.btnShowAdd_ = true;
						$scope.entityList=[];
						$.messager.popup("没有查询到相关数据");
						return;
					}else{
						$scope.btnShow_ = true;	
						$scope.btnShowAdd_ = true;
						$scope.paginationConf.totalItems = rec.totalElements;  
					}
				}
				
				if($scope.employeeEntity.isInclude == 1){
					$scope.employeeEntity.isInclude = true;
				}
				
				if($scope.employeeEntity.isInclude == 0){
					$scope.employeeEntity.isInclude = false;
				}
				$scope.entityList=[];
				//$scope.paginationConf.totalItems = rec.totalElements;  相当于又调用了一次分页重新查了一次列表
				for (var i = 0; i < rec.content.length; i++) {
					if (rec.content[i].state == 0) {
						$scope.entityList = rec.content;
						$scope.entityList[i].stateTemp = "正常";
						/*$scope.entityList[i].orgName = SYS_USER_INFO.orgName;*/
					} else if (rec.content[i].state == 1) {
						$scope.entityList = rec.content;
						$scope.entityList[i].stateTemp = "停用";
						/*$scope.entityList[i].orgName = SYS_USER_INFO.orgName;*/
					}
				}
				
				for(var i =0;i<$scope.entityList.length;i++){
					$scope.entityList[i].loginIdCopy = $scope.entityList[i].loginId;
					if($scope.entityList[i].loginId && $scope.entityList[i].loginId.length > 14){
						$scope.entityList[i].loginIdCopy = $scope.entityList[i].loginIdCopy.substring(0,14)+"...";
					}
					$scope.entityList[i].nameCopy = $scope.entityList[i].name;
					if($scope.entityList[i].name && $scope.entityList[i].name.length > 14){
						$scope.entityList[i].nameCopy = $scope.entityList[i].nameCopy.substring(0,14)+"...";
					}
					$scope.entityList[i].codeCopy = $scope.entityList[i].code;
					if($scope.entityList[i].code && $scope.entityList[i].code.length > 14){
						$scope.entityList[i].codeCopy = $scope.entityList[i].codeCopy.substring(0,14)+"...";
					}
					$scope.entityList[i].phoneNoCopy = $scope.entityList[i].phoneNo;
					if($scope.entityList[i].phoneNo && $scope.entityList[i].phoneNo.length > 14){
						$scope.entityList[i].phoneNoCopy = $scope.entityList[i].phoneNoCopy.substring(0,14)+"...";
					}
					$scope.entityList[i].mailCopy = $scope.entityList[i].mail;
					if($scope.entityList[i].mail && $scope.entityList[i].mail.length > 14){
						$scope.entityList[i].mailCopy = $scope.entityList[i].mailCopy.substring(0,14)+"...";
					}
					$scope.entityList[i].orgNameCopy = $scope.entityList[i].orgName;
					if($scope.entityList[i].orgName && $scope.entityList[i].orgName.length > 14){
						$scope.entityList[i].orgNameCopy = $scope.entityList[i].orgNameCopy.substring(0,14)+"...";
					}
					$scope.entityList[i].updateTimeCopy = $scope.entityList[i].updateTime;
					if($scope.entityList[i].updateTime && $scope.entityList[i].updateTime.length > 14){
						$scope.entityList[i].updateTimeCopy = $scope.entityList[i].updateTimeCopy.substring(0,14)+"...";
					}
				}
			}
		}
		function qErr(rec){
			if(rec.data.message){
				$.messager.popup("查询失败");
			}
		}
		if($scope.employeeEntity.isInclude == true){
			$scope.employeeEntity.isInclude = 1;
		}
		
		if($scope.employeeEntity.isInclude == false){
			$scope.employeeEntity.isInclude = 0;
		}
		if(!$scope.employeeEntity.changeOrgId){
			$scope.employeeEntity.changeOrgId = $scope.employeeEntity.orgId_;
		}
		if(!$scope.employeeEntity.code){
			$scope.employeeEntity.code = $scope.userInfo.orgCode;
		}
		personOutSvc.queryPersonList({
			parTypeId:3,
			orgCode:$scope.employeeEntity.code,
			departmentName:$scope.employeeEntity.orgName,
			/*currOrgId:$scope.employeeEntity.changeOrgId,*/
			currOrgId:$scope.employeeEntity.orgId_,
			fuzzyData:$scope.formParm.fuzzyData,
			isInclude:$scope.employeeEntity.isInclude,
			proPartyId:$scope.employeeEntity.proId,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
		},qSucc,qErr);
		
	
	};
	
	
	
	
	
	//查询功能，获取下级部门
	$scope.queryNextDepartment = function(varl){
		entSvc.queryPartyInstallList({parTypeId:5,currOrgId:Number(varl)}, function(rec){
			if(rec.content.length <= 0){
				$scope.searchDeptList = {};
				return;
			}else if(rec.content.length > 0){
				$scope.searchDeptList = rec.content;
			}
		},function(){
			$.messager.popup("获取部门列表失败");
		});
	};
	

	
	//判断更新添加按钮
	$scope.actionFlag = {add:false,update:false};
	
	//查看员工详细信息
	$scope.openCheckDetail = function(flag){
		if($scope.partyId){
			$scope.actionFlag = {add:false,update:false};
			$scope.getEmployee();
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}	
		if(flag == 1){
			$("#EmployeeDetailId").modal({backdrop: 'static', keyboard: false});
		}
		
		if(flag == 4){
			$("#EmployeeState").modal({backdrop: 'static', keyboard: false});
		}
	};
	

	
	//查询角色功能
	$scope.queryRoleFunction = function(varl){
		roleSvc.getRoleDetail({id:varl},function qSucc(rec){
			$scope.queryRoleFunctionList = [];//
			for(var i=0;i<rec.funcInfo.length;i++){
				$scope.queryRoleFunctionList.push(rec.funcInfo[i]);
			}
		},function qErr(){});
	};
	
	//勾选已经选中的角色   
	$scope.checkRole = function(userFunList){
		$scope.getAuthorityList();
		$scope.authorityListTemp = $scope.authorityList;
		var num = 0;
		if(userFunList){
			for (var i = 0; i < $scope.authorityListTemp.length; i++) {
				for(var j = 0; j < userFunList.length; j++){
					if ($scope.authorityListTemp[i].functionId == userFunList[j].funId) {
						$scope.authorityListTemp[i].chck = true;
						
						if($scope.authorityListTemp[i].chck == true){//增加一个计数器用于和数组比对看看是否全部勾选为true
							num++;
							if(num == $scope.authorityListTemp.length){//全勾上就显示全取消
								$("#allSelectAdd").val("全取消");
								$("#allSelectUpd").val("全取消");
							}else{
								$("#allSelectAdd").val("全选");
								$("#allSelectUpd").val("全选");
							}
						}
					}
					
					if(i%2==0)
					{
						$scope.authorityListTemp[i].firstTr = true;
					}
					else
					{
						$scope.authorityListTemp[i].secondTr = true;
					}
					$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
					if($scope.authorityListTemp[i].showName.length > 11){
						$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
					}					
					
//					if($scope.authorityListTemp[i].functionId == 10||$scope.authorityListTemp[i].functionId == 11||$scope.authorityListTemp[i].functionId == 12){
//						$scope.authorityListTemp[i].firstTr = true;
//					}
//					if($scope.authorityListTemp[i].functionId == 13||$scope.authorityListTemp[i].functionId == 14||$scope.authorityListTemp[i].functionId == 17){
//						$scope.authorityListTemp[i].secondTr = true;
//						$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
//						if($scope.authorityListTemp[i].showName.length > 11){
//							$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
//						}
//					}
				}
			}
			
		}
		
	};
	
//获取选中功能信息  2016.1.5因需要回显授权名字不需要选择所以注释以作备份
	$scope.getCheckRoles = function(objList_){
		$scope.employeeEntityAdd.funInfo = [];
		for(var j = 0; j < $scope[objList_].length; j++){
			if($scope[objList_][j]){
				$scope.employeeEntityAdd.funInfo.push({functionId:$scope[objList_][j].functionId});
			}
		}
	};
	
	//获取选中功能信息
//	$scope.getCheckRoles = function(objList_){
//		$scope.employeeEntityAdd.funInfo = [];
//		$scope.employeeEntityAdd.funInfo.push({functionId: 10},{functionId: 11},{functionId: 12},{functionId: 13},{functionId: 14},{functionId: 17});
//	};
	

	//根据员工ID 获取员工详细信息
	
	$scope.getEmployee = function(){
		if(!$scope.partyId){
			$.messager.popup("请选择一条记录");
			return;
		}else{
			personOutSvc.queryPerson({id:$scope.partyId},
			function qSucc(rec){
				$scope.employeeEntityAdd = rec;//获得员工权限
				
				$scope.employeeEntityAdd.loginId_Copy = $scope.employeeEntityAdd.loginId;//记录登录名校验是否更改过
				
				$scope.employeeEntityAdd.loginUId = rec.uId;
				//$scope.checkRole($scope.employeeEntityAdd.funInfo);
				if($scope.employeeEntityAdd.funInfo && $scope.employeeEntityAdd.funInfo.length>0){
					$scope.checkRole($scope.employeeEntityAdd.funInfo);
				}else{
					$scope.getAuthorityList();
					$scope.authorityListTemp = $scope.authorityList;
					for (var i = 0; i < $scope.authorityListTemp.length; i++) {
						
						if(i%2==0)
						{
							$scope.authorityListTemp[i].firstTr = true;
						}
						else
						{
							$scope.authorityListTemp[i].secondTr = true;
						}
						$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
						if($scope.authorityListTemp[i].showName.length > 11){
							$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
						}	
						
//						if($scope.authorityListTemp[i].functionId == 10||$scope.authorityListTemp[i].functionId == 11||$scope.authorityListTemp[i].functionId == 12){
//							$scope.authorityListTemp[i].firstTr = true;
//						}
//						if($scope.authorityListTemp[i].functionId == 13||$scope.authorityListTemp[i].functionId == 14||$scope.authorityListTemp[i].functionId == 17){
//							$scope.authorityListTemp[i].secondTr = true;
//							$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
//							if($scope.authorityListTemp[i].showName.length > 11){
//								$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
//							}
//						}
						
					}
					if($scope.entityList[0].orgLevel == 3){//如果现在是给处级加员工就删掉企业设置的权限
						$scope.authorityListTemp.splice(0,1);
					}
				}
			},function qErr(rec){});
		}
	};
	
	//根据部门ID获得部门名称
	$scope.getDeptName = function(varl){
		entSvc.queryPartyInstallDetail({id:varl},function(rec){
			$scope.employeeEntity.deptName = rec.name;
			$scope.displayNameUpd = rec.name;
			$scope.employeeEntity.UpddeptId = $scope.user.currOrgId;
			$scope.employeeEntity.UpddeptName = $scope.user.orgName;
		},function(){
			$.messager.popup("获取部门详细信息失败");
		});
	};
	
	//根据登录名获取管理员信息
	$scope.returnMessage = {};
	$scope.getAdministrator = function(){
		$scope.employeeEntityAdd.orgName = '';
		$scope.employeeEntityAdd.phoneNo = '';
		$scope.employeeEntityAdd.mail = '';
		
		if($scope.employeeEntityAdd.loginId){
			function succ(rec){
				/*if(rec.status && rec.status == '1'){
					$scope.returnMessage.msg = true;
				}else{
					$scope.returnMessage.msg = false;
				}*/
				if(!rec.status){
					$scope.returnMessage.msg = true;
				}else{
					$scope.returnMessage.msg = false;
				}
				if(rec){
					$scope.employeeEntityAdd.phoneNo = rec.contactTel;
					$scope.employeeEntityAdd.mail = rec.email;
					$scope.employeeEntityAdd.deptName = rec.name;
					$scope.employeeEntityAdd.orgName = rec.name;
				}
				
			};
			
			function err(rec){
				if(rec.data.message){
					$scope.returnMessage.msg = false;
				}else{
					$scope.returnMessage.msg = true;
				}
				$.messager.popup(rec.data.message);
				return;
			};
			                                    
			CheckEmployeeTrueOrFalseOutSvc.unifydo({urlPath:$scope.employeeEntityAdd.loginId},succ,err);
		}else{
			$.messager.popup("请输入登录用户名");
		}
	};
	
	/**
	 * 打开添加员工信息页面	
	 */
	$scope.openAddEmployee = function() {
			/*初始化邮箱筛选*/
			var s1 = new Suggest();
			s1.init(); //执行初始化函数
			
		   // $scope.queryPerson();
			$scope.showFlag='';
			$scope.formParms.electronicMail = '';
			$scope.employeeEntityAdd= {};/*清空employeeEntity*/
			//$scope.employeeEntityAdd.orgName = $scope.employeeEntity.orgName;
	/*		$scope.PicList = [];
			$scope.PListLength = 0;*/
			//$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
			$scope.actionFlag = {add:true,update:false};
			$scope.getAuthorityList();
			$("#allSelectAdd").val("全选");
			$scope.authorityListTemp = $scope.authorityList;
			
			for(var i=0;i<$scope.authorityListTemp.length;i++){
				if(i%2==0)
				{
					$scope.authorityListTemp[i].firstTr = true;
				}
				else
				{
					$scope.authorityListTemp[i].secondTr = true;
				}
				$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
				if($scope.authorityListTemp[i].showName.length > 11){
					$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
				}
			}
			
//			for(var i=0;i<$scope.authorityListTemp.length;i++){
//				if($scope.authorityListTemp[i].functionId == 10||$scope.authorityListTemp[i].functionId == 11||$scope.authorityListTemp[i].functionId == 12){
//					$scope.authorityListTemp[i].firstTr = true;
//				}
//				if($scope.authorityListTemp[i].functionId == 13||$scope.authorityListTemp[i].functionId == 14||$scope.authorityListTemp[i].functionId == 17){
//					$scope.authorityListTemp[i].secondTr = true;
//					$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
//					if($scope.authorityListTemp[i].showName.length > 11){
//						$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
//					}
//				}
//			}
			$scope.employeeEntityAdd.mobile = '';
			
			$scope.PicList = [];
		    $scope.ay = [];
		    
		    $scope.employeeEntityAdd.orgName = '';
		    $scope.employeeEntityAdd.mail = '';
		    $scope.employeeEntityAdd.phoneNo = '';
		    
			$("#EmployeeAddId").modal({backdrop: 'static', keyboard: false});
			setTimeout(function() {
			    $scope.$apply(function() {
			    	var textareas = document.getElementsByTagName("textarea");
			    	var pf=new window.placeholderFactory(); 
			    	pf.createPlaceholder(textareas);
			    });  
			}, 10);
	};
	
	/**
	 * 添加员工信息
	 */
	$scope.formParms = {};
	$scope.addEmployeeEntity = function(obj){
		
		if(obj.$valid){
			
//			if($scope.returnMessage.msg == false ||!$scope.returnMessage.msg){
//				$.messager.popup("请查询过正确的登录名后在点击提交按钮");
//				return;
//			}
			
			$scope.getCheckRoles('authorityListTemp');/* 获取权限 */
		/*	$scope.getAuthorityList();
			$scope.authorityListTemp = $scope.authorityList;
			for(var i=0;i<$scope.authorityListTemp.length;i++){
				if($scope.authorityListTemp[i].functionId < 9){
					$scope.authorityListTemp[i].firstTr = true;
				}
				if($scope.authorityListTemp[i].functionId > 8){
					$scope.authorityListTemp[i].secondTr = true;
				}
			}*/
			//$scope.employeeEntityAdd.deptId = $scope.employeeEntity.changeOrgId;
			//$scope.employeeEntityAdd.deptName = $scope.employeeEntity.AdddeptName;
			//$scope.formParms.electronicMail=$("#electronicMail").val();
			$scope.employeeEntityAdd.email = $scope.formParms.electronicMail;
			$scope.employeeEntityAdd.uploadFileInfo=$scope.PicList;
			
			$scope.employeeEntityAdd.orgName = '外部企业' + (new Date()).getTime();
			
			personOutSvc.addPersonDetail($scope.employeeEntityAdd,function(rec){
				$.messager.popup("添加员工信息成功");
				$scope.searchEntity = {
					pageNo:0,
					currOrgId:$scope.employeeEntity.changeOrgId,
					pageSize:$scope.paginationConf.itemsPerPage
				};
				
				$scope.queryTemPartyList(1);
				$("#EmployeeAddId").modal('hide');
			},function(rec){
				if(rec.data.message){
					$.messager.popup(rec.data.message);
				}else{
					$.messager.popup("添加员工信息失败");
				}
				
			});
		}else{
			if(!obj.loginName.$valid){
				$scope.showFlag = 'loginName';//登录用户名
			}
			else if(!obj.name.$valid){
				$scope.showFlag = 'name';//员工姓名
			}
			else if(!obj.code.$valid){
				$scope.showFlag = 'code';//员工编号
			}
			else if(!obj.telephone.$valid){
				$scope.showFlag = 'telephone';//联系手机号
			}
			else if(!obj.qq.$valid){
				$scope.showFlag = 'qq';//qq
			}
			else if(!obj.electronicMail.$valid){
				$scope.showFlag = 'electronicMail';//email
			}
			return;
		}
	};
	
	//打开更新员工信息页面
	$scope.openUpdEmployee = function(){
		/*初始化邮箱筛选*/
		var s2 = new Suggest('electronicMailUpdOut','suggestUpdOut');
		s2.init(); //执行初始化函数
		$scope.employeeEntityAdd = {};
		$scope.PicList=[];//打开更新员工信息的时候，清空图片缓存
		$scope.getAuthorityList();
		$("#allSelectUpd").val("全选");
		$scope.authorityListTemp = $scope.authorityList;	
		if($scope.partyId){
			$scope.actionFlag = {add:false,update:true};
			$scope.getEmployee();
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}
		//$scope.employeeEntityAdd.mail = "1160352664@qq.com";
		//$scope.employeeEntityAdd.phoneNo = '13810000000';
		$scope.employeeEntityAdd.orgName = '';
		$scope.employeeEntityAdd.phoneNo = '';
		$scope.employeeEntityAdd.mail = '';
		$("#EmployeeUpdateId").modal({backdrop: 'static', keyboard: false});
		setTimeout(function() {
		    $scope.$apply(function() {
		    	var textareas = document.getElementsByTagName("textarea");
		    	var pf=new window.placeholderFactory(); 
		    	pf.createPlaceholder(textareas);
		    	//document.getElementById("eeeee").value="asd";
		    });  
		}, 100);
	};
	
	//修改员工信息
	$scope.updateEmployeeEntity = function(obj){
		if(obj.$valid){
			
			if($scope.employeeEntityAdd.loginId != $scope.employeeEntityAdd.loginId_Copy &&($scope.returnMessage.msg == false ||!$scope.returnMessage.msg)){
				$.messager.popup("请先点击查询按钮，确认正确在点击提交按钮");
				return;
			}
			
			$scope.getCheckRoles('authorityListTemp');
			
			if($scope.employeeEntity.UpddeptId){
				$scope.employeeEntityAdd.deptId = $scope.employeeEntity.UpddeptId;
				//$scope.employeeEntityAdd.deptName = $scope.employeeEntity.UpddeptName;
			}
			$scope.employeeEntityAdd.uploadFileInfo=$scope.PicList;
			$scope.employeeEntityAdd.orgName=$scope.employeeEntityAdd.deptName; 
			personOutSvc.updatePerson({id:$scope.employeeEntityAdd.partyId},$scope.employeeEntityAdd,function(rec){
				$scope.showFlag='';
				$scope.queryTemPartyList(1);
				$.messager.popup("角色信息更新成功");
				$scope.radioTrIndex=1;
				$scope.paginationConf.currentPage=1;
				$("#EmployeeUpdateId").modal('hide');
			},function(rec){
				$scope.showFlag='';
				if(rec.data.message){
					$.messager.popup(rec.data.message);
				}
			});
		}else{
			if(!obj.loginName.$valid){
				$scope.showFlag = 'loginName';//登录用户名
			}
			else if(!obj.name.$valid){
				$scope.showFlag = 'name';//员工姓名
			}
			else if(!obj.code.$valid){
				$scope.showFlag = 'code';//员工编号
			}
			else if(!obj.telephone.$valid){
				$scope.showFlag = 'telephone';//联系手机号
			}
			else if(!obj.qq.$valid){
				$scope.showFlag = 'qq';//qq
			}
			else if(!obj.electronicMailUpd.$valid){
				$scope.showFlag = 'electronicMailUpd';//email
			}
			return;
		}
	};
	
	//角色状态启用/停用
	$scope.stateList={};
	
	$scope.delEmployee = function(varl){
		if(!$scope.partyId){
			$.messager.popup("请选择一条记录");
			return;
		}else{
			personOutSvc.queryPerson({id:$scope.partyId},function(rec){
				if (rec.state == 0) {
					$scope.stateList = rec;
					$scope.stateList.state = "正常";
				} else if (rec.state == 1) {
					$scope.stateList = rec;
					$scope.stateList.state = "停用";
				}
				$("#EmployeeState").modal({backdrop: 'static', keyboard: false});
			},function(){});
		}
	};
	
	$scope.stateSubmit = function(){
			function qSucc(rec){
				if($scope.employeeEntityAdd.state == 0){
					$.messager.popup("停用成功");
					$scope.radioTrIndex=1;
					$scope.paginationConf.currentPage=1;
					$scope.enterpriseState =1;
					$scope.queryTemPartyList(1);
					$("#EmployeeState").modal('hide');
				}
				else if($scope.employeeEntityAdd.state == 1){
					$.messager.popup("启用成功");
					$scope.radioTrIndex=1;
					$scope.paginationConf.currentPage=1;
					$scope.enterpriseState =0;
					$scope.queryTemPartyList(1);	
					$("#EmployeeState").modal('hide');
				}
			};
			function qErr(){
				$scope.partyId=null;
				if($scope.partyId==null){
					$scope.radioTrIndex=null;
				} 
				$scope.queryTemPartyList(1);
				$.messager.popup("提交失败");
				$("#EmployeeState").modal('hide');
			};
			personOutSvc.oPerson({id:$scope.partyId,state:($scope.employeeEntityAdd.state == 0?1:0)},qSucc,qErr);
	};
	
	$scope.closeStateSubmit = function(){
	/*	$scope.partyId=null;
		if($scope.partyId==null){
			$scope.radioTrIndex=null;
		}
		$scope.queryTemPartyList(1);*/
		$("#EmployeeState").modal('hide');
	};
	
	/**
	 * 主页面-所属部门控件
	 */
	$scope.employeeEntityPage={}; 
	$scope.employeeEntityPage.PagedeptId = $scope.employeeEntity.orgId_;
	$scope.employeeEntityPage.PagedeptName = SYS_USER_INFO.orgName;
	//设置当前的上级机构Q
	$scope.displayNamePage="全选";
	$scope.parentOrgPage ={};
	
	//设置当前的下级机构Q
	$scope.chooseChildOrg = function(id,name){/* 所传参数一个为登录人id，一个为登录人name 第一次从cookies中传入的数据 */
		$scope.queryEntListPage(id,name);/* 查询子类信息的方法 */
		$scope.displayNamePage=name;/* 当第一次选中父级部门选项的时候改变上面按钮的名字为父级部门的名字 */
	};
	
	//查询当前父级部门下子级部门列表
	$scope.queryEntListPage = function(id,name){
		entSvc.queryPartyInstallList({
			parTypeId:5,/* 此值写死，对应的当事人类型5为部门 */
			currOrgId:Number(id)/* 数字化id传值 */
		}, function(rec){
			/* rec返回值中存在着子级部门的信息如子部门id，子部门名称，父级部门id，父部门名字等,此处在赋值一次的意义是当点击子级部门的子级部门时会有变化*/
			$scope.employeeEntityPage.PagedeptId = id;
			$scope.employeeEntityPage.PagedeptName = name;
			if(rec.content.length <= 0){/* 当前部门没有子级部门的时候 */
				$.messager.popup("当前无下级部门查询");
				$scope.parentOrgListPage = {};//当前部门没有子类部门的时候为什么给上一级的子级部门集合清空？ P1   因为如果不清空下面的子级展示会把上一次的子级的值展出
				return;
			}else if(rec.content.length > 0){/* 当前部门有子级部门的时候 */
				$scope.parentOrgPage = Number(id);/* 当前类的父类id就是上一级父类的currOrgId */
				$scope.parentOrgListPage = rec.content;/* $scope.parentOrgListPage 存下了当前父类部门下的子类部门都有哪些 */
			}
		},function(){
			$.messager.popup("获取部门列表失败");
		});
	};
	
	/*
	*点击查询上级部门事件
	*/
	$scope.chooseParentOrg = function(){
		if($scope.displayNamePage=="全选"){/* 返回到最上一级的时候,如果在按钮为全选的时候在往上返回 */
			$.messager.popup("当前无上级部门查询");
			$scope.displayNamePage="全选";
			$scope.parentOrgListPage={};/* 清空原子级集合，在按钮为全选的时候点击展示出只有本类名称，没有子级名称所以要清空 */
			return;
		}
		if($scope.employeeEntityPage.PagedeptName == $scope.user.orgName && $scope.employeeEntityPage.PagedeptId == $scope.user.currOrgId){/* 当返回到按钮为全选的时候 */
			$.messager.popup("当前无上级部门查询");
			$scope.displayNamePage="全选";
			$scope.parentOrgListPage={};
		}else{
			//deptIdAdd是下级部门的标识,作为查询上级部门的参数,添加到$scope.getParentOrgListAdd方法中
			$scope.getParentOrgListPage($scope.employeeEntityPage.PagedeptId);/* 传入父类部门的id当参数 */
		}
	};
	
	/*
	*返回上级部门的方法
	*/
	$scope.parentOrgListPage = {};
	$scope.getParentOrgListPage = function(id){
		entSvc.queryPartyInstallList({
			currOrgId:Number(id),/* 当前部门id */
			qryParentFlag:true,
			parTypeId:5/* 部门参数5 写死 */
		}, function(rec){/* 此返回值返回的是此类的父类包含的所有子类信息 */
			/* 查询这三种判断的返回值的区别 */
		/* 	if(rec.content.length == 0){因为如果子类下没有子类了是不会继续往下点的，也就不会造成子类下为空的情况（父类点完子类是空的）也就不会造成父类下没有子类，也就不会rec.content返回值length为0的情况，所以注释
				$scope.employeeEntityPage.PagedeptId = Number($scope.user.currOrgId);
				$scope.employeeEntityPage.PagedeptName =$scope.user.orgName;
				$scope.parentOrgListPage={};
				return;
			} */
			if(rec.content.length == 1){/* 当其父类只有一个子类的时候 */
				$scope.parentOrg = rec.content[0].parentOrgId;/* 获取父类id */
				$scope.displayNamePage = rec.content[0].parentOrgName;/* 展示其子类的父类名字在按钮上 */
				$scope.employeeEntityPage.PagedeptId = Number(rec.content[0].parentOrgId);/* 赋值父类id */
				$scope.employeeEntityPage.PagedeptName =rec.content[0].parentOrgName;/* 赋值父类名字 */
				$scope.parentOrgListPage=rec.content;/* 把子类的信息付给集合用于展示 */
				return;
			}
			if(rec.content.length >= 1){
				$scope.parentOrg = rec.content[0].parentOrgId;/* 获取父类id */
				$scope.displayNamePage = rec.content[0].parentOrgName;/* 获取父类名字 */
				$scope.employeeEntityPage.PagedeptId = Number(rec.content[0].parentOrgId);
				$scope.employeeEntityPage.PagedeptName =rec.content[0].parentOrgName;
				$scope.parentOrgListPage = rec.content;
			}
		},function(){});
	};

	/**
	 * 添加页面-所属部门控件
	 */
	
	 
	 
	//设置当前的上级机构A
	$scope.displayNameAdd="请选择";
	$scope.parentOrgAdd = "";
	//设置当前的下级机构A
	$scope.chooseChildOrgAdd = function(varl,varl1){
		$scope.showFlag='';
		if(varl == null || varl == ""){
			$.messager.popup("请先查询登录用户名");
			return;
		}
		$scope.queryEntListAdd(varl,varl1);
		$scope.queryRoleList(varl);
		$scope.displayNameAdd=varl1;
	}; 
	//查询部门列表A
	$scope.queryEntListAdd = function(flag,varl){
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:Number(flag)
		},function(rec){
			$scope.employeeEntity.AdddeptId = flag;
			$scope.employeeEntity.AdddeptName = varl;
			if(rec.content.length <= 0){
				$.messager.popup("当前无下级部门查询");
				$scope.parentOrgAdd = Number(flag);
				$scope.parentOrgListAdd = {};
				return;
			}else if(rec.content.length > 0){
				$scope.parentOrgAdd = Number(flag);
				$scope.parentOrgListAdd = rec.content;
			}
			$scope.queryRoleFunctionList = [];
		},function(){
			$.messager.popup("获取上级部门列表失败");
			$scope.queryRoleFunctionList = [];
		});
	};
	
	/*
	*上级部门点击查询事件
	*/
	$scope.chooseParentOrgAdd = function(){
		if($scope.parentOrgAdd == "" || $scope.parentOrgAdd == null){
			$.messager.popup("当前无上级部门查询");
			$scope.displayNamePage="全选";
			$scope.parentOrgListAdd={};
			return;
		}
		if($scope.displayNameAdd == $scope.user.orgName && $scope.parentOrgAdd == $scope.user.currOrgId){
			$.messager.popup("当前无上级部门查询");
			$scope.displayNamePage="全选";
			$scope.parentOrgListAdd={};
		}else{
			//deptIdAdd是下级部门的标识,作为查询上级部门的参数,添加到$scope.getParentOrgListAdd方法中
			$scope.getParentOrgListAdd($scope.employeeEntity.AdddeptId);
		}
		
	}; 
	
	
	/*
	*查询上级部门方法
	*/
	$scope.parentOrgListAdd = {};
	$scope.getParentOrgListAdd = function(varl){
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:Number(varl),
			qryParentFlag:true
		}, function(rec){
			if(rec.content.length == 0){
				$scope.employeeEntity.AdddeptId = Number($scope.user.currOrgId);
				$scope.employeeEntity.AdddeptName =$scope.user.orgName;
				$scope.parentOrgAdd = Number($scope.user.currOrgId);
				$scope.displayNameAdd = $scope.user.orgName;
				$scope.queryRoleList($scope.employeeEntity.AdddeptId);
				return;
			}
			if(rec.content.length == 1){
				$scope.parentOrgAdd = rec.content[0].parentOrgId;
				$scope.displayNameAdd = rec.content[0].parentOrgName;
				$scope.employeeEntity.AdddeptId = Number(rec.content[0].parentOrgId);
				$scope.employeeEntity.AdddeptName =rec.content[0].parentOrgName;
				$scope.parentOrgListAdd = rec.content;
				$scope.queryRoleList($scope.employeeEntity.AdddeptId);
				return;
			}
			if(rec.content.length >= 1){
				$scope.parentOrgAdd = rec.content[0].parentOrgId;
				$scope.displayNameAdd = rec.content[0].parentOrgName;
				$scope.employeeEntity.AdddeptId = Number(rec.content[0].parentOrgId);
				$scope.employeeEntity.AdddeptName =rec.content[0].parentOrgName;
				$scope.parentOrgListAdd = rec.content;
				$scope.queryRoleList($scope.employeeEntity.AdddeptId);
			}
		},function(){});
		$scope.queryRoleFunctionList = [];
	};
	
	/**
	 * 修改页面-所属部门控件
	 */
	$scope.displayNameUpd="请选择";
	$scope.parentOrgUpd ="";
	
	/*
	*点击查询下级部门事件
	*/
	$scope.chooseChildOrgUpd = function(varl,varl1){
		$scope.queryEntListUpd(varl,varl1);
		$scope.displayNameUpd=varl1;
		$scope.queryRoleList(varl);
		$scope.showFlag='';
	};
	
	/*
	*查询下级部门方法
	*/
	$scope.queryEntListUpd = function(flag,varl){
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:Number(flag)
		},function(rec){
			$scope.employeeEntity.UpddeptId = flag;
			$scope.employeeEntity.UpddeptName = varl;
			if(rec.content.length <= 0){
				$scope.parentOrgListUpd = {};
				$.messager.popup("没有下级部门");
				return;
			}else if(rec.content.length > 0){
				$scope.parentOrgUpd = Number(flag);
				$scope.parentOrgListUpd = rec.content;
			}
		},function(){
			$.messager.popup("获取部门列表失败");
		});
	};
	
	$scope.chooseParentOrgUpd = function(){
		if($scope.displayNameUpd == $scope.user.orgName && $scope.parentOrgUpd == $scope.user.currOrgId){
			$.messager.popup("当前无上级部门查询");
			$scope.parentOrgListUpd={};
		}else{
			//deptIdAdd是下级部门的标识,作为查询上级部门的参数,添加到$scope.getParentOrgListAdd方法中
			$scope.getParentOrgListUpd($scope.employeeEntity.UpddeptId);
		}
		
	};
	
	$scope.parentOrgListUpd = {};
	$scope.getParentOrgListUpd = function(varl){
		entSvc.queryPartyInstallList({
			parTypeId:5,
			qryParentFlag:true,
			currOrgId:Number(varl)
		}, function(rec){
			if(rec.content.length == 0){
				$scope.parentOrgUpd = Number($scope.user.currOrgId);
				$scope.displayNameUpd = $scope.user.orgName;
				$scope.employeeEntity.UpddeptId = Number($scope.user.currOrgId);
				$scope.employeeEntity.UpddeptName =$scope.user.orgName;
				$scope.queryRoleList($scope.employeeEntity.UpddeptId);
				return;
			}
			if(rec.content.length == 1){
				$scope.parentOrgUpd = rec.content[0].parentOrgId;
				$scope.displayNameUpd = rec.content[0].parentOrgName;
				$scope.employeeEntity.UpddeptId = Number(rec.content[0].parentOrgId);
				$scope.employeeEntity.UpddeptName =rec.content[0].parentOrgName;
				$scope.parentOrgListUpd=rec.content;
				$scope.queryRoleList($scope.employeeEntity.UpddeptId);
				return;
			}
			if(rec.content.length >= 1){
				$scope.parentOrgUpd = rec.content[0].parentOrgId;
				$scope.displayNameUpd = rec.content[0].parentOrgName;
				$scope.employeeEntity.UpddeptId = Number(rec.content[0].parentOrgId);
				$scope.employeeEntity.UpddeptName =rec.content[0].parentOrgName;
				$scope.parentOrgListUpd = rec.content;
				$scope.queryRoleList($scope.employeeEntity.UpddeptId);
			}
			
		},function(){});
	};
	
	$scope.upLoadBtn=function(varl){
		varl = 'input[id='+varl+']';
		$(varl).click();
	};
	
	
	
	$scope.PListLength = 0;
    $scope.onFileSelect = function ($files) {
    	if($files){
            for (var i = 0; i < $files.length; i++) {
                var file = $files[i];
                var MaxSize = 2097152;//图片最大尺寸(byte)   2*1024*1024=2097152 Byte
                var PicType = new Array('gif', 'jpeg', 'png', 'jpg' ,'bmp');
                var fileType=file.name.match(/^(.*)(\.)(.{1,8})$/)[3];/* 图片名字经过正则，之后剩下图片类型后缀 */
                var isPic=false;
                for (var j in PicType) {
                    if (fileType.toLowerCase() == PicType[j].toLowerCase()) {/* 如果图片的类型后缀(小写后)和设定好的类型后缀数组中的值(小写后)有相同的话 */
                        isPic=true;
                        if (file.size < MaxSize) {/* 不得小于5120  不得大于2097152 byte */
                            $scope.upload = $upload.upload({
                                url: PicUrl, //PicUrl
                                method: 'POST',
                                data: {myObj: $scope.myModelObj},
                                file: file,
                            }).progress(function (evt) {
                            }).success(function (data, status, headers, config) {        
                                $scope.FileSize = file.size;
                                $scope.PicRealName = data.fileName;//6c6b027d-d2e4-4ef4-b88f-f907bef2eddc.jpg 下载的图片名字
                                if(!$scope.employeeEntity.equipmentPic){//防止出现第一次下载图片出现图片名字为undefind，试图片加载失败
                                	$scope.employeeEntity.equipmentPic = "";
                                }
                                $scope.employeeEntity.equipmentPic += data.fileName + ",";//把每个图片的名字用字符串的形式拼接起来
                                $scope.ay = $scope.employeeEntity.equipmentPic.split(',');//然后去掉其中的逗号用数组存起来
                                $scope.PicList = [];
                                $scope['PicOneCopy'] = {};
                                for (i = 0; i < $scope.ay.length - 1; i++) {
                                    var fullname = $scope.ay[i].split('.');//去掉每个图片名字中的点，分成图片名和类型名存在新的数组
                                    var PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};//把数组的属性放入对象
                                    
                            /*        //为了展示图片做的实验
                                    $scope['PicOneCopy'][i] = {'PicName': fullname[0], 'PicType': fullname[1]};
                                    */
                                    
                                    
                                    if (i < 2) {
                                        $scope.PicList.push(PicOne);//把对象存入数组展示用
                                        $scope.PListLength = $scope.PicList.length;//控制展示图片数量用
                                        $scope.PicUrl = PicUrl;//PicUrl
                                        $scope.PicAction = "Action=TmpPic";
                                    } else {
                                        $.messager.popup("最多上传2张图片");
                                    }
                                }
                            });      
                        }else {
                            $.messager.popup("图片大小必须小于"+MaxSize+"请重新上传");
                        }
                    }
                }  if(isPic==false)
                {
                    $.messager.popup("上传失败，请选择格式JPG,JEPG,BMP,GIF,PNG且小于2M的图片");
                }
            }
    	}
    };
    
    
    /*
     * pic
     */
    $scope.upLoadBtn = function () {
        $('input[id=fileUpLoadId]').click();
    };
    
    //监控图片数量
    $scope.removePic=function(parm,obj){
    	$scope.testArray = [];
		var picName = obj.PicName+"."+obj.PicType+",";//把选择的图片名字和类型拼接起来与之前拼接字符串的对象相同
		var arrPics=$scope.employeeEntity.equipmentPic.split(picName);//从对象中去掉这个图片存在新对象中
		$scope.employeeEntity.equipmentPic="";//清空原对象
		
		for(var i=0;i<arrPics.length;i++){
			$scope.employeeEntity.equipmentPic += arrPics[i];//遍历这个
			if(arrPics[i]!=''){
				$scope.testArray.push(arrPics[i]);//拿到不空的值用于判断图片现存数量
			}
		}
		$scope.PListLength = $scope.testArray.length;
	};
	
	//删除图片和用户的关联
	$scope.deletePic=function(parm,obj){
		function succ(){
			$scope.removePic(parm,obj);//监控图片数量
		}
		function err(rec){
			if(rec.data.message){
				$.messager.popup(rec.data.message);
			}
		}
		personOutSvc.deletePersonPic({urlPath:"pic",id:$scope.employeeEntityAdd.partyId,upLoadId:obj.uploadId},succ,err);
	};
	
	//下载文件
	$scope.getImage = function(varl){
		downloadSvc.downloadFile({id:varl},function(rec){
			return rec;
		},function(){
			$.messager.popup("获取图片失败");
		});
	};

	//图片：显示/隐藏
	$scope.visible = false;
	$scope.toggleww = function () {
	    $scope.visible = !$scope.visible;
    };
	
	
	//关闭添加弹出框
    $scope.closeAddEmployee = function(){
    	$scope.showFlag = '';
    	
    	$scope.parentOrgListAdd = {};
    	$("#EmployeeAddId").modal('hide');
    };
    
    //关闭更新弹出框
    $scope.closeUpdateEmployee = function(){
    	$scope.showFlag = '';
    	$("#EmployeeUpdateId").modal('hide');
    };
    
    //关闭查看弹出框
    $scope.closeCheckEmployee = function(){
    	$("#EmployeeDetailId").modal('hide');
    };
    
	//选中订单ID
    $scope.radioList={};
    $scope.enterpriseState = '';
	$scope.check = function(entity,index_){
		$scope.radioTrIndex=index_;
		$scope.partyId = entity.partyId;
		$scope.enterpriseState = entity.state; 
		$scope.employee_state = entity.stateTemp;
		$scope.flagId = entity.loginId;//点击的时候存一个id值
		/* if(entity.state == "正常"){
			$scope.personState =0;
		}else if(entity.state == "停用"){
			$scope.personState =1;
		} */
		//$scope.chooseEmployee(entity.partyId,$scope.personState);
	};
	
	//检查员工id是否存在
	$scope.checkCodeFun = function(){
		//if($scope.employeeEntityAdd.code){
			
			function qSucc(rec){
				if(rec.msg=="FALSE"){
					//$.messager.popup("此编号可以使用");
				}
				if(rec.msg=="TRUE"){
					$.messager.popup("此编号已存在，请重新输入");
					$scope.employeeEntityAdd.code = "";/* 存在清空其值 */
					$("#CodeId").focus();/* 光标定位回原位置 */
				}
			}
			
			function qErr(){}
			
			personSvc.checkCode({code:$scope.employeeEntityAdd.code},qSucc,qErr);
		
		//}
			
	};
	
	
	
	
	
	 
	
	
	   $('html').bind('keyup', function(e)
				{
			          //当按下回车的时候
					  if(e.keyCode == 13)
					  {
						   //当焦点为输入框的id的时候
						  if(document.activeElement.id=="purId"){
							  //把ng-model的数值强制赋给输入框本身的value
							 //$("#purId").val($scope.fuzzyData);
							 //$scope.queryTemPartyList(1);
							  $("#searchBtnId").click();
							 
						  } 
						  if(document.activeElement.id=="addId"){
							  //把ng-model的数值强制赋给输入框本身的value
							 //$("#purId").val($scope.fuzzyData);
							 //$scope.queryTemPartyList(1);
							  $("#addBtn").click();
							 
						  }
						  if(document.activeElement.id=="updId_"){
							  //把ng-model的数值强制赋给输入框本身的value
							 //$("#purId").val($scope.fuzzyData);
							 //$scope.queryTemPartyList(1);
							  $("#updBtn").click();
							 
						  } 
						
					  
					  }
				});
	
	     
	
	   
	   
	   
	   

	   
	   
		//添加中的全选
		$scope.selectAllboxAdd = function(objList){
			
			if($("#allSelectAdd").val()=="全选"){	
				
				for(var j = 0; j < $scope[objList].length; ++j){
					$scope[objList][j].chck = true;
				}
				$("#allSelectAdd").val("全取消");
			}else if($("#allSelectAdd").val()=="全取消"){
				for(var i = 0; i < $scope[objList].length; ++i){
				    
			    	$scope[objList][i].chck = false;
				
		        }
				$("#allSelectAdd").val("全选");
		   }
		};
		
		
		//修改中的全选
		$scope.selectAllboxUpd = function(objList){
			
			if($("#allSelectUpd").val()=="全选"){	
				
				for(var j = 0; j < $scope[objList].length; ++j){
					$scope[objList][j].chck = true;
				}
				$("#allSelectUpd").val("全取消");
			}else if($("#allSelectUpd").val()=="全取消"){
				for(var i = 0; i < $scope[objList].length; ++i){
				    
			    	$scope[objList][i].chck = false;
				
		        }
				$("#allSelectUpd").val("全选");
		   }
		};
	   
	   //邮箱校验用
	/*	 if(!obj.electronicMail.$valid){
         	// 因为校验机制可能与邮箱加@之后的信息有冲突，所以单写一个校验checkEmail方法里面包括校验邮箱的正则内容，
         	//并返回boolean值，把邮件的值传进入进入校验，如果通过就给邮件的ng-model赋值，不通过就提示报错 
         	if(!$scope.checkEmail($("#electronicMail").val())){
               	 $scope.showFlag = 'electronicMail';
               	 if(obj.electronicMail.$error.pattern==true){
               		 $.messager.popup("邮箱格式有误，请重新输入");
               	 }
                  return;
         	}
         	$scope.formParms.electronicMail=$("#electronicMail").val();
         	
          }*/
	
/*	$scope.admFlagFun = function(){
		
	};*/
	
	/**
	 * 查询添加中的所属项目
	 */
/*		$scope.btnShow_ = true;//按钮显示初始化
		$scope.queryPerson = function(pageNo,id){
			if(pageNo){
				$scope.paginationConf.currentPage = 1;
			}
	 		function qSucc(rec){
	 			if(rec.content.length!=0){
	 				$scope.proList={};
	 	 			$scope.proList = rec.content;
	 	 			$scope.paginationConf.totalItems = rec.totalElements;
	 	 			if($scope.num < 3){//因为首先会自动查询2回，不知道哪里调用的所以设定调用次数<3次的时候都是不显示按钮。对应软需上的初始为请选择不显示按钮和分页和列表
	 	 				$scope.btnShow_ = false;
	 	 				$scope.num++;
	 	 				return;
	 	 			}else{
	 	 				$scope.btnShow_ = true;
	 	 			}
	 			}else{
	 				$scope.proList = rec.content;//查询为空的时候对应展示空
	 				$scope.btnShow_ = false;
	 			}
	 		
	 		}
	 		function qErr(rec){}
	 		
	 		if(id){
				var currOrgId_=id;
			}else{
				var currOrgId_=$scope.employeeEntity.orgId_;
			}
	 		proSvc.queryPartyInstallList({
	 			currOrgId:currOrgId_,
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.itemsPerPage
			},qSucc,qErr);
		};*/
	
		
		
        /*$scope.picName = 'thumb_image3.jpg';
		
		$scope.clickA = function(){
			$('#element_id a').lightBox({maxWidth:50,maxHeight:50,imageArray:[["http://localhost:8080/Picture/08a5528a-9cd5-4255-a697-b4b096492e2b/png","测试..."]]}); 
		};
		
		$scope.arrayList = [{name:'281576-106.jpg',showName:'thumb_image3.jpg'},{name:'thumb_image3.jpg',showName:'281576-106.jpg'}];*/
		
		/*
		*多余字体用...代替
		*/
		$scope.KWList = function(val){
			for(var i=0;i<val.length;i++){
				if(val[i].name.length > 9){
					$scope.KeyWordList[i].infoTitleA = val[i].name.substring(0,7)+"...";
	        	}else{
	        		$scope.KeyWordList[i].infoTitleA = val[i].name;
	        	}
			}
		};
		
		
		/*
		*input框ng-change事件
		*/
		$scope.KeyWordQuery = function(inputValue,showFlag){/* 需要 */
			if(inputValue.length == 0){//如果输入框没有值了，就隐藏下面的展示结果域
				$scope[showFlag] = false;
			}
			$scope.KeyWordList=[];/* 需要 */

			if($scope.employeeEntity.orgName.length < 1){
				$scope.showLevel = false;
				$scope.employeeEntity.isInclude = false;//复选框控制
			}
			
			function qSucc(rec){/* 需要 */
				if(rec.content.length<=0){/* 需要 */
					$scope[showFlag]=false;/* 需要 */
				}else{
					$scope[showFlag]=true;/* 需要 */
					$scope.KeyWordList=rec.content;/* 需要 */
					$scope.KWList(rec.content);//字数超过9个后用...代替/
				}
			}
			function qErr(){}
			if(inputValue){
				entSvc.queryPartyInstallList({Action:'QueryEnts'},{
					orgCode:SYS_USER_INFO.orgCode,
					orgName:$scope.employeeEntity.orgName,
					pageNo:$scope.paginationConf.currentPage-1,
					pageSize:$scope.paginationConf.itemsPerPage
				},qSucc,qErr);
			}
		};
		
		
		/*
		*点击搜索下拉框定位显示在input
		*/
		$scope.searBean = {};
		$scope.InputShow = function(parm,searBean,infoTitleBean,LiNumA,level,id,changeOrgId,code,codeName){//点击的值，scope后的属性名，属性名后的属性名，LiNumA为显示下方的flag，level为组织级别，
		
			if(parm){
				$scope[searBean][infoTitleBean] = parm;/* 需要 */
				$scope[searBean][changeOrgId] = id;//保存被点选的单位的id备用
				$scope[searBean][codeName] = code;
			
				if(level > 2){//如果选择的当前单位的级别高于2也就是是处级
					$scope.showLevel = false;//根据组织级别控制是否有显示下级的复选框，2以上为处级也就是没有下级不显示复选框
					$scope.employeeEntity.isInclude = false;//复选框控制
				} 
				if(level < 3){//如果不是处级，也就是有下级企业
					$scope.showLevel = true;//显示包含下级单位复选框
				}
				$scope[LiNumA] = false;//隐藏点选后的下拉框
				$scope.userInfo.orgLevel_show=level;
				$scope.queryPersonCopy(1,id); //根据目前选择的单位id查询对应的项目
				return;
			}
			
		};
		
		/**
		 * 查询所属项目
		 */
			$scope.queryPersonCopy = function(pageNo,id){
				if(pageNo){
					$scope.paginationConf.currentPage = 1;
				}
		 		function qSucc(rec){
		 				$scope.proListCopy={};
		 	 			$scope.proListCopy = rec.content;//对应的项目
		 	 			/*$scope.paginationConf.totalItems = rec.totalElements;*/
		 		}
		 		function qErr(rec){}
		 		
		 		if(id){
					var currOrgId_=id;//如果有点选过其他单位
				}else{
					var currOrgId_=$scope.employeeEntity.orgId_;//如果没有点选过其他单位是最初的登录单位
				}
		 		proSvc.queryPartyInstallList({
		 			currOrgId:currOrgId_,
					pageNo:$scope.paginationConf.currentPage-1,
					pageSize:$scope.paginationConf.itemsPerPage
				},qSucc,qErr);
			};
			$scope.queryPersonCopy();//初始化执行查询项目为主页显示
			
			/*开启幻灯片效果*/
			$scope.createLightBox=function(){
        		$('#element_id a').lightBox();
			}
			
			/*email 输入框数去焦点的时候，将输入框的值 赋给绑定的对象*/
			$scope.emailBlur=function(id){
				$scope.formParms.electronicMail=$('#'+id).val();
			};
			
			/*email 输入框数去焦点的时候，将输入框的值 赋给绑定的对象*/
			$scope.emailBlurUpd=function(id){
				$scope.employeeEntityAdd.email=$('#'+id).val();
			};
			
			$scope.trClick = function(obj){
				$scope.addModelTrIndex=obj.$parent.$index;
				for(var i=0;i<$scope.authorityListTemp.length;i++){
					if(i == $scope.addModelTrIndex){
						$scope.authorityListTemp[i].chck = !$scope.authorityListTemp[i].chck;
					}
					if($scope.authorityListTemp[i].chck == true){
						$("#allSelectAdd").val("全取消");
						$("#allSelectUpd").val("全取消");
					}else{
						$("#allSelectAdd").val("全选");
						$("#allSelectUpd").val("全选");
					}
				}
			};
			
			
			
//复用形式的叉号 2016.1.11
			
			$scope.cleanDateFunEndNew = function(obj,obj2,obj3,obj4,obj5,obj6){
				$scope[obj3][obj4] = '';
				if(obj6){
					$("#"+obj2).focus();
				}
				$scope['flagShow'+obj] = false;
				if(obj5 && $scope[obj5] == true){
					$scope[obj5] = false;
				}
			};
			
			$scope.clickInputNew = function(obj,obj2){//obj:输入参数;obj2：控制flag显示
				if(obj && obj.length > 0){
					$scope['flagShow'+obj2] = true;
				}else{
					$scope['flagShow'+obj2] = false;
				}
			};
			
			/*
			 * obj:控制flag显示;
			 * obj2:查询展示的flag
			 * obj3:查询展示的数组
			 * */
			$scope.blurInputNew = function(obj,obj2,obj3,obj4,obj5){//obj：控制flag显示
				
				
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
			
			$scope.changeProFunNew = function(inputValue,showFlag,_equOutCom){
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
			
	
});


