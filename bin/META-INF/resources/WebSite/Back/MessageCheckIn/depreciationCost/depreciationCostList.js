app.controller('DepreciationCostController', function($scope,$timeout,published,depreciationHist,entSvc,proSvc ) {
	
	
	//ie9下titile正确显示使用
	document.title="折旧费登记"
		
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
	
    /*$scope.orgId = $scope.userInfo.orgId;
	$scope.orgCode = $scope.userInfo.orgCode;
	$scope.orgName = $scope.userInfo.orgName;
	$scope.orgLevel = $scope.userInfo.orgLevel;*/

	$scope.equQryBean = {};
	$scope.equQryBean.isInclude = 0;
	$scope.equQryBean.isCrecOrg = 0;

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
	
	/* 初始化资源管理列表查询 */
	if($scope.userInfo.proId){/** 如果登录人员有项目，则当前单位显示项目信息，且不能选择单位/项目；列表显示该项目下的设备资源 */
		$scope.equQryBean.orgFlag = 3;
		$scope.equQryBean.orgPartyId = $scope.userInfo.proId;
		$scope.equQryBean.orgName = $scope.userInfo.proName;
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

	
	$scope.employers = [];
	$scope.queryEmployer = {};
	$scope.check = true;	//	项目选项 显示标志
	$scope.queryEmployer.check = false;	//	项目选项值
	$scope.checkTrEmployer = true;	//	列名称 - 单位名称 显示标志
	$scope.checkTrProjects = false;	//	列名称 - 项目名称 显示标志
	/* 打开 选择单位/项目模态框 */
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
			if(2==orgLv){
				$scope.checkTrProjects = true;
				$scope.checkTrEmployer = false;
				$scope.queryEmployer.check = true;
				$scope.check = false;

				/** 根据currOrgId，查询该组织下的项目 begin */
				function qSucc(rec){
					$scope.employerList = rec.content;
					$('#employerModel').modal('show');
				}
				function qErr(){
					
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
				function qSucc3(rec){
					$scope.employerList = rec.content;
					$('#employerModel').modal('show');
				}
				function qErr3(){
					
				}
				entSvc.queryPartyInstallList($scope.queryEmployer, qSucc3, qErr3);
				/** 根据currOrgId，查询该组织下的机构 end */
			}
		}
		else{//	非首次打开
			$('#employerModel').modal('show');
		}
	}
	
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
		function qErr(){
			
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
		function qErr(){
			
		}
		proSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
	};

	/* 变更并关闭 选择单位/项目模态框 */
	$scope.modifyEmployerModel = function(val){
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
	
	
	/*	$scope.employeeEntity= {};
		
		$scope.employeeEntity = {'equipmentPic': ''};//声明图片初始路径
		$scope.employeeEntity.isInclude = false;
		$scope.showLevel = null;
		$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
		$scope.employeeEntity.orgName_ = SYS_USER_INFO.orgName;//因为没有排除orgName在哪里使用，所以创建了orgName_用于点击时传当前单位属性
		$scope.employeeEntity.orgId_ = SYS_USER_INFO.orgId;
		$scope.employeeEntity.orgCode = SYS_USER_INFO.orgCode;
		if($scope.employeeEntity.orgName && $scope.orgLevel < 3){//控制包含下级的显示，当有当前单位和组织级别小于3的时候展示包含下级单位
			$scope.showLevel = true;
		}else if(!$scope.employeeEntity.orgName || $scope.orgLevel > 2){
			$scope.showLevel = false;
		}*/
		
	
	/**
	 *分页标签参数配置
	*/
	$scope.paginationConf = {
        currentPage:1,//当前页数
        totalItems:1,//数据总数
        itemsPerPage: 20,	//每页显示多少
        pagesLength: 10,		//分页标签数量显示
        perPageOptions: [20, 30, 40, 50],
        
        
        // * parm1:当前选择页数
        // * parm2:每页显示多少
        
        onChange:function(currentPage){
    		$scope.queryDepreciationHist(currentPage);
        	$scope.radioTrIndex=null;
        	$scope.save = false;
        }
    };
	
	$scope.check = function(params,varl){
		$scope.radioTrIndex=varl;
	};
	
	/**
	 *查询折旧费登记列表信息
	 */
	$scope.depreactionList=[];
    $scope.queryDepreciationHist = function(currentPage){
    	if(currentPage){
    		$scope.paginationConf.currentPage = currentPage;
    	}
    	if($scope.queryData.endDate){
			var str=$scope.queryData.endDate.toString().substring(0, 7);
		}
    	function qSucc(rec){
    		if(rec.content==null){
    			$scope.reveal = false;
    			$scope.depreactionList=[];
    			$.messager.popup("没有符合条件的记录");
    			return;
    		}else{
    			$scope.reveal = true;
    			$scope.depreactionList=rec.content;
    		}
    		$scope.paginationConf.totalItems=rec.totalElements;
    		if(rec.content!=null){
    		$scope.num=$scope.depreactionList.length;
    		
    		for(var i=0;i<$scope.depreactionList.length;i++){
				if($scope.depreactionList[i].asset!==null){
					if($scope.depreactionList[i].asset.length>10){
						$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset.substring(0,10)+"...";
					}else{
						$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset;
					}
				}
			}
    		
    		for(var i=0;i<$scope.depreactionList.length;i++){
				if($scope.depreactionList[i].equNo!==null){
					if($scope.depreactionList[i].equNo.length>10){
						$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo.substring(0,10)+"...";
					}else{
						$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo;
					}
				}
			}
    		
    		for(var i=0;i<$scope.depreactionList.length;i++){
				if($scope.depreactionList[i].equipmentName!==null){
					if($scope.depreactionList[i].equipmentName.length > 10){
						$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName.substring(0,10)+"...";
					}else{
						$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName;
					}
				}
			}
    		for(var i=0;i<$scope.depreactionList.length;i++){
				if($scope.depreactionList[i].brandName!==null){
					if($scope.depreactionList[i].brandName.length>7){
						$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName.substring(0,7)+"...";
					}else{
						$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName;
					}
				}
			}
    	
			for(var i=0;i<$scope.depreactionList.length;i++){
				$scope.formatMoney('depreactionList','depreciation',2,i);
				$scope.depreactionList[i].depreciation = $scope.depreactionList[i].depreciation;
			}
    		}
    	}
    	function qErr(rec){
    	}
    	if($scope.equQryBean.orgFlag==2){
    		$scope.equQryBean.isInclude = 0;
    	}
    	if($scope.equQryBean.orgFlag==3){
    		$scope.equQryBean.isInclude = 0;
    	}
    	depreciationHist.post({
    		pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage,
			isInclude:$scope.equQryBean.isInclude, 
			orgName:$scope.equQryBean.orgName,
			month:str,
			orgFlag:$scope.equQryBean.orgFlag,
			orgPartyId:$scope.equQryBean.orgPartyId,
			orgCode:$scope.equQryBean.orgCode
    	},qSucc,qErr);
    };
	
	/**
	 * 条件查询折旧费登记列表信息
	 */
    $scope.criteriaList={};
    $scope.criteriaVal=0;
    $scope.criteriaQueryDepreciationHist = function(pageNo){
    	$scope.criteriaVal=1;
    	if($scope.queryData.endDate){
			var str=$scope.queryData.endDate.toString().substring(0, 7);
		}
    	function qSucc(rec){
    		if(pageNo == 1){
    			$scope.paginationConf.currentPage=1;
    		}
    		
    		if(rec.content.length==0){
    			$scope.reveal = false;
    			$scope.depreactionList = [];
    			$.messager.popup("没有符合条件的记录");
    			return;
    		}else{
    			$scope.depreactionList=rec.content;
    			$scope.reveal = true;
    		}
    		
    		if(rec.content!=null){
        		$scope.num=$scope.depreactionList.length;
        		
        		for(var i=0;i<$scope.depreactionList.length;i++){
    				if($scope.depreactionList[i].asset!==null){
    					if($scope.depreactionList[i].asset.length>10){
    						$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset.substring(0,10)+"...";
    					}else{
    						$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset;
    					}
    				}
    			}
        		
        		
        		for(var i=0;i<$scope.depreactionList.length;i++){
    				if($scope.depreactionList[i].equNo!==null){
    					if($scope.depreactionList[i].equNo.length>10){
    						$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo.substring(0,10)+"...";
    					}else{
    						$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo;
    					}
    				}
    			}
        		
        		for(var i=0;i<$scope.depreactionList.length;i++){
    				if($scope.depreactionList[i].equipmentName!==null){
    					if($scope.depreactionList[i].equipmentName.length>10){
    						$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName.substring(0,10)+"...";
    					}else{
    						$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName;
    					}
    				}
    			}
        		for(var i=0;i<$scope.depreactionList.length;i++){
    				if($scope.depreactionList[i].brandName!==null){
    					if($scope.depreactionList[i].brandName.length>5){
    						$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName.substring(0,5)+"...";
    					}else{
    						$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName;
    					}
    				}
    			}
        		for(var i=0;i<$scope.depreactionList.length;i++){
    				if($scope.depreactionList[i].productionDate!==null){
    					if($scope.depreactionList[i].productionDate.length>5){
    						$scope.depreactionList[i].productionDateA = $scope.depreactionList[i].productionDate.substring(0,5)+"...";
    					}else{
    						$scope.depreactionList[i].productionDateA = $scope.depreactionList[i].productionDate;
    					}
    				}
    			}
        		
    			for(var i=0;i<$scope.depreactionList.length;i++){
    				$scope.formatMoney('depreactionList','depreciation',2,i);
    				$scope.depreactionList[i].depreciation = $scope.depreactionList[i].depreciation;
    			}
        		}
			/*if($scope.equQryBean.isInclude == 1){
				$scope.equQryBean.isInclude = true;
			}
			
			if($scope.equQryBean.isInclude == 0){
				$scope.equQryBean.isInclude = false;
			}
    		*/
    		$scope.paginationConf.totalItems=rec.totalElements;
    		if(rec.content!=null){
        		$scope.num=$scope.depreactionList.length;
        		
    			for(var i=0;i<$scope.depreactionList.length;i++){
    				$scope.formatMoney('depreactionList','depreciation',2,i);
    				$scope.depreactionList[i].depreciation = $scope.depreactionList[i].depreciation;
    			}
        		}
    		
    	}
    	function qErr(){}
    	
    	if($scope.equQryBean.orgFlag==2){
    		$scope.equQryBean.isInclude = 0;
    	}
    	if($scope.equQryBean.orgFlag==3){
    		$scope.equQryBean.isInclude = 0;
    	}
    	
    	depreciationHist.post({
    		'orgFlag':$scope.equQryBean.orgFlag,
    		'orgPartyId':$scope.equQryBean.orgPartyId,
    		pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage,
			isInclude:$scope.equQryBean.isInclude,
			month:str,
			//orgCode:$scope.equQryBean.isInclude,
			orgName:$scope.equQryBean.orgName
    	},qSucc,qErr);
    };
    
    
    /**
     * 保存按钮事件
     */
	$scope.saveClick=function(){
		$scope.save = true;
		if($scope.queryData.endDate){
			var str=$scope.queryData.endDate.toString().substring(0, 7);
		}

		function qSucc(rec){
			$scope.save = false;
			$.messager.popup(rec.msg);
			str="";					//登记月份
			$scope.queryDepreciationHist();
	}
		function qErr(){
			$scope.save = false;
		};
		
		for(var i=0;i<$scope.depreactionList.length;i++){
			if($scope.depreactionList[i].depreciation && $scope.depreactionList[i].depreciation.indexOf(",") && $scope.depreactionList[i].depreciation.indexOf(",") > 0){
				$scope.depreactionList[i].depreciation=$scope.depreactionList[i].depreciation.toString().replace(/\,/g,'');
			}
		}
		depreciationHist.post({Action:"AddOrUpd"},{
		
			bdhbtList:$scope.depreactionList,
			month_:str
		},qSucc,qErr);
		
	};
	$scope.param={};	
	/**
	 * 获取当前日期的字符串表示形式
	 */
	$scope.queryData={};
	$scope.getNowDateStr=function()
	{
		var nowDate=new Date();
		year=nowDate.getFullYear();
		month = nowDate.getMonth()+1;
		month1=nowDate.getMonth()+3;
		//day=nowDate.getDate();
		if(month<10){
			month="0"+month;
		}
		/*if(day<10){
			day="0"+day;
		}*/
	    var strDate=year+"-"+month1;//+"-"+day
	    var endDate = year+"-"+month;
	    $scope.queryData.endDate = endDate;
	    $('#endDateId').datetimepicker('setEndDate', strDate);
	    //$scope.param = {date:strDate};
	}
	$("button").focus(function(){this.blur()});	
	
	
	$scope.flagEnd = true; /* 叉号显示初始值赋值 */
	
	
	/* 清除结束日期 */
	$scope.saveEndBean = null;/* 用于保存结束日期初始值 */
	$scope.cleanDateFunEnd = function()
	{
	    $scope.saveEndBean = $scope.queryData.endDate; /* 保存初始值  */
	    /* $scope.flagEnd = false; */ /* 清空叉号 */
	    $scope.queryData.endDate = null; /* 清空日期控件值 */
	    document.getElementById("endDateId").focus(); /* 光标定位回日期控件 */
	};
	
	
	
	$scope.openAdd = function(){
		$("#depreciationAddId").modal({backdrop: 'static', keyboard: false});
	};
	
	
	$scope.openUpd = function(){
		$("#depreciationUpdId").modal({backdrop: 'static', keyboard: false});
	};
	
	$scope.openQuery = function(){
		$("#depreciationQueryId").modal({backdrop: 'static', keyboard: false});
	};

	/*
	*input框ng-change事件
	*/
	/*$scope.KeyWordQuery = function(inputValue,showFlag){ 需要 
		if(inputValue.length == 0){//如果输入框没有值了，就隐藏下面的展示结果域
			$scope[showFlag] = false;
		}
		$scope.KeyWordList=[]; 需要 

		if($scope.employeeEntity.orgName.length < 1){
			$scope.showLevel = false;
			$scope.employeeEntity.isInclude = false;//复选框控制
		}
		
		function qSucc(rec){ 需要 
			if(rec.content.length<=0){ 需要 
				$scope[showFlag]=false; 需要 
			}else{
				$scope[showFlag]=true; 需要 
				$scope.KeyWordList=rec.content; 需要 
				for(var i=0;i<$scope.KeyWordList.length;i++){
					if(inputValue == $scope.KeyWordList[i].name){
						$scope.changeOrgCode_ = $scope.KeyWordList[i].code;//如果查询的有对应的名字就把code赋值给查询的code（此code同时也是点击赋值的code）
						if($scope.KeyWordList[i].orgLevel < 3){
							$scope.showLevel = true;
						}else{
							$scope.showLevel = false;
						}
						break;
					}else{
						$scope.changeOrgCode_ = $scope.KeyWordList[i].name;
						$scope.showLevel = false;
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
	};*/
	
	
	/*
	*点击搜索下拉框定位显示在input
	*/
	/*$scope.searBean = {};
	$scope.InputShow = function(parm,searBean,infoTitleBean,LiNumA,level,id,changeOrgId,code,codeName){//点击的值，scope后的属性名，属性名后的属性名，LiNumA为显示下方的flag，level为组织级别，
		if(parm){
			$scope[searBean][infoTitleBean] = parm; 需要 
			$scope[searBean][changeOrgId] = id;//保存被点选的单位的id备用
			$scope.changeOrgCode_ = code;
			if(level > 2){//如果选择的当前单位的级别高于2也就是是处级
				$scope.showLevel = false;//根据组织级别控制是否有显示下级的复选框，2以上为处级也就是没有下级不显示复选框
				$scope.employeeEntity.isInclude = false;//复选框控制
			} 
			if(level < 3){//如果不是处级，也就是有下级企业
				$scope.showLevel = true;//显示包含下级单位复选框
			}
			$scope[LiNumA] = false;//隐藏点选后的下拉框
			$scope.orgLevel_show=level;
			return;
		}
		
	};*/
	
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
	
	/**
	 * 每三位数字添加一个逗号分隔符号
	 */

	$scope.centsCopyFive = '';
	$scope.formatMoney=function(list_,obj2_,counts,this_){//参数分别是：num=输入值，parm=属性,flag=区分添加和修改的符号，counts=小数点最多几位
			$scope.numsArray_ = [];
		
		
		    $scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
		
			if($scope[list_][this_][obj2_]==null||$scope[list_][this_][obj2_]==""){//首先确定输入的有值
				return;
			}else{
				$scope[list_][this_][obj2_]=$scope[list_][this_][obj2_].toString();//把原值字符串话，因为数据库存的是大类型，只有字符串话才能切割（用于登记的时候重新加上逗号）
				$scope.numsArray_=$scope[list_][this_][obj2_].split("");//把输入的字符变成数组用于判断其中点的数目
			}
			
			for(var i=0;i<$scope[list_][this_].length;i++){//数值第一位不能是0，是0就返回0
				if($scope[list_][this_][0] == 0){
					//$scope.mess[parm] = 0;
					$scope[list_][this_][obj2_]=0;
					return ;
				}
				
			}
			
			for(var i=0;i<$scope.numsArray_.length;i++){//不能有2个以上的小数点否则为0
				if($scope.numsArray_[i] == '.'){
					$scope.test_.push($scope.numsArray_[i]);
					if($scope.test_.length>1){
						$scope[list_][this_][obj2_] = 0;
						return;
					}
				}
			}
			
			//检索点号的位置或者说是否有点号
			var judge = $scope[list_][this_][obj2_].indexOf(".");
			var cents='';//包括小数点之后
			var centsCopy =0;//不包括小数点之后
			
			//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
			if(judge>0){
				cents = $scope[list_][this_][obj2_].substring(judge, $scope[list_][this_][obj2_].length);//包括点开始截取到完结
				centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
				$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].substring(0,judge);//截取（不包括点）点之前的数字
				
				if(centsCopy.length == counts){//当小数点后面的位数达到软需要求时记录数值,counts是方法传入的参数也就是要求小数点最多几位
					$scope.centsCopyFive = centsCopy;//$scope.centsCopyFive为一个记录对象，记录当满足小数点要求时，这个时候小数点后的数字是什么，用于下面的赋值
				}
				
				if(centsCopy.length> counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
					cents = '.'+$scope.centsCopyFive;
				}
			}
			
			$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].toString().replace(/\,/g,'');//全局匹配有没有逗号，有就清除，用于清除上次的逗号在进行排版
			//如果num不是数字就赋值为0   这个不完美如果小数点后有字母不为0
			if(isNaN($scope[list_][this_][obj2_])){
				$scope[list_][this_][obj2_] = "0";
			}
		
			if(isNaN(centsCopy)){//如果小数点后面的值有不为数字的字符就把小数点之前的置为0，包括小数点之后的字符为空，这样起到如果有不为数字的字符就为0
				$scope[list_][this_][obj2_] = "0";
 				cents = "";
 			}
			
			for (var i = 0; i < Math.floor(($scope[list_][this_][obj2_].length-(1+i))/3); i++){
				$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].substring(0,$scope[list_][this_][obj2_].length-(4*i+3))+','+$scope[list_][this_][obj2_].substring($scope[list_][this_][obj2_].length-(4*i+3));
			}
			//如果有小数点算上小数点赋值
			if(cents.length!=0){
				$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_]+cents;
				if($scope[list_][this_][obj2_].length > 18){
					$scope[list_][this_][obj2_] = 0;
				}
			}else{
				$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_];
				if($scope[list_][this_][obj2_].length > 18){
					$scope[list_][this_][obj2_] = 0;
				}
			}
		
	};
	
	/**
	 * 以下为12.29日编写的有关输入框叉号的一系列方法，其中包括：点击叉号清除输入框值焦点定位到输入框、点击输入框判断如果输入框有值就显示叉号，没有就清空、失去焦点推迟0.15秒失去叉号这样可以保证失去焦点的时候不会叉号直接就被清空了来不及点
	 * 顺序按照上面的描述排序
	 */
	$scope.flagShow = false;
	
	$scope.cleanDateFunEnd = function(){
		$scope.equQryBean.orgName = '';
		$("#searchContent").focus();
		$scope.flagShow = false;
		if($scope.LiNumA == true){
			$scope.LiNumA = false;
		}
	};
	
	$scope.clickInput = function(obj){
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
		
		if($scope.equQryBean.orgName == ''){//失去焦点时如果当前单位是空的默认查询当前登录人信息
			$scope.equQryBean.orgName = SYS_USER_INFO.orgName;
			
			$scope.equQryBean.code=SYS_USER_INFO.orgCode;
			$scope.equQryBean.OrgId = SYS_USER_INFO.orgId;
			
			if(SYS_USER_INFO.orgLevel == 2){
				$scope.showLevel = true;
			}          
			
			if(SYS_USER_INFO.orgLevel == 1){
				$scope.showLevel = true;
			}
			
			if(SYS_USER_INFO.orgLevel == 3){
				$scope.showLevel = false;
			}
		}
	};
	
});
