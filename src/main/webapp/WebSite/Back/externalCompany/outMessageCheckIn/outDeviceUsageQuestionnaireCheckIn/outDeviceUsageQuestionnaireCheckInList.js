app.controller('outDeviceUsageQuestionnaireCheckInListController', function($scope,$timeout,entSvc,published,busPublishHist) {
	

	$scope.userInfo={};
	$scope.userInfo.orgId=SYS_USER_INFO.orgId;
	$scope.userInfo.code=SYS_USER_INFO.orgCode;
	$scope.userInfo.Name=SYS_USER_INFO.orgName;
	$scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
	
	/**
	 *分页标签参数配置
	*/
	$scope.paginationConf = {
        currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 20,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [20, 30, 40, 50],
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        onChange:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	$scope.queryClick();
        	$scope.radioTrIndex=null;
        	/*if($scope.radioTrIndex==null){
        		$scope.parmDataId=null;
        	}
        	if($scope.queryClickVal==true){
        		 $scope.queryClick();
        	}else{
        		$scope.queryBusPublishHist();
        	}*/
        }
    };

	/**
	 *查询发布结果登记列表信息
	 */
	$scope.busPublishList=[];
    $scope.queryBusPublishHist = function(){
    	function qSucc(rec){
    		$scope.busPublishList=rec.content;
    		$scope.paginationConf.totalItems=rec.totalElements;
    		$scope.testFun();
    	}
    	function qErr(){}
    	busPublishHist.post({
    		pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
    	},qSucc,qErr);
    };
    
    /**
     *点击查询按钮查询发布结果登记 
     */
    $scope.state="";
    $scope.queryClick=function(){
    	$scope.queryClickVal=true;
    	function qSucc(rec){
    		$scope.parmDataId=null;
    		$scope.busPublishList=rec.content;
    		$scope.testFun();
    		$scope.paginationConf.totalItems=rec.totalElements;
    		if($scope.busPublishList.length==0){
    			$.messager.popup("没有符合条件的记录");
    		}
    	}
    	function qErr(){}
    	busPublishHist.post({
    		pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage,
    		state:$scope.queryData.dataState,									//流程状态，
    		startReleaseDate:$scope.queryData.beginDate,		//最小发布时间，
    		endReleaseDate:$scope.queryData.endDate				//最大发布时间
    	},qSucc,qErr);
    }

    /**
	 * 点击行查询发布结果登记列表信息
	 */
    $scope.queryPublishList=[];
   	$scope.queryBusPublishClick = function(){
    	if(!$scope.parmDataId){
			$.messager.popup("请选择一条记录");
			return;
		}
    	function qSucc(rec){
    		$scope.queryPublishList=rec.publishInfo;
    		$('#OutQueryId').modal({backdrop: 'static', keyboard: false});
    	}
    	function qErr(){}
    	busPublishHist.unifydo({ urlPath: $scope.parmDataId},qSucc,qErr);
    };
	
    /**
     * 选中订单ID
     */
    $scope.radioList={};
	$scope.check = function(params,varl){
		$scope.radioTrIndex=varl;
		$scope.parmDataId=params.dataId;
	};
    
	/**
	 * 点击行登记发布结果
	 */
    $scope.addPublishList=[];
   	$scope.addBusPublishClick = function(){
   		$scope.showFlag = '';
   		$scope.showFlag = '';
   		$scope.showFlag = '';
    	if(!$scope.parmDataId){
			$.messager.popup("请选择一条记录");
			return;
		}
    	function qSucc(rec){
    		$scope.addPublishList=rec.publishInfo;
    		if($scope.addPublishList.state==null){
    			$scope.addPublishList.state = 2;
    		}
    		if($scope.addPublishList.busState==null){
    			$scope.addPublishList.busState = ""; 
    		}
    		
    		$('#OutAddId').modal({backdrop: 'static', keyboard: false});
    		setTimeout(function() {
    		    $scope.$apply(function() {
    		    	var textareas = document.getElementsByTagName("textarea");
    		    	var pf=new window.placeholderFactory(); 
    		    	pf.createPlaceholder(textareas);
    		    	//document.getElementById("eeeee").value="asd";
    		    });  
    		}, 10);
    		
    	}
    	function qErr(){}
    	busPublishHist.unifydo({ urlPath: $scope.parmDataId},qSucc,qErr);
    	
    };
    /**
     *关闭模态框
     */
    $scope.closemodel=function(){
    	$scope.addPublishList.state='';
    	$scope.addPublishList.busState='';
    	$scope.addPublishList.depName='';
    	$scope.addPublishList.note='';
    	$scope.showFlag = '';
   		$scope.showFlag = '';
   		$scope.showFlag = '';
    }
    
    /**
     *提交保存登记 saveClick
     */
    $scope.saveClick=function(obj){
    	if(!obj.$valid){
    		if($scope.addPublishList.state == "" || $scope.addPublishList.state == null){
				$scope.showFlag = 'state';
				return;
			}else{
				$scope.showFlag = '';
			}
    		if($scope.addPublishList.busState == "" || $scope.addPublishList.busState == null){
				$scope.showFlag = 'busState';
				return;
			}else{
				$scope.showFlag = '';
			}
    		if(!obj.depName.$valid){
				$scope.showFlag = 'depName';
			}
    		return;
    	}else{
    		
    		function qSucc(rec){
    			$.messager.popup("保存成功");
    			$scope.queryClick();    			
    			$scope.queryBusPublishHist();   			
    			$("#OutAddId").modal('hide');
    			$scope.radioTrIndex=null;
    			$scope.parmDataId=null;
    			/*window.location.reload();*/
    		}
    		function qErr(){}
    		busPublishHist.put({ 
	    			id:$scope.addPublishList.id,
				dataId:$scope.addPublishList.dataId,
				 state:$scope.addPublishList.state,
			  busState:$scope.addPublishList.busState,
				  note:$scope.addPublishList.note,
			   depName:$scope.addPublishList.depName
			   
    		},qSucc,qErr);
    	}
    	
    	
    };
    

    $scope.blurInput = function(){
		$timeout(function() { // 延迟0.15秒这样能优先执行清除日期的方法达到赋值，要不点击会直接清除叉号不会执行清除日期的方法不能赋值 
			$scope.flagShow = false;
			$scope.LiNumA_ = false;
			$scope.KeyWordList = [];
	     },150);
	};
	
	
	     
	/**
	 * 获取当前日期的字符串表示形式
	 */
	$scope.queryData={}; 
	$scope.getNowDateStr=function()
	{
		var nowDate=new Date();
		year=nowDate.getFullYear();
		month=nowDate.getMonth()+1;
		day=nowDate.getDate();
		if(month<10){
			month="0"+month;
		}
		if(day<10){
			day="0"+day;
		}
	    var strDate=year+"-"+month+"-"+day;
	    
	    $scope.queryData.endDate = strDate;
	    
	}
	 
	/* $scope.getNowDateStr=function()
	{
		var nowDate=new Date(),
		year=nowDate.getFullYear(),
		month=nowDate.getMonth()+1,
		day=nowDate.getDate(), 
		month=month>10?month:"0"+month;
	    var strDate=year+"-"+month+"-"+day;
	    
	    $scope.queryData.endDate = strDate;
	    
	} */
	
	/**
	 * 获取当前日期三十天之前的时间
	 */
	$scope.getBeforeDate=function(){
		$scope.queryData.beginDate = getLastMonthYestdy(new Date());
	    $scope.limitEndDate("beginDateId");
	    $scope.limitEndDate("endDateId");
	    
	};
	/**
	 * 获得上个月在昨天这一天的日期   
	 */
	function getLastMonthYestdy(date){   
		var daysInMonth = new Array([0],[31],[28],[31],[30],[31],[30],[31],[31],[30],[31],[30],[31]);   
		var strYear = date.getFullYear();     
		var strDay = date.getDate();     
		var strMonth = date.getMonth()+1;   
		//判断是否是闰年
		if(strYear%4 == 0 && strYear%100 != 0)
		{   
		        daysInMonth[2] = 29;   
		}   
		//判断当前月是否本年的一月份
	     if(strMonth - 1 == 0)   
	     {   
	        strYear -= 1;   
	        strMonth = 12;   
	     }   
	     else  
	     {   
	        strMonth -= 1;   
	     }   
	    strDay = daysInMonth[strMonth] >= strDay ? strDay : daysInMonth[strMonth];   
	     if(strMonth<10)     
	     {     
	        strMonth="0"+strMonth;     
	     }   
	     if(strDay<10)     
	     {     
	        strDay="0"+strDay;     
	     }   
	     datastr = strYear+"-"+strMonth+"-"+strDay;   
	     return datastr;   
	  }  
	
	/**
	 * 限制日期空间的可选日期不能大于今天
	 */
	$scope.limitEndDate=function(dateId)
	{
		$('#beginDateId').datetimepicker({
			format: 'yyyy-mm-dd',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			endDate:new Date(),
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0,
			initialDate:$scope.queryData.beginDate
		});
	    
	    $('#endDateId').datetimepicker({
			format: 'yyyy-mm-dd',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			endDate:new Date(),
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0,
			initialDate:$scope.queryData.endDate
		});
	};
	
	//当点击第一个日期控件给第二个日期控件赋开始值
	$scope.complienStart = function (){
		$('#endDateId').datetimepicker('setStartDate', $scope.queryData.beginDate);
		return;
		
	};
	//当点击第二个日期控件给第一个日期控件赋结束值
	$scope.complienEnd = function (){
		$('#beginDateId').datetimepicker('setEndDate', $scope.queryData.endDate);
		return;
	
	};
	
	$("button").focus(function(){this.blur()});	
	
	
	
	$scope.flagStart = true; /* 叉号显示初始值赋值 */
	$scope.flagEnd = true; /* 叉号显示初始值赋值 */
	
	/* // 获取开始日期焦点 
	$scope.clickDateFunStart = function()
	{
		$scope.flagStart = true; // 点击出现叉号 
	}; */
	
	/* // 获取结束日期焦点 
	$scope.clickDateFunEnd = function()
	{
		$scope.flagEnd = true; // 点击出现叉号 
	}; */
	
	/* 清除开始日期 */
	$scope.saveStartBean = null;/* 用于保存开始日期初始值 */
	$scope.cleanDateFunStart = function()
	{
		$scope.saveStartBean = $scope.queryData.beginDate; /* 保存初始值  */
		/* $scope.flagStart = false; */ /* 清空叉号 */
		$scope.queryData.beginDate = null; /* 清空日期控件值 */
		document.getElementById("beginDateId").focus(); /* 光标定位回日期控件 */
	};
	
	/* 清除结束日期 */
	$scope.saveEndBean = null;/* 用于保存结束日期初始值 */
	$scope.cleanDateFunEnd = function()
	{
	    $scope.saveEndBean = $scope.queryData.endDate; /* 保存初始值  */
	    /* $scope.flagEnd = false; */ /* 清空叉号 */
	    $scope.queryData.endDate = null; /* 清空日期控件值 */
	    document.getElementById("endDateId").focus(); /* 光标定位回日期控件 */
	};
	
	/* // 失去焦点清除叉号 
	$scope.cleanFlagFunStart = function()
	{
		$timeout(function() { // 延迟0.1秒这样能优先执行清除日期的方法达到赋值，要不点击会直接清除叉号不会执行清除日期的方法不能赋值 
	      	 if($scope.flagStart==true){ // 如果叉号存在 
	   	    	$scope.flagStart = false; // 清除叉号 
	   	     }
	     },100);
			   
	};
	
	// 失去焦点清除叉号 
	$scope.cleanFlagFunEnd = function() // 同上 
	{
		$timeout(function() {
	      	 if($scope.flagEnd==true){
	   	    	$scope.flagEnd = false;
	   	     }
	     },100);
			   
	}; */
	
	
	$scope.openAdd = function(){
		$("#rentCheckAddId").modal({backdrop: 'static', keyboard: false});
	};
	
	
	$scope.openUpd = function(){
		$("#rentCheckUpdId").modal({backdrop: 'static', keyboard: false});
	};
	
	$scope.openQuery = function(){
		$("#rentCheckQueryId").modal({backdrop: 'static', keyboard: false});
	};
	
	$scope.KeyWordQuery = function(inputValue,showFlag,count_){/* 需要 */
		if(inputValue.length == 0){//如果输入框没有值了，就隐藏下面的展示结果域
			$scope[showFlag] = false;
		}
		$scope.KeyWordList=[];/* 需要 */

		function qSucc(rec){/* 需要 */
			if(rec.content.length<=0){/* 需要 */
				$scope[showFlag]=false;/* 需要 */
			}else{
				$scope[showFlag]=true;/* 需要 */
			/*($scope.formParms.busState == 2){
					
				}*/
				$scope.KeyWordList=rec.content;/* 需要 */
				$scope.KWList(rec.content,1);//字数超过9个后用...代替/
			}
		}
		function qErr(){}
		//根据传参数的不同决定action是什么
		var actionName = '';
		
		if(count_ == 'one'){
			 actionName = 'QueryEnts';
		}
		if(count_ == 'all'){
			actionName = 'QueEnts';
		}
		
		if(inputValue){
			entSvc.queryPartyInstallList({Action:actionName},{
				orgCode:"000",
				orgName:inputValue,
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.itemsPerPage
			},qSucc,qErr);
		}
	};
	
	$scope.searBean = {};
	$scope.InputShow = function(parm,searBean,infoTitleBean,LiNumA,currOrgId,id,subsidiaryId){/* 参数为点击的信息 */
		$scope.temporaryParame = '';
		if($scope.userInfo.orgLevel == 2){
			$scope.proListBureauCopy = [];
		}
		if(parm){
			$scope.addPublishList.depName = parm;
			$scope.temporaryParame = $scope.addPublishList.depName;//临时参数
			$scope[searBean][infoTitleBean] = parm;/* 需要 */
			$scope[searBean][id]=currOrgId;//这个值目前用于拿到登录中项目的id
			$scope[searBean][subsidiaryId] = currOrgId;//这个值用于子公司名称传值
			$scope[LiNumA] = false;
			if($scope.userInfo.orgLevel == 2){
				$scope.shouTableFun($scope.userInfo.orgId);
			}
			
			return;
		}
		
	};
$scope.testFun = function(){
		
		$scope.changeListValue($scope.busPublishList,'depName');
		$scope.changeListValueC($scope.busPublishList,'equNo');
		$scope.changeListValueA($scope.busPublishList,'asset');
		$scope.changeListValueB($scope.busPublishList,'equipmentName');
	};
	$scope.changeListValue = function(objList,obj){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i][obj]&&objList[i][obj].length>10)
			{
				objList[i][obj+'Temp']=objList[i][obj].substr(0,15)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
				
			}
			else
			{
				
				objList[i][obj+'Temp']=objList[i][obj];
				
			}
			
		}

	};	
	$scope.changeListValueA = function(objList,obj){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i][obj]&&objList[i][obj].length>9)
			{
				objList[i][obj+'Temp']=objList[i][obj].substr(0,6)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
				
			}
			else
			{
				
				objList[i][obj+'Temp']=objList[i][obj];
				
			}
			
		}

	};	
	$scope.changeListValueB = function(objList,obj){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i][obj]&&objList[i][obj].length>6)
			{
				objList[i][obj+'Temp']=objList[i][obj].substr(0,6)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
				
			}
			else
			{
				
				objList[i][obj+'Temp']=objList[i][obj];
				
			}
			
		}

	};	
	$scope.changeListValueC = function(objList,obj){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i][obj]&&objList[i][obj].length>6)
			{
				objList[i][obj+'Temp']=objList[i][obj].substr(0,5)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
				
			}
			else
			{
				
				objList[i][obj+'Temp']=objList[i][obj];
				
			}
			
		}

	};	
	$scope.KWList = function(val,obj){
		
		if(obj == 2){
			for(var i=0;i<val.length;i++){
				if(val[i].name.length > 9){
					$scope.KeyWordListAddOut[i].infoTitleA = val[i].name.substring(0,7)+"...";
	        	}else{
	        		$scope.KeyWordListAddOut[i].infoTitleA = val[i].name;
	        	}
			}
		}
		
		if(obj == 1){
			for(var i=0;i<val.length;i++){
				if(val[i].name.length > 9){
					$scope.KeyWordList[i].infoTitleA = val[i].name.substring(0,7)+"...";
	        	}else{
	        		$scope.KeyWordList[i].infoTitleA = val[i].name;
	        	}
			}
		}
		
		if(obj == 0){
			for(var i=0;i<val.length;i++){
				if(val[i].name.length > 9){
					$scope.KeyWordListAdd[i].infoTitleA = val[i].name.substring(0,7)+"...";
	        	}else{
	        		$scope.KeyWordListAdd[i].infoTitleA = val[i].name;
	        	}
			}
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
	
});
	/* function cleanDateFun()
	{
	    var saveEndBean = document.getElementById("endDateId").value;
	    document.getElementById("endDateId").value = null;
	    document.getElementById("endDateId").focus();
	} */