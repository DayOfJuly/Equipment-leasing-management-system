app.controller('messageAggregateController', function($scope, $timeout, SYS_CODE_CON, sysCodeTranslateFactory, category, entSvc, proSvc, statisticsSvc, statisticsExportSvc, downloadExcelUrl) {

	$scope.sysCodeCon = SYS_CODE_CON;	//	把常量赋值给一个对象这样可以使用了
	$scope.ct = sysCodeTranslateFactory;	//	把翻译赋值给一个对象

	/* userInfo */
	$scope.userInfo = {};

	$scope.userInfo.orgParTypeId = SYS_USER_INFO.orgParTypeId;
	$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
	$scope.userInfo.orgId = SYS_USER_INFO.orgId;
	$scope.userInfo.orgCode = SYS_USER_INFO.orgCode;
	$scope.userInfo.orgName = SYS_USER_INFO.orgName;
	$scope.userInfo.proId = SYS_USER_INFO.proId;
	$scope.userInfo.proName = SYS_USER_INFO.proName;

	/* 初始化资源明细查询参数 */
	$scope.equDtlQryBean = {};

	$scope.equDtlQryBean.isInclude = 0;/** 当前单位 包含下级单位值 */
	$scope.equDtlQryBean.isOrgShowFlag = true;/** 当前单位 选择框 - 显示标志 */

	if(8==$scope.userInfo.orgParTypeId){
		$scope.equDtlQryBean.isOrgShowFlag = false;

		$scope.equDtlQryBean.orgFlag = 8;
		$scope.equDtlQryBean.orgPartyId = $scope.userInfo.orgId;
		$scope.equDtlQryBean.orgNameInput = $scope.userInfo.orgName;
	}
	else{
		if($scope.userInfo.proId){/** 如果登录人员有项目，则当前单位显示项目信息，且不能选择单位/项目；列表显示该项目下的设备资源 */
			$scope.equDtlQryBean.isOrgShowFlag = false;

			$scope.equDtlQryBean.orgFlag = 3;
			$scope.equDtlQryBean.orgPartyId = $scope.userInfo.proId;
			$scope.equDtlQryBean.orgNameInput = $scope.userInfo.proName;
		}
		else{/** 如果登录人员没有项目，则当前单位默认显示单位信息，可以选择单位/项目；列表显示该单位/项目下的设备资源 */
			if(1==$scope.userInfo.orgLevel){
				$scope.equDtlQryBean.orgFlag = 9;

				$scope.equDtlQryBean.isInclude = 1;
			}
			else if(2==$scope.userInfo.orgLevel){
				$scope.equDtlQryBean.orgFlag = 1;
			}
			else if(3==$scope.userInfo.orgLevel){
				$scope.equDtlQryBean.orgFlag = 2;
			}

			$scope.equDtlQryBean.orgCode = $scope.userInfo.orgCode;
			$scope.equDtlQryBean.orgPartyId = $scope.userInfo.orgId;
			$scope.equDtlQryBean.orgName = $scope.userInfo.orgName;
		}
	};

	/* 初始化资源明细列表查询 */
	$scope.equipmentList = [];/** 设备分类资源汇总信息 */
	$scope.isShowFlag = false;
	$scope.queryEquipmentData = function(){
		/** 资源明细列表查询 begin */
		function qSucc(rec){
			$scope.equipmentList = rec.list;

			$scope.equDtlQryBean.startMonth = rec.busEquipmentReportBean.startMonth;
			$scope.equDtlQryBean.endMonth = rec.busEquipmentReportBean.endMonth;

			if(rec.list.length!=0){
				$scope.isShowFlag = true;
			}
			else{
				$scope.equipmentList = [];
				$scope.isShowFlag = false;
				$.messager.popup("没有符合条件的记录！");
			}
		}
		function qErr(rec){
			$scope.equipmentList = [];
			$.messager.popup(rec.data.message);
		}

		$scope.equDtlQryBean.equCategoryId = "";

		statisticsSvc.queryStatisticsList({urlPath: 'Collection', Action:'InfoPublishCollection'}, $scope.equDtlQryBean, qSucc, qErr);
		/** 资源明细列表查询 end */
	};
	$scope.queryEquipmentData();

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
			$scope.employers = [{name: $scope.userInfo.orgName, orgCode: $scope.userInfo.orgCode, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

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
		$scope.employer.orgCode = orgInfo.code;
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

		$scope.equDtlQryBean.orgFlag = $scope.employer.orgFlag;
		$scope.equDtlQryBean.orgCode = $scope.employer.orgCode;
		$scope.equDtlQryBean.orgPartyId = $scope.employer.currOrgId;
		$scope.equDtlQryBean.orgName = $scope.employer.name;

		if($scope.equDtlQryBean.orgFlag==9){
			$scope.equDtlQryBean.isInclude = 1;
		}
		else{
			$scope.equDtlQryBean.isInclude = 0;
		}
	};

	/* 取消并关闭 选择单位/项目模态框 */
	$scope.closeEmployerModel = function(){
		$('#employerModel').modal('hide');
	} 

	$scope.equNameslength = [];

	/* 展开查询设备名称资源汇总信息 */
	$scope.openCategory = function(index, equCategoryId, obj){
		/** 查询设备名称资源汇总信息 begin */
		function qSucc(rec){
			$scope.equNameList = rec.list;

			if(rec.list.length!=0){
				obj.type = "CLOSE_";

				/** 加入到原列表中 */
				var firstList = $scope.equipmentList.slice(0, index + 1);
				var lastList = $scope.equipmentList.slice(index + 1);

				$scope.equipmentList = firstList.concat($scope.equNameList, lastList);
				/** 保存当前查询的设备名称资源汇总数，用于收缩去除原列表中的该设备名称资源汇总信息 */
				$scope.equNameslength.push({equCategoryId: equCategoryId, length: $scope.equNameList.length});
			}
			else{
				$.messager.popup("没有符合条件的记录！");
			}
		}
		function qErr(rec){
			$.messager.popup(rec.data.message);
		}

		$scope.equDtlQryBean.equCategoryId = equCategoryId;

		statisticsSvc.queryStatisticsList({urlPath: 'Collection', Action: 'InfoPublishCollection'}, $scope.equDtlQryBean, qSucc, qErr);
		/** 查询设备名称资源汇总信息 end */
	};

	/* 收缩查询设备名称资源汇总信息 */
	$scope.closeCategory = function(index, equCategoryId, obj){
		if($scope.equNameslength.length!=0){
			for(var i=0;i<$scope.equNameslength.length;i++){
				if(equCategoryId==$scope.equNameslength[i].equCategoryId){
					obj.type = "OPEN_";

					var firstList = $scope.equipmentList.slice(0, index + 1);
					var lastList = $scope.equipmentList.slice($scope.equNameslength[i].length + index + 1);

					$scope.equipmentList = firstList.concat(lastList);
					/** 移除当前查询的设备名称资源汇总数 */
					$scope.equNameslength.splice(i, 1);
				}
				
			}
		}
	};

	/* 导出Excel */
	$scope.exportExcel = function(){
		$('#exportExcelModel').modal('show');

		/** 导出资源明细excel begin */
		function exportSucc(rec){
			var name = rec.excel;
			var path = rec.downloadExcelPath;

			window.location.href = downloadExcelUrl + name;

			$scope.equDtlQryBean.start = "";
			$scope.equDtlQryBean.itemCount = "";

			$('#exportExcelModel').modal('hide');
		}
		function exportErr(rec){
			$.messager.popup(rec.data.message);

			$('#exportExcelModel').modal('hide');
		}

		statisticsExportSvc.Export({urlPath: 'Collection', Action: 'InfoPublishCollection'}, $scope.equDtlQryBean, exportSucc, exportErr);
		/** 导出资源明细excel end */
	};

});
