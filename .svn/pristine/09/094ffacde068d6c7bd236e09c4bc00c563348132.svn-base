app.controller('projectListController',function($scope,regionSvc,proSvc,entSvc,SYS_CODE_CON,sysCodeTranslateFactory){

	/* ie9下title正确显示使用 */
	document.title = "项目设置";

	/* 水印信息 */
	$scope.placeholders = {
		note: "请输入字符在120个以内"
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

	/* 总公司人员只能查询，不能管理 */
	$scope.levelFlag = true;
	if(SYS_USER_INFO.orgLevel==1){ 
		$scope.levelFlag = false;
	};

	if($scope.userInfo.proId){
		$scope.dis = true;
	}else{
		$scope.dis = false;
	}
	
	/* 项目设置列表查询分页标签参数配置 */
	$scope.paginationConf = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 20,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [20, 40, 60, 80],
		onChange: function(currentPage){
			$scope.queryProjects(currentPage);
		}
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

	$scope.btnShow_ = false;
	$scope.queryProjects = function(currentPage){
		if(currentPage)
		{
			$scope.paginationConf.currentPage = currentPage;
		}

		$scope.radioTrIndex = "";

		/** 根据currOrgId，查询该组织下的项目 begin */
		function qSucc(rec){
			$scope.proList = rec.content;
			$scope.paginationConf.totalItems = rec.totalElements;

			if(rec.content.length!=0){
				$scope.btnShow_ = true;
				for(var i=0;i<$scope.proList.length;i++){
					/** 项目编号 */
					$scope.proList[i].codeCopy = $scope.proList[i].code;
					if($scope.proList[i].code && $scope.proList[i].code.length > 10){
						$scope.proList[i].codeCopy = $scope.proList[i].codeCopy.substring(0,10) + "...";
					}

					/** 项目名称 */
					$scope.proList[i].nameCopy = $scope.proList[i].name;
					if($scope.proList[i].name && $scope.proList[i].name.length > 10){
						$scope.proList[i].nameCopy = $scope.proList[i].nameCopy.substring(0,10) + "...";
					}

					/** 项目所属单位编号 */
					$scope.proList[i].parentCodeCopy = $scope.proList[i].parentCode;
					if($scope.proList[i].parentCode && $scope.proList[i].parentCode.length > 14){
						$scope.proList[i].parentCodeCopy = $scope.proList[i].parentCodeCopy.substring(0,14) + "...";
					}

					/** 最后更新时间 */
					$scope.proList[i].updateTimeCopy = $scope.proList[i].updateTime;
					if($scope.proList[i].updateTime && $scope.proList[i].updateTime.length > 14){
						$scope.proList[i].updateTimeCopy = $scope.proList[i].updateTimeCopy.substring(0,14) + "...";
					}
				}
			}
			else{
				$scope.btnShow_ = false;
				$.messager.popup("没有符合条件的记录！");
			}
		}

		function qErr(rec){
			
		}

		$scope.proQryBean.pageNo = $scope.paginationConf.currentPage - 1;
		$scope.proQryBean.pageSize = $scope.paginationConf.itemsPerPage;

		proSvc.queryPartyInstallList($scope.proQryBean, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
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
		if(orgInfo){
		$scope.queryEmployer.currOrgId = orgInfo.currOrgId;
		}
		if(employersIndex){
		var orgLv = $scope.employers[employersIndex].orgFlag;
		}
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

		$scope.proQryBean.currOrgId = $scope.employer.currOrgId;
		$scope.proQryBean.name = $scope.employer.name;
	};

	/* 取消并关闭 选择单位/项目模态框 */
	$scope.closeEmployerModel = function(){
		$('#employerModel').modal('hide');
	} 

	/* 选择单选框 */
	$scope.radioTrIndex = "";	/** 记录第几个单选框标记 */
	$scope.qryProDetail = {};

	$scope.clickSelect = function(currOrgId,state, index_){
		$scope.radioTrIndex = index_;
		if(state==0){
			$scope.btnShowFlag = false;
		}else{
			$scope.btnShowFlag = true;
		}
		$scope.qryProDetail.proId = currOrgId;
	};

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

	/* 关闭-项目查询详情-模态框 */
	$scope.closeWindowQuery = function(){
		$("#EnterPriseQueryModal").modal('hide');
	};

	$scope.areaListA = [];
	$scope.pListA = [];
	$scope.cListA = [];

	/* 项目添加 - 全部省信息 */
	$scope.queryProvince = function(){
		/** 查询地区信息 begin */
		function aSucc(rec){
			$scope.areaListA = rec;
		}
		function aErr(rec){
			
		}

		regionSvc.queryRegionArea({}, aSucc, aErr);
		/** 查询地区信息 begin */
	};
	$scope.queryProvince();

	$scope.projectBean = {};/** 项目信息 */

	/* 弹出-项目添加-模态框 */
	$scope.openAddModal = function(){
		//	清除验证信息
		$scope.showFlag = '';

		$scope.projectBean = {};

		$scope.projectBean.judgeAddUpd = "add";

		$scope.projectBean.parentCode = $scope.userInfo.orgCode;
		$scope.projectBean.parentOrgId = $scope.userInfo.orgId;
		$scope.projectBean.parTypeId = 5;

		$('#EnterPriseModal').modal({backdrop: 'static', keyboard: false});

		setTimeout(function() {
			$scope.$apply(function() {
				var textareas = document.getElementsByTagName("textarea");
				var pf = new window.placeholderFactory();
				pf.createPlaceholder(textareas);
				});
			}, 10);
	};

	$scope.addLoanApply = function(obj){
		if(obj.$valid){
			
			$scope.projectBean.atDistrictName = $('#district option:selected').text();
			$scope.projectBean.atCityName = $('#city option:selected').text();
			$scope.projectBean.atProvinceName = $('#province option:selected').text();
			if($scope.copyCode==null){
				$scope.copyCode = $scope.projectBean.parentCode + "-" + $scope.projectBean.code;
			}else if($scope.projectBean.code.indexOf($scope.projectBean.parentCode + "-")=='-1'){
				$scope.copyCode = $scope.projectBean.parentCode + "-" + $scope.projectBean.code;
			}else{
				$scope.copyCode = $scope.projectBean.code;
			}
			if($scope.projectBean.code != $scope.copyCode){
				$scope.projectBean.code = $scope.projectBean.parentCode + "-" + $scope.projectBean.code;
			}
			/** 根据项目id，修改项目信息 begin */
			function qSucc3(rec){
				$scope.queryProjects(1);
				$('#EnterPriseModal').modal('hide');
				$.messager.popup("添加成功！");
			}
			function qErr3(rec){
				$.messager.popup(rec.data.message);
			}

			proSvc.addPartyInstallDetail($scope.projectBean, qSucc3, qErr3);
		}
		else{
			if(!obj.code.$valid){
				$scope.showFlag = 'code';
				return;
			}
			else if(!obj.name.$valid){
				$scope.showFlag = 'name';
				return;
			}
			else if(!obj.contactsMobile.$valid){
				$scope.showFlag = 'contactsMobile';
				return;
			}
			else if(!obj.province.$valid){
				$scope.showFlag = 'proA';
				return;
			}
			else if(!obj.city.$valid){
				$scope.showFlag = 'citA';
				return;
			}
			else if(!obj.district.$valid){
				$scope.showFlag = 'disA';
				return;
			}
		}
	};

	$scope.showFlag = "";

	/* 弹出-项目修改-模态框 */
	$scope.openUpdModal = function(parm){
		if(!$scope.qryProDetail.proId){
			$.messager.popup("请选择一条信息");
			return;
		}

		//	清除验证信息
		$scope.showFlag = '';

		$scope.projectBean = {};

		function qSucc(rec){
			$scope.projectBean = rec;

			$scope.projectBean.judgeAddUpd = "upd";

			if($scope.projectBean.atProvince){
				/** 根据省id，查询市 - 地区信息 begin */
				function qSucc2(rec){
					$scope.pListA = rec;
				}
				function qErr2(rec){
					
				}
	
				regionSvc.queryRegionArea({regionId: $scope.projectBean.atProvince}, qSucc2, qErr2);
				/** 根据省id，查询市 - 地区信息 end */
			}

			if($scope.projectBean.atCity){
				/** 根据市id，查询区 - 地区信息 begin */
				function qSucc3(rec){
					$scope.cListA = rec;
				}
				function qErr3(rec){
					
				}
	
				regionSvc.queryRegionArea({regionId: $scope.projectBean.atCity}, qSucc3, qErr3);
				/** 根据市id，查询区 - 地区信息 end */
			}

			$("#EnterPriseModal").modal({backdrop: 'static', keyboard: false});

			setTimeout(function() {
				$scope.$apply(function() {
					var textareas = document.getElementsByTagName("textarea");
					var pf = new window.placeholderFactory();
					pf.createPlaceholder(textareas);
					});
				}, 10);
		}

		function qErr(){
			
		}

		proSvc.queryPartyInstallDetail({id: $scope.qryProDetail.proId}, qSucc, qErr);
	};

	/* 项目修改 */
	$scope.updLoanApply = function(obj){
		if(obj.$valid){
			$scope.projectBean.atDistrictName = $('#district option:selected').text();
			$scope.projectBean.atCityName = $('#city option:selected').text();
			$scope.projectBean.atProvinceName = $('#province option:selected').text();

			/** 根据项目id，修改项目信息 begin */
			function qSucc3(rec){
				$scope.queryProjects(1);
				$('#EnterPriseModal').modal('hide');
				$.messager.popup("修改成功！");
			}
			function qErr3(rec){
				$('#EnterPriseModal').modal('hide');
				$.messager.popup(rec.data.message);
			}

			proSvc.updatePartyInstallDetail({id: $scope.projectBean.proId}, $scope.projectBean, qSucc3, qErr3);
		}
		else{
			if(!obj.code.$valid){
				$scope.showFlag = 'code';
				return;
			}
			else if(!obj.name.$valid){
				$scope.showFlag = 'name';
				return;
			}
			else if(!obj.contactsMobile.$valid){
				$scope.showFlag = 'contactsMobile';
				return;
			}
			else if(!obj.province.$valid){
				$scope.showFlag = 'proA';
				return;
			}
			else if(!obj.city.$valid){
				$scope.showFlag = 'citA';
				return;
			}
			else if(!obj.district.$valid){
				$scope.showFlag = 'disA';
				return;
			}
			else if(!obj.offAddr.$valid){
				$scope.showFlag = 'offAddr';
				return;
			}
		}
	};

	/* 关闭-项目添加/修改-模态框 */
	$scope.closeWindow = function(){
		//	清空市/区行政地区下拉框
		$scope.pListA = [];
		$scope.cListA = [];
	};

	/* 选择省时，改变市列表 */
	$scope.changeProA = function(){
		if($scope.projectBean.atProvince){
			/** 根据省id，查询市 - 地区信息 begin */
			function qSucc2(rec){
				$scope.pListA = rec;
				$scope.cListA = [];
			}
			function qErr2(rec){
				
			}

			regionSvc.queryRegionArea({regionId: $scope.projectBean.atProvince}, qSucc2, qErr2);
			/** 根据省id，查询市 - 地区信息 end */
		}
		else{
			$scope.pListA = [];
			$scope.cListA = [];
		}
	};

	/* 选择市时，改变区列表 */
	$scope.changeCityA = function(){
		if($scope.projectBean.atCity){
			/** 根据市id，查询区 - 地区信息 begin */
			function qSucc3(rec){
				setTimeout(function(){
					$scope.$apply(function(){
						$scope.cListA = rec;
					});
				},50);
			}
			function qErr3(rec){
				
			}

			regionSvc.queryRegionArea({regionId: $scope.projectBean.atCity}, qSucc3, qErr3);
			/** 根据市id，查询区 - 地区信息 end */
		}
		else{
			$scope.cListA = [];
		}
	};

	/* 弹出开工/完工模态框 */
	$scope.stateList = {};
	$scope.stopOrGoOn = function(){
		if(!$scope.qryProDetail.proId){
			$.messager.popup("请选择一条信息");
			return;
		}

		$scope.projectDetail = {};

		/** 根据项目id，查询项目详情 begin */
		function qSucc(rec){
			$scope.projectDetail = rec;

			$("#projectStateId").modal({backdrop: 'static', keyboard: false});
		}

		function qErr(){
			
		}

		proSvc.queryPartyInstallDetail({id: $scope.qryProDetail.proId}, qSucc, qErr);
		/** 根据项目id，查询项目详情 end */
	};

	/* 项目开工/完工 */
	$scope.opStAdmin = function(){
		function qSucc(rec){
			$scope.btnShowFlag = "初始化";
			$scope.queryProjects(1);
			$("#projectStateId").modal('hide');
			if($scope.projectDetail.state==2){
				$.messager.popup("启用成功");
			}
			else if($scope.projectDetail.state==0){
				$.messager.popup("停用成功");
			}
		}
		function qErr(){
			$("#projectStateId").modal('hide');
			$.messager.popup("提交失败");
			
		}
		proSvc.deletePartyInstallDetail({id: $scope.projectDetail.proId}, qSucc, qErr);
	};

	/* 关闭-项目开工/完工-模态框 */
	$scope.closeWindowState = function(){
		$("#projectStateId").modal('hide');
	};

});
