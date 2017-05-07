app.controller('EquipmentListController', function($scope, $timeout, SYS_CODE_CON, sysCodeTranslateFactory, equipment, entSvc, proSvc, regionSvc, category, busEquParameterSvc) {

	/* ie9下title正确显示使用 */
	document.title = "资源管理";

	/* 水印信息 */
	$scope.placeholders = {
		equipmentCost: "请输入金额",
		remark: "其他主要条款",
		models: "请输入型号",
		specifications: "请输入规格",
		sellPrice: "请输入金额",
		scrapPrice: "请输入金额"
	};

	$scope.sysCodeCon = SYS_CODE_CON;	//	把常量赋值给一个对象这样可以使用了
	$scope.ct = sysCodeTranslateFactory;	//	把翻译赋值给一个对象

	/* userInfo */
	$scope.userInfo = {};

	$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
	$scope.userInfo.orgId = SYS_USER_INFO.orgId;
	$scope.userInfo.orgCode = SYS_USER_INFO.orgCode;
	$scope.userInfo.orgName = SYS_USER_INFO.orgName;
	$scope.userInfo.proId = SYS_USER_INFO.proId;
	$scope.userInfo.proName = SYS_USER_INFO.proName;
	$scope.userInfo.perPartyId = SYS_USER_INFO.perPartyId;

	/* 总公司人员只能查询，不能管理 */
	$scope.levelFlag = true;
	if(SYS_USER_INFO.orgLevel==1){ 
		$scope.levelFlag = false;
	};

	/* 资源管理列表查询分页标签参数配置 */
	$scope.paginationConf = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 20,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [20, 40, 60, 80],
		onChange: function(currentPage){
			$scope.queryEquipmentData(currentPage);
		}
	};

	$scope.equQryBean = {};
	$scope.equQryBean.isInclude = 0;
	$scope.equQryBean.isCrecOrg = 0;

	/* 初始化资源管理列表查询 */
	if($scope.userInfo.proId){/** 如果登录人员有项目，则当前单位显示项目信息，且不能选择单位/项目；列表显示该项目下的设备资源 */
		$scope.equQryBean.orgFlag = 3;
		$scope.equQryBean.orgPartyId = $scope.userInfo.proId;
		$scope.equQryBean.orgNameInput = $scope.userInfo.proName;
	}
	else{/** 如果登录人员没有项目，则当前单位默认显示单位信息，可以选择单位/项目；列表显示该单位/项目下的设备资源 */
		if(1==$scope.userInfo.orgLevel){
			$scope.equQryBean.orgFlag = 9;

			$scope.equQryBean.isInclude = 1;
		}
		else if(2==$scope.userInfo.orgLevel){
			$scope.equQryBean.orgFlag = 1;
		}
		else if(3==$scope.userInfo.orgLevel){
			$scope.equQryBean.orgFlag = 2;
		}
		$scope.equQryBean.orgPartyId = $scope.userInfo.orgId;
		$scope.equQryBean.orgName = $scope.userInfo.orgName;
	};

	$scope.btnShow_ = false;
	$scope.queryEquipmentData = function(currentPage){
		if(currentPage)
		{
			$scope.paginationConf.currentPage = currentPage;
		}

		$scope.selectFlag = "";

		/** 资源管理（中铁用户）列表查询 begin */
		function qSucc(rec){
			$scope.equipmentList = rec.content;
			$scope.paginationConf.totalItems = rec.totalElements;

			if(rec.content.length!=0){
				$scope.btnShow_ = true;
				for(var i=0;i<$scope.equipmentList.length;i++){
					/** 所属局级单位名称 */
					$scope.equipmentList[i].bureauOrgPartyNameCopy = $scope.equipmentList[i].bureauOrgPartyName;
					if($scope.equipmentList[i].bureauOrgPartyName && $scope.equipmentList[i].bureauOrgPartyName.length > 10){
						$scope.equipmentList[i].bureauOrgPartyNameCopy = $scope.equipmentList[i].bureauOrgPartyNameCopy.substring(0,10) + "...";
					}

					/** 所属处级单位名称 */
					$scope.equipmentList[i].sonOrgNameCopy = $scope.equipmentList[i].sonOrgName;
					if($scope.equipmentList[i].sonOrgName && $scope.equipmentList[i].sonOrgName.length > 10){
						$scope.equipmentList[i].sonOrgNameCopy = $scope.equipmentList[i].sonOrgNameCopy.substring(0,10) + "...";
					}

					/** 所属项目名称 */
					$scope.equipmentList[i].proOrgNameCopy = $scope.equipmentList[i].proOrgName;
					if($scope.equipmentList[i].proOrgName && $scope.equipmentList[i].proOrgName.length > 10){
						$scope.equipmentList[i].proOrgNameCopy = $scope.equipmentList[i].proOrgNameCopy.substring(0,10) + "...";
					}

					/** 设备资源编号 */
					$scope.equipmentList[i].equNoCopy = $scope.equipmentList[i].equNo;
					if($scope.equipmentList[i].equNo && $scope.equipmentList[i].equNo.length > 9){
						$scope.equipmentList[i].equNoCopy = $scope.equipmentList[i].equNoCopy.substring(0,9) + "...";
					}

					/** 资产编号 */
					$scope.equipmentList[i].assetCopy = $scope.equipmentList[i].asset;
					if($scope.equipmentList[i].asset && $scope.equipmentList[i].asset.length > 4){
						$scope.equipmentList[i].assetCopy = $scope.equipmentList[i].assetCopy.substring(0,4) + "...";
					}

					/** 设备名称 */
					$scope.equipmentList[i].equNameCopy = $scope.equipmentList[i].equName;
					if($scope.equipmentList[i].equName && $scope.equipmentList[i].equName.length > 8){
						$scope.equipmentList[i].equNameCopy = $scope.equipmentList[i].equNameCopy.substring(0,8) + "...";
					}

					/** 品牌名称 */
					$scope.equipmentList[i].brandNameCopy = $scope.equipmentList[i].brandName;
					if($scope.equipmentList[i].brandName && $scope.equipmentList[i].brandName.length > 6){
						$scope.equipmentList[i].brandNameCopy = $scope.equipmentList[i].brandNameCopy.substring(0,6)+"...";
					}

					/** 生产厂家名称 */
					$scope.equipmentList[i].manufacturerNameCopy = $scope.equipmentList[i].manufacturerName;
					if($scope.equipmentList[i].manufacturerName && $scope.equipmentList[i].manufacturerName.length > 8){
						$scope.equipmentList[i].manufacturerNameCopy = $scope.equipmentList[i].manufacturerNameCopy.substring(0,8) + "...";
					}

					/** 型号名称 */
					$scope.equipmentList[i].modelsCopy = $scope.equipmentList[i].models;
					if($scope.equipmentList[i].models && $scope.equipmentList[i].models.length > 4){
						$scope.equipmentList[i].modelsCopy = $scope.equipmentList[i].modelsCopy.substring(0,4)+"...";
					}

					/** 规格名称 */
					$scope.equipmentList[i].specificationsCopy = $scope.equipmentList[i].specifications;
					if($scope.equipmentList[i].specifications && $scope.equipmentList[i].specifications.length > 4){
						$scope.equipmentList[i].specificationsCopy = $scope.equipmentList[i].specificationsCopy.substring(0,4)+"...";
					}
				}
			}
			else{
				$scope.btnShow_ = false;
				$.messager.popup("没有符合条件的记录！");
			}
		}

		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		$scope.equQryBean.pageNo = $scope.paginationConf.currentPage - 1;
		$scope.equQryBean.pageSize = $scope.paginationConf.itemsPerPage;
		if($scope.equQryBean.isCrecOrg==1){
			$scope.equQryBean.equAtOrgName = $scope.equQryBean.equAtOrgNameInput;
		}
		else{
			$scope.equQryBean.equAtOrgName = $scope.equQryBean.equAtOrgNameSelect;
		}

		equipment.post({Action: "AllUseOwn"}, $scope.equQryBean, qSucc, qErr);
		/** 资源管理（中铁用户）列表查询 end */
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
				$scope.clickProjects(currentPage);
				}
		}
	};

	$scope.employers = [];
	$scope.employer = {};
	$scope.queryEmployer = {};
	$scope.check = true;	//	项目选项 显示标志
	$scope.queryEmployer.check = false;	//	项目选项值
	$scope.checkTrEmployer = true;	//	列名称 - 单位名称 显示标志
	$scope.checkTrProjects = false;	//	列名称 - 项目名称 显示标志

	/* 打开 选择当前单位/项目模态框 */
	$scope.openEmployerModel = function(){
		if($scope.employers.length==0){//	首次打开
			var orgLv;
			if(1==$scope.userInfo.orgLevel){
				orgLv = 9;
			}
			else if(2==$scope.userInfo.orgLevel){
				orgLv = 1;
			}
			else if(3==$scope.userInfo.orgLevel){
				orgLv = 2;
			}

			$scope.queryEmployer.currOrgId = $scope.userInfo.orgId;

			/** 放入单位信息，且查询该组织下的机构/项目 */
			$scope.employers = [{name: $scope.userInfo.orgName, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

			$scope.queryEmployer.pageNo = 0;
			$scope.queryEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

			if(2==orgLv){
				$scope.checkTrProjects = true;
				$scope.checkTrEmployer = false;
				$scope.queryEmployer.check = true;
				$scope.check = false;

				/** 根据currOrgId，查询该组织下的项目 begin */
				function qSucc(rec){
					$scope.employerList = rec.content;
					$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
					$('#employerModel').modal({backdrop: 'static', keyboard: false});
				}
				function qErr(rec){
					$.messager.popup(rec.data.message);
				}
				proSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
				/** 根据currOrgId，查询该组织下的项目 end */
				}
			else{
				$scope.checkTrProjects = false;
				$scope.checkTrEmployer = true;
				$scope.queryEmployer.check = false;
				$scope.check = true;

				/** 根据currOrgId，查询该组织下的机构 begin */
				function qSucc2(rec){
					$scope.employerList = rec.content;
					$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
					$('#employerModel').modal({backdrop: 'static', keyboard: false});
				}
				function qErr2(rec){
					$.messager.popup(rec.data.message);
				}
				entSvc.queryPartyInstallList($scope.queryEmployer, qSucc2, qErr2);
				/** 根据currOrgId，查询该组织下的机构 end */
			}
		}
		else{//	非首次打开
			$('#employerModel').modal({backdrop: 'static', keyboard: false});
		}
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
		else if(3==orgInfo.orgLevel){
			orgLv = 2;
		}

		/** 保存点击的机构信息 */
		$scope.employer = {};

		$scope.employer.name = orgInfo.name;
		$scope.employer.currOrgId = orgInfo.currOrgId;
		$scope.employer.orgFlag = orgLv;

		$scope.employers.push($scope.employer);

		$scope.queryEmployer.currOrgId = orgInfo.currOrgId;

		if(2==orgLv){/** 处级单位 */
			$scope.checkTrProjects = true;
			$scope.checkTrEmployer = false;
			$scope.queryEmployer.check = true;
			$scope.check = false;

			$scope.qryProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkTrProjects = false;
			$scope.checkTrEmployer = true;
			$scope.queryEmployer.check = false;
			$scope.check = true;

			$scope.qryEmployer();
		}
	};

	/* 点击项目，变更保存的项目信息 */
	$scope.clickProject = function(orgInfo){
		/** 变更保存点击的项目信息 */
		$scope.employer = {};

		$scope.employer.name = orgInfo.name;
		$scope.employer.currOrgId = orgInfo.currOrgId;
		$scope.employer.orgFlag = 3;

		var employersLength = $scope.employers.length;
		if(employersLength>0 && 3==$scope.employers[employersLength - 1].orgFlag){
			$scope.employers.splice(employersLength - 1, 1);
		}
		$scope.employers.push($scope.employer);
	};

	/* 点击当前位置的单位/项目，变更当前位置、单位/项目列表 */
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
		if(3==orgLv){/** 项目 */
			return ;
		}
		else if(2==orgLv){/** 处级单位 */
			$scope.checkTrProjects = true;
			$scope.checkTrEmployer = false;
			$scope.queryEmployer.check = true;
			$scope.check = false;

			$scope.qryProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkTrProjects = false;
			$scope.checkTrEmployer = true;
			$scope.queryEmployer.check = false;
			$scope.check = true;

			$scope.qryEmployer();
		}
	};

	/* 勾选项目，根据当前位置的最下级单位id，查询单位/项目列表 */
	$scope.clickProjects = function(currentPage) {
		if(currentPage)
		{
			$scope.paginationConfOrgORProject.currentPage = currentPage;
		}

		var employersLength = $scope.employers.length;
		if(employersLength<=0){
			return ;
		}

		if($scope.employers[employersLength - 1].orgFlag==3){
			return ;
		}

		$scope.queryEmployer.currOrgId = $scope.employers[employersLength - 1].currOrgId;

		if($scope.queryEmployer.check){
			$scope.checkTrProjects = true;
			$scope.checkTrEmployer = false;

			$scope.qryProject();
		}
		else{
			$scope.checkTrProjects = false;
			$scope.checkTrEmployer = true;

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
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		entSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的机构 end */
	};

	/* 根据currOrgId，查询该组织下的项目 */
	$scope.qryProject = function(){
		$scope.queryEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
		$scope.queryEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的项目 begin */
		function qSucc(rec){
			$scope.employerList = rec.content;
			$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		proSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
	};

	/* 变更并关闭 选择单位/项目模态框 */
	$scope.modifyEmployerModel = function(){
		$('#employerModel').modal('hide');

		var employersLength = $scope.employers.length;
		if(employersLength<=0){
			return ;
		}

		$scope.employer = $scope.employers[employersLength - 1];

		$scope.equQryBean.orgFlag = $scope.employer.orgFlag;
		$scope.equQryBean.orgPartyId = $scope.employer.currOrgId;
		$scope.equQryBean.orgName = $scope.employer.name;
	};

	/* 取消并关闭 选择单位/项目模态框 */
	$scope.closeEmployerModel = function(){
		$('#employerModel').modal('hide');
	} 

	/* 资源管理列表查询分页标签参数配置 */
	$scope.paginationConfEquAtOrgORProject = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 10,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [10, 20, 30, 40],
		onChange: function(currentPage){
			if($scope.queryEquAtEmployer.currOrgId){
				$scope.clickEquAtProjects(currentPage);
				}
		}
	};

	$scope.equAtEmployers = [];
	$scope.equAtEmployer = {};
	$scope.queryEquAtEmployer = {};
	$scope.equAtCheck = true;	//	项目选项 显示标志
	$scope.queryEquAtEmployer.check = false;	//	项目选项值
	$scope.checkEquAtTrEmployer = true;	//	列名称 - 单位名称 显示标志
	$scope.checkEquAtTrProjects = false;	//	列名称 - 项目名称 显示标志

	/* 打开 选择所在单位/项目模态框 */
	$scope.openEquAtEmployerModel = function(){
		if($scope.equAtEmployers.length==0){//	首次打开
			$scope.queryEquAtEmployer.currOrgId = 1;
			$scope.queryEquAtEmployer.currOrgName = "总公司";

			/** 放入单位信息，且查询该组织下的机构/项目 */
			$scope.equAtEmployers = [{name: $scope.queryEquAtEmployer.currOrgName, currOrgId: $scope.queryEquAtEmployer.currOrgId, orgFlag: 9}];

			$scope.queryEquAtEmployer.pageNo = 0;
			$scope.queryEquAtEmployer.pageSize = $scope.paginationConfEquAtOrgORProject.itemsPerPage;

			$scope.checkEquAtTrProjects = false;
			$scope.checkEquAtTrEmployer = true;
			$scope.queryEquAtEmployer.check = false;
			$scope.equAtCheck = true;

			/** 根据currOrgId，查询该组织下的机构 begin */
			function qSucc2(rec){
				$scope.equAtEmployerList = rec.content;
				$scope.paginationConfEquAtOrgORProject.totalItems = rec.totalElements;
				$('#equAtEmployerModel').modal({backdrop: 'static', keyboard: false});
			}
			function qErr2(rec){
				$.messager.popup(rec.data.message);
			}
			entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc2, qErr2);
			/** 根据currOrgId，查询该组织下的机构 end */
		}
		else{//	非首次打开
			$('#equAtEmployerModel').modal({backdrop: 'static', keyboard: false});
		}
	};

	/* 点击查询下级单位，且保存点击的机构信息 */
	$scope.clickEquAtEmployer = function(currentPage, orgInfo){
		if(currentPage)
		{
			$scope.paginationConfEquAtOrgORProject.currentPage = currentPage;
		}

		var orgLv;
		if(1==orgInfo.orgLevel){
			orgLv = 9;
		}
		else if(2==orgInfo.orgLevel){
			orgLv = 1;
		}
		else if(3==orgInfo.orgLevel){
			orgLv = 2;
		}

		/** 保存点击的机构信息 */
		$scope.equAtEmployer = {};

		$scope.equAtEmployer.name = orgInfo.name;
		$scope.equAtEmployer.currOrgId = orgInfo.currOrgId;
		$scope.equAtEmployer.orgFlag = orgLv;

		$scope.equAtEmployers.push($scope.equAtEmployer);

		$scope.queryEquAtEmployer.currOrgId = orgInfo.currOrgId;

		if(2==orgLv){/** 处级单位 */
			$scope.checkEquAtTrProjects = true;
			$scope.checkEquAtTrEmployer = false;
			$scope.queryEquAtEmployer.check = true;
			$scope.equAtCheck = false;

			$scope.qryEquAtProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkEquAtTrProjects = false;
			$scope.checkEquAtTrEmployer = true;
			$scope.queryEquAtEmployer.check = false;
			$scope.equAtCheck = true;

			$scope.qryEquAtEmployer();
		}
	};

	/* 点击项目，变更保存的项目信息 */
	$scope.clickEquAtProject = function(orgInfo){
		/** 变更保存点击的项目信息 */
		$scope.equAtEmployer = {};

		$scope.equAtEmployer.name = orgInfo.name;
		$scope.equAtEmployer.currOrgId = orgInfo.currOrgId;
		$scope.equAtEmployer.orgFlag = 3;

		var employersLength = $scope.equAtEmployers.length;
		if(employersLength>0 && 3==$scope.equAtEmployers[employersLength - 1].orgFlag){
			$scope.equAtEmployers.splice(employersLength - 1, 1);
		}
		$scope.equAtEmployers.push($scope.equAtEmployer);
	};

	/* 点击当前位置的单位/项目，变更当前位置、单位/项目列表 */
	$scope.clickEquAtEmployers = function(currentPage, orgInfo, employersIndex){
		if(currentPage)
		{
			$scope.paginationConfEquAtOrgORProject.currentPage = currentPage;
		}

		/** 变更当前位置 */
		var employersLength = $scope.equAtEmployers.length;
		if(employersLength<=0){
			return ;
		}

		$scope.equAtEmployers.splice(employersIndex + 1, employersLength - employersIndex - 1);

		/** 保存点击的机构信息 */
		$scope.queryEquAtEmployer.currOrgId = orgInfo.currOrgId;

		var orgLv = $scope.equAtEmployers[employersIndex].orgFlag;
		if(3==orgLv){/** 项目 */
			return ;
		}
		else if(2==orgLv){/** 处级单位 */
			$scope.checkTrProjects = true;
			$scope.checkTrEmployer = false;
			$scope.queryEquAtEmployer.check = true;
			$scope.equAtCheck = false;

			$scope.qryEquAtProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkEquAtTrProjects = false;
			$scope.checkEquAtTrEmployer = true;
			$scope.queryEquAtEmployer.check = false;
			$scope.equAtCheck = true;

			$scope.qryEquAtEmployer();
		}
	};

	/* 勾选项目，根据当前位置的最下级单位id，查询单位/项目列表 */
	$scope.clickEquAtProjects = function(currentPage) {
		if(currentPage)
		{
			$scope.paginationConfEquAtOrgORProject.currentPage = currentPage;
		}

		var employersLength = $scope.equAtEmployers.length;
		if(employersLength<=0){
			return ;
		}

		if($scope.equAtEmployers[employersLength - 1].orgFlag==3){
			return ;
		}

		$scope.queryEquAtEmployer.currOrgId = $scope.equAtEmployers[employersLength - 1].currOrgId;

		if($scope.queryEquAtEmployer.check){
			$scope.checkEquAtTrProjects = true;
			$scope.checkEquAtTrEmployer = false;

			$scope.qryEquAtProject();
		}
		else{
			$scope.checkEquAtTrProjects = false;
			$scope.checkEquAtTrEmployer = true;

			$scope.qryEquAtEmployer();
		}
	};

	/* 根据currOrgId，查询该组织下的机构 */
	$scope.qryEquAtEmployer = function(){
		$scope.queryEquAtEmployer.pageNo = $scope.paginationConfEquAtOrgORProject.currentPage - 1;
		$scope.queryEquAtEmployer.pageSize = $scope.paginationConfEquAtOrgORProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的机构 begin */
		function qSucc(rec){
			$scope.equAtEmployerList = rec.content;
			$scope.paginationConfEquAtOrgORProject.totalItems = rec.totalElements;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的机构 end */
	};

	/* 根据currOrgId，查询该组织下的项目 */
	$scope.qryEquAtProject = function(){
		$scope.queryEquAtEmployer.pageNo = $scope.paginationConfEquAtOrgORProject.currentPage - 1;
		$scope.queryEquAtEmployer.pageSize = $scope.paginationConfEquAtOrgORProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的项目 begin */
		function qSucc(rec){
			$scope.equAtEmployerList = rec.content;
			$scope.paginationConfEquAtOrgORProject.totalItems = rec.totalElements;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		proSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
	};

	/* 变更并关闭 选择单位/项目模态框 */
	$scope.modifyEquAtEmployerModel = function(){
		$('#equAtEmployerModel').modal('hide');

		var employersLength = $scope.equAtEmployers.length;
		if(employersLength<=0){
			return ;
		}

		$scope.equAtEmployer = $scope.equAtEmployers[employersLength - 1];

		$scope.equQryBean.equAtOrgFlag = $scope.equAtEmployer.orgFlag;
		$scope.equQryBean.equAtOrgPartyId = $scope.equAtEmployer.currOrgId;
		$scope.equQryBean.equAtOrgNameSelect = $scope.equAtEmployer.name;
	};

	/* 取消并关闭 选择单位/项目模态框 */
	$scope.closeEquAtEmployerModel = function(){
		$('#equAtEmployerModel').modal('hide');
	} 

	/* 清空并关闭 选择单位/项目模态框 */
	$scope.clearEquAtEmployerModel = function(){
		$scope.equQryBean.equAtOrgFlag = null;
		$scope.equQryBean.equAtOrgPartyId = null;
		$scope.equQryBean.equAtOrgNameSelect = null;

		$scope.equAtEmployers = [];
		$scope.equAtEmployer = {};
		$scope.queryEquAtEmployer = {};
		$scope.equAtCheck = true;	//	项目选项 显示标志
		$scope.queryEquAtEmployer.check = false;	//	项目选项值
		$scope.checkEquAtTrEmployer = true;	//	列名称 - 单位名称 显示标志
		$scope.checkEquAtTrProjects = false;	//	列名称 - 项目名称 显示标志

		$('#equAtEmployerModel').modal('hide');
	};

	/* 选择单选框 */
	$scope.selectFlag = "";	/** 记录第几个单选框标记 */
	$scope.qryEquDetail = {};

	$scope.equipSelect = function(equipmentId, equFlag, equState, index_){
		$scope.selectFlag = index_;
		$scope.qryEquDetail.equipmentId = equipmentId;
		$scope.qryEquDetail.equFlag = equFlag;
		$scope.qryEquDetail.equState = equState;
	};

	/* 双击列表中的一条记录或点击查看按钮，查询详情 */
	$scope.equipment = {};

	$scope.openQueryModal = function(equipmentId, equFlag, equState, index_){
		if(index_){
			$scope.selectFlag = index_;
		}
		if(equipmentId){
			$scope.qryEquDetail.equipmentId = equipmentId;
		}
		if(equFlag){
			$scope.qryEquDetail.equFlag = equFlag;
		}
		if(equState){
			$scope.qryEquDetail.equState = equState;
		}

		if(!$scope.qryEquDetail.equipmentId){
			$.messager.popup("请选择一条信息");
			return;
		}

		function qSucc(rec){
			$scope.equipment = rec;

			/** 生产厂家名称 */
			$scope.equipment.manufacturerNameCopy = $scope.equipment.manufacturerName;
			if($scope.equipment.manufacturerName && $scope.equipment.manufacturerName.length > 12){
				$scope.equipment.manufacturerNameCopy = $scope.equipment.manufacturerNameCopy.substring(0,12) + "...";
			}

			if(!$scope.equipment.equipmentCost){
				$scope.equipment.equipmentCost = "";
			}

			if(!$scope.equipment.leasePrice){
				$scope.equipment.leasePrice = "";
			}

			if($scope.equipment.equAtProjectName){
				$scope.equipment.equAtName = $scope.equipment.equAtProjectName;
			}
			else{
				$scope.equipment.equAtName = $scope.equipment.equAtOrgName;
			}

			/** 根据设备来源分类，回显不同信息 */
			$scope.clickRegion($scope.equipment.equipmentSourceNo);

			$("#equipmentMessage").modal({backdrop: 'static', keyboard: false});
		}

		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		equipment.unifydo({urlPath: $scope.qryEquDetail.equipmentId}, qSucc, qErr);
	};

	/* 根据设备来源分类，回显不同信息 */
	$scope.clickRegion = function(flag){
		if(flag==1){
			$scope.association = true;
			$scope.own = false;
			$scope.stocks = true;
			if($scope.equipmentBean){
				if(5==$scope.equipmentBean.busState1){
					$scope.equipmentBean.SupplementStar = false;
				}
				else{
					$scope.equipmentBean.SupplementStar = true;
				}

				$scope.equipmentBean.onProvinceId = "";
				$scope.equipmentBean.onCityId = "";
				$scope.equipmentBean.onDistrictId = "";
				$scope.equipmentBean.address = "";
				$scope.equipmentBean.custodian = "";
				$scope.equipmentBean.contactPersonPhone = "";
				$scope.pList = [];
				$scope.cList = [];

				$scope.changeOwnContactInfo();
			}
		}
		if(flag==2){
			$scope.association = false;
			$scope.own = true;
			$scope.stocks = true;
			if($scope.equipmentBean){
				$scope.equipmentBean.SupplementStar = false;

				if(!$scope.equipmentBean.projectName){
					return ;
				}

				$scope.changeContactInfo();
			}
		}
		if(flag==3){
			$scope.association = false;
			$scope.own = true;
			$scope.stocks = false;
			if($scope.equipmentBean){
				$scope.equipmentBean.SupplementStar = true;

				if(!$scope.equipmentBean.projectName){
					return ;
				}

				$scope.changeContactInfo();
			}
		}
	};

	/* 点击删除按钮，删除设备资源 */
	$scope.openDelModal = function(){
		if(!$scope.qryEquDetail.equipmentId){
			$.messager.popup("请选择一条信息");
			return;
		}

		$.messager.confirm("提示", "是否确认删除当前数据？", function(){
			/** 删除设备资源 begin */
			equipment.del({urlPath: $scope.qryEquDetail.equipmentId}, 
				function (rec){
					$scope.selectFlag = "";
					$scope.qryEquDetail = {};
					$.messager.popup(rec.msg);
					$scope.queryEquipmentData(1);
				}, 
				function (){
					$.messager.popup("删除失败！");
				}
			);
			/** 删除设备资源 end */
		});
	};

	$scope.areaList = [];
	$scope.pList = [];
	$scope.cList = [];

	/* 设备资源添加/修改 - 全部省信息 */
	$scope.queryProvince = function(){
		/** 查询地区信息 begin */
		function aSucc(rec){
			$scope.areaList = rec;

		}
		function aErr(rec){
			$.messager.popup(rec.data.message);
		}

		regionSvc.queryRegionArea({}, aSucc, aErr);
		/** 查询地区信息 begin */
	};
	$scope.queryProvince();

	$scope.subOrgList = [];

	/* 设备资源添加/修改 - 登录人员为局级单位，且没有项目时，查询所属处级单位列表 */
	$scope.querySubOrg = function(){
		if($scope.userInfo.orgLevel!=2){/** 非局级单位 */
			return ;
		}

		if($scope.userInfo.proId){/** 有项目 */
			return ;
		}

		$scope.querySubOrgBean = {};

		$scope.querySubOrgBean.currOrgId = $scope.userInfo.orgId;
		$scope.querySubOrgBean.pageNo = 0;
		$scope.querySubOrgBean.pageSize = 99;

		/** 根据currOrgId，查询该组织下的机构 begin */
		function qSucc(rec){
			$scope.subOrgList = rec.content;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		entSvc.queryPartyInstallList($scope.querySubOrgBean, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的机构 end */
	};
	$scope.querySubOrg();

	$scope.showFlag = "";/** 错误信息提示标志 */
	$scope.equipmentBean = {};

	/* 打开 设备资源添加模态框 */
	$scope.openAddModal = function(){
		$scope.equipmentBean = {};

		$scope.equipmentBean.flagShow_ = 'add';
		$scope.equipmentBean.createUser = $scope.userInfo.perPartyId;

		if($scope.userInfo.orgLevel==3){/** 登录人员为处级单位，则查询（局级单位）上级单位id和名称 */
			$scope.equipmentBean.subsidiaryId = $scope.userInfo.orgId;
			$scope.equipmentBean.subsidiaryName = $scope.userInfo.orgName;

			/** 根据机构id，查询该机构及其上级机构详情 begin */
			function qSucc(rec){
				$scope.equipmentBean.bureauId = rec.parentOrgId;
				$scope.equipmentBean.bureauName = rec.parentOrgName;
			}
			function qErr(rec){
				$.messager.popup(rec.data.message);
			}

			entSvc.queryPartyInstallDetail({id: $scope.userInfo.orgId}, qSucc, qErr);
			/** 根据机构id，查询该机构及其上级机构详情 end */
		}
		else{/** 登录人员为非处级单位 */
			$scope.equipmentBean.bureauId = $scope.userInfo.orgId;
			$scope.equipmentBean.bureauName = $scope.userInfo.orgName;
		}

		if($scope.userInfo.proId){/** 登录人员有项目 */
			$scope.equipmentBean.projectId = $scope.userInfo.proId;
			$scope.equipmentBean.projectName = $scope.userInfo.proName;
		}

		$scope.pList = [];
		$scope.cList = [];

		$scope.equipmentBean.equipmentSourceNo = 1;/** 设备来源分类默认值 1-自有 */
		$scope.association = true;/** 设备使用情况登记 - 自有 */
		$scope.own = false;/** 设备使用情况登记 - 外租/外协 */
		$scope.stocks = true;/** 交易信息登记 - 自有/外租 */

		$scope.equipmentBean.equShowDisFlag_ = true;/** 业务状态和设备使用单位的初始化，默认不允许修改 */
	 	$scope.equipmentBean.equShowRedFlag_ = false;/** 业务状态和设备使用单位的必选项（星号）初始化，默认没有星号 */
	 	$scope.equipmentBean.equAtOrgShowDisFlag_ = true;

		$scope.equipmentBean.SupplementStar = true;/** 交易信息登记初始化，默认不允许修改；根据使用情况的修改，确定是否允许修改 */
		$scope.equipmentBean.leaseModeName1 = '1';/** 租赁方式初始化，默认为1-月租 */
		$scope.equipmentBean.settlementModeName1 = '1';/** 结算方式初始化，默认为1-转账 */

		$scope.titleMsg = "设备资源添加";
		$scope.showFlag = "";/** 错误信息提示标志 */

		$('#equipmentModal').modal({backdrop: 'static', keyboard: false});
	};

	/* 关闭 设备资源添加模态框 */
	$scope.closeAddModal = function(){
		$('#equipmentModal').modal('hide');
		$scope.showFlag = "";/** 错误信息提示标志 */
		$scope.equipmentBean = {};
	};

	/* 选择省时，改变市列表 */
	$scope.changeProvince = function(){
		if($scope.equipmentBean.onProvinceId){
			/** 根据省id，查询市 - 地区信息 begin */
			function qSucc2(rec){
				$scope.pList = rec;
				$scope.cList = [];
			}
			function qErr2(rec){
				$.messager.popup(rec.data.message);
			}

			regionSvc.queryRegionArea({regionId: $scope.equipmentBean.onProvinceId}, qSucc2, qErr2);
			/** 根据省id，查询市 - 地区信息 end */
		}
		else{
			$scope.pList = [];
			$scope.cList = [];
		}
	};

	/* 选择市时，改变区列表 */
	$scope.changeCity = function(){
		if($scope.equipmentBean.onCityId){
			/** 根据市id，查询区 - 地区信息 begin */
			function qSucc3(rec){
				setTimeout(function(){
					$scope.$apply(function(){
						$scope.cList = rec;
					});
				},50);

			}
			function qErr3(rec){
				$.messager.popup(rec.data.message);
			}

			regionSvc.queryRegionArea({regionId: $scope.equipmentBean.onCityId}, qSucc3, qErr3);
			/** 根据市id，查询区 - 地区信息 end */
		}
		else{
			$scope.cList = [];
		}
	};

	/* 变更子公司时，清空已选择的所属项目信息，并获取选择的子公司名称 */
	$scope.subOrgSelect = function(){
		$scope.equipmentBean.projectName = "";
		$scope.equipmentBean.projectId = null;
		$scope.equipmentBean.subsidiaryName = $('#selectSubsidiaryId option:selected').text();

		/** 当所属项目变更时，同步处理使用单位信息 */
		$scope.changeBusState();
	}

	/* 所属项目列表查询分页标签参数配置 */
	$scope.paginationConfProject = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 10,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [10, 20, 30, 40],
		onChange: function(currentPage){
			if($scope.queryProject.currOrgId){
				$scope.clickPros(currentPage);
				}
		}
	};

	$scope.projects = [];
	$scope.project = {};
	$scope.queryProject = {};

	/* 打开 选择所属项目模态框 */
	$scope.openProjectModel = function(){
		$scope.projects = [];
		$scope.queryProject = {};

		var currOrgId;
		if($scope.equipmentBean.subsidiaryId){
			currOrgId = $scope.equipmentBean.subsidiaryId;

			/** 放入单位信息 */
			$scope.projects = [
			                   {name: $scope.equipmentBean.bureauName, currOrgId: $scope.equipmentBean.bureauId, orgFlag: 1}, 
			                   {name: $scope.equipmentBean.subsidiaryName, currOrgId: $scope.equipmentBean.subsidiaryId, orgFlag: 2}
			                  ];
		}
		else{
			currOrgId = $scope.equipmentBean.bureauId;

			/** 放入单位信息 */
			$scope.projects = [{name: $scope.equipmentBean.bureauName, currOrgId: $scope.equipmentBean.bureauId, orgFlag: 1}];
		}

		$scope.queryProject.currOrgId = currOrgId;

		$scope.queryProject.pageNo = 0;
		$scope.queryProject.pageSize = $scope.paginationConfProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的项目 begin */
		function qSucc(rec){
			$scope.employerList = rec.content;
			$scope.paginationConfProject.totalItems = rec.totalElements;
			$('#projectModel').modal({backdrop: 'static', keyboard: false});
		}
		function qErr(){
			
		}

		proSvc.queryPartyInstallList($scope.queryProject, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
	};

	/* 点击项目，变更保存的所属项目信息 */
	$scope.clickPro = function(orgInfo){
		/** 变更保存点击的项目信息 */
		$scope.project = {};

		$scope.project.name = orgInfo.name;
		$scope.project.currOrgId = orgInfo.currOrgId;
		$scope.project.orgFlag = 3;

		/** 保存项目的所在省、市、县，负责人，联系电话和详细地址 */
		if(orgInfo.contacts){
			$scope.project.custodian = orgInfo.contacts;
		}
		if(orgInfo.contactsMobile){
			$scope.project.contactPersonPhone = orgInfo.contactsMobile;
		}
		if(orgInfo.offAddr){
			$scope.project.address = orgInfo.offAddr;
		}
		$scope.project.onProvinceId = orgInfo.atProvince;
		$scope.project.onCityId = orgInfo.atCity;
		$scope.project.onDistrictId = orgInfo.atDistrict;

		$scope.contactInfo = $scope.project;

		var employersLength = $scope.projects.length;
		if(employersLength>0 && 3==$scope.projects[employersLength - 1].orgFlag){
			$scope.projects.splice(employersLength - 1, 1);
		}
		$scope.projects.push($scope.project);
	};

	/* 根据currOrgId，查询该组织下的项目 */
	$scope.clickPros = function(currentPage){
		if(currentPage)
		{
			$scope.paginationConfProject.currentPage = currentPage;
		}

		$scope.queryProject.pageNo = $scope.paginationConfProject.currentPage - 1;
		$scope.queryProject.pageSize = $scope.paginationConfProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的项目 begin */
		function qSucc(rec){
			$scope.employerList = rec.content;
			$scope.paginationConfProject.totalItems = rec.totalElements;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		proSvc.queryPartyInstallList($scope.queryProject, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
	};

	$scope.contactInfo = {};/** 使用情况联系人信息（外租/外协） */

	/* 变更并关闭 选择所属项目模态框 */
	$scope.modifyProjectModel = function(){
		$('#projectModel').modal('hide');

		var employersLength = $scope.projects.length;
		if(employersLength<=0){
			return ;
		}

		$scope.project = $scope.projects[employersLength - 1];
		if($scope.project.orgFlag!=3){
			
			return ;
		}

		$scope.equipmentBean.projectName = $scope.project.name;
		$scope.equipmentBean.projectId = $scope.project.currOrgId;

		/** 当所属项目变更时，同步处理使用单位信息 */
		$scope.changeBusState();

		if(2==$scope.equipmentBean.equipmentSourceNo || 3==$scope.equipmentBean.equipmentSourceNo){/** 外租/外协 */
			/** 若设备来源分类为外租或外协时，同步处理所在城市、详细地址、保管人、联系电话 */
			$scope.changeContactInfo();
		}
	};

	$scope.changeContactInfo = function(){
		if(!$scope.contactInfo){
			return ;
		}
		/** 保存项目的所在省、市、县，负责人，联系电话和详细地址 */
		if($scope.contactInfo.custodian){
			$scope.equipmentBean.custodian = $scope.contactInfo.custodian;
		}
		if($scope.contactInfo.contactPersonPhone){
			$scope.equipmentBean.contactPersonPhone = $scope.contactInfo.contactPersonPhone;
		}
		if($scope.contactInfo.address){
			$scope.equipmentBean.address = $scope.contactInfo.address;
		}
		$scope.equipmentBean.onProvinceId = $scope.contactInfo.onProvinceId;
		$scope.equipmentBean.onCityId = $scope.contactInfo.onCityId;
		$scope.equipmentBean.onDistrictId = $scope.contactInfo.onDistrictId;
		$scope.changeProvince();/** 市信息初始化 */
		$scope.changeCity();/** 区信息初始化 */
	};

	/* 取消并关闭 选择所属项目模态框 */
	$scope.closeProjectModel = function(){
		$('#projectModel').modal('hide');
	} 

	/* 检查设备编号是否已存在 */
	$scope.checkEquNoToExist = function(){
		if(!$scope.equipmentBean.equNo){
			return ;
		}

		var equNo = "";
		if($scope.equipmentBean.subsidiaryId){
			for(var i=0;i<$scope.subOrgList.length;i++){
				if($scope.equipmentBean.subsidiaryId==$scope.subOrgList[i].currOrgId){
					$scope.equipmentBean.subsidiaryCode = $scope.subOrgList[i].code;
				}
			}
			equNo = "" + $scope.equipmentBean.subsidiaryCode + "-" + $scope.equipmentBean.equNo;
		}
		else{
			equNo = "" + $scope.userInfo.orgCode + "-" + $scope.equipmentBean.equNo;
		}

		if($scope.equipmentBean.equNo.length<=0){
			return ;
		}

		if(!$scope.equipmentBean.flagShow_){
			return
		}

		/** 根据equNo，查询设备编号是否已存在 begin */
		function qSucc(rec){
			$scope.equNoInfo = rec.msg;

			if($scope.equipmentBean.flagShow_=='add'){
				if($scope.equNoInfo && $scope.equNoInfo.length>0){
					$scope.equipmentBean.equNo = '';
					$.messager.popup("设备编号不可以重复！");
					return ;
				}
			}
			else if($scope.equipmentBean.flagShow_=='upd'){
				if($scope.equNoInfo && $scope.equNoInfo.length>0 && $scope.equipmentBean.equipmentId!=rec.msg.equipmentId){
					$scope.equipmentBean.equNo = '';
					$.messager.popup("设备编号不可以重复！");
					return ;
				}
			}
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		equipment.unifydo({Action: 'GetByEquNo', equNo: equNo}, qSucc, qErr);
		/** 根据equNo，查询设备编号是否已存在 end */
	};

	/* 选择设备名称 - 查询设备分类信息 */
	$scope.queryCategoryList = function(){
		/** 查询设备分类信息 begin */
		function qSucc(rec){
			$scope.categoryList = rec.content;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		category.unifydo({Action: 'EquCategory', pageNo: 0, pageSize: 99}, qSucc, qErr);
		/** 查询设备分类信息 end */
	};
	$scope.queryCategoryList();

	/* 设备名称列表查询分页标签参数配置 */
	$scope.paginationConfEquClassify = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 10,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [10, 20, 30, 40],
		onChange: function(currentPage){
			if($scope.queryEquName.Action){
				$scope.queryEquNameData(currentPage);
				}
		}
	};

	$scope.queryEquName = {};

	/* 打开 选择设备名称及设备参数模态框 */
	$scope.openEquNameModel = function(){
		$scope.selectTableIndex = "";

		$scope.queryEquName = {};

		$scope.queryEquName.pageNo = 0;
		$scope.queryEquName.pageSize = $scope.paginationConfEquClassify.itemsPerPage;
		$scope.queryEquName.relationType = 1;
		$scope.queryEquName.Action = "All";

		/** 根据设备分类、设备名称，查询设备名称信息 begin */
		function qSucc(rec){
			$scope.equNameList = rec.content;
			$scope.paginationConfEquClassify.totalItems = rec.totalElements;
			$('#equName__').modal({backdrop: 'static', keyboard: false});
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		category.unifydo($scope.queryEquName, qSucc, qErr);
		/** 根据设备分类、设备名称，查询设备名称信息 end */
	};

	/* 查询设备名称信息 */
	$scope.queryEquNameData = function(currentPage){
		if(currentPage)
		{
			$scope.paginationConfEquClassify.currentPage = currentPage;
		}

		$scope.selectTableIndex = "";

		$scope.queryEquName.pageNo = $scope.paginationConfEquClassify.currentPage - 1;
		$scope.queryEquName.pageSize = $scope.paginationConfEquClassify.itemsPerPage;

		/** 根据设备分类、设备名称，查询设备名称信息 begin */
		function qSucc(rec){
			$scope.equNameList = rec.content;
			$scope.paginationConfEquClassify.totalItems = rec.totalElements;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		category.unifydo($scope.queryEquName, qSucc, qErr);
		/** 根据设备分类、设备名称，查询设备名称信息 end */
	};

	/* 关闭 选择设备名称及设备参数模态框 */
	$scope.closeEquNameModel = function(){
		$('#equName__').modal('hide');
	};

	/* 设备名称列表-选择单选框 */
	$scope.selectTableIndex = "";	/** 记录第几个单选框标记 */
	$scope.equNameParam = {};

	$scope.equNameSelect = function(equNameInfo, index_){
		$scope.selectTableIndex = index_;
		$scope.equNameParam.categoryId = equNameInfo.categoryId;
		$scope.equNameParam.equNameId = equNameInfo.equName.equNameId;
		$scope.equNameParam.equName = equNameInfo.equName.equipmentName;
	};

	/* 双击设备名称列表中的一条记录或点击确定按钮，选择设备参数 */
	$scope.openEquNameAddModal = function(equNameInfo, index_){
		if(index_){
			$scope.selectTableIndex = index_;
		}

		if(equNameInfo){
			$scope.equNameParam.categoryId = equNameInfo.categoryId;
			$scope.equNameParam.equNameId = equNameInfo.equName.equNameId;
			$scope.equNameParam.equName = equNameInfo.equName.equipmentName;
		}

		if(!$scope.equNameParam.equNameId){
			$.messager.popup("请选择一条信息");
			return;
		}

		/** 查询生产厂家信息 begin */
		function qSucc(rec){
			$scope.manufacturerList = rec.content;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

//		busEquParameterSvc.unifydo({action: 'GET_BUS_EQU_NAME_PARAMETER', equNameId: $scope.equNameParam.equNameId, type: 2, status: 1, pageNo: 0, pageSize: 99}, qSucc, qErr);
		busEquParameterSvc.unifydo({type: 2, status: 1, pageNo: 0, pageSize: 99}, qSucc, qErr);
		/** 查询生产厂家信 end */

		/** 查询品牌信息 begin */
		function qSucc2(rec){
			$scope.brandList = rec.content;
		}
		function qErr2(rec){
			$.messager.popup(rec.data.message);
		}

//		busEquParameterSvc.unifydo({action: 'GET_BUS_EQU_NAME_PARAMETER', equNameId: $scope.equNameParam.equNameId, type: 1, status: 1, pageNo: 0, pageSize: 99}, qSucc2, qErr2);
		busEquParameterSvc.unifydo({type: 1, status: 1, pageNo: 0, pageSize: 99}, qSucc2, qErr2);
		/** 查询品牌信息 end */

		/** 查询型号信息 begin */
		function qSucc3(rec){
			$scope.modelsList = rec.content;
		}
		function qErr3(rec){
			$.messager.popup(rec.data.message);
		}

//		busEquParameterSvc.unifydo({action: 'GET_BUS_EQU_NAME_PARAMETER', equNameId: $scope.equNameParam.equNameId, type: 3, status: 1, pageNo: 0, pageSize: 99}, qSucc3, qErr3);
		busEquParameterSvc.unifydo({type: 3, status: 1, pageNo: 0, pageSize: 99}, qSucc3, qErr3);
		/** 查询型号信息 end */

		/** 查询规格信息 begin */
		function qSucc4(rec){
			$scope.specificationsList = rec.content;
		}
		function qErr4(rec){
			$.messager.popup(rec.data.message);
		}

//		busEquParameterSvc.unifydo({action: 'GET_BUS_EQU_NAME_PARAMETER', equNameId: $scope.equNameParam.equNameId, type: 4, status: 1, pageNo: 0, pageSize: 99}, qSucc4, qErr4);
		busEquParameterSvc.unifydo({type: 4, status: 1, pageNo: 0, pageSize: 99}, qSucc4, qErr4);
		/** 查询规格信息 end */

		$scope.modelsShow = true;
		$scope.specificationsShow = true;

		$('#categoryParameter').modal({backdrop: 'static', keyboard: false});
	};

	/** 手动添加 */
	$scope.addManual = function(selectVal){
		if(selectVal=="models"){/** 型号 */
			$scope.modelsShow = false;
			$scope.equNameParam.models = "";
			$scope.equNameParam.modelsId = "";
		}
		else if(selectVal=="specifications"){/** 规格 */
			$scope.specificationsShow = false;
			$scope.equNameParam.specifications = "";
			$scope.equNameParam.specificationsId = "";
		}
	};

	/** 重选 */
	$scope.addSelect = function(selectVal){
		if(selectVal=="models"){/** 型号 */
			$scope.modelsShow = true;
			$scope.equNameParam.models = "";
			$scope.equNameParam.modelsId = "";
		}
		else if(selectVal=="specifications"){/** 规格 */
			$scope.specificationsShow = true;
			$scope.equNameParam.specifications = "";
			$scope.equNameParam.specificationsId = "";
		}
	};

	/* 保存选中的设备名称及参数信息 */
	$scope.addEquNameInfo = function(){
		$scope.equipmentBean.categoryId = $scope.equNameParam.categoryId;
		$scope.equipmentBean.equNameId = $scope.equNameParam.equNameId;
		$scope.equipmentBean.equName = $scope.equNameParam.equName;

		if(!$scope.equNameParam.manufacturerId){
			$.messager.popup("请选择生产厂家");
			return;
		}

		if(!$scope.equNameParam.brandNo){
			$.messager.popup("请选择品牌");
			return;
		}

		if(!$scope.equNameParam.models && !$scope.equNameParam.modelsId){
			$.messager.popup("请选择型号");
			return;
		}

		if(!$scope.equNameParam.specifications && !$scope.equNameParam.specificationsId){
			$.messager.popup("请选择规格");
			return;
		}

		/** 生产厂家 */
		$scope.equipmentBean.manufacturerName = $('#manufacturerId option:selected').text();

		$scope.equipmentBean.manufacturerNameCopy = $scope.equipmentBean.manufacturerName;
		if($scope.equipmentBean.manufacturerName && $scope.equipmentBean.manufacturerName.length > 12){
			$scope.equipmentBean.manufacturerNameCopy = $scope.equipmentBean.manufacturerNameCopy.substring(0,12) + "...";
		}

		$scope.equipmentBean.manufacturerId = $scope.equNameParam.manufacturerId;

		/** 品牌 */
		$scope.equipmentBean.brandName = $('#brandNo option:selected').text();
		$scope.equipmentBean.brandNo = $scope.equNameParam.brandNo;

		/** 型号 */
		if($scope.equNameParam.modelsId){
			$scope.equipmentBean.models = $('#modelsId option:selected').text();
			$scope.equipmentBean.modelsId = $scope.equNameParam.modelsId;
		}
		else{
			$scope.equipmentBean.modelsId = "";
			$scope.equipmentBean.models = $scope.equNameParam.models;
		}

		/** 规格 */
		if($scope.equNameParam.specificationsId){
			$scope.equipmentBean.specifications = $('#specificationsId option:selected').text();
			$scope.equipmentBean.specificationsId = $scope.equNameParam.specificationsId;
			}
		else{
			$scope.equipmentBean.specificationsId = "";
			$scope.equipmentBean.specifications = $scope.equNameParam.specifications;
		}

		$('#categoryParameter').modal('hide');
		$('#equName__').modal('hide');
	};

	/* 关闭 选择设备参数模态框 */
	$scope.closeEquNameAddModal = function(){
		$('#categoryParameter').modal('hide');
	};

	/* 变更设备状态 */
	$scope.changeEquState = function(){
		if(2==$scope.equipmentBean.equState1){/** 使用中 */
			$scope.equipmentBean.equShowDisFlag_ = false;
		 	$scope.equipmentBean.equShowRedFlag_ = true;
		}
		else{/** 闲置/已出售/已报废 */
			$scope.equipmentBean.equShowDisFlag_ = true;
		 	$scope.equipmentBean.equShowRedFlag_ = false;
		}

		$scope.equipmentBean.sellPrice1 = "";
		$scope.equipmentBean.scrapPrice1 = "";
		$scope.equipmentBean.busState1 = "";

		$scope.changeBusState();
	};

	/* 变更业务状态 */
	$scope.changeBusState = function(){
		$scope.ownContactInfo = {};

		if(1==$scope.equipmentBean.busState1){/** 自用 */
			if(!$scope.equipmentBean.projectName){
				$.messager.popup("请选择项目名称");
				return ;
			}

			$scope.equipmentBean.equAtOrgShowDisFlag_ = true;
			$scope.equipmentBean.SupplementStar = true;

			$scope.equipmentBean.equAtOrgId1 = $scope.equipmentBean.bureauId;
			$scope.equipmentBean.equAtOrgName1 = $scope.equipmentBean.bureauName;
			if($scope.equipmentBean.subsidiaryId){
				$scope.equipmentBean.equAtSubOrgId1 = $scope.equipmentBean.subsidiaryId;
				}
			else{
				$scope.equipmentBean.equAtSubOrgId1 = "";
			}
			$scope.equipmentBean.equAtProjectId1 = $scope.equipmentBean.projectId;
			$scope.equipmentBean.equAtName1 = $scope.equipmentBean.projectName;

			$scope.changeContactInfo();
		}
		else if(5==$scope.equipmentBean.busState1){/** 外租 */
			$scope.equipmentBean.equAtOrgShowDisFlag_ = false;
			$scope.equipmentBean.SupplementStar = false;

			$scope.equipmentBean.equAtOrgId1 = "";
			$scope.equipmentBean.equAtOrgName1 = "";
			$scope.equipmentBean.equAtSubOrgId1 = "";
			$scope.equipmentBean.equAtProjectId1 = "";
			$scope.equipmentBean.equAtName1 = "";

			$scope.equipmentBean.address = "";
			$scope.equipmentBean.custodian = "";
			$scope.equipmentBean.contactPersonPhone = "";
		 	$scope.equipmentBean.onProvinceId = "";
		 	$scope.equipmentBean.onCityId = "";
		 	$scope.equipmentBean.onDistrictId = "";
			$scope.pList = [];
			$scope.cList = [];
		}
		else{/** 调拨/局内租/外局租 */
			$scope.equipmentBean.equAtOrgShowDisFlag_ = true;
			if(2==$scope.equipmentBean.equipmentSourceNo){
				$scope.equipmentBean.SupplementStar = false;
			}
			else{
				$scope.equipmentBean.SupplementStar = true;
			}

			$scope.equipmentBean.equAtOrgId1 = "";
			$scope.equipmentBean.equAtOrgName1 = "";
			$scope.equipmentBean.equAtSubOrgId1 = "";
			$scope.equipmentBean.equAtProjectId1 = "";
			$scope.equipmentBean.equAtName1 = "";

			$scope.equipmentBean.address = "";
			$scope.equipmentBean.custodian = "";
			$scope.equipmentBean.contactPersonPhone = "";
		 	$scope.equipmentBean.onProvinceId = "";
		 	$scope.equipmentBean.onCityId = "";
		 	$scope.equipmentBean.onDistrictId = "";
			$scope.pList = [];
			$scope.cList = [];
		}
	};

	/* 资源管理列表查询分页标签参数配置 */
	$scope.paginationConfEquAtProject = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 10,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [10, 20, 30, 40],
		onChange: function(currentPage){
			if($scope.queryEquAtProject.currOrgId){
				$scope.clickEquAtProProjects(currentPage);
				}
		}
	};

	$scope.equAtProjects = [];
	$scope.equAtProject = {};
	$scope.queryEquAtProject = {};
	$scope.equAtProCheck = true;	//	项目选项 显示标志
	$scope.queryEquAtProject.check = false;	//	项目选项值
	$scope.checkTrEquAtOrg = true;	//	列名称 - 单位名称 显示标志
	$scope.checkTrEquAtPro = false;	//	列名称 - 项目名称 显示标志

	/* 打开 选择使用单位/项目模态框 */
	$scope.openEquAtProjectModel = function(){
		if(!$scope.equipmentBean.busState1){
			$.messager.popup("请选择业务状态");
			return ;
		}

		$scope.equAtProjects = [];
		$scope.queryEquAtProject = {};

		$scope.queryEquAtProject.pageNo = 0;
		$scope.queryEquAtProject.pageSize = $scope.paginationConfEquAtProject.itemsPerPage;

		var busState = $scope.equipmentBean.busState1;/** 业务状态 */
		switch(busState){
			case "2":/** 调拨 */
				if($scope.equipmentBean.subsidiaryId){
					$scope.queryEquAtProject.currOrgId = $scope.equipmentBean.subsidiaryId;
					$scope.queryEquAtProject.currOrgName = $scope.equipmentBean.subsidiaryName;

					/** 放入单位信息 */
					$scope.equAtProjects = [
					                   {name: $scope.equipmentBean.bureauName, currOrgId: $scope.equipmentBean.bureauId, orgFlag: 1, notClick: true}, 
					                   {name: $scope.equipmentBean.subsidiaryName, currOrgId: $scope.equipmentBean.subsidiaryId, orgFlag: 2, notClick: true}
					                  ];
				}
				else{
					$scope.queryEquAtProject.currOrgId = $scope.equipmentBean.bureauId;
					$scope.queryEquAtProject.currOrgName = $scope.equipmentBean.bureauName;

					/** 放入单位信息 */
					$scope.equAtProjects = [{name: $scope.equipmentBean.bureauName, currOrgId: $scope.equipmentBean.bureauId, orgFlag: 1, notClick: true}];
				}

				$scope.queryEquAtProject.nonProId = $scope.equipmentBean.projectId;

				/** 根据currOrgId，查询该组织下的项目 begin */
				function qSucc(rec){
					if(rec.content.length<=0){
						$.messager.popup("单位" + $scope.queryEquAtProject.currOrgName + "下，无其他项目可以调拨");
					}
					else{
						$scope.equAtProCheck = false;	//	项目选项 显示标志
						$scope.queryEquAtProject.check = true;	//	项目选项值
						$scope.checkTrEquAtOrg = false;	//	列名称 - 单位名称 显示标志
						$scope.checkTrEquAtPro = true;	//	列名称 - 项目名称 显示标志

						$scope.employerList = rec.content;
						$scope.paginationConfEquAtProject.totalItems = rec.totalElements;
						$('#equAtProjectModel').modal({backdrop: 'static', keyboard: false});
					}
				}
				function qErr(rec){
					$.messager.popup(rec.data.message);
				}

				proSvc.queryPartyInstallList($scope.queryEquAtProject, qSucc, qErr);
				/** 根据currOrgId，查询该组织下的项目 end */

				break;
			case "3":/** 局内租 */
				$scope.queryEquAtProject.currOrgId = $scope.equipmentBean.bureauId;
				$scope.queryEquAtProject.currOrgName = $scope.equipmentBean.bureauName;

				/** 放入单位信息 */
				$scope.equAtProjects = [{name: $scope.equipmentBean.bureauName, currOrgId: $scope.equipmentBean.bureauId, orgFlag: 1}];

				$scope.queryEquAtProject.nonProId = $scope.equipmentBean.projectId;

				/** 根据currOrgId，查询该组织下的机构 begin */
				function qSucc2(rec){
					if(rec.content.length<=0){
						/** 根据currOrgId，查询该组织下的项目 begin */
						function qSucc3(rec){
							if(rec.content.length<=0){
								$.messager.popup("单位" + $scope.queryEquAtProject.currOrgName + "下，无其他项目可以局内租");
							}
							else{
								$scope.equAtProCheck = false;	//	项目选项 显示标志
								$scope.queryEquAtProject.check = true;	//	项目选项值
								$scope.checkTrEquAtOrg = false;	//	列名称 - 单位名称 显示标志
								$scope.checkTrEquAtPro = true;	//	列名称 - 项目名称 显示标志

								$scope.employerList = rec.content;
								$scope.paginationConfEquAtProject.totalItems = rec.totalElements;
								$('#equAtProjectModel').modal({backdrop: 'static', keyboard: false});
							}
						}
						function qErr3(rec){
							$.messager.popup(rec.data.message);
						}

						proSvc.queryPartyInstallList($scope.queryEquAtProject, qSucc3, qErr3);
						/** 根据currOrgId，查询该组织下的项目 end */
					}
					else{
						$scope.equAtProCheck = true;	//	项目选项 显示标志
						$scope.queryEquAtProject.check = false;	//	项目选项值
						$scope.checkTrEquAtOrg = true;	//	列名称 - 单位名称 显示标志
						$scope.checkTrEquAtPro = false;	//	列名称 - 项目名称 显示标志

						$scope.employerList = rec.content;
						$scope.paginationConfEquAtProject.totalItems = rec.totalElements;
						$('#equAtProjectModel').modal({backdrop: 'static', keyboard: false});
					}
				}
				function qErr2(rec){
					$.messager.popup(rec.data.message);
				}
				entSvc.queryPartyInstallList($scope.queryEquAtProject, qSucc2, qErr2);
				/** 根据currOrgId，查询该组织下的机构 end */

				break;
			case "4":/** 外局租 */
				$scope.queryEquAtProject.currOrgId = 1;
				$scope.queryEquAtProject.currOrgName = "总公司";

				/** 放入单位信息 */
				$scope.equAtProjects = [{name: $scope.queryEquAtProject.currOrgName, currOrgId: $scope.queryEquAtProject.currOrgId, orgFlag: 9}];

				$scope.queryEquAtProject.nonCurrOrgId = $scope.equipmentBean.bureauId;
				$scope.queryEquAtProject.nonProId = $scope.equipmentBean.projectId;

				/** 根据currOrgId，查询该组织下的机构 begin */
				function qSucc4(rec){
					if(rec.content.length<=0){
						/** 根据currOrgId，查询该组织下的项目 begin */
						function qSucc5(rec){
							if(rec.content.length<=0){
								$.messager.popup("单位" + $scope.queryEquAtProject.currOrgName + "以外，无其他项目可以外局租");
							}
							else{
								$scope.equAtProCheck = false;	//	项目选项 显示标志
								$scope.queryEquAtProject.check = true;	//	项目选项值
								$scope.checkTrEquAtOrg = false;	//	列名称 - 单位名称 显示标志
								$scope.checkTrEquAtPro = true;	//	列名称 - 项目名称 显示标志

								$scope.employerList = rec.content;
								$scope.paginationConfEquAtProject.totalItems = rec.totalElements;
								$('#equAtProjectModel').modal({backdrop: 'static', keyboard: false});
							}
						}
						function qErr5(rec){
							$.messager.popup(rec.data.message);
						}

						proSvc.queryPartyInstallList($scope.queryEquAtProject, qSucc5, qErr5);
						/** 根据currOrgId，查询该组织下的项目 end */
					}
					else{
						$scope.equAtProCheck = true;	//	项目选项 显示标志
						$scope.queryEquAtProject.check = false;	//	项目选项值
						$scope.checkTrEquAtOrg = true;	//	列名称 - 单位名称 显示标志
						$scope.checkTrEquAtPro = false;	//	列名称 - 项目名称 显示标志

						$scope.employerList = rec.content;
						$scope.paginationConfEquAtProject.totalItems = rec.totalElements;
						$('#equAtProjectModel').modal({backdrop: 'static', keyboard: false});
					}
				}
				function qErr4(rec){
					$.messager.popup(rec.data.message);
				}
				entSvc.queryPartyInstallList($scope.queryEquAtProject, qSucc4, qErr4);
				/** 根据currOrgId，查询该组织下的机构 end */

				break;
			default:
				break;
		}
	};

	/* 点击查询下级单位，且保存点击的机构信息 */
	$scope.clickEquAtOrg = function(currentPage, orgInfo){
		if(currentPage)
		{
			$scope.paginationConfEquAtProject.currentPage = currentPage;
		}

		var orgLv;
		if(1==orgInfo.orgLevel){
			orgLv = 9;
		}
		else if(2==orgInfo.orgLevel){
			orgLv = 1;
		}
		else if(3==orgInfo.orgLevel){
			orgLv = 2;
		}

		/** 保存点击的机构信息 */
		$scope.equAtProject = {};

		$scope.equAtProject.name = orgInfo.name;
		$scope.equAtProject.currOrgId = orgInfo.currOrgId;
		$scope.equAtProject.orgFlag = orgLv;

		$scope.equAtProjects.push($scope.equAtProject);

		$scope.queryEquAtProject.currOrgId = orgInfo.currOrgId;

		if(2==orgLv){/** 处级单位 */
			$scope.checkTrEquAtPro = true;
			$scope.checkTrEquAtOrg = false;
			$scope.queryEquAtProject.check = true;
			$scope.equAtProCheck = false;

			$scope.qryEquAtProProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkTrEquAtPro = false;
			$scope.checkTrEquAtOrg = true;
			$scope.queryEquAtProject.check = false;
			$scope.equAtProCheck = true;

			$scope.qryEquAtOrg();
		}
	};

	/* 点击项目，变更保存的项目信息 */
	$scope.clickEquAtProProject = function(orgInfo){
		/** 变更保存点击的项目信息 */
		$scope.equAtProject = {};

		$scope.equAtProject.name = orgInfo.name;
		$scope.equAtProject.currOrgId = orgInfo.currOrgId;
		$scope.equAtProject.orgFlag = 3;
		/** 保存项目的所在省、市、县，负责人，联系电话和详细地址 */
		if(orgInfo.contacts){
			$scope.equAtProject.custodian = orgInfo.contacts;
		}
		if(orgInfo.contactsMobile){
			$scope.equAtProject.contactPersonPhone = orgInfo.contactsMobile;
		}
		if(orgInfo.offAddr){
			$scope.equAtProject.address = orgInfo.offAddr;
		}
		$scope.equAtProject.onProvinceId = orgInfo.atProvince;
		$scope.equAtProject.onCityId = orgInfo.atCity;
		$scope.equAtProject.onDistrictId = orgInfo.atDistrict;

		$scope.ownContactInfo = $scope.equAtProject;

		var employersLength = $scope.equAtProjects.length;
		if(employersLength>0 && 3==$scope.equAtProjects[employersLength - 1].orgFlag){
			$scope.equAtProjects.splice(employersLength - 1, 1);
		}
		$scope.equAtProjects.push($scope.equAtProject);
	};

	/* 点击当前位置的单位/项目，变更当前位置、单位/项目列表 */
	$scope.clickEquAtOrgs = function(currentPage, orgInfo, employersIndex){
		if(currentPage)
		{
			$scope.paginationConfEquAtProject.currentPage = currentPage;
		}

		if(orgInfo.notClick){
			return ;
		}

		/** 变更当前位置 */
		var employersLength = $scope.equAtProjects.length;
		if(employersLength<=0){
			return ;
		}

		$scope.equAtProjects.splice(employersIndex + 1, employersLength - employersIndex - 1);

		/** 保存点击的机构信息 */
		$scope.queryEquAtProject.currOrgId = orgInfo.currOrgId;

		var orgLv = $scope.equAtProjects[employersIndex].orgFlag;
		if(3==orgLv){/** 项目 */
			return ;
		}
		else if(2==orgLv){/** 处级单位 */
			$scope.checkTrEquAtPro = true;
			$scope.checkTrEquAtOrg = false;
			$scope.queryEquAtProject.check = true;
			$scope.equAtProCheck = false;

			$scope.qryEquAtProProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkTrEquAtPro = false;
			$scope.checkTrEquAtOrg = true;
			$scope.queryEquAtProject.check = false;
			$scope.equAtProCheck = true;

			$scope.qryEquAtOrg();
		}
	};

	/* 勾选项目，根据当前位置的最下级单位id，查询单位/项目列表 */
	$scope.clickEquAtProProjects = function(currentPage) {
		if(currentPage)
		{
			$scope.paginationConfEquAtProject.currentPage = currentPage;
		}

		var employersLength = $scope.equAtProjects.length;
		if(employersLength<=0){
			return ;
		}

		if($scope.equAtProjects[employersLength - 1].orgFlag==3){
			return ;
		}

		$scope.queryEquAtProject.currOrgId = $scope.equAtProjects[employersLength - 1].currOrgId;

		if($scope.queryEquAtProject.check){
			$scope.checkTrEquAtPro = true;
			$scope.checkTrEquAtOrg = false;

			$scope.qryEquAtProProject();
		}
		else{
			$scope.checkTrEquAtPro = false;
			$scope.checkTrEquAtOrg = true;

			$scope.qryEquAtOrg();
		}
	};

	/* 根据currOrgId，查询该组织下的机构 */
	$scope.qryEquAtOrg = function(){
		$scope.queryEquAtProject.pageNo = $scope.paginationConfEquAtProject.currentPage - 1;
		$scope.queryEquAtProject.pageSize = $scope.paginationConfEquAtProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的机构 begin */
		function qSucc(rec){
			$scope.employerList = rec.content;
			$scope.paginationConfEquAtProject.totalItems = rec.totalElements;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		entSvc.queryPartyInstallList($scope.queryEquAtProject, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的机构 end */
	};

	/* 根据currOrgId，查询该组织下的项目 */
	$scope.qryEquAtProProject = function(){
		$scope.queryEquAtProject.pageNo = $scope.paginationConfEquAtProject.currentPage - 1;
		$scope.queryEquAtProject.pageSize = $scope.paginationConfEquAtProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的项目 begin */
		function qSucc(rec){
			$scope.employerList = rec.content;
			$scope.paginationConfEquAtProject.totalItems = rec.totalElements;
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		proSvc.queryPartyInstallList($scope.queryEquAtProject, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
	};

	$scope.ownContactInfo = {};/** 使用情况联系人信息（自有） */

	/* 变更并关闭 选择单位/项目模态框 */
	$scope.modifyEquAtProjectModel = function(){
		var employersLength = $scope.equAtProjects.length;
		if(employersLength<=0){
			return ;
		}

		if($scope.equAtProjects[employersLength - 1].orgFlag!=3){
			$.messager.popup("请选择使用单位的项目");
			return ;
		}

		for(var i=0;i<employersLength;i++){
			var equAtOrgInfo = $scope.equAtProjects[i];
			if(equAtOrgInfo.orgFlag==1){
				$scope.equipmentBean.equAtOrgId1 = equAtOrgInfo.currOrgId;
				$scope.equipmentBean.equAtOrgName1 = equAtOrgInfo.name;
			}
			else if(equAtOrgInfo.orgFlag==2){
				$scope.equipmentBean.equAtSubOrgId1 = equAtOrgInfo.currOrgId;
			}
			else if(equAtOrgInfo.orgFlag==3){
				$scope.equipmentBean.equAtProjectId1 = equAtOrgInfo.currOrgId;
				$scope.equipmentBean.equAtName1 = equAtOrgInfo.name;
				/** 保存项目的所在省、市、县，负责人，联系电话和详细地址 */
				if($scope.equAtProject.custodian){
					$scope.equipmentBean.custodian = $scope.equAtProject.custodian;
				}
				if($scope.equAtProject.contactPersonPhone){
					$scope.equipmentBean.contactPersonPhone = $scope.equAtProject.contactPersonPhone;
				}
				if($scope.equAtProject.address){
					$scope.equipmentBean.address = $scope.equAtProject.address;
				}
				$scope.equipmentBean.onProvinceId = $scope.equAtProject.onProvinceId;
				$scope.equipmentBean.onCityId = $scope.equAtProject.onCityId;
				$scope.equipmentBean.onDistrictId = $scope.equAtProject.onDistrictId;
				$scope.changeProvince();/** 市信息初始化 */
				$scope.changeCity();/** 区信息初始化 */
			}
		}

		$('#equAtProjectModel').modal('hide');
	};

	$scope.changeOwnContactInfo = function(){
		if(!$scope.ownContactInfo){
			return ;
		}
		/** 保存项目的所在省、市、县，负责人，联系电话和详细地址 */
		if($scope.ownContactInfo.custodian){
			$scope.equipmentBean.custodian = $scope.ownContactInfo.custodian;
		}
		if($scope.ownContactInfo.contactPersonPhone){
			$scope.equipmentBean.contactPersonPhone = $scope.ownContactInfo.contactPersonPhone;
		}
		if($scope.ownContactInfo.address){
			$scope.equipmentBean.address = $scope.ownContactInfo.address;
		}
		$scope.equipmentBean.onProvinceId = $scope.ownContactInfo.onProvinceId;
		$scope.equipmentBean.onCityId = $scope.ownContactInfo.onCityId;
		$scope.equipmentBean.onDistrictId = $scope.ownContactInfo.onDistrictId;
		$scope.changeProvince();/** 市信息初始化 */
		$scope.changeCity();/** 区信息初始化 */
	};

	/* 取消并关闭 选择单位/项目模态框 */
	$scope.closeEquAtProjectModel = function(){
		$('#equAtProjectModel').modal('hide');
	};

	/* 设备资源添加 */
	$scope.addEqu = function(setForm, flag){
		$scope.showFlag = "";

		/** 验证输入的金额格式 */
		var amountReg = /^[0-9.]{0,18}$/;

		if(!setForm.$valid){
			if(!setForm.projectName.$valid){
				$scope.showFlag = 'projectName';
				$.messager.popup("请选择项目");
				return;
			}

			if(!setForm.equNo.$valid){
				$scope.showFlag = 'equNo';
				$.messager.popup("请输入设备编号");
				return;
			}

			if(!setForm.equName.$valid){
				$scope.showFlag = 'equName';
				$.messager.popup("请选择设备名称");
				return;
			}

			/** 若设备来源分类为自有时，则控制设备状态为必输 */
			if(1==$scope.equipmentBean.equipmentSourceNo){
				if(!setForm.equState1.$valid){
					$scope.showFlag = 'equState1';
					$.messager.popup("请选择设备状态");
					return;
				}

				if(2==$scope.equipmentBean.equState1){/** 若设备状态为使用中时，则控制业务状态和设备使用单位为必输 */
					if(!setForm.busState1.$valid){
						$scope.showFlag = 'busState1';
						$.messager.popup("请选择业务状态");
						return;
					}
					if(!setForm.equAtName1.$valid){
						$scope.showFlag = 'equAtName1';
						$.messager.popup("设备使用单位不能为空，请添加");
						return;
					}
				}
				else if(3==$scope.equipmentBean.equState1){/** 若设备状态为已出售时，则控制出售价格为必输 */
					if(!setForm.sellPrice1.$valid){
						$scope.showFlag = 'sellPrice1';
						$.messager.popup("请输入出售价格");
						return;
					}

					if($scope.equipmentBean.sellPrice1 && !amountReg.test($scope.equipmentBean.sellPrice1)){
						$scope.showFlag = 'sellPrice1Pattern';
						$.messager.popup("请输入正确的出售价格");
						return ;
					}
				}
				else if(4==$scope.equipmentBean.equState1){/** 若设备状态为已报废时，则控制报废残值为必输 */
					if(!setForm.scrapPrice1.$valid){
						$scope.showFlag = 'scrapPrice1';
						$.messager.popup("请输入报废残值");
						return;
					}

					if($scope.equipmentBean.scrapPrice1 && !amountReg.test($scope.equipmentBean.scrapPrice1)){
						$scope.showFlag = 'sellPrice1Pattern';
						$.messager.popup("请输入正确的报废残值");
						return ;
					}
				}

				if(!setForm.onProvinceId1.$valid){
					$scope.showFlag = 'onProvinceId1';
					$.messager.popup("请选择所在省份");
					return;
				}

				if(!setForm.onCityId1.$valid){
					$scope.showFlag = 'onCityId1';
					$.messager.popup("请选择所在城市");
					return;
				}

				if(!setForm.onDistrictId1.$valid){
					$scope.showFlag = 'onDistrictId1';
					$.messager.popup("请选择所在区县");
					return;
				}

				if(!setForm.contactPersonPhone1.$valid){
					$scope.showFlag = 'contactPersonPhone1';
					$.messager.popup("请输入联系电话");
					return;
				}

				if(5==$scope.equipmentBean.busState1 && $scope.equipmentBean.leasePrice1 && !amountReg.test($scope.equipmentBean.leasePrice1)){
					$scope.showFlag = 'leasePrice1Pattern';
					$.messager.popup("请输入正确的租赁单价");
					return ;
				}
			}
			else{
				if(!setForm.onProvinceId2.$valid){
					$scope.showFlag = 'onProvinceId2';
					$.messager.popup("请选择所在省份");
					return;
				}

				if(!setForm.onCityId2.$valid){
					$scope.showFlag = 'onCityId2';
					$.messager.popup("请选择所在城市");
					return;
				}

				if(!setForm.onDistrictId2.$valid){
					$scope.showFlag = 'onDistrictId2';
					$.messager.popup("请选择所在区县");
					return;
				}

				if(!setForm.contactPersonPhone2.$valid){
					$scope.showFlag = 'contactPersonPhone2';
					$.messager.popup("请输入联系电话");
					return;
				}

				if(2==$scope.equipmentBean.equipmentSourceNo && $scope.equipmentBean.leasePrice1 && !amountReg.test($scope.equipmentBean.leasePrice1)){
					$scope.showFlag = 'leasePrice1Pattern';
					$.messager.popup("请输入正确的租赁单价");
					return ;
				}
			}
		}

		/** 验证输入的联系电话格式 */
		var phoneReg = /^[0-9\-]{7,}$/;
		if($scope.equipmentBean.contactPersonPhone && !phoneReg.test($scope.equipmentBean.contactPersonPhone)){
			$scope.showFlag = 'contactPersonPhonePattern';
			$.messager.popup("请输入正确的联系电话");
			return ;
		}

		if($scope.equipmentBean.equipmentCost && !amountReg.test($scope.equipmentBean.equipmentCost)){
			$scope.showFlag = 'equipmentCostPattern';
			$.messager.popup("请输入正确的设备原值");
			return ;
		}

		var amountReg2 = /^[0-9.]{0,15}$/;
		if($scope.equipmentBean.power && !amountReg2.test($scope.equipmentBean.power)){
			$scope.showFlag = 'powerPattern';
			$.messager.popup("请输入正确的功率");
			return ;
		}

		/** 转换整型、浮点型 */
		$scope.equipmentBean.bureauId = parseInt($scope.equipmentBean.bureauId);

		if($scope.equipmentBean.subsidiaryId){
			$scope.equipmentBean.subsidiaryId = parseInt($scope.equipmentBean.subsidiaryId);
		}

		$scope.equipmentBean.projectId = parseInt($scope.equipmentBean.projectId);
		$scope.equipmentBean.brandNo = parseInt($scope.equipmentBean.brandNo);
		$scope.equipmentBean.manufacturerId = parseInt($scope.equipmentBean.manufacturerId);
		$scope.equipmentBean.manufacturer = $scope.equipmentBean.manufacturerName;

		if($scope.equipmentBean.modelsId){
			$scope.equipmentBean.modelsId = parseInt($scope.equipmentBean.modelsId);
		}

		if($scope.equipmentBean.specificationsId){
			$scope.equipmentBean.specificationsId = parseInt($scope.equipmentBean.specificationsId);
		}

		$scope.equipmentBean.equipmentSourceNo = parseInt($scope.equipmentBean.equipmentSourceNo);

		if($scope.equipmentBean.powerType){
			$scope.equipmentBean.powerType = parseInt($scope.equipmentBean.powerType);
		}

		$scope.equipmentBean.pubState = 1;/** 发布状态：1-未发布 */
		$scope.equipmentBean.delFlag = 0;/** 删除标志：0或者null-正常 */

		if($scope.equipmentBean.equipmentCost){
			$scope.equipmentBean.equipmentCost = parseFloat($scope.equipmentBean.equipmentCost);
		}

		$scope.equipmentBean.categoryId = parseInt($scope.equipmentBean.categoryId);
		$scope.equipmentBean.assetOwnersId = parseInt($scope.userInfo.orgId);
		$scope.equipmentBean.totalDepreciation = 0;
		$scope.equipmentBean.createUser = parseInt($scope.userInfo.perPartyId);

		$scope.equipmentBean.onProvinceId = parseInt($scope.equipmentBean.onProvinceId);
		$scope.equipmentBean.onCityId = parseInt($scope.equipmentBean.onCityId);
		$scope.equipmentBean.onDistrictId = parseInt($scope.equipmentBean.onDistrictId);
		/** 获取所在城市信息 */
		if(1==$scope.equipmentBean.equipmentSourceNo){
			$scope.equipmentBean.onProvince = $('#onProvinceId1 option:selected').text();
			$scope.equipmentBean.onCity = $('#onCityId1 option:selected').text();
			$scope.equipmentBean.onDistrict = $('#onDistrictId1 option:selected').text();
		}
		else{
			$scope.equipmentBean.onProvince = $('#onProvinceId2 option:selected').text();
			$scope.equipmentBean.onCity = $('#onCityId2 option:selected').text();
			$scope.equipmentBean.onDistrict = $('#onDistrictId2 option:selected').text();
		}

		if(1==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为自有时，则获取设备状态 */
			$scope.equipmentBean.equState = parseInt($scope.equipmentBean.equState1);
			if(2==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为使用中时，则获取业务状态和设备使用单位 */
				$scope.equipmentBean.busState = parseInt($scope.equipmentBean.busState1);

				if($scope.equipmentBean.equAtSubOrgId1){
					$scope.equipmentBean.equAtSubOrgId = parseInt($scope.equipmentBean.equAtSubOrgId1);/** 使用处级单位id */
				}

				if($scope.equipmentBean.equAtProjectId1){
					$scope.equipmentBean.equAtProjectId = parseInt($scope.equipmentBean.equAtProjectId1);/** 使用项目id */
					$scope.equipmentBean.equAtOrgId = parseInt($scope.equipmentBean.equAtOrgId1);/** 使用局级单位id */
					$scope.equipmentBean.equAtOrgName = $scope.equipmentBean.equAtOrgName1;	/** 使用局级单位名称 */
				}
				else{
					$scope.equipmentBean.equAtOrgName = $scope.equipmentBean.equAtName1;/** 外部单位名称 */
				}
			}
			else if(3==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为已出售时，则获取出售价格 */
				$scope.equipmentBean.sellPrice = parseFloat($scope.equipmentBean.sellPrice1);
			}
			else if(4==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为已报废时，则获取报废残值 */
				$scope.equipmentBean.scrapPrice = parseFloat($scope.equipmentBean.scrapPrice1);
			}
			else{/** 若设备来源分类为自有、且设备状态为闲置时，则清除业务状态和设备使用单位，出售价格，报废残值 */
				$scope.equipmentBean.busState = null;
				$scope.equipmentBean.equAtSubOrgId = null;
				$scope.equipmentBean.equAtProjectId = null;
				$scope.equipmentBean.equAtOrgId = null;
				$scope.equipmentBean.equAtOrgName = "";
				$scope.equipmentBean.sellPrice = 0;
				$scope.equipmentBean.scrapPrice = 0;
			}
		}
		else{/** 若设备来源分类为外租/外协时，则清除设备状态、业务状态和设备使用单位，出售价格，报废残值 */
			$scope.equipmentBean.equState = null;
			$scope.equipmentBean.busState = null;
			$scope.equipmentBean.equAtSubOrgId = null;
			$scope.equipmentBean.equAtProjectId = null;
			$scope.equipmentBean.equAtOrgId = null;
			$scope.equipmentBean.equAtOrgName = "";
			$scope.equipmentBean.sellPrice = 0;
			$scope.equipmentBean.scrapPrice = 0;
		}

		if(2==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为外租时，则获取交易信息登记内容 */
			if(!$scope.equipmentBean.SupplementStar){
				$scope.equipmentBean.leaseModeName = $scope.equipmentBean.leaseModeName1;
				$scope.equipmentBean.settlementModeName = $scope.equipmentBean.settlementModeName1;
			}
			else{
				$scope.equipmentBean.leaseModeName = "";
				$scope.equipmentBean.settlementModeName = "";
			}

			if($scope.equipmentBean.leasePrice1){
				$scope.equipmentBean.leasePrice = parseFloat($scope.equipmentBean.leasePrice1);
			}

			$scope.equipmentBean.contractNo = $scope.equipmentBean.contractNo1;
			$scope.equipmentBean.remark = $scope.equipmentBean.remark1;
		}
		else if(1==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为自有、设备状态为使用中、业务状态为外租时，则获取交易信息登记内容 */
			if(2==$scope.equipmentBean.equState1 && 5==$scope.equipmentBean.busState1){
				if(!$scope.equipmentBean.SupplementStar){
					$scope.equipmentBean.leaseModeName = $scope.equipmentBean.leaseModeName1;
					$scope.equipmentBean.settlementModeName = $scope.equipmentBean.settlementModeName1;
				}
				else{
					$scope.equipmentBean.leaseModeName = "";
					$scope.equipmentBean.settlementModeName = "";
				}
	
				if($scope.equipmentBean.leasePrice1){
					$scope.equipmentBean.leasePrice = parseFloat($scope.equipmentBean.leasePrice1);
				}

				$scope.equipmentBean.contractNo = $scope.equipmentBean.contractNo1;
				$scope.equipmentBean.remark = $scope.equipmentBean.remark1;
			}
			else{
				$scope.equipmentBean.leaseModeName = "";
				$scope.equipmentBean.settlementModeName = "";
				$scope.equipmentBean.leasePrice = 0;
				$scope.equipmentBean.contractNo = "";
				$scope.equipmentBean.remark = "";
			}
		}
		else{/** 若设备来源分类为外协时，则清楚交易信息登记内容 */
			$scope.equipmentBean.leaseModeName = "";
			$scope.equipmentBean.settlementModeName = "";
			$scope.equipmentBean.leasePrice = 0;
			$scope.equipmentBean.contractNo = "";
			$scope.equipmentBean.remark = "";
		}

		function addSucc(rec){
			if(1==flag){//	保存并关闭
				$('#equipmentModal').modal('hide');
				$scope.equipmentBean = {};
				$scope.queryEquipmentData(1);
			}
			else{//	继续添加
				$scope.equipmentBean.equNo = "";/** 设备编号 */
				$scope.equipmentBean.asset = "";/** 资产编号 */
				$scope.equipmentBean.facortyNo = "";/** 出厂编号 */
				$scope.equipmentBean.licenseNo = "";/** 牌照号码 */
				$scope.queryEquipmentData(1);
				$scope.equipmentBean.powerType = "" + $scope.equipmentBean.powerType;
			}

			$.messager.popup(rec.msg);
		}
		function addErr(rec){
			$.messager.popup(rec.data.message);
		}

		equipment.put($scope.equipmentBean, addSucc, addErr);
	};

	/* 打开 设备资源修改模态框 */
	$scope.openUpdModal = function(){
		if(!$scope.qryEquDetail.equipmentId){
			$.messager.popup("请选择一条信息");
			return;
		}

		$scope.equipmentBean = {};

		function qSucc(rec){
			$scope.equipmentBean = rec;

			$scope.equipmentBean.flagShow_ = 'upd';

			/** 所属单位信息 begin */
			$scope.equipmentBean.bureauId = $scope.equipmentBean.bureauOrgPartyId;
			$scope.equipmentBean.bureauName = $scope.equipmentBean.bureauOrgPartyName;
			$scope.equipmentBean.subsidiaryId = $scope.equipmentBean.sonOrgPartyId;
			$scope.equipmentBean.subsidiaryName = $scope.equipmentBean.sonOrgName;
			$scope.equipmentBean.projectId = $scope.equipmentBean.proOrgPartyId;
			$scope.equipmentBean.projectName = $scope.equipmentBean.proOrgName;
			/** 所属单位信息 end */

			$scope.equipmentBean.assetOwnersId = $scope.equipmentBean.orgPartyId;

			/** 生产厂家 */
			$scope.equipmentBean.manufacturerId = $scope.equipmentBean.manufacturerNo;
			$scope.equipmentBean.manufacturerNameCopy = $scope.equipmentBean.manufacturerName;
			if($scope.equipmentBean.manufacturerName && $scope.equipmentBean.manufacturerName.length > 12){
				$scope.equipmentBean.manufacturerNameCopy = $scope.equipmentBean.manufacturerNameCopy.substring(0,12) + "...";
			}

			/** 转换字符串、整型、浮点型 */
			$scope.equipmentBean.powerType = "" + $scope.equipmentBean.powerType;
			/** 处理设备编号，去掉单位编码 */
			var equNo_offset = $scope.equipmentBean.equNo.indexOf("-");
			if(equNo_offset!=-1){
				$scope.equipmentBean.equNo = $scope.equipmentBean.equNo.substring(equNo_offset + 1);
			}

			/** 根据设备来源分类，回显不同信息 */
			var flag = $scope.equipmentBean.equipmentSourceNo;
			if(flag==1){
				$scope.association = true;
				$scope.own = false;
				$scope.stocks = true;
			}
			if(flag==2){
				$scope.association = false;
				$scope.own = true;
				$scope.stocks = true;
			}
			if(flag==3){
				$scope.association = false;
				$scope.own = true;
				$scope.stocks = false;
			}

			$scope.changeProvince();/** 市信息初始化 */

			$scope.changeCity();/** 区信息初始化 */

			$scope.equipmentBean.equShowDisFlag_ = true;
		 	$scope.equipmentBean.equShowRedFlag_ = false;
		 	$scope.equipmentBean.equAtOrgShowDisFlag_ = true;

			if(1==$scope.equipmentBean.equipmentSourceNo){/** 设备来源分类 - 自有 */
				$scope.equipmentBean.equState1 = "" + $scope.equipmentBean.equState;

			 	$scope.equipmentBean.SupplementStar = true;
			 	$scope.equipmentBean.leaseModeName1 = '1';/** 租赁方式初始化，默认为1-月租 */
			 	$scope.equipmentBean.settlementModeName1 = '1';/** 结算方式初始化，默认为1-转账 */

			 	if(3==$scope.equipmentBean.equState){/** 设备状态 - 已出售 */
					$scope.equipmentBean.sellPrice1 = $scope.equipmentBean.sellPrice;
				}
				else if(4==$scope.equipmentBean.equState){/** 设备状态 - 已报废 */
					$scope.equipmentBean.scrapPrice1 = $scope.equipmentBean.scrapPrice;
				}
				else if(2==$scope.equipmentBean.equState){/** 设备状态 - 使用中 */
					$scope.equipmentBean.busState1 = "" + $scope.equipmentBean.busState;

					$scope.equipmentBean.equShowDisFlag_ = false;
				 	$scope.equipmentBean.equShowRedFlag_ = true;

					if(5==$scope.equipmentBean.busState){/** 业务状态 - 外租 */
						$scope.equipmentBean.equAtName1 = $scope.equipmentBean.equAtOrgName;

						$scope.equipmentBean.equAtOrgShowDisFlag_ = false;

						$scope.initModEquStocks();
					}
					else{/** 业务状态 - 自用/调拨/局内租/外局租 */
						$scope.equipmentBean.equAtOrgId1 = $scope.equipmentBean.equAtOrgId;
						$scope.equipmentBean.equAtOrgName1 = $scope.equipmentBean.equAtOrgName;
						$scope.equipmentBean.equAtSubOrgId1 = $scope.equipmentBean.equAtSubOrgId;
						$scope.equipmentBean.equAtProjectId1 = $scope.equipmentBean.equAtProjectId;
						$scope.equipmentBean.equAtName1 = $scope.equipmentBean.equAtProjectName;
					}
				}
			}
			else if(2==$scope.equipmentBean.equipmentSourceNo){/** 设备来源分类 - 外租 */
			 	$scope.initModEquStocks();
			}
			else{/** 设备来源分类 - 外协 */
			 	$scope.equipmentBean.SupplementStar = true;
			}

		 	$scope.titleMsg = "设备资源修改";
			$scope.showFlag = "";/** 错误信息提示标志 */

			$("#equipmentModal").modal({backdrop: 'static', keyboard: false});
		}

		function qErr(rec){
			$.messager.popup(rec.data.message);
		}
		equipment.unifydo({urlPath: $scope.qryEquDetail.equipmentId}, qSucc, qErr);
	};

	/* 若为外租时，初始化设备资源修改页面的交易信息登记内容 */
	$scope.initModEquStocks = function(){
		$scope.equipmentBean.SupplementStar = false;
	 	if($scope.equipmentBean.leaseModeName){/** 交易信息登记 - 租赁方式 */
	 		$scope.equipmentBean.leaseModeName1 = $scope.equipmentBean.leaseModeName;
	 		}
	 	else{
	 		$scope.equipmentBean.leaseModeName1 = '1';/** 租赁方式初始化，默认为1-月租 */
	 	}

	 	if($scope.equipmentBean.settlementModeName){/** 交易信息登记 - 结算方式 */
	 		$scope.equipmentBean.settlementModeName1 = $scope.equipmentBean.settlementModeName;
	 	}
	 	else{
	 		$scope.equipmentBean.settlementModeName1 = '1';/** 结算方式初始化，默认为1-转账 */
	 	}

	 	if($scope.equipmentBean.leasePrice){/** 交易信息登记 - 租赁单价 */
	 		$scope.equipmentBean.leasePrice1 = $scope.equipmentBean.leasePrice;
	 	}

	 	if($scope.equipmentBean.contractNo){/** 交易信息登记 - 合同编号 */
	 		$scope.equipmentBean.contractNo1 = $scope.equipmentBean.contractNo;
	 	}

	 	if($scope.equipmentBean.remark){/** 交易信息登记 - 备注 */
	 		$scope.equipmentBean.remark1 = $scope.equipmentBean.remark;
	 	}
	};

	/* 设备资源修改 */
	$scope.updEqu = function(setForm){
		$scope.showFlag = "";

		/** 验证输入的金额格式 */
		var amountReg = /^[0-9.]{0,18}$/;

		if(!setForm.$valid){
			if(!setForm.projectName.$valid){
				$scope.showFlag = 'projectName';
				$.messager.popup("请选择项目");
				return;
			}

			if(!setForm.equNo.$valid){
				$scope.showFlag = 'equNo';
				$.messager.popup("请输入设备编号");
				return;
			}

			if(!setForm.equName.$valid){
				$scope.showFlag = 'equName';
				$.messager.popup("请选择设备名称");
				return;
			}

			/** 若设备来源分类为自有时，则控制设备状态为必输 */
			if(1==$scope.equipmentBean.equipmentSourceNo){
				if(!setForm.equState1.$valid){
					$scope.showFlag = 'equState1';
					$.messager.popup("请选择设备状态");
					return;
				}

				if(2==$scope.equipmentBean.equState1){/** 若设备状态为使用中时，则控制业务状态和设备使用单位为必输 */
					if(!setForm.busState1.$valid){
						$scope.showFlag = 'busState1';
						$.messager.popup("请选择业务状态");
						return;
					}
					if(!setForm.equAtName1.$valid){
						$scope.showFlag = 'equAtName1';
						$.messager.popup("设备使用单位不能为空，请添加");
						return;
					}
				}
				else if(3==$scope.equipmentBean.equState1){/** 若设备状态为已出售时，则控制出售价格为必输 */
					if(!setForm.sellPrice1.$valid){
						$scope.showFlag = 'sellPrice1';
						$.messager.popup("请输入出售价格");
						return;
					}

					if($scope.equipmentBean.sellPrice1 && !amountReg.test($scope.equipmentBean.sellPrice1)){
						$scope.showFlag = 'sellPrice1Pattern';
						$.messager.popup("请输入正确的出售价格");
						return ;
					}
				}
				else if(4==$scope.equipmentBean.equState1){/** 若设备状态为已报废时，则控制报废残值为必输 */
					if(!setForm.scrapPrice1.$valid){
						$scope.showFlag = 'scrapPrice1';
						$.messager.popup("请输入报废残值");
						return;
					}

					if($scope.equipmentBean.scrapPrice1 && !amountReg.test($scope.equipmentBean.scrapPrice1)){
						$scope.showFlag = 'sellPricePattern';
						$.messager.popup("请输入正确的报废残值");
						return ;
					}
				}

				if(!setForm.onProvinceId1.$valid){
					$scope.showFlag = 'onProvinceId1';
					$.messager.popup("请选择所在省份");
					return;
				}

				if(!setForm.onCityId1.$valid){
					$scope.showFlag = 'onCityId1';
					$.messager.popup("请选择所在城市");
					return;
				}

				if(!setForm.onDistrictId1.$valid){
					$scope.showFlag = 'onDistrictId1';
					$.messager.popup("请选择所在区县");
					return;
				}

				if(!setForm.contactPersonPhone1.$valid){
					$scope.showFlag = 'contactPersonPhone1';
					$.messager.popup("请输入联系电话");
					return;
				}
			}
			else{
				if(!setForm.onProvinceId2.$valid){
					$scope.showFlag = 'onProvinceId2';
					$.messager.popup("请选择所在省份");
					return;
				}

				if(!setForm.onCityId2.$valid){
					$scope.showFlag = 'onCityId2';
					$.messager.popup("请选择所在城市");
					return;
				}

				if(!setForm.onDistrictId2.$valid){
					$scope.showFlag = 'onDistrictId2';
					$.messager.popup("请选择所在区县");
					return;
				}

				if(!setForm.contactPersonPhone2.$valid){
					$scope.showFlag = 'contactPersonPhone2';
					$.messager.popup("请输入联系电话");
					return;
				}

				if(2==$scope.equipmentBean.equipmentSourceNo && $scope.equipmentBean.leasePrice1 && !amountReg.test($scope.equipmentBean.leasePrice1)){
					$scope.showFlag = 'leasePrice1Pattern';
					$.messager.popup("请输入正确的租赁单价");
					return ;
				}
			}
		}

		/** 验证输入的联系电话格式 */
		var phoneReg = /^[0-9\-]{7,}$/;
		if($scope.equipmentBean.contactPersonPhone && !phoneReg.test($scope.equipmentBean.contactPersonPhone)){
			$scope.showFlag = 'contactPersonPhonePartten';
			$.messager.popup("请输入正确的联系电话");
			return ;
		}

		if($scope.equipmentBean.equipmentCost && !amountReg.test($scope.equipmentBean.equipmentCost)){
			$scope.showFlag = 'equipmentCostPattern';
			$.messager.popup("请输入正确的设备原值");
			return ;
		}

		var amountReg2 = /^[0-9.]{0,15}$/;
		if($scope.equipmentBean.power && !amountReg2.test($scope.equipmentBean.power)){
			$scope.showFlag = 'powerPattern';
			$.messager.popup("请输入正确的功率");
			return ;
		}

		/** 转换整型、浮点型 */
		$scope.equipmentBean.bureauId = parseInt($scope.equipmentBean.bureauId);

		if($scope.equipmentBean.subsidiaryId){
			$scope.equipmentBean.subsidiaryId = parseInt($scope.equipmentBean.subsidiaryId);
		}
		else{
			$scope.equipmentBean.subsidiaryId = null;
		}

		$scope.equipmentBean.projectId = parseInt($scope.equipmentBean.projectId);
		$scope.equipmentBean.brandNo = parseInt($scope.equipmentBean.brandNo);
		$scope.equipmentBean.manufacturerId = parseInt($scope.equipmentBean.manufacturerId);
		$scope.equipmentBean.manufacturer = $scope.equipmentBean.manufacturerName;

		if($scope.equipmentBean.modelsId){
			$scope.equipmentBean.modelsId = parseInt($scope.equipmentBean.modelsId);
		}
		else{
			$scope.equipmentBean.modelsId = null;
		}

		if($scope.equipmentBean.specificationsId){
			$scope.equipmentBean.specificationsId = parseInt($scope.equipmentBean.specificationsId);
		}
		else{
			$scope.equipmentBean.specificationsId = null;
		}

		$scope.equipmentBean.equipmentSourceNo = parseInt($scope.equipmentBean.equipmentSourceNo);

		if($scope.equipmentBean.powerType){
			$scope.equipmentBean.powerType = parseInt($scope.equipmentBean.powerType);
		}
		else{
			$scope.equipmentBean.powerType = null;
		}

		if($scope.equipmentBean.equipmentCost){
			$scope.equipmentBean.equipmentCost = parseFloat($scope.equipmentBean.equipmentCost);
		}
		else{
			$scope.equipmentBean.equipmentCost = 0;
		}

		$scope.equipmentBean.categoryId = parseInt($scope.equipmentBean.categoryId);
		$scope.equipmentBean.assetOwnersId = parseInt($scope.userInfo.orgId);

		$scope.equipmentBean.onProvinceId = parseInt($scope.equipmentBean.onProvinceId);
		$scope.equipmentBean.onCityId = parseInt($scope.equipmentBean.onCityId);
		$scope.equipmentBean.onDistrictId = parseInt($scope.equipmentBean.onDistrictId);
		/** 获取所在城市信息 */
		if(1==$scope.equipmentBean.equipmentSourceNo){
			$scope.equipmentBean.onProvince = $('#onProvinceId1 option:selected').text();
			$scope.equipmentBean.onCity = $('#onCityId1 option:selected').text();
			$scope.equipmentBean.onDistrict = $('#onDistrictId1 option:selected').text();
		}
		else{
			$scope.equipmentBean.onProvince = $('#onProvinceId2 option:selected').text();
			$scope.equipmentBean.onCity = $('#onCityId2 option:selected').text();
			$scope.equipmentBean.onDistrict = $('#onDistrictId2 option:selected').text();
		}

		if(1==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为自有时，则获取设备状态 */
			$scope.equipmentBean.equState = parseInt($scope.equipmentBean.equState1);
			if(2==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为使用中时，则获取业务状态和设备使用单位 */
				$scope.equipmentBean.busState = parseInt($scope.equipmentBean.busState1);

				if($scope.equipmentBean.equAtSubOrgId1){
					$scope.equipmentBean.equAtSubOrgId = parseInt($scope.equipmentBean.equAtSubOrgId1);/** 使用处级单位id */
				}
				else{
					$scope.equipmentBean.equAtSubOrgId = null;
				}

				if($scope.equipmentBean.equAtProjectId1){
					$scope.equipmentBean.equAtProjectId = parseInt($scope.equipmentBean.equAtProjectId1);/** 使用项目id */
					$scope.equipmentBean.equAtOrgId = parseInt($scope.equipmentBean.equAtOrgId1);/** 使用局级单位id */
					$scope.equipmentBean.equAtOrgName = $scope.equipmentBean.equAtOrgName1;	/** 使用局级单位名称 */
				}
				else{
					$scope.equipmentBean.equAtProjectId = null;
					$scope.equipmentBean.equAtOrgId = null;
					$scope.equipmentBean.equAtOrgName = $scope.equipmentBean.equAtName1;/** 外部单位名称 */
				}

				$scope.equipmentBean.sellPrice = 0;
				$scope.equipmentBean.scrapPrice = 0;
			}
			else if(3==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为已出售时，则获取出售价格 */
				$scope.equipmentBean.sellPrice = parseFloat($scope.equipmentBean.sellPrice1);

				$scope.equipmentBean.busState = null;
				$scope.equipmentBean.equAtSubOrgId = null;
				$scope.equipmentBean.equAtProjectId = null;
				$scope.equipmentBean.equAtOrgId = null;
				$scope.equipmentBean.equAtOrgName = "";
				$scope.equipmentBean.scrapPrice = 0;
			}
			else if(4==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为已报废时，则获取报废残值 */
				$scope.equipmentBean.scrapPrice = parseFloat($scope.equipmentBean.scrapPrice1);

				$scope.equipmentBean.busState = null;
				$scope.equipmentBean.equAtSubOrgId = null;
				$scope.equipmentBean.equAtProjectId = null;
				$scope.equipmentBean.equAtOrgId = null;
				$scope.equipmentBean.equAtOrgName = "";
				$scope.equipmentBean.sellPrice = 0;
			}
			else{/** 若设备来源分类为自有、且设备状态为闲置时，则清除业务状态和设备使用单位，出售价格，报废残值 */
				$scope.equipmentBean.busState = null;
				$scope.equipmentBean.equAtSubOrgId = null;
				$scope.equipmentBean.equAtProjectId = null;
				$scope.equipmentBean.equAtOrgId = null;
				$scope.equipmentBean.equAtOrgName = "";
				$scope.equipmentBean.sellPrice = 0;
				$scope.equipmentBean.scrapPrice = 0;
			}
		}
		else{/** 若设备来源分类为外租/外协时，则清除设备状态、业务状态和设备使用单位，出售价格，报废残值 */
			$scope.equipmentBean.equState = null;
			$scope.equipmentBean.busState = null;
			$scope.equipmentBean.equAtSubOrgId = null;
			$scope.equipmentBean.equAtProjectId = null;
			$scope.equipmentBean.equAtOrgId = null;
			$scope.equipmentBean.equAtOrgName = "";
			$scope.equipmentBean.sellPrice = 0;
			$scope.equipmentBean.scrapPrice = 0;
		}

		if(2==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为外租时，则获取交易信息登记内容 */
			if(!$scope.equipmentBean.SupplementStar){
				$scope.equipmentBean.leaseModeName = $scope.equipmentBean.leaseModeName1;
				$scope.equipmentBean.settlementModeName = $scope.equipmentBean.settlementModeName1;
			}
			else{
				$scope.equipmentBean.leaseModeName = "";
				$scope.equipmentBean.settlementModeName = "";
			}

			if($scope.equipmentBean.leasePrice1){
				$scope.equipmentBean.leasePrice = parseFloat($scope.equipmentBean.leasePrice1);
			}
			else{
				$scope.equipmentBean.leasePrice = 0;
			}

			$scope.equipmentBean.contractNo = $scope.equipmentBean.contractNo1;
			$scope.equipmentBean.remark = $scope.equipmentBean.remark1;
		}
		else if(1==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为自有、设备状态为使用中、业务状态为外租时，则获取交易信息登记内容 */
			if(5==$scope.equipmentBean.busState1){
				if(!$scope.equipmentBean.SupplementStar){
					$scope.equipmentBean.leaseModeName = $scope.equipmentBean.leaseModeName1;
					$scope.equipmentBean.settlementModeName = $scope.equipmentBean.settlementModeName1;
				}
				else{
					$scope.equipmentBean.leaseModeName = "";
					$scope.equipmentBean.settlementModeName = "";
				}
	
				if($scope.equipmentBean.leasePrice1){
					$scope.equipmentBean.leasePrice = parseFloat($scope.equipmentBean.leasePrice1);
				}
				else{
					$scope.equipmentBean.leasePrice = 0;
				}

				$scope.equipmentBean.contractNo = $scope.equipmentBean.contractNo1;
				$scope.equipmentBean.remark = $scope.equipmentBean.remark1;
			}
			else{
				$scope.equipmentBean.leaseModeName = "";
				$scope.equipmentBean.settlementModeName = "";
				$scope.equipmentBean.leasePrice = 0;
				$scope.equipmentBean.contractNo = "";
				$scope.equipmentBean.remark = "";
			}
		}
		else{/** 若设备来源分类为外协时，则清楚交易信息登记内容 */
			$scope.equipmentBean.leaseModeName = "";
			$scope.equipmentBean.settlementModeName = "";
			$scope.equipmentBean.leasePrice = 0;
			$scope.equipmentBean.contractNo = "";
			$scope.equipmentBean.remark = "";
		}

		function updSucc(rec){
			$('#equipmentModal').modal('hide');
			$scope.equipmentBean = {};
			$scope.queryEquipmentData(1);

			$.messager.popup(rec.msg);
		}
		function updErr(rec){
			$.messager.popup(rec.data.message);
		}

		equipment.post({parm: $scope.equipmentBean.equipmentId}, $scope.equipmentBean, updSucc, updErr);
	};

	/* 使用情况登记 - 完成 */
	$scope.saveButton = function(setForm){
		$scope.showFlag = "";

		if(!setForm.$valid){
			/** 若设备来源分类为自有时，则控制设备状态为必输 */
			if(1==$scope.equipmentBean.equipmentSourceNo){
				if(!setForm.equState1.$valid){
					$scope.showFlag = 'equState1';
					$.messager.popup("请选择设备状态");
					return;
				}

				/** 若设备来源分类为自有、且设备状态为使用中时，则控制业务状态和设备使用单位为必输 */
				if(2==$scope.equipmentBean.equState1){
					if(!setForm.busState1.$valid){
						$scope.showFlag = 'busState1';
						$.messager.popup("请选择业务状态");
						return;
					}
					if(!setForm.equAtName1.$valid){
						$scope.showFlag = 'equAtName1';
						$.messager.popup("设备使用单位不能为空，请添加");
						return;
					}
				}

				if(!setForm.contactPersonPhone1.$valid){
					$scope.showFlag = 'contactPersonPhone1';
					$.messager.popup("请输入联系电话");
					return;
				}

				if(!setForm.approachDate1.$valid){
					$scope.showFlag = 'approachDate1';
					$.messager.popup("请选择进场日期");
					return;
				}

				if(!setForm.exitDate1.$valid){
					$scope.showFlag = 'exitDate1';
					$.messager.popup("请选择出场日期");
					return;
				}
			}
			else{
				if(!setForm.contactPersonPhone2.$valid){
					$scope.showFlag = 'contactPersonPhone2';
					$.messager.popup("请输入联系电话");
					return;
				}

				if(!setForm.approachDate2.$valid){
					$scope.showFlag = 'approachDate2';
					$.messager.popup("请选择进场日期");
					return;
				}

				if(!setForm.exitDate2.$valid){
					$scope.showFlag = 'exitDate2';
					$.messager.popup("请选择出场日期");
					return;
				}
			}
		}

		/** 验证输入的联系电话格式 */
		var phoneReg = /^[0-9\-]{7,}$/;
		if($scope.equipmentBean.contactPersonPhone && !phoneReg.test($scope.equipmentBean.contactPersonPhone)){
			$scope.showFlag = 'contactPersonPhonePartten';
			$.messager.popup("请输入正确的联系电话");
			return ;
		}

		/** 转换整型、浮点型 */
		$scope.equipmentBean.equipmentSourceNo = parseInt($scope.equipmentBean.equipmentSourceNo);

		$scope.equipmentBean.onProvinceId = parseInt($scope.equipmentBean.onProvinceId);
		$scope.equipmentBean.onCityId = parseInt($scope.equipmentBean.onCityId);
		$scope.equipmentBean.onDistrictId = parseInt($scope.equipmentBean.onDistrictId);
		/** 获取所在城市信息 */
		if(1==$scope.equipmentBean.equipmentSourceNo){
			$scope.equipmentBean.onProvince = $('#onProvinceId1 option:selected').text();
			$scope.equipmentBean.onCity = $('#onCityId1 option:selected').text();
			$scope.equipmentBean.onDistrict = $('#onDistrictId1 option:selected').text();
		}
		else{
			$scope.equipmentBean.onProvince = $('#onProvinceId2 option:selected').text();
			$scope.equipmentBean.onCity = $('#onCityId2 option:selected').text();
			$scope.equipmentBean.onDistrict = $('#onDistrictId2 option:selected').text();
		}

		if(1==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为自有时，则获取设备状态 */
			$scope.equipmentBean.equState = parseInt($scope.equipmentBean.equState1);
			if(2==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为使用中时，则获取业务状态和设备使用单位 */
				$scope.equipmentBean.busState = parseInt($scope.equipmentBean.busState1);

				if($scope.equipmentBean.equAtSubOrgId1){
					$scope.equipmentBean.equAtSubOrgId = parseInt($scope.equipmentBean.equAtSubOrgId1);/** 使用处级单位id */
				}
				else{
					$scope.equipmentBean.equAtSubOrgId = null;
				}

				if($scope.equipmentBean.equAtProjectId1){
					$scope.equipmentBean.equAtProjectId = parseInt($scope.equipmentBean.equAtProjectId1);/** 使用项目id */
					$scope.equipmentBean.equAtOrgId = parseInt($scope.equipmentBean.equAtOrgId1);/** 使用局级单位id */
					$scope.equipmentBean.equAtOrgName = $scope.equipmentBean.equAtOrgName1;	/** 使用局级单位名称 */
				}
				else{
					$scope.equipmentBean.equAtProjectId = null;
					$scope.equipmentBean.equAtOrgId = null;
					$scope.equipmentBean.equAtOrgName = $scope.equipmentBean.equAtName1;/** 外部单位名称 */
				}

				$scope.equipmentBean.sellPrice = 0;
				$scope.equipmentBean.scrapPrice = 0;
			}
			else if(3==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为已出售时，则获取出售价格 */
				$scope.equipmentBean.sellPrice = parseFloat($scope.equipmentBean.sellPrice1);

				$scope.equipmentBean.busState = null;
				$scope.equipmentBean.equAtSubOrgId = null;
				$scope.equipmentBean.equAtProjectId = null;
				$scope.equipmentBean.equAtOrgId = null;
				$scope.equipmentBean.equAtOrgName = "";
				$scope.equipmentBean.scrapPrice = 0;
			}
			else if(4==$scope.equipmentBean.equState1){/** 若设备来源分类为自有、且设备状态为已报废时，则获取报废残值 */
				$scope.equipmentBean.scrapPrice = parseFloat($scope.equipmentBean.scrapPrice1);

				$scope.equipmentBean.busState = null;
				$scope.equipmentBean.equAtSubOrgId = null;
				$scope.equipmentBean.equAtProjectId = null;
				$scope.equipmentBean.equAtOrgId = null;
				$scope.equipmentBean.equAtOrgName = "";
				$scope.equipmentBean.sellPrice = 0;
			}
			else{/** 若设备来源分类为自有、且设备状态为闲置时，则清除业务状态和设备使用单位，出售价格，报废残值 */
				$scope.equipmentBean.busState = null;
				$scope.equipmentBean.equAtSubOrgId = null;
				$scope.equipmentBean.equAtProjectId = null;
				$scope.equipmentBean.equAtOrgId = null;
				$scope.equipmentBean.equAtOrgName = "";
				$scope.equipmentBean.sellPrice = 0;
				$scope.equipmentBean.scrapPrice = 0;
			}
		}
		else{/** 若设备来源分类为外租/外协时，则清除设备状态、业务状态和设备使用单位，出售价格，报废残值 */
			$scope.equipmentBean.equState = null;
			$scope.equipmentBean.busState = null;
			$scope.equipmentBean.equAtSubOrgId = null;
			$scope.equipmentBean.equAtProjectId = null;
			$scope.equipmentBean.equAtOrgId = null;
			$scope.equipmentBean.equAtOrgName = "";
			$scope.equipmentBean.sellPrice = 0;
			$scope.equipmentBean.scrapPrice = 0;
		}

		if(2==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为外租时，则获取交易信息登记内容 */
			if(!$scope.equipmentBean.SupplementStar){
				$scope.equipmentBean.leaseModeName = $scope.equipmentBean.leaseModeName1;
				$scope.equipmentBean.settlementModeName = $scope.equipmentBean.settlementModeName1;
			}
			else{
				$scope.equipmentBean.leaseModeName = "";
				$scope.equipmentBean.settlementModeName = "";
			}

			if($scope.equipmentBean.leasePrice1){
				$scope.equipmentBean.leasePrice = parseFloat($scope.equipmentBean.leasePrice1);
			}
			else{
				$scope.equipmentBean.leasePrice = 0;
			}

			$scope.equipmentBean.contractNo = $scope.equipmentBean.contractNo1;
			$scope.equipmentBean.remark = $scope.equipmentBean.remark1;
		}
		else if(1==$scope.equipmentBean.equipmentSourceNo){/** 若设备来源分类为自有、设备状态为使用中、业务状态为外租时，则获取交易信息登记内容 */
			if(5==$scope.equipmentBean.busState1){
				if(!$scope.equipmentBean.SupplementStar){
					$scope.equipmentBean.leaseModeName = $scope.equipmentBean.leaseModeName1;
					$scope.equipmentBean.settlementModeName = $scope.equipmentBean.settlementModeName1;
				}
				else{
					$scope.equipmentBean.leaseModeName = "";
					$scope.equipmentBean.settlementModeName = "";
				}
	
				if($scope.equipmentBean.leasePrice1){
					$scope.equipmentBean.leasePrice = parseFloat($scope.equipmentBean.leasePrice1);
				}
				else{
					$scope.equipmentBean.leasePrice = 0;
				}

				$scope.equipmentBean.contractNo = $scope.equipmentBean.contractNo1;
				$scope.equipmentBean.remark = $scope.equipmentBean.remark1;
			}
			else{
				$scope.equipmentBean.leaseModeName = "";
				$scope.equipmentBean.settlementModeName = "";
				$scope.equipmentBean.leasePrice = 0;
				$scope.equipmentBean.contractNo = "";
				$scope.equipmentBean.remark = "";
			}
		}
		else{/** 若设备来源分类为外协时，则清楚交易信息登记内容 */
			$scope.equipmentBean.leaseModeName = "";
			$scope.equipmentBean.settlementModeName = "";
			$scope.equipmentBean.leasePrice = 0;
			$scope.equipmentBean.contractNo = "";
			$scope.equipmentBean.remark = "";
		}

		function qSucc(rec){
			$.messager.popup(rec.msg);
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		equipment.put({Action: 'AddUseInfo'}, $scope.equipmentBean, qSucc, qErr);
 	};

});