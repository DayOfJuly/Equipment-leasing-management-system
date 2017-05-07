<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>已发布的信息</title>
<link rel="stylesheet"  type="text/css" href="../../../media/css/home.css">
<jsp:include page="../../Front/Include/Head.jsp" />

<jsp:include page="../../Front/conmmon/publicSession.jsp" />
<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
<!-- <link href="../../../media/css/bootstrapAfter.css" rel="stylesheet" type="text/css" /> -->
<!-- <script src="../../../media/js/lrtk.js" type="text/javascript"></script> -->
<script language="javascript" type="text/javascript" src="../../../media/js/ss.js"></script><!--左右GUNDONG-->
<script type="text/javascript" src="../../../js/JsLib/chinesepyi.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../../media/js/pagination.js"></script>
<script type="text/javascript" src="../../../js/JsLib/angular-sanitize.min.js"></script>
<script type="text/javascript" src="../../../js/userJs/useCookie.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/SysCodeConfig.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/SysCodeTranslate.js"></script>

<script type="text/javascript" src="../../../media/js/tm.paginations.js"></script>
<script type="text/javascript">
var app = angular.module('searchApp',['ngResource','unifyModule','tm.paginations','ngSanitize','Config','sysCodeConfigModule','sysCodeTranslateModule']);
app.controller('searchController',function($scope,entSvc,busDealInfo,$timeout,proSvc,busPublishHist,busPublishInfo,rentSvc,SaleSvc,SYS_CODE_CON,sysCodeTranslateFactory,DemandRentSvc,DemandSaleSvc,published,busAuditSvc){
	
	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
	    
	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	
	/*
	*分页标签参数配置
	*/
	$scope.paginationConf = {
		currentPage: 1,		/*当前页数*/
        totalItems: 1,		/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10, 15, 20, 30, 50],
        onChange : function(parm1){
        	$scope.paginationConf.currentPage = parm1;
        if($scope.dataTypeName || $scope.dataStateName){
        		$scope.searchPublish();
        	}else{
        		$scope.searchPublish();
        	}  
        }
	};
	
	/*
	*分页标签参数配置
	*/
	$scope.paginationConfb = {
		currentPage: 1,		/*当前页数*/
        totalItems: 1,		/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10, 15, 20, 30, 50],
        onChange : function(parm1){
        	$scope.paginationConf.currentPage = parm1;
		}
	};
	
	
	$scope.flagStart = true; /* 叉号显示初始值赋值 */
	$scope.flagEnd = true; /* 叉号显示初始值赋值 */
	 $scope.testFun = function(){			
			$scope.changeListValue2($scope.publishList,'infoTitle');
			$scope.changeListValue($scope.publishList,'releaseDate');
	};
	
	$scope.queryPublish=function(){
		function qSucc(rec){
			$scope.publishList=rec.content;
			$scope.testFun();
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){} 
		busPublishInfo.post({
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
		},qSucc,qErr);
	}
	
	/*
	*复用的替换关键字方法
	*/
	$scope.searBean={};
	$scope.changeListTitleFun = function(resultList,fontColorObj)/* 传入数值的集合，改变颜色后的数值 */
	{
		for(var i=0;i<resultList.length;i++)/* 遍历数值集合，把每个值和输入的值匹配 */
		{
			if($scope.searBean.infoTitleBean)/* 如果有输入的值 */
			{
				var ib=$scope.searBean.infoTitleBean;/* 把输入的值放入一个变量 */
				var reg=new RegExp(ib,"g");/* 用js中的正则方法去格式化输入的值，因为直接在replace中用replace独有的格式化方式是无法实现格式变量的，浏览器不识别 */   
				resultList[i].infoTitleTemp=resultList[i].infoTitleTemp.replace(reg,fontColorObj);/* 将格式好的输入值和改变后需要展现的值用replace替换，达到如果这个集合有输入框输入的值，就把输入值替换成改变后有颜色的值，然后在赋值给原值，因为会产生一个新对象(replace方法规则)*/	
			}
		} 
		return  resultList;/* 返回改变好的集合 */
	};
	
	/*
	 * 获取当前日期的字符串表示形式
	 */
	$scope.condition = {};
	$scope.getNowDateStr=function()
	{
		var nowDate=new Date(),
		year=nowDate.getFullYear(),
		month=nowDate.getMonth()+1,
		day=nowDate.getDate(), 
		month=month>10?month:"0"+month;
		if(day<10){
			day="0"+day;
		}
	    var strDate=year+"-"+month+"-"+day;
	    
	    $scope.condition.endDate = strDate;
	};
	
	/*
	 * 获取当前日期三十天之前的时间
	 */
	$scope.getBeforeDate=function(){
		$scope.condition.beginDate = getLastMonthYestdy(new Date());
	    $scope.limitEndDate("beginDateId");
	    $scope.limitEndDate("endDateId");
	    
	};
	
	/*
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
	};  

	/*
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
				initialDate:$scope.condition.beginDate
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
				initialDate:$scope.condition.endDate
			});
		    
	};

	//当点击第一个日期控件给第二个日期控件赋开始值
	$scope.complienStart = function (){
		$('#endDateId').datetimepicker('setStartDate', $scope.condition.beginDate);
		return;
		
	};
	//当点击第二个日期控件给第一个日期控件赋结束值
	$scope.complienEnd = function (){
		$('#beginDateId').datetimepicker('setEndDate', $scope.condition.endDate);
		return;

	};
	$scope.cleanDateFunStart = function()
	{
		$scope.saveStartBean = $scope.condition.beginDate; /* 保存初始值  */
		/* $scope.flagStart = false; */ /* 清空叉号 */
		$scope.condition.beginDate = null; /* 清空日期控件值 */
		document.getElementById("beginDateId").focus(); /* 光标定位回日期控件 */
	};
	$scope.cleanDateFunEnd = function()
	{
	    $scope.saveEndBean = $scope.condition.endDate; /* 保存初始值  */
	    /* $scope.flagEnd = false; */ /* 清空叉号 */
	    $scope.condition.endDate = null; /* 清空日期控件值 */
	    document.getElementById("endDateId").focus(); /* 光标定位回日期控件 */
	};
	
	/*
	 * 鼠标移除事件
	 */
	$scope.BeginOut = function(){
		if($scope.condition.beginDate.length == 0){
			$scope.getBeforeDate();
		}
	};
	
	/*
	 * 鼠标移除事件
	 */
	$scope.today={};
	$scope.EndOut = function(){
		if($scope.condition.endDate.length == 0){
			var year = new Date().getFullYear(); //年
			var month = new Date().getMonth() + 1; //月
			var day = new Date().getDate(); //日
			 $scope.condition.endDate=year+"-"+month+"-"+day;
		}
	};
	
	/*
	 * 点击行选中radio
	 */
	$scope.radioList={};
	//选中订单ID
	$scope.check = function(params,varl){
		$scope.radioTrIndex=varl;
		$scope.selectObj(params.loginId);
	}; 
	
	/*
	*查询
	*/
	$scope.outDiv = false;
	$scope.sarchPublishClick=function(type,state){	
		$scope.dataTypeName = type;
		$scope.dataStateName = state;
		function qSucc(rec){
			if(!rec.content){
				$.messager.popup("没有符合条件的记录");
				$scope.publishList = [];
				$scope.outDiv = true;
				return;
			}
			if(rec.content){
				$scope.publishList=rec.content;
				$scope.outDiv = false;
			}
			$scope.testFun();
			$scope.paginationConf.totalItems=rec.totalElements;
			
		}
		function qErr(rec){} 
		if($scope.condition.beginDate && $scope.condition.endDate){
		busPublishInfo.post({
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage,
			dataType:$scope.dataTypeName,
			dataState:$scope.dataStateName,
			startReleaseDate:$scope.condition.beginDate,
			endReleaseDate: $scope.condition.endDate
		},qSucc,qErr);
		}else{
			busPublishInfo.post({
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.itemsPerPage,
				dataType:$scope.dataTypeName,
				dataState:$scope.dataStateName,
			},qSucc,qErr);
		}
	};
	
	$scope.changeListValue = function(objList,obj){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i][obj]&&objList[i][obj].length>7)
			{
				objList[i][obj+'Temp']=objList[i][obj].substr(0,10)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
				
			}
			else
			{
				
				objList[i][obj+'Temp']=objList[i][obj];
				
			}
			
		}

	};	
	$scope.changeListValue2 = function(objList,obj){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i][obj]&&objList[i][obj].length>25)
			{
				objList[i][obj+'Temp']=objList[i][obj].substr(0,25)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
				
			}
			else
			{
				
				objList[i][obj+'Temp']=objList[i][obj];
				
			}
			
		}

	};	
	$scope.searchPublish=function(pageNo){
		if(pageNo == 1){
			$scope.paginationConf.currentPage = 1;
		}
		function qSucc(rec){
			if(rec.content.length==0){
				$.messager.popup("没有符合条件的记录");
			}
			$scope.publishList=rec.content;
			$scope.testFun();
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){} 
		busPublishInfo.post({
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage,
			dataType:$scope.dataTypeName,
			dataState:$scope.dataStateName,
			startReleaseDate:$scope.condition.beginDate,
			endReleaseDate: $scope.condition.endDate
		},qSucc,qErr);
	}
	
	//拒绝原因
	$scope.queryError=function(param){
	        $scope.message="";
 			function qSucc3(rec){
 				$scope.formParms=rec.auditInfo;
 				$scope.queryAudit = rec.refuseReasons;
 				for(i=0;i<$scope.queryAudit.length;i++){
 					$scope.message += $scope.queryAudit[i].reasonNote+"\n";
 				}
 				return;
 			}
 			function qErr3(rec){}
 			
 			
 			busPublishInfo.unifydo({Action:"GetAduitInfo",urlPath:param},qSucc3,qErr3);	
			
 		}
	
	
	/*
	*刷新
	*/
	$scope.refPublish=function(parm){
		function qSucc(rec){
			$scope.publishList=rec.content;
			$scope.paginationConf.currentPage=1;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(){} 
		busPublishInfo.unifydo({
			id:parm
		},qSucc,qErr);
	};
	
	/*
	*修改
	*/
	$scope.updPublish=function(val){
 		if(val.dataType == 1){
 			window.open("../Publish/Infopub.jsp?id="+val.dataId+"&infoType=1");
 		}else if(val.dataType == 2){
 			window.open("../Publish/InfopubSale.jsp?id="+val.dataId+"&infoType=2");
 		}else if(val.dataType == 3){
 			window.open("../Publish/DemandInfoPub.jsp?id="+val.dataId+"&infoType=3");
 		}else if(val.dataType == 4){
 			window.open("../Publish/DemandInfoPubShop.jsp?id="+val.dataId+"&infoType=4");
		}
	};
	
	$scope.titleopen=function(val){
		if(val.dataType == 1){
 			window.open("../Publish/ViewInfo.jsp?id="+val.dataId+"&infoType=1");
 		}else if(val.dataType == 2){
 			window.open("../Publish/ViewInfo.jsp?id="+val.dataId+"&infoType=2");
 		}else if(val.dataType == 3){
 			window.open("../Publish/ViewDemandRentInfo.jsp?id="+val.dataId+"&infoType=3");
 		}else if(val.dataType == 4){
 			window.open("../Publish/ViewDemandSaleInfo.jsp?id="+val.dataId+"&infoType=4");
		}
	}
	
	
	/*
	*删除
	*/
	$scope.delPublish=function(parm){
		$.messager.confirm("提示", "是否删除？", function() { 
		function qSucc(rec){
			$scope.publishList=rec.content;
			$scope.paginationConf.currentPage=1;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(){} 
		busPublishInfo.del({
			urlPath:parm
		},qSucc,qErr); 
		})
	};
	
	$scope.userInfo={};
	$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
	$scope.userInfo.orgId = SYS_USER_INFO.orgId;
	$scope.userInfo.orgCode = SYS_USER_INFO.orgCode;
	$scope.userInfo.orgName = SYS_USER_INFO.orgName;
	$scope.userInfo.proId = SYS_USER_INFO.proId;
	$scope.userInfo.proName = SYS_USER_INFO.proName;
	$scope.userInfo.orgParTypeId = SYS_USER_INFO.orgParTypeId;

	$scope.KeyWordQueryPublish = function(inputValue,showFlag,count_){/* 需要 */
		if(inputValue.length == 0){//如果输入框没有值了，就隐藏下面的展示结果域
			$scope[showFlag] = false;
		}
		$scope.KeyWordList=[];/* 需要 */

		function qSucc(rec){/* 需要 */
			if(rec.content.length<=0){/* 需要 */
				$scope[showFlag]=false;/* 需要 */
			}else{
				$scope[showFlag]=true;/* 需要 */
			/*	if($scope.formParms.busState == 2){
					
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
				orgCode:"000000",
				orgName:inputValue,
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.itemsPerPage
			},qSucc,qErr);
		}
	};
	
	 /**
     *提交保存登记 saveClick
     */
    $scope.saveClick=function(obj){
    		if($scope.addPublishList.state == "" || $scope.addPublishList.state == null){
				$scope.showFlag = 'state';
				$.messager.popup("请选择交易状态 ");
				return;
			}else{
				$scope.showFlag = '';
			}
    		
    		if($scope.addPublishList.state!="3"){
    			
	    		if($scope.addPublishList.busState == "" || $scope.addPublishList.busState == null){
					$scope.showFlag = 'busState';
					$.messager.popup("请选择成交单位类型");
					return;
				}
	    		if($scope.equQryBean.orgName){
	    			$scope.addPublishList.depName = $scope.equQryBean.orgName;
	    			if(!$scope.addPublishList.depName){
	    				$scope.showFlag = 'depName';
	    				$.messager.popup("设备成交单位不能为空，请添加");
	    				return;
	    			}
	    		}else if(!$scope.addPublishList.depName){
	    			$scope.showFlag = 'depName';
	    			$.messager.popup("设备成交单位不能为空，请添加");
	    			return;
	    		}
    		}
    		function qSucc(rec){
    			$.messager.popup("保存成功");
    			
    			$("#publishBackModal").modal('hide');
    			$scope.radioTrIndex=null;
    			$scope.parmDataId=null;
    			window.location.reload();
    		}
    		function qErr(){}
    		if($scope.addPublishList.forecastSum==""||$scope.addPublishList.forecastSum==null){
    		
    		}else{
    			$scope.addPublishList.forecastSum=$scope.addPublishList.forecastSum.toString().replace(/\,/g,'');/*期望金额分隔符去掉处理*/
    		}
    		busPublishHist.put({ 
	    			id:$scope.addPublishList.id,
				dataId:$scope.addPublishList.dataId,
				 state:$scope.addPublishList.state,
			  busState:$scope.addPublishList.busState,
				  note:$scope.addPublishList.note,
			   depName:$scope.addPublishList.depName,
			   forecastSum:$scope.addPublishList.forecastSum
    		},qSucc,qErr);
    	
    	
    	
    };
	
	
	 $scope.blurInputPublish = function(){
			$timeout(function() { // 延迟0.15秒这样能优先执行清除日期的方法达到赋值，要不点击会直接清除叉号不会执行清除日期的方法不能赋值 
				$scope.flagShow = false;
				$scope.LiNumA_ = false;
				$scope.KeyWordList = [];
		     },150);
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
		
	$scope.dis={};
	$scope.dis = false;
	$scope.addPublishList = {};
	//发布结果登记 
	$scope.addPublish = function(publishObj){
		
		function qSucc(rec){
			$scope.addPublishList = rec.publishInfo;
			if($scope.addPublishList.state==1){
				$scope.addPublishList.state = "1";
			}
			if($scope.addPublishList.state==2){
				$scope.addPublishList.state = "";
			}
			if($scope.addPublishList.state==3){
				$scope.addPublishList.state = "3";
				$scope.show=1;
			}
   			$scope.name = 1;
   			$scope.dis= false;	//控制交易状态是否可选
   			$scope.addPublishList.forecastSum = $scope.ct.formatCurrency($scope.addPublishList.forecastSum);
    		if(rec.publishInfo!==null){
        		if($scope.addPublishList.busState==null){
        			if($scope.userInfo.orgParTypeId==8){//如果是外单位，成交单位类型默认为外单位且不可选
        				$scope.addPublishList.busState ='5'; 
        				$scope.type = true;
        			}else{//如果是中铁内部的，则可选
        				$scope.addPublishList.busState =""; 
        				$scope.type = false;
        			}        			
        			$scope.sh = false;//控制所在单位的弹出框的按钮是否显示
        		}else{
        			if($scope.addPublishList.busState==5){
        				$scope.sh = false;
        			}else{
        				$scope.sh = true;
        			}
        			
        			$scope.dis= true;
        		}
    		}else{
    			$.messager.popup("暂无设备信息！");
    			return;
    		}
    		
    		$('#publishBackModal').modal({backdrop: 'static', keyboard: false});
    		
    		setTimeout(function() {
    		    $scope.$apply(function() {
    		    	var textareas = document.getElementsByTagName("textarea");
    		    	var pf=new window.placeholderFactory(); 
    		    	pf.createPlaceholder(textareas);
    		    });  
    		}, 10);

    	}
		
    	function qErr(){}
    	
    	busPublishHist.unifydo({ urlPath: publishObj.dataId},qSucc,qErr);
		
	}
	 /**
     *关闭发布结果登记模态框
     */
    $scope.closemodel=function(){
		$scope.show=2;
    	$scope.addPublishList.state='';
    	$scope.addPublishList.busState='';
    	$scope.addPublishList.depName='';
    	$scope.addPublishList.note='';
    	$scope.addPublishList.forecastSum='';
   		$("#publishBackModal").modal('hide');
    }
	 //详细信息 
	$scope.busDealInfoSearchBean = {};
	$scope.businessMessageModel = function(pram){
		$scope.equState = pram.equState;
		function qSucc(rec){
			$scope.businessList = rec.content;
			$scope.paginationConfb.totalItems = rec.totalElements;
			if(rec.content==""){
				$.messager.popup("暂时没有客户操作【我想交易】！");
				return;
			}else{
				$('#businessMessageModel').modal({backdrop: 'static', keyboard: false});
			}
			
		}
		
		function qErr(){
			
		}
		$scope.busDealInfoSearchBean.dataId = pram.dataId;
		$scope.busDealInfoSearchBean.pageNo = 0;
		$scope.busDealInfoSearchBean.pageSize = 99;
		busDealInfo.post({action:"GET_BUS_DEAL_INFOS"},$scope.busDealInfoSearchBean,qSucc,qErr);
		
		
		function qSuc(rec){
			
    		$scope.addPublishList=rec.publishInfo;
    		
    		if(rec.publishInfo!==null){
    			if($scope.addPublishList.state==null){
        			$scope.addPublishList.state = 2;
        		}
        		
        		if($scope.addPublishList.busState==null){
        			$scope.addPublishList.busState = ""; 
        		}
    		}
    		
    		setTimeout(function() {
    		    $scope.$apply(function() {
    		    	var textareas = document.getElementsByTagName("textarea");
    		    	var pf=new window.placeholderFactory(); 
    		    	pf.createPlaceholder(textareas);
    		    	//document.getElementById("eeeee").value="asd";
    		    });  
    		}, 10);
    		
    	}
    	function qEr(){}
    	busPublishHist.unifydo({ urlPath: pram.dataId},qSuc,qEr);
		
		
	}
	
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
	
	$scope.equQryBean = {};
	$scope.equQryBean.isInclude = 0;
	$scope.equQryBean.isCrecOrg = 0;
	$scope.parentOrg={};
	$scope.MessageBack = function(currOrgId){//传入参数为在返回上一级按钮出现之前点击的企业id（这个id是每次点击展示下一级企业时手动存储的）
		function qSucc(rec){	
			$scope.parentOrg= rec;
		}
		function qErr(rec){}
		entSvc.queryPartyInstallDetail({id:SYS_USER_INFO.orgId},qSucc,qErr);
	};
	
	$scope.MessageBack();
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

	$scope.suerClick =function(suer){
		$scope.employers=[];
		if(suer==3){
			//局内
			$scope.sh = true;
			$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
			$scope.userInfo.orgId = SYS_USER_INFO.orgId;
			$scope.userInfo.orgName = SYS_USER_INFO.orgName;
			
		}else if(suer==4){//局外
			$scope.sh = true;
			$scope.userInfo.orgLevel = 1;
			$scope.userInfo.orgId = 1;
			$scope.userInfo.orgName = "总公司";
			
		}else{
			//外单位
			$scope.sh = false;
			$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
			$scope.userInfo.orgId = SYS_USER_INFO.orgId;
			$scope.userInfo.orgName = SYS_USER_INFO.orgName;
		}
	}
	
	
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
				orgLv = 9;//总公司
			}
			else if(2==$scope.userInfo.orgLevel){
				orgLv = 1;//局
			}
			else if(3==$scope.userInfo.orgLevel){
				orgLv = 2;//处
			}

			$scope.queryEmployer.currOrgId = $scope.userInfo.orgId;

			/** 放入单位信息，且查询该组织下的机构/项目 */
			$scope.employers = [{name: $scope.userInfo.orgName, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

			if(2==orgLv){//当前登录人是处级单位的人员时
				$scope.checkTrProjects = true;
				$scope.checkTrEmployer = false;
				$scope.queryEmployer.check = false;
				$scope.check = true;
				//查询上级单位ID
				/** 根据currOrgId，查询该组织下的项目 begin */
				function qSucc(rec){
					$scope.employerList = rec.content;
					$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
					$('#employerModel').modal('show');
				}
				function qErr(){
					
				}
				
				$scope.queryEmployer.currOrgId = $scope.parentOrg.parentOrgId;//当登录人是处级单位的人员，并且选择了局内时，查询的是局内所有的单位
				$scope.employers = [{name: $scope.parentOrg.parentOrgName, currOrgId: $scope.parentOrg.parentOrgId, orgFlag: 1}];
// 				proSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
				entSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);	
				/** 根据currOrgId，查询该组织下的项目 end */
				}
			else{
				$scope.checkTrProjects = false;
				$scope.checkTrEmployer = true;
				$scope.queryEmployer.check = false;
				$scope.check = true;

				if($scope.userInfo.orgLevel == 1 && SYS_USER_INFO.orgLevel==2){//局外，当前登录人是局级单位的
					$scope.queryEmployer.nonCurrOrgId = SYS_USER_INFO.orgId;
				}else{
					$scope.queryEmployer.nonCurrOrgId = $scope.parentOrg.parentOrgId;//局外，当前等人不是局级单位（处级单位的）
				}
				/** 根据currOrgId，查询该组织下的机构 begin */
				function qSucc3(rec){
					$scope.employerList = rec.content;
					$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
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
		$scope.name=2;
	};

	
	/* 取消并关闭 选择单位/项目模态框 */
	$scope.closeEmployerModel = function(){
		$('#employerModel').modal('hide');
	} 
	
	
	
	
	
	/**
	 * 每三位数字添加一个逗号分隔符号
	 */
 	$scope.formData={};              //num为传入的值，parm为复用的属性 ，flag为区分的标志这里可能不需要
 	$scope.centsCopyFive = '';
	$scope.formatMoney=function(num,parm,counts){//参数分别是：num=输入值，parm=属性,flag=区分添加和修改的符号，counts=小数点最多几位
		$scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
		if(num==null||num==""){
			return;
		}else{
			$scope.numArray_=num.split("");//把输入的字符变成数组用于判断其中点的数目
		}
		for(var i=0;i<num.length;i++){//数值第一位不能是0，是0就返回0
			if(num[0] == 0){
				$scope.addPublishList[parm] = 0;
				return;
			}
			
		}
		/* for(var i=0;i<num.length;i++){//数值第二位不是  . ，是0就返回0
				if(num[1] !== '.'){
					$scope.formParms[parm] = 0;
					return;
				}	
			} */
		for(var i=0;i<$scope.numArray_.length;i++){//不能有2个以上的小数点否则为0
			if($scope.numArray_[i] == '.'){
				$scope.test_.push($scope.numArray_[i]);
				if($scope.test_.length>1){
					$scope.addPublishList[parm] = 0;
					return;
				}
			}
		}
		//检索点号的位置或者说是否有点号
		var judge = num.indexOf(".");
		var cents='';//包括小数点之后
		var centsCopy =0;//不包括小数点之后
		//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
		if(judge>0){
			cents = num.substring(judge, num.length);//包括点开始截取到完结
			centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
			num = num.substring(0,judge);//截取（不包括点）点之前的数字
			
			if(centsCopy.length==counts){//当小数点后面的位数达到软需要求时记录数值
				$scope.centsCopyFive = centsCopy;
			}
			
			if(centsCopy.length>counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
				cents = '.'+$scope.centsCopyFive;
			}
		}
		num = num.toString().replace(/\,/g,'');//全局匹配有没有逗号，有就清除，用于清除上次的逗号在进行排版
		//如果num不是数字就赋值为0   这个不完美如果小数点后有字母不为0
		if(isNaN(num)){
			num = "0";
		}
		if(isNaN(centsCopy)){//如果小数点后面的值有不为数字的字符就把小数点之前的置为0，包括小数点之后的字符为空，这样起到如果有不为数字的字符就为0
			num = "0";
			cents = "";
		}
		for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++){
			num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3));
		 }
		//如果有小数点算上小数点赋值
		if(cents.length!=0){
			$scope.addPublishList[parm] = num+cents;
			 if($scope.addPublishList[parm].length > 21){
             	$scope.addPublishList[parm] =0;
             }
		}else{
			//没有直接加小数点之前的赋值
			$scope.addPublishList[parm] = num;
			 if($scope.addPublishList[parm].length > 14){
             	$scope.addPublishList[parm] =0;
             }
		}
	};
	
	$scope.show = 2;
	$scope.state = function(){
		if($scope.addPublishList.state == "3"){
			$scope.show = 1;
		}else{
			$scope.show = 2;
		}
	}
	
	
});

</script>

  <style type="text/css">
	.table-hover > tbody > tr:hover > td,
	.table-hover > tbody > tr:hover > th {
		  background-color: #f5f5f5;
	}
	.form-control {
		  display: block;
		  color: #555555;
		  padding: 0px ;
		  background-color: #ffffff;
		  background-image: none;
		  border: 1px solid #cccccc;
		  border-radius: 0px;
}

</style>

</head>
<body  ng-app="searchApp" ng-controller="searchController">
<div ng-include src="'./publish_Model.jsp'" ></div>
<jsp:include page="../../Front/Main/Top.jsp"/>
<div class="main">
   <div class="position">&nbsp;  <span>></span>  &nbsp;首页&nbsp; <span>></span> &nbsp;我的鲁班   &nbsp;<span>></span>  &nbsp; 已发布的信息</div>
   <div class="fbxx_top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="gwafdg">
  <tr>
    <td width="6%">信息类型： </td>
    <td width="12%"> 
    <select  class="sel_a form-control" name="PayerAcNo" ng-model="dataTypeName" ng-click="size=1;">
        <option value="">全部</option>
        <option value="1">出租</option>
        <option value="2">出售</option>
        <option value="3">求租</option>
        <option value="4">求购</option>
      </select></td>
    <td width="6%">审核状态：</td>
    <td width="13%">
     <select  class="sel_a form-control" name="PayerAcNo" ng-model="dataStateName" ng-click="size=1;" >
          <option value="">全部</option>
          <option value="1">待审核</option>
		  <option value="3">通过</option>
		 <option value="4">退回</option>   
		 <option value="5">删除</option>        
		 </select>
    </td>
    <td width="6%">发布日期：</td>
    <td width="26%">
       <input  id="beginDateId" type="text" ng-init="getBeforeDate();"  ng-change="complienStart();" 
			 ng-mouseleave="BeginOut();" ng-change="complienStart();" ng-model="condition.beginDate" type="text" class="inpt_a jfdk inpt_o span126 form-control input-group date form_date" />
       
       <span class="jfoiwp">-</span>
       <input    ng-init="getNowDateStr();"  ng-change="complienEnd();"
			  ng-mouseleave="EndOut();"  id="endDateId" type="text" class="inpt_a inpt_o span126 form-control" ng-model="condition.endDate"/>
    </td>
    <td width="31%">  <input  type="button"  class="inpt_booom inpt_booom_pol" value="查询" ng-click="sarchPublishClick(dataTypeName,dataStateName)" />
    </td>
  </tr>
</table>
     <div class="clear"></div>

   </div>
  <div style=" margin-top:10px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj table-hover">
        <tr >
						<th>序号</th>
						<th>信息类型</th>
						<th>信息标题</th>
						<th >联系人</th>
						<th >联系电话</th>
						<th >发布日期</th>
						<th >审核状态</th>
						<th >交易状态</th>
						<th >操作</th>
					</tr>
       	 <tr ng-repeat="p in publishList">
						<td  ng-bind="$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage"></td>
						<td  ng-bind="ct.codeTranslate(p.dataType,'MESSAGE_TYPE')"></td>
						<td  title="{{p.infoTitle}}">
							<a ng-if="p.dataState==3 && p.dataType==1" ng-click="titleopen(p);" style="text-decoration: none;color: blue" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
							<a ng-if="p.dataState==3 && p.dataType==2" ng-click="titleopen(p);" style="text-decoration: none;color: blue" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
							<a ng-if="p.dataState==3 && p.dataType==3" ng-click="titleopen(p);" style="text-decoration: none;color: blue" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
							<a ng-if="p.dataState==3 && p.dataType==4" ng-click="titleopen(p);" style="text-decoration: none;color: blue" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
							<a ng-if="p.dataState!==3 && p.dataType==1" href="" style="text-decoration: none;color: black;" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
							<a ng-if="p.dataState!==3 && p.dataType==2" href="" style="text-decoration: none;color: black;" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
							<a ng-if="p.dataState!==3 && p.dataType==3" href="" style="text-decoration: none;color: black;" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
							<a ng-if="p.dataState!==3 && p.dataType==4" href="" style="text-decoration: none;color: black;" ng-bind="'【'+ct.codeTranslate(p.dataType,'MESSAGE_TYPE')+'】'+p.infoTitleTemp"></a>
						</td>
						<td  ng-bind="p.contactPerson"></td>
						<td  ng-bind="p.contactPhone"></td>
						<td  title="{{p.releaseDate}}" ng-bind="p.releaseDate"></td>
						<td  ng-show="p.dataState==3"><span style="color: #FF9900;" ng-bind="p.dataStateDesc"></span></td>
						<td  ng-show="p.dataState==1"><span style="color: #FF9900;"  ng-bind="p.dataStateDesc"></span></td>
						<td  ng-show="p.dataState==4"><span style="color: #FF9900;" ng-mouseover="queryError(p.dataId)" title="{{message}}" ng-bind="p.dataStateDesc"></span></td>
						<td  ng-show="p.dataState==5"><span style="color: #FF9900;" ng-mouseover="queryError(p.dataId)" title="{{message}}" ng-bind="p.dataStateDesc"></span></td>
						<td  ng-bind="ct.codeTranslate(p.equState,'STATE_EQU_STATE')"></td>
						<td >
							<span style="margin-left:5px;color: gray;" ng-show="p.dataState==1">刷新</span>
							<span style="margin-left:5px;color: gray;" ng-show="p.dataState==4">刷新</span>
							<a href="" style="text-decoration: none;margin-left:5px;color: blue" ng-show="p.dataState==3" ng-click="refPublish(p.id);" >刷新</a>
							<span style="margin-left:5px;color: gray;" ng-show="p.dataState==3" >修改</span>
							<a href="" style="text-decoration: none;margin-left:5px;color: blue;" ng-click="updPublish(p);" ng-show="p.dataState==1">修改</a>
							<a href="" style="text-decoration: none;margin-left:5px;color: blue;" ng-click="updPublish(p);" ng-show="p.dataState==4">修改</a>
							<!-- <a href="" style="text-decoration: none;margin-left:5px;color: blue"  ng-show="p.dataState!=5"  ng-click="delPublish(p.id);">作废</a> -->
							
							<a ng-if="p.dataState==3" style="text-decoration: none;margin-left:5px;color: blue" ng-click="addPublish(p);">发布结果登记</a>
							<a style="text-decoration: none;margin-left:5px;color: blue" ng-show="p.dataState==3" ng-click="businessMessageModel(p);">交易信息</a>
						</td>
					</tr>
      </table>

   </div>

				<div style="float: right;">
					<tm-paginations ng-if="!outDiv" conf="paginationConf"  style="margin-right:0px; " ></tm-paginations>
					<span ng-if="outDiv">没有符合条件的记录</span>
   				</div>
   				
   <div class="clear"></div>
   
   <div ng-include src="'./businessMessageModel.jsp'" ></div>
   <div ng-include src="'./publishBack_Model.jsp'" ></div>
</div>
<jsp:include page="../../Front/Include/Bottom.jsp" />
</body>
</html>




