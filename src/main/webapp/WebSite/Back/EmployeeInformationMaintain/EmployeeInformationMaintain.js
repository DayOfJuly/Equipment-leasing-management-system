app.controller('EmployeeAppController', function($scope,$timeout,CheckEmployeeTrueOrFalseSvc,personSvc,roleSvc,entSvc,personMsgSvc,$upload,downloadSvc,authoritySvc,SYS_CODE_CON,sysCodeTranslateFactory,regionSvc,published,proSvc,PicUrl) {

	//ie9下titile正确显示使用
	document.title="员工信息维护"
		
	/*水印信息*/
	$scope.placeholders={
		note:"请输入字符在60个以内"
	};
	
	
	//111                                                 
    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    
    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	
    /* userInfo */
	$scope.userInfo = {};

	$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
	$scope.userInfo.orgId = SYS_USER_INFO.orgId;
	$scope.userInfo.orgCode = SYS_USER_INFO.orgCode;
	$scope.userInfo.orgName = SYS_USER_INFO.orgName;
	$scope.userInfo.proId = SYS_USER_INFO.proId;
	$scope.userInfo.proName = SYS_USER_INFO.proName;
    
    
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

		authoritySvc.queryAuthorities({funType:1},function(rec){
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
	
	
	
	/**
	    * 初始化向下查询（当前登陆人下级企业查询）
	    * 用session中的登录人id和name当参数，查询当前登录人的信息展示本企业和下级企业
	    */
		$scope.NextProject = function(){
			
	 	   function qSucc(rec)
	 	   {
	 		    $scope.nextArray=[];//定义一个数组用于接收拼接的数组
	 			var initArray=[{"currOrgId":SYS_USER_INFO.orgId,"name":SYS_USER_INFO.orgName}];//初始值为当前登录人的信息
	 			var nextArray = [];//定义一个数组接收当前登陆人下的企业信息
	 			nextArray = rec.content;
	 			$scope.nextArray=initArray.concat(nextArray)//拼接2个数组的值付一个新的数组里展示
	 			
	 		}
	 		
	 		function qErr(rec){}
	 			entSvc.queryPartyInstallList({
					currOrgId:$scope.userInfo.orgId,
					pageNo:0,
					pageSize:99
				},qSucc,qErr);
		};
		$scope.NextProject();
	
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
        perPageOptions: [10, 20, 30, 40, 50],
		/*
		 * parm1:当前选择页数
		 * parm2:每页显示多少
		 */
		 onChange : function(parm1, parm2) {
			$scope.paginationConf.currentPage=parm1;
			$scope.radioTrIndex=null;
			if($scope.radioTrIndex==null){
				$scope.partyId=null;
			}
			$scope.queryList();
		}
	};
	$scope.btnShow_ = true;//按钮显示初始化

	$scope.queryList = function(){
		function qSucc(rec){
			if(rec.content){
					if(rec.content.length == 0){
						$scope.btnShow_ = false;	
						$scope.btnShowAdd_ = false;
						$scope.entityList=[];
						$.messager.popup("没有查询到相关数据");
						return;
					}else{
						$scope.btnShow_ = true;	
						$scope.btnShowAdd_ = true;
						$scope.paginationConf.totalItems = rec.totalElements;  
					}
				
				if($scope.employeeEntity.isInclude == 1){
					$scope.employeeEntity.isInclude = true;
				}
				
				if($scope.employeeEntity.isInclude == 0){
					$scope.employeeEntity.isInclude = false;
				}
				$scope.entityList=[];
				for (var i = 0; i < rec.content.length; i++) {
					if (rec.content[i].state == 0) {
						$scope.entityList = rec.content;
						$scope.entityList[i].stateTemp = "正常";
					} else if (rec.content[i].state == 1) {
						$scope.entityList = rec.content;
						$scope.entityList[i].stateTemp = "停用";
					}
				}
				
				for(var i =0;i<$scope.entityList.length;i++){
					$scope.entityList[i].loginIdCopy = $scope.entityList[i].loginId;
					if($scope.entityList[i].loginId && $scope.entityList[i].loginId.length > 6){
						$scope.entityList[i].loginIdCopy = $scope.entityList[i].loginIdCopy.substring(0,6)+"...";
					}
					$scope.entityList[i].nameCopy = $scope.entityList[i].name;
					if($scope.entityList[i].name && $scope.entityList[i].name.length > 4){
						$scope.entityList[i].nameCopy = $scope.entityList[i].nameCopy.substring(0,4)+"...";
					}
					$scope.entityList[i].codeCopy = $scope.entityList[i].code;
					if($scope.entityList[i].code && $scope.entityList[i].code.length > 6){
						$scope.entityList[i].codeCopy = $scope.entityList[i].codeCopy.substring(0,6)+"...";
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
					$scope.entityList[i].proNameCopy = $scope.entityList[i].proName;
					if($scope.entityList[i].proName && $scope.entityList[i].proName.length > 14){
						$scope.entityList[i].proNameCopy = $scope.entityList[i].proNameCopy.substring(0,14)+"...";
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
		
		
		//2016.1.12 14:27为了和资源管理同处理修改输入框的查询效果============================================
		if(!$scope.employeeEntity.orgName){//如果没有输入任何值
			$scope.employeeEntity.code = SYS_USER_INFO.orgCode;//赋值登陆人的code
			$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;//赋值登陆人的name
			$scope.userInfo.orgLevel_show = SYS_USER_INFO.orgLevel;//赋值登录人级别level
			//$scope.employeeEntity.code = '';//这个是查询时候的一个暂存code值，没什么大用保险起见我给清空了
		}else{
			if($scope.employeeEntity.orgName && !$scope.KeyWordListFlag && click_ && !$scope.LiNumA){
				$scope.employeeEntity.code = $scope.employeeEntity.orgName;//搜例如青花瓷的时候
				//$scope.employeeEntity.code = '';
			}else{
				if($scope.KeyWordList){
					for(var i=0;i<$scope.KeyWordList.length;i++){//如果有展示值的时候
						if($scope.employeeEntity.orgName == $scope.KeyWordList[i].name){//如果输入的name等于展示集合的name那就赋值给对应的code
							$scope.employeeEntity.code = $scope.KeyWordList[i].code;
							break;
						}else{
							$scope.employeeEntity.code = $scope.employeeEntity.orgName;//没有对应展示值的时候
						}
					}
				}
			}
		}
		//2016.1.12 14:27为了和资源管理同处理修改输入框的查询效果===========================================
		personSvc.queryPersonList({
			parTypeId:3,
			orgCode:$scope.employeeEntity.code,
			departmentName:$scope.employeeEntity.orgName,
			currOrgId:$scope.employeeEntity.changeOrgId,
			fuzzyData:$scope.formParm.fuzzyData,
			isInclude:$scope.employeeEntity.isInclude,
			proPartyId:$scope.employeeEntity.proId,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
		},qSucc,qErr);
		
	}
	
	//条件查询
	$scope.formParm = {};
	$scope.KeyWordListFlag = true;
	$scope.queryTemPartyList = function(pageNo,click_){
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function qSucc(rec){
			if(rec.content){
				
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
						$scope.btnShowAdd_ = false;
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
					if($scope.entityList[i].loginId && $scope.entityList[i].loginId.length > 6){
						$scope.entityList[i].loginIdCopy = $scope.entityList[i].loginIdCopy.substring(0,6)+"...";
					}
					$scope.entityList[i].nameCopy = $scope.entityList[i].name;
					if($scope.entityList[i].name && $scope.entityList[i].name.length > 4){
						$scope.entityList[i].nameCopy = $scope.entityList[i].nameCopy.substring(0,4)+"...";
					}
					$scope.entityList[i].codeCopy = $scope.entityList[i].code;
					if($scope.entityList[i].code && $scope.entityList[i].code.length > 6){
						$scope.entityList[i].codeCopy = $scope.entityList[i].codeCopy.substring(0,6)+"...";
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
					$scope.entityList[i].proNameCopy = $scope.entityList[i].proName;
					if($scope.entityList[i].proName && $scope.entityList[i].proName.length > 14){
						$scope.entityList[i].proNameCopy = $scope.entityList[i].proNameCopy.substring(0,14)+"...";
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
		
		//2016.1.12 14:27为了和资源管理同处理修改输入框的查询效果============================================
		if(!$scope.employeeEntity.orgName){//如果没有输入任何值
			$scope.employeeEntity.code = SYS_USER_INFO.orgCode;//赋值登陆人的code
			$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;//赋值登陆人的name
			$scope.userInfo.orgLevel_show = SYS_USER_INFO.orgLevel;//赋值登录人级别level
			//$scope.employeeEntity.code = '';//这个是查询时候的一个暂存code值，没什么大用保险起见我给清空了
		}else{
			if($scope.employeeEntity.orgName && !$scope.KeyWordListFlag && click_ && !$scope.LiNumA){
				$scope.employeeEntity.code = $scope.employeeEntity.orgName;//搜例如青花瓷的时候
				//$scope.employeeEntity.code = '';
			}else{
				if($scope.KeyWordList){
					for(var i=0;i<$scope.KeyWordList.length;i++){//如果有展示值的时候
						if($scope.employeeEntity.orgName == $scope.KeyWordList[i].name){//如果输入的name等于展示集合的name那就赋值给对应的code
							$scope.employeeEntity.code = $scope.KeyWordList[i].code;
							break;
						}else{
							$scope.employeeEntity.code = $scope.employeeEntity.orgName;//没有对应展示值的时候
						}
					}
				}
			}
		}
		//2016.1.12 14:27为了和资源管理同处理修改输入框的查询效果===========================================
		if($scope.proQryBean.orgCode){
			personSvc.queryPersonList({
				parTypeId:3,
				orgCode:$scope.proQryBean.orgCode,
				departmentName:$scope.proQryBean.name,
				currOrgId:$scope.proQryBean.currOrgId,
				fuzzyData:$scope.formParm.fuzzyData,
				isInclude:$scope.employeeEntity.isInclude,
				proPartyId:$scope.employeeEntity.proId,
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.itemsPerPage
			},qSucc,qErr);
			
		}else{
			personSvc.queryPersonList({
				parTypeId:3,
				orgCode:$scope.employeeEntity.code,
				departmentName:$scope.employeeEntity.orgName,
				currOrgId:$scope.employeeEntity.changeOrgId,
				fuzzyData:$scope.formParm.fuzzyData,
				isInclude:$scope.employeeEntity.isInclude,
				proPartyId:$scope.employeeEntity.proId,
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.itemsPerPage
			},qSucc,qErr);
		}
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
	$scope.checkRole = function(userFunList,deptName,orgLevel){
		$scope.getAuthorityList();
		$scope.authorityListTemp = $scope.authorityList;
		var length = $scope.authorityListTemp.length / 2;
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
					if(i<length){
						$scope.authorityListTemp[i].firstTr = true;
					}else{
						$scope.authorityListTemp[i].secondTr = true;
					}

					/** 打开添加model，若登录人员的企业不是总公司，则设置showFlag=false */
					if(deptName=="总公司"){
						if($scope.authorityListTemp[i].functionId== 5||$scope.authorityListTemp[i].functionId== 16||$scope.authorityListTemp[i].functionId== 30||$scope.authorityListTemp[i].functionId== 31||$scope.authorityListTemp[i].functionId== 32){
							$scope.authorityListTemp[i].showFlag = true;
						}else{
							$scope.authorityListTemp[i].showFlag = true;
						}										
					}else{
						if($scope.authorityListTemp[i].functionId== 5||$scope.authorityListTemp[i].functionId== 16||$scope.authorityListTemp[i].functionId== 30||$scope.authorityListTemp[i].functionId== 31||$scope.authorityListTemp[i].functionId== 32){
							$scope.authorityListTemp[i].showFlag = false;
						}else{
							$scope.authorityListTemp[i].showFlag = true;
						}
						
					}
				}
			}
			if(orgLevel == 3){//如果现在是给处级加员工就删掉企业设置的权限
				$scope.authorityListTemp.splice(0,1);
			}

		}
	};
	
	//获取选中功能信息
	$scope.getCheckRoles = function(objList_){
		$scope.employeeEntityAdd.funInfo = [];
		for(var j = 0; j < $scope[objList_].length; j++){
			if($scope[objList_][j].chck){
				$scope.employeeEntityAdd.funInfo.push({functionId:$scope[objList_][j].functionId});
			}
		}
	};
	

	$scope.showObj = '';
	//根据员工ID 获取员工详细信息
	
	$scope.getEmployee = function(){
		if(!$scope.partyId){
			$.messager.popup("请选择一条记录");
			return;
		}else{
			personSvc.queryPerson({id:$scope.partyId},
			function qSucc(rec){
				$scope.employeeEntityAdd = rec;//获得员工权限
			
				$scope.employeeEntityAdd.loginId_Copy = $scope.employeeEntityAdd.loginId;//记录登录名校验是否更改过
				
				if($scope.employeeEntityAdd.uploadFileInfo && $scope.employeeEntityAdd.uploadFileInfo.length>=2){
					$scope.PListLength=$scope.employeeEntityAdd.uploadFileInfo.length;
				}
				$scope.employeeEntityAdd.loginUId = rec.uId;
				if($scope.employeeEntityAdd.funInfo && $scope.employeeEntityAdd.funInfo.length>0){
					$scope.checkRole($scope.employeeEntityAdd.funInfo,$scope.employeeEntityAdd.deptName,$scope.employeeEntityAdd.deptLv);
				}else{
					$scope.getAuthorityList();
					$scope.authorityListTemp = $scope.authorityList;
					var length = $scope.authorityListTemp.length / 2;
					for(var i=0;i<$scope.authorityListTemp.length;i++){
						if(i<length){
							$scope.authorityListTemp[i].firstTr = true;
						}else{
							$scope.authorityListTemp[i].secondTr = true;
						}

						$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
						if($scope.authorityListTemp[i].showName.length > 9){
							$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
						}

						/** 打开添加model，若登录人员的企业不是总公司，则设置showFlag=false */
						if($scope.employeeEntityAdd.deptLv==1){					
							$scope.authorityListTemp[i].showFlag = true;										
						}else{
							if($scope.authorityListTemp[i].functionId== 5||$scope.authorityListTemp[i].functionId== 16||$scope.authorityListTemp[i].functionId== 30||$scope.authorityListTemp[i].functionId== 31||$scope.authorityListTemp[i].functionId== 32){
								$scope.authorityListTemp[i].showFlag = false;
							}else{
								$scope.authorityListTemp[i].showFlag = true;
							}
							
						}
					}
					if($scope.employeeEntityAdd.deptLv == 3){//如果现在是给处级加员工就删掉企业设置的权限
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
	
/*	//根据登录名获取管理员信息
	$scope.getAdministrator = function(){
		if($scope.employeeEntity.loginId){
			personMsgSvc.getUserDetail({loginId:$scope.employeeEntity.loginId,orgId:$scope.user.currOrgId},function(rec){
				if(rec.loginId==null||rec.loginId==""){
					$.messager.popup("请先创建企业");
					$scope.employeeEntity.loginId = '';
				}
				
				//拿到点击查询的时候需要修改的返回值
				$scope.employeeEntity.email = rec.email;
				$scope.employeeEntity.loginId = rec.loginId;
				$scope.employeeEntity.loginUId = rec.loginUId;
				$scope.employeeEntity.mobile = rec.mobile;
				$scope.employeeEntity.openId = rec.openId;
				
				
				$scope.employeeEntity.orgId = $scope.user.currOrgId;
				$scope.employeeEntity.orgName = $scope.user.orgName;
				$scope.employeeEntity.AdddeptId = $scope.user.currOrgId;
				$scope.employeeEntity.AdddeptName = $scope.user.orgName;
			},function(){});
		}else{
			$.messager.popup("请输入登录用户名");
		}
	};*/
	
	//根据登录名获取管理员信息
	$scope.returnMessage = {};
	
	$scope.getAdministrator = function(){
		$scope.employeeEntityAdd.phoneNo = '';
		$scope.employeeEntityAdd.mail ='';
		if($scope.employeeEntityAdd.loginId){
			function succ(rec){
				if(rec.status && rec.status == '1'){
					$scope.returnMessage.msg = true;
				}else{
					$scope.returnMessage.msg = false;
				}
			/*	if(!rec.status){
					$scope.returnMessage.msg = true;
				}else{
					$scope.returnMessage.msg = false;
				}*/
				$scope.employeeEntityAdd.mail=rec.user_email; 
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
			                                    
			CheckEmployeeTrueOrFalseSvc.unifydo({urlPath:$scope.employeeEntityAdd.loginId},succ,err);
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
		   //所属企业默认是当前登录人的所属企业
		   $scope.employeeEntityAdd.deptId=$scope.userInfo.orgId;
			$scope.employeeEntityAdd.orgName = $scope.employeeEntity.orgName;
			$scope.PicList = [];//打开添加员工信息页面 清空图片缓存
			$scope.employeeEntity.equipmentPic=[];//打开添加员工信息页面 清空图片缓存
			$scope.PListLength = 0;
			//$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
			$scope.actionFlag = {add:true,update:false};
			$scope.getAuthorityList();
			$("#allSelectAdd").val("全选");

			$scope.authorityListTemp = $scope.authorityList;

			if($scope.userInfo.orgLevel == 3){//如果现在是给处级加员工就删掉企业设置的权限
				$scope.authorityListTemp.splice(0,1);
			}

			var length = $scope.authorityListTemp.length / 2;
			for(var i=0;i<$scope.authorityListTemp.length;i++){
				if(i<length){
					$scope.authorityListTemp[i].firstTr = true;
				}else{
					$scope.authorityListTemp[i].secondTr = true;
				}

				$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
				if($scope.authorityListTemp[i].showName.length > 9){
					$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
				}

				/** 打开添加model，若登录人员的企业不是总公司，则设置showFlag=false */
				if($scope.userInfo.orgLevel==1){					
					$scope.authorityListTemp[i].showFlag = true;										
				}else{
					if($scope.authorityListTemp[i].functionId== 5||$scope.authorityListTemp[i].functionId== 16||$scope.authorityListTemp[i].functionId== 30||$scope.authorityListTemp[i].functionId== 31||$scope.authorityListTemp[i].functionId== 32){
						$scope.authorityListTemp[i].showFlag = false;
					}else{
						$scope.authorityListTemp[i].showFlag = true;
					}
					
				}
			}
			$scope.copyAuthorityListTemp = $scope.authorityListTemp;
			$scope.employeeEntityAdd.mobile = '';
			
			$scope.PicList = [];
		    $scope.ay = [];
			
			//$scope.employeeEntityAdd.phoneNo ="13810000000";
		    //$scope.employeeEntityAdd.mail = '11503244456@qq.com';
		    $scope.employeeEntityAdd.phoneNo = '';
		    $scope.employeeEntityAdd.mail = '';
			
			
				$scope.checkPerIdFun("add");
			
			
			$scope.employeeEntityAdd.orgNameCopy = $scope.employeeEntityAdd.orgName;
			if($scope.employeeEntityAdd.orgName.length > 7){
				$scope.employeeEntityAdd.orgNameCopy = $scope.employeeEntityAdd.orgNameCopy.substring(0,7)+'...';
			}
			$("#EmployeeAddId").modal({backdrop: 'static', keyboard: false});
			setTimeout(function() {
			    $scope.$apply(function() {
			    	var textareas = document.getElementsByTagName("textarea");
			    	var pf=new window.placeholderFactory(); 
			    	pf.createPlaceholder(textareas);
			    	//document.getElementById("eeeee").value="asd";
			    });  
			}, 10);
			//$("#EmployeeAddId").modal({backdrop: false, keyboard: false});
	};
	
	$scope.checkParId = function(){
		
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

//			if($scope.saveDeptId){
//				$scope.employeeEntityAdd.deptId = $scope.saveDeptId;  
//			}else{
//				$scope.employeeEntityAdd.deptId = $scope.employeeEntity.changeOrgId;  
//			}
			$scope.employeeEntityAdd.deptName = $scope.employeeEntity.AdddeptName;
			//$scope.formParms.electronicMail=$("#electronicMail").val();
			$scope.employeeEntityAdd.email = $scope.formParms.electronicMail;
			$scope.employeeEntityAdd.uploadFileInfo=$scope.PicList;
			
			if($scope.employeeEntityAdd.orgName !=''){
				$scope.employeeEntityAdd.orgName = '';
			}
			
			personSvc.addPersonDetail($scope.employeeEntityAdd,function(rec){
				$.messager.popup("添加员工信息成功");
				$scope.searchEntity = {
					pageNo:0,
					currOrgId:$scope.employeeEntity.changeOrgId,
					pageSize:$scope.paginationConf.itemsPerPage
				};
				
				$scope.queryTemPartyList(1);
				if($scope.saveDeptId){
		    		$scope.queryPersonCopy(1,$scope.saveDeptId);
		    	}else{
		    		$scope.queryPersonCopy();
		    	}
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
		var s2 = new Suggest('electronicMailUpd','suggestUpd');
		s2.init(); //执行初始化函数
		$scope.employeeEntityAdd = {};
		$scope.PicList=[];//打开更新员工信息的时候，清空图片缓存
		$scope.PListLength=0;
		$scope.employeeEntity.equipmentPic=[];//打开更新员工信息的时候，清空图片缓存

		$("#allSelectUpd").val("全选");
		$scope.authorityListTemp = $scope.authorityList;
		if($scope.partyId){
			$scope.actionFlag = {add:false,update:true};
			$scope.getEmployee();
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}
		$scope.employeeEntityAdd.phoneNo ="";
		$scope.employeeEntityAdd.mail = '';
			
			$scope.checkPerIdFun("upd");
		
			$scope.queryPersonCopy(1,$scope.adminId_);
		
			$scope.employeeEntityAdd.loginId_Copy = $scope.employeeEntityAdd.loginId;
			
		$("#EmployeeUpdateId").modal({backdrop: 'static', keyboard: false});
		setTimeout(function() {
		    $scope.$apply(function() {
		    	var textareas = document.getElementsByTagName("textarea");
		    	var pf=new window.placeholderFactory(); 
		    	pf.createPlaceholder(textareas);
		    	//document.getElementById("eeeee").value="asd";
		    });  
		}, 10);
		
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
				$scope.employeeEntityAdd.deptName = $scope.employeeEntity.UpddeptName;
			}
			if($scope.PicList && $scope.PicList.length!=0 && $scope.employeeEntityAdd.uploadFileInfo && $scope.employeeEntityAdd.uploadFileInfo.length!=0){
				var p =$scope.PicList;
				var a =$scope.employeeEntityAdd.uploadFileInfo;
				$scope.employeeEntityAdd.uploadFileInfo=p.concat(a);
			}else{
				if($scope.employeeEntityAdd.uploadFileInfo && $scope.employeeEntityAdd.uploadFileInfo.length == 0){
					$scope.employeeEntityAdd.uploadFileInfo = $scope.PicList;
				}
			}
			
			$scope.employeeEntityAdd.uploadFileInfo=$scope.PicList;
			personSvc.updatePerson({id:$scope.employeeEntityAdd.partyId},$scope.employeeEntityAdd,function(rec){
				$scope.showFlag='';
				$scope.queryTemPartyList(1);
				$.messager.popup("角色信息更新成功");
				$scope.radioTrIndex=1;
				$scope.paginationConf.currentPage=1;
				if($scope.saveDeptId){
		    		$scope.queryPersonCopy(1,$scope.saveDeptId);
		    	}else{
		    		$scope.queryPersonCopy();
		    	}
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
			personSvc.queryPerson({id:$scope.partyId},function(rec){
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
					$.messager.popup("删除成功");
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
			personSvc.oPerson({id:$scope.partyId,state:($scope.employeeEntityAdd.state == 0?1:0)},qSucc,qErr);
	};
	
	$scope.closeStateSubmit = function(){
/*		$scope.partyId=null;
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
	
	$scope.picBtnJudge=true;
	$scope.picBtnJudgeList=[0];
	$scope.upLoadBtn=function(varl){
/*		
		if($scope.employeeEntityAdd.uploadFileInfo && $scope.PicList){
			var num = $scope.employeeEntityAdd.uploadFileInfo.length +$scope.PicList.length;
			if(num >= 2){
				$.messager.popup("大于两张不能上传");
				return;
			}
			因为不会超过2张图片现在注释掉了
		}*/
		
	/*	$timeout(function(){
			varl = 'input[id='+varl+']';
			$(varl).click();
     	},200)
     	原来加了延迟可以用但是会和钱的topmenu中的时间延迟冲突就取消了
    */
		
		//$scope.picBtnJudgeList=[0]; 这个给数组赋值的语句放到onFileSelect后面了这样能达到上传一张图片后还能继续上传
		varl = 'input[id='+varl+']';
		$(varl).click();
		//$('input[id=fileUpLoadId]').click(); 这个上面传参数复用了
	};
	
	
	
	$scope.PListLength = 0;
    $scope.onFileSelect = function ($files) {
    /*    	
 		lastModified: 1441854467633
    	lastModifiedDate: Thu Sep 10 2015 11:07:47 GMT+0800 (中国标准时间)
    	name: "ab3b9ff2426334e22aab79e5d90017d5.jpg"
    	size: 22503
    	type: "image/jpeg"
    	webkitRelativePath: ""
    	这是$files中包括的图片信息
    */
    	$scope.picBtnJudgeList=[0];
    	if($files){//$files包含图片信息其中有图片大小、图片名字、图片种类、上传时间等
            for (var i = 0; i < $files.length; i++) {
                var file = $files[i];//把上述图片信息赋值给变量file,因为数组中就一个信息所以把第一个数组的值赋值给变量file
                var MaxSize = 2097152;//图片最大尺寸(byte)   2*1024*1024=2097152 Byte
                var PicType = new Array('gif', 'jpeg', 'png', 'jpg' ,'bmp');//设定好上传种类
                var fileType=file.name.match(/^(.*)(\.)(.{1,8})$/)[3];/* 图片名字经过正则，之后剩下上传图片的类型如：jpg */
                var isPic=false;
                for (var j in PicType) {
                    if (fileType.toLowerCase() == PicType[j].toLowerCase()) {/* 如果图片的类型后缀(小写后)和设定好的类型后缀数组中的值(小写后)有相同的话 */
                        isPic=true;
                        if (file.size < MaxSize) {/*  不得大于2097152 byte */
                            $scope.upload = $upload.upload({
                                url: PicUrl, //PicUrl  
                                method: 'POST',
                                data: {myObj: $scope.myModelObj},
                                file: file,
                            }).progress(function (evt) {
                            }).success(function (data, status, headers, config) {      
                                $scope.FileSize = file.size;//上传后下载显示的图片大小
                                $scope.PicRealName = data.fileName;//6c6b027d-d2e4-4ef4-b88f-f907bef2eddc.jpg 下载的图片名字(这里的名字和本地图片的名字有差异，是上传后名字被改过了）
                                if(!$scope.employeeEntity.equipmentPic){//防止出现第一次下载图片出现图片名字为undefind，试图片加载失败
                                	$scope.employeeEntity.equipmentPic = "";
                                }
                                $scope.employeeEntity.equipmentPic += data.fileName + ",";//把每个图片的名字用字符串的形式拼接起来(此时在图片名字后面会有逗号）
                                $scope.ay = $scope.employeeEntity.equipmentPic.split(',');//然后去掉其中的逗号用数组存起来(split的作用主要是根据括号里的字符串去分割，分割成字符串数组的形式相互之间用逗号分隔开）
                                $scope.PicList = [];
                                $scope['PicOneCopy'] = {};
                                for (i = 0; i < $scope.ay.length - 1; i++) {//这里的长度减一主要因为数组最后的一个元素是空的
                                	//here 2016.1.12 9：44
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
                                    $scope.picBtnJudgeList=[0];
                                }
                                if($scope.employeeEntityAdd.uploadFileInfo){
                                	$scope.PListLength = $scope.employeeEntityAdd.uploadFileInfo.length +$scope.PicList.length;
                                }
                            });      
                        }else {
                            $.messager.popup("员工照片上传失败，请重新上传");
                        }
                    }
                }  if(isPic==false)
                {
                    $.messager.popup("员工照片上传失败，请重新上传");
                }
            }
    	}
    };
    
    
/*    
     * pic
     
    $scope.upLoadBtn = function () {
        $('input[id=fileUpLoadId]').click();
    };*/
    
    //监控图片数量
    $scope.removePic=function(parm,obj,parm2){
    	var num=-1;
    	if(parm2){
    		if(parm2==1){
    			for(var i=0;i<$scope.employeeEntityAdd.uploadFileInfo.length;i++){
    				if($scope.employeeEntityAdd.uploadFileInfo[i].picName==obj.picName){
    					num=i;
    					break;
    				}
    			}
    			$scope.employeeEntityAdd.uploadFileInfo.splice(num,1);
    		}else if(parm2==2){
    			//$scope.employeeEntity.equipmentPic="";//清空原对象  别删这是2016.2.1 15:01的时候我测试代码的时候注释了源代码，为了2点：1为什么修改删除的时候如果删除的是现数据要清空原数据，2为什么删除现数据的时候会有名字不等的情况
    			for(var i=0;i<$scope.PicList.length;i++){
    				if($scope.PicList[i].PicName==obj.PicName){
    					num=i;
    					break;//这是我后加的
    				}/*else{
    					var tmp=$scope.PicList[i].PicName+"."+$scope.PicList[i].PicType+",";
    					$scope.employeeEntity.equipmentPic+=tmp; 别删这是2016.2.1 15:01的时候我测试代码的时候注释了源代码，为了2点：1为什么修改删除的时候如果删除的是现数据要清空原数据，2为什么删除现数据的时候会有名字不等的情况
    				}*/
    			}
    			$scope.PicList.splice(num,1);
    		}
    		
    	}

		$scope.PListLength = $scope.employeeEntityAdd.uploadFileInfo.length+$scope.PicList.length;
		
	};
//===============================================================================================  begin  ==============================================================================================	
	
/*    $scope.removePic=function(parm,obj,parm2){ 别删这是2016.2.1 15:01的时候我测试代码的时候注释了源代码，为了2点：1为什么修改删除的时候如果删除的是现数据要清空原数据，2为什么删除现数据的时候会有名字不等的情况
    	var num=-1;
    	if(parm2){
    		if(parm2==1){
    			for(var i=0;i<$scope.employeeEntityAdd.uploadFileInfo.length;i++){
    				if($scope.employeeEntityAdd.uploadFileInfo[i].picName==obj.picName){
    					num=i;
    					break;
    				}
    			}
    			$scope.employeeEntityAdd.uploadFileInfo.splice(num,1);
    		}else if(parm2==2){
    			$scope.employeeEntity.equipmentPic="";//清空原对象
    			for(var i=0;i<$scope.PicList.length;i++){
    				if($scope.PicList[i].PicName==obj.PicName){
    					num=i;
    				}else{
    					var tmp=$scope.PicList[i].PicName+"."+$scope.PicList[i].PicType+",";
    					$scope.employeeEntity.equipmentPic+=tmp;
    				}
    			}
    			$scope.PicList.splice(num,1);
    		}
    		
    	}

		$scope.PListLength = $scope.employeeEntityAdd.uploadFileInfo.length+$scope.PicList.length;
		
	};*/
	//==========================================================================================  end  ===================================================================================================	

    //监控图片数量
    $scope.removePicAdd=function(parm,obj,parm2){
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
	$scope.deletePic=function(parm,obj,num){
		var tmpObj=obj;
		function succ(rec){
			$scope.removePic(parm,tmpObj,num);//监控图片数量
		}
		function err(rec){
			if(rec.data.message){
				$.messager.popup(rec.data.message);
			}
		}
		personSvc.deletePersonPic({urlPath:"pic",id:$scope.employeeEntityAdd.partyId,upLoadId:obj.uploadId},succ,err);
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
    	/*if($scope.saveDeptId){
    		$scope.queryPersonCopy(1,$scope.saveDeptId);
    	}else{
    		$scope.queryPersonCopy();
    	}*/
    	$scope.parentOrgListAdd = {};
    	$("#EmployeeAddId").modal('hide');
    };
    
    //关闭更新弹出框
    $scope.closeUpdateEmployee = function(){
    	$scope.showFlag = '';
    /*	if($scope.saveDeptId){
    		$scope.queryPersonCopy(1,$scope.saveDeptId);
    	}else{
    		$scope.queryPersonCopy();
    	}*/
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
		$scope.checkId_=entity.partyId;//判断管理员是否是同一个人用
		$scope.adminId_ = entity.orgPartyId;//判断企业下是否有管理
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
	//添加员工时选择所属企业查询是否存在管理员
	$scope.change = function(currOrgId,index){
		var levelName;
		levelName = $('#dept option:selected').text();
		if(levelName=='总公司'){
			for(i=0;i<$scope.authorityListTemp.length;i++){				
					$scope.authorityListTemp[i].showFlag = true;
					if($("#allSelectAdd").val()=="全取消"){
						$scope.authorityListTemp[i].chck = true;
					}
			}
		}else{
			for(i=0;i<$scope.authorityListTemp.length;i++){
				if($scope.authorityListTemp[i].functionId== 5||$scope.authorityListTemp[i].functionId== 16||$scope.authorityListTemp[i].functionId== 30||$scope.authorityListTemp[i].functionId== 31||$scope.authorityListTemp[i].functionId== 32){
					$scope.authorityListTemp[i].showFlag = false;
					$scope.authorityListTemp[i].chck = false;
				}else{
					$scope.authorityListTemp[i].showFlag = true;
				}	
			}
		}
		for(i=0;i<$scope.nextArray.length;i++){			
			if($scope.nextArray[i].currOrgId==currOrgId){
				$scope.levelFlagAdd = $scope.nextArray[i].orgLevel;
			}
		}
		if($scope.levelFlagAdd==3){
		if($scope.levelFlagAdd==3){
			$scope.authorityListTemp.splice(0,1);
		}else{
			$scope.getAuthorityList();
			$scope.authorityListTemp = $scope.authorityList;

			$("#allSelectAdd").val("全选");
			var length = $scope.authorityListTemp.length / 2;
			for(var i=0;i<$scope.authorityListTemp.length;i++){
				if(i<length){
					$scope.authorityListTemp[i].firstTr = true;
				}else{
					$scope.authorityListTemp[i].secondTr = true;
				}

				$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].note;
				if($scope.authorityListTemp[i].showName.length > 9){
					$scope.authorityListTemp[i].showName = $scope.authorityListTemp[i].showName.substring(0,9)+"...";
				}

				/** 打开添加model，若登录人员的企业不是总公司，则设置showFlag=false */
				if($scope.userInfo.orgLevel==1){					
					$scope.authorityListTemp[i].showFlag = true;										
				}else{
					if($scope.authorityListTemp[i].functionId== 5||$scope.authorityListTemp[i].functionId== 16||$scope.authorityListTemp[i].functionId== 30||$scope.authorityListTemp[i].functionId== 31||$scope.authorityListTemp[i].functionId== 32){
						$scope.authorityListTemp[i].showFlag = false;
					}else{
						$scope.authorityListTemp[i].showFlag = true;
					}
					
				}
			}
		}
		}
		function qSucc(rec){
			if(rec.msg.length!=0){
				$scope.showManageFlag = false;
			}
			
			if(rec.msg.length == 0){
				$scope.showManageFlag = true;
			}
		}
		function qErr(){}
		
		$scope.employeeEntity.changeOrgId = currOrgId;
		
		if(currOrgId)//防止当前企业ID为空时报错
		{
			personSvc.checkCode({parentOrgId:$scope.employeeEntity.changeOrgId,Action:'GetAdmin'},qSucc,qErr);
		}
		// 根据企业的ID获取该企业下的项目列表
		$scope.changeProListCopy(currOrgId);
	}
	
	
	
	/**
	 * 根据企业的ID获取该企业下的项目列表
	 */
		$scope.changeProListCopy = function(currOrgId){
			
	 		function qSucc(rec)
	 		{
 				$scope.proListCopy = [];
 	 			$scope.proListCopy = rec.content;//对应的项目
 	 			for(var i=0;i<$scope.proListCopy.length;i++)
 	 			{
 					$scope.proListCopy[i].nameCopy=$scope.proListCopy[i].name;
 	 				if($scope.proListCopy[i].name.length > 5)
 	 				{
 	 					$scope.proListCopy[i].nameCopy=$scope.proListCopy[i].nameCopy.substring(0,5)+"...";
 	 				}
 	 			}
	 		}
	 		function qErr(rec){$.messager.popup(rec.data.message);}
	 		
	 		$scope.proBean={};
	 		$scope.proBean.currOrgId=currOrgId;
	 		$scope.proBean.pageNo=0;
	 		$scope.proBean.pageSize=99;
	 		$scope.proBean.state=0;
	 		
			if(currOrgId)//防止当前企业ID为空时，没有清空项目列表
			{
		 		proSvc.queryPartyInstallList($scope.proBean,qSucc,qErr);
			}
			else
			{
				$scope.proListCopy = [];
			}
			
		};
	
	
	/**
	 * 查询是否存在管理员
	 */
	$scope.checkPerIdFun = function(num){
		
		if(num && num == 'add'){//添加的时候用的是上面查询的企业id
			
			function qSucc(rec){
				if(rec.msg.length!=0){
					$scope.showManageFlag = false;
				}
				
				if(rec.msg.length == 0){
					$scope.showManageFlag = true;
				}
			}
			
			function qErr(){}
			
			if(!$scope.employeeEntity.changeOrgId){
				$scope.employeeEntity.changeOrgId = SYS_USER_INFO.orgId;
			}
			personSvc.checkCode({parentOrgId:$scope.employeeEntity.changeOrgId,Action:'GetAdmin'},qSucc,qErr);
		}
		
		if(num && num == 'upd'){//修改的时候用的是点击展示的企业id
			function qSuccs(rec){
				if(rec.msg.length!=0){
					if($scope.checkId_ == rec.msg[0].partyId){
						$scope.showManageFlag = true;//如果有管理且是同一个人可以显示复选框
					}
					
					if($scope.checkId_ != rec.msg[0].partyId){
						$scope.showManageFlag = false;//如果有管理且不是同一个人不可以显示复选框
					}
				}
				
				if(rec.msg.length == 0){
					$scope.showManageFlag = true;
				}
			}
			
			function qErrs(){}
			
			personSvc.checkCode({parentOrgId:$scope.adminId_,Action:'GetAdmin'},qSuccs,qErrs);
		}
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
					if($scope[objList][j].showFlag==true){
						$scope[objList][j].chck = true;
					}
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
					if($scope[objList][j].showFlag==true){
						$scope[objList][j].chck = true;
					}
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
					$scope.KeyWordList[i].infoTitleA = val[i].name.substring(0,9)+"...";
	        	}else{
	        		$scope.KeyWordList[i].infoTitleA = val[i].name;
	        	}
			}
		};
		
		
		/*
		*input框ng-change事件
		*/
		$scope.flagAdd_show = false;
		$scope.KeyWordQuery = function(inputValue,showFlag){/* 需要 */
			$scope.KeyWordListFlag = false;//如果改变输入框的值就把flag变成false，用于时时监控不管是改变的值是有查询结果还是没有都先为false这样可以把青花瓷的例子筛选出来，也可以把没改变的时候筛选出来
			if(inputValue.length == 0){//如果输入框没有值了，就隐藏下面的展示结果域
				$scope[showFlag] = false;
				$scope.flagShow = false;
			}else{
				$scope.flagShow = true;
			}
			$scope.KeyWordList=[];/* 需要 */

			if($scope.employeeEntity.orgName.length < 1){
				$scope.showLevel = false;
				$scope.employeeEntity.isInclude = false;//复选框控制
			}
			
			function qSucc(rec){/* 需要 */
				if(rec.content.length<=0){/* 需要 */
					$scope[showFlag]=false;/* 需要 */
					$scope.flagAdd_show = true;//添加按钮不能点
				}else{
					$scope[showFlag]=true;/* 需要 */
					$scope.KeyWordList=rec.content;/* 需要 */
					$scope.KeyWordListFlag = true;//如果有查询的值flag就为true
					
					for(var i=0;i<$scope.KeyWordList.length;i++){//这里的遍历主要用于在改变输入值的时候如果有查询出对应的名字就赋值对应的code（解决在不展示查询信息的时候也可以根据查到的code去查询（如中铁二局查到后失去焦点在点查询的时候）
						if($scope.employeeEntity.orgName == $scope.KeyWordList[i].name){//如果输入的name等于展示集合的name那就赋值给对应的code
							$scope.employeeEntity.code = $scope.KeyWordList[i].code;//此地赋值code
							$scope.employeeEntity.deptId = $scope.KeyWordList[i].currOrgId;//id是用来赋值给当前单位下的人的
							$scope.saveDeptId = $scope.KeyWordList[i].currOrgId;
							$scope.flagAdd_show = false;//添加按钮不能点
							if($scope.KeyWordList[i].orgLevel == 2){
								$scope.userInfo.orgLevel_show = 2;
							}
							if($scope.KeyWordList[i].orgLevel == 3){
								$scope.userInfo.orgLevel_show = 3;
							}
							if($scope.KeyWordList[i].orgLevel == 1){
								$scope.userInfo.orgLevel_show = 1;
							}
							$scope.queryPersonCopy(1,$scope.saveDeptId);//根据当前单位的改变，改变项目名称
							break;
						}else{
							$scope.employeeEntity.code = $scope.employeeEntity.orgName;//没有就赋值名字为code相当于去查空（如中次）
							$scope.userInfo.orgLevel_show = 3;//2016.1.12 如果在修改输入文字的时候不等于局级的名字那一律按不显示复选框处理
							$scope.flagAdd_show = true;//添加按钮不能点
							$scope.queryPersonCopy(1,111111111111);//如果没有对应企业传一个不存在的id查出空项目
							//$scope.saveDeptId = 111111111111;//污染这个参数让其不能查到对应的项目
						}
					}
					
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
				$scope[searBean][codeName] = code;//$scope.employeeEntity.code
				if(level > 2){//如果选择的当前单位的级别高于2也就是是处级
					$scope.showLevel = false;//根据组织级别控制是否有显示下级的复选框，2以上为处级也就是没有下级不显示复选框
					$scope.employeeEntity.isInclude = false;//复选框控制
				} 
				if(level < 3){//如果不是处级，也就是有下级企业
					$scope.showLevel = true;//显示包含下级单位复选框
				}
				$scope[LiNumA] = false;//隐藏点选后的下拉框
				$scope.userInfo.orgLevel_show=level;
				$scope.flagAdd_show = false;
				$scope.saveDeptId = id;
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
		 			if(rec.content){
		 				$scope.proListCopy = [];
		 	 			$scope.proListCopy = rec.content;//对应的项目
		 	 			
		 	 			for(var i=0;i<$scope.proListCopy.length;i++){
	 	 					$scope.proListCopy[i].nameCopy=$scope.proListCopy[i].name;
		 	 				if($scope.proListCopy[i].name.length > 5){
		 	 					$scope.proListCopy[i].nameCopy=$scope.proListCopy[i].nameCopy.substring(0,5)+"...";
		 	 				}
		 	 			}
		 			}
		
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
					pageSize:20,
					state:0
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
			
			/**
			 * 添加模态框中权限点击方法
			 */
			$scope.trClick = function(obj){
				$scope.addModelTrIndex = obj.$parent.$index;
				for(var i=0;i<$scope.authorityListTemp.length;i++){
					if(i == obj.$parent.$index){
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
			
			//*************************************************************************************************************************************************************
			/**
			 * 以下为12.29日编写的有关输入框叉号的一系列方法，其中包括：点击叉号清除输入框值焦点定位到输入框、点击输入框判断如果输入框有值就显示叉号，没有就清空、失去焦点推迟0.15秒失去叉号这样可以保证失去焦点的时候不会叉号直接就被清空了来不及点
			 * 顺序按照上面的描述排序
			 */
			$scope.flagShow = false;
			
			$scope.cleanDateFunEnd = function(){
				$scope.employeeEntity.orgName = '';
				$("#searchContent").focus();
				$scope.flagShow = false;
				$scope.flagAdd_show = true;//加号flag
				if($scope.LiNumA == true){
					$scope.LiNumA = false;
				}
			};
			
			$scope.clickInput = function(obj){//开始是没有叉号，点击输入框如果有值就显示叉号没有，就不显示叉号
				if(obj.length > 0){
					$scope.flagShow = true;
				}else{
					$scope.flagShow = false;
				}
			};
			
			$scope.blurInput = function(){
				$timeout(function() { // 延迟0.15秒这样能优先执行清除日期的方法达到赋值，要不点击会直接清除叉号不会执行清除日期的方法不能赋值 
					$scope.flagShow = false;
					$scope.LiNumA = false;
					$scope.KeyWordList = [];
			     },150);
				
				if($scope.employeeEntity.orgName == ''){//失去焦点时如果当前单位是空的默认查询当前登录人信息
					$scope.flagAdd_show = false;//当为空的时候离可点添加
					$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
					
					$scope.employeeEntity.code=SYS_USER_INFO.orgCode;
					$scope.employeeEntity.changeOrgId = SYS_USER_INFO.orgId;
					$scope.KeyWordListFlag = true ;
					if(SYS_USER_INFO.orgLevel == 2){
						$scope.userInfo.orgLevel_show = 2;
					}          
					
					if(SYS_USER_INFO.orgLevel == 1){
						$scope.userInfo.orgLevel_show = 1;
					}
					
					if(SYS_USER_INFO.orgLevel == 3){
						$scope.userInfo.orgLevel_show = 3;
					}
					$scope.queryPersonCopy();
				}
			};
			//*************************************************************************************************************************************************************
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
			
			
			
			
			/**
			 * 给下拉框定一个值展开
			 */
			var judgeSelect=true;
			$scope.saveFlag = true;
			$scope.openProSelect = function(obj,obj2){//按照1、2、3的顺序，点击下拉框（1），改变一个值（2），下拉框收回去(3),这是一个循环
				$scope.outClickFlag = false;//（1）先触发这里的select
				if(judgeSelect){//1
					if($scope.employeeEntity.proId){//为了能触发change方法所以把值清空了
						$scope.employeeEntity.proIdCopy_ = $scope.employeeEntity.proId;
						$scope.employeeEntity.proId = null;
					}
					$("#"+obj).attr("size",$scope[obj2].length); 
					$scope.saveFlag = false;
				}else{
					judgeSelect = true;//3
					$scope.saveFlag = true;
					$("#"+obj).attr("size",1);
				}
			};
			
			/**
			 * 给下拉框定一个值展开的改变方法（也就是点击具体值后，改变值的方法）
			 */
			$scope.openProSelectChange=function(){
				judgeSelect = false;//2
				$scope.saveFlag = false;
			};
			
			
	/*		*//**
			 * 点击外面的情况
			 *//*
			$scope.outClickFlag = true;
			$scope.click_BlurToInitFun = function(obj1,obj3){
				if($scope[obj3] && $scope[obj3].length > 10){
					if($scope.outClickFlag){//（3）当点击外面的时候触发的这里把select收回去这时因为之前转成了true所以成功进来了，也相当于恢复了初始状态
						if(obj1){
							$("#"+obj1).attr("size",1);
						}
					}else{//(2)触发完外面的select紧接着触发的这里的点击事件进入这里恢复成true，相当于第一次点击什么事情都没发生
						$scope.outClickFlag = true;
					}
				}
			};*/
			
			$scope.mouseFlag = true;
			
			$scope.overFun = function(){
				$scope.mouseFlag = false;
			};
			
			$scope.leaveFun = function(){
				$scope.mouseFlag = true;
			};
			
			document.onmousedown = function(){
				if($scope.mouseFlag == true && $scope.saveFlag == false){//鼠标在外面和下拉框展开着
					$scope.$apply(function() {
						$scope.employeeEntity.proId = $scope.employeeEntity.proIdCopy_;
					});
					$("#addTest").attr("size",1);
				}
			};
			
			setTimeout(function() {
			    $scope.$apply(function() {
			    	var textareas = document.getElementsByTagName("textarea");
			    	var pf=new window.placeholderFactory(); 
			    	pf.createPlaceholder(textareas);
			    	//document.getElementById("eeeee").value="asd";
			    });  
			}, 500);
			
			
			/* 总公司人员只能查询，不能管理 */
			$scope.levelFlag = true;
			if(SYS_USER_INFO.orgLevel==1){ 
				$scope.levelFlag = false;
			};

			$scope.proQryBean = {};

			/* 初始化项目设置列表查询 */
			$scope.proQryBean.currOrgId = $scope.userInfo.orgId;
			if($scope.userInfo.proId){/** 如果登录人员有项目，则当前单位显示项目信息，且不能选择单位 */
				$scope.proQryBean.proId = $scope.userInfo.proId;
				$scope.proQryBean.nameInput = $scope.userInfo.proName;
			}
			else{/** 如果登录人员没有项目，则当前单位默认显示单位信息，可以选择单位 */
				if($scope.userInfo.orgLevel==3){
					$scope.proQryBean.nameInput = $scope.userInfo.orgName;
				}
				else{
					$scope.proQryBean.name = $scope.userInfo.orgName;
				}
			};
			
			
			/* 资源管理列表查询分页标签参数配置 */
			$scope.paginationConfOrgORProject = {
				currentPage: 1,/** 当前页数 */
				totalItems: 1,/** 数据总数 */
				itemsPerPage: 10,/** 每页显示多少 */
				pagesLength: 10,/** 分页标签数量显示 */
				perPageOptions: [10, 20, 30, 40],
				onChange: function(currentPage){
					if($scope.queryEmployer.currOrgId){
						$scope.changEmployers(currentPage);
						}
				}
			};
			
			$scope.employers = [];
			$scope.employer = {};
			$scope.queryEmployer = {};

			/* 打开 选择所在单位模态框 */
			$scope.openEmployerModel = function(){
				if($scope.employers.length==0){//	首次打开
					var orgLv;
					if(1==$scope.userInfo.orgLevel){
						orgLv = 9;
					}
					else if(2==$scope.userInfo.orgLevel){
						orgLv = 1;
					}

					$scope.queryEmployer.currOrgId = $scope.userInfo.orgId;

					/** 放入单位信息，且查询该组织下的机构 */
					$scope.employers = [{name: $scope.userInfo.orgName, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

					$scope.queryEmployer.pageNo = 0;
					$scope.queryEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

					/** 根据currOrgId，查询该组织下的机构 begin */
					function qSucc(rec){
						$scope.employerList = rec.content;
						$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
						$('#employerModel').modal('show');
					}
					function qErr(){
						
					}
					entSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
					/** 根据currOrgId，查询该组织下的机构 end */
				}
				else{//	非首次打开
					$('#employerModel').modal('show');
				}
			};
			
			
			/* 点击查询按钮，根据当前位置的最下级单位id，查询单位列表 */
			$scope.changEmployers = function(currentPage) {
				if(currentPage)
				{
					$scope.paginationConfOrgORProject.currentPage = currentPage;
				}

				var employersLength = $scope.employers.length;
				if(employersLength<=0){
					return ;
				}

				if($scope.employers[employersLength - 1].orgFlag==2){
					return ;
				}

				$scope.queryEmployer.currOrgId = $scope.employers[employersLength - 1].currOrgId;

				$scope.qryEmployer();
			};
			
			/* 点击查询下级单位，且保存点击的机构信息 */
			$scope.clickEmployer = function(currentPage, orgInfo){
				if(currentPage)
				{
					$scope.paginationConfOrgORProject.currentPage = currentPage;
				}

				var orgLv;
				if(1==orgInfo.orgLevel){
					orgLv = 9;
				}
				else if(2==orgInfo.orgLevel){
					orgLv = 1;
				}

				/** 保存点击的机构信息 */
				$scope.employer = {};

				$scope.employer.name = orgInfo.name;
				$scope.employer.currOrgId = orgInfo.currOrgId;
				$scope.employer.orgFlag = orgLv;
				$scope.employer.orgCode = orgInfo.code;
				$scope.employers.push($scope.employer);

				$scope.queryEmployer.currOrgId = orgInfo.currOrgId;

				$scope.qryEmployer();
			};
			
			/* 点击处级单位，变更保存的处级单位信息 */
			$scope.changEmployer = function(orgInfo){
				/** 变更保存点击的处级单位信息 */
				$scope.employer = {};

				$scope.employer.name = orgInfo.name;
				$scope.employer.currOrgId = orgInfo.currOrgId;
				$scope.employer.orgFlag = 2;
				$scope.employer.orgCode = orgInfo.code;
				
				var employersLength = $scope.employers.length;
				if(employersLength>0 && 2==$scope.employers[employersLength - 1].orgFlag){
					$scope.employers.splice(employersLength - 1, 1);
				}
				$scope.employers.push($scope.employer);
			};
			
			/* 点击当前位置的单位，变更当前位置、单位列表 */
			$scope.clickEmployers = function(currentPage, orgInfo, employersIndex){
				if(currentPage)
				{
					$scope.paginationConfOrgORProject.currentPage = currentPage;
				}

				/** 变更当前位置 */
				var employersLength = $scope.employers.length;
				if(employersLength<=0){
					return ;
				}

				$scope.employers.splice(employersIndex + 1, employersLength - employersIndex - 1);

				/** 保存点击的机构信息 */
				$scope.queryEmployer.currOrgId = orgInfo.currOrgId;

				var orgLv = $scope.employers[employersIndex].orgFlag;
				if(2==orgLv){/** 处级单位 */
					return ;
				}
				else{/** 总公司/局级单位 */
					$scope.qryEmployer();
				}
			};
			
			
			/* 根据currOrgId，查询该组织下的机构 */
			$scope.qryEmployer = function(){
				$scope.queryEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
				$scope.queryEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

				/** 根据currOrgId，查询该组织下的机构 begin */
				function qSucc(rec){
					$scope.employerList = rec.content;
					$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
				}
				function qErr(){
					
				}
				entSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
				/** 根据currOrgId，查询该组织下的机构 end */
			};

			/* 变更并关闭 选择单位/项目模态框 */
			$scope.modifyEmployerModel = function(val){
				$('#employerModel').modal('hide');

				var employersLength = $scope.employers.length;
				if(employersLength<=0){
					return ;
				}

				$scope.employer = $scope.employers[employersLength - 1];
				$scope.proQryBean.orgCode = $scope.employer.orgCode;
				$scope.proQryBean.currOrgId = $scope.employer.currOrgId;
				$scope.proQryBean.name = $scope.employer.name;
				$scope.changeProListCopy($scope.proQryBean.currOrgId);
			};

			/* 取消并关闭 选择单位/项目模态框 */
			$scope.closeEmployerModel = function(){
				$('#employerModel').modal('hide');
			} 
			
			
			/* 双击列表中的一条记录或点击查看按钮，查询详情 */
			$scope.projectDetail = {};

			$scope.queryProDetail = function(currOrgId, index_){
				if(index_){
					$scope.radioTrIndex = index_;
				}
				if(currOrgId){
					$scope.qryProDetail.proId = currOrgId;
				}

				if(!$scope.qryProDetail.proId){
					$.messager.popup("请选择一条信息");
					return;
				}

				$scope.projectDetail = {};

				/** 根据项目id，查询项目详情 begin */
				function qSucc(rec){
					$scope.projectDetail = rec;

					$("#EnterPriseQueryModal").modal({backdrop: 'static', keyboard: false});
				}

				function qErr(){
					
				}

				proSvc.queryPartyInstallDetail({id: $scope.qryProDetail.proId}, qSucc, qErr);
				/** 根据项目id，查询项目详情 end */
			};
			
});


