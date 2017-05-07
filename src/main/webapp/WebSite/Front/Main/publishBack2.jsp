<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>已发布的信息</title>
<link rel="stylesheet"  type="text/css" href="../../../media/css/home.css">
<jsp:include page="../Include/Head.jsp" />
<jsp:include page="../conmmon/publicSession.jsp" />
<script type="text/javascript" src="../../../js/JsLib/chinesepyi.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../../media/js/pagination.js"></script>
<script type="text/javascript" src="../../../js/JsLib/angular-sanitize.min.js"></script>
<script type="text/javascript" src="../../../js/userJs/useCookie.js"></script>
<script type="text/javascript" src="../../../media/js/tm.pagination.js"></script>
<script src="../../../js/JsLib/angular.min.js"></script>
<script type="text/javascript">
var app = angular.module('searchApp',['ngResource','unifyModule','tm.pagination','ngSanitize',,'Config']);
app.controller('searchController',function($scope,busPublishInfo,rentSvc,SaleSvc,DemandRentSvc,DemandSaleSvc,published,busAuditSvc){
	
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
        		 $scope.queryPublish(); 
        	} 
        }
	};
	$scope.flagStart = true; /* 叉号显示初始值赋值 */
	$scope.flagEnd = true; /* 叉号显示初始值赋值 */
	
	$scope.queryPublish=function(){
		function qSucc(rec){
			if(rec.content.length==0){
				$.messager.popup("没有符合条件的记录");
				return;
			}
			$scope.publishList=rec.content;

			$scope.paginationConf.totalItems=rec.totalElements;
			for(var i=0;i<rec.content.length;i++){
				//
				if(rec.content[i].dataType == 1){
					$scope.publishList[i].dataType="出租";
				}
				else if(rec.content[i].dataType == 2){
					$scope.publishList[i].dataType="出售";
				}
				else if(rec.content[i].dataType == 3){
					$scope.publishList[i].dataType="求租";
				}
				else if(rec.content[i].dataType == 4){
					$scope.publishList[i].dataType="求购";
				}
				//
				if(rec.content[i].dataState == 1){
					$scope.publishList[i].dataState="待审核";
				}
				else if(rec.content[i].dataState == 2){
					$scope.publishList[i].dataState="审核中";
				}
				else if(rec.content[i].dataState == 3){
					$scope.publishList[i].dataState="审核通过";
				}
				else if(rec.content[i].dataState == 4){
					$scope.publishList[i].dataState="审核拒绝";
				}
				//
				if(rec.content[i].equState == 2){
					$scope.publishList[i].equState="未成交";
				}
				else if(rec.content[i].equState == 1){
					$scope.publishList[i].equState="已成交";
				}else{
					$scope.publishList[i].equState="-";
				}
			}
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
	$scope.sarchPublishClick=function(){		
		function qSucc(rec){
			
			if(rec.content.length==0){
				$.messager.popup("没有符合条件的记录");
				return;
			}
			$scope.publishList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
			
			
			for(var i=0;i<rec.content.length;i++){
				//
				if(rec.content[i].dataType == 1){
					$scope.publishList[i].dataType="出租";
				}
				else if(rec.content[i].dataType == 2){
					$scope.publishList[i].dataType="出售";
				}
				else if(rec.content[i].dataType == 3){
					$scope.publishList[i].dataType="求租";
				}
				else if(rec.content[i].dataType == 4){
					$scope.publishList[i].dataType="求购";
				}
				//
/* 				if(rec.content[i].dataState == 1){
					$scope.publishList[i].dataState="待审核";
				}
				else if(rec.content[i].dataState == 2){
					$scope.publishList[i].dataState="审核中";
				}
				else if(rec.content[i].dataState == 3){
					$scope.publishList[i].dataState="审核通过";
				}
				else if(rec.content[i].dataState == 4){
					$scope.publishList[i].dataState="审核拒绝";
				} */
				//
				if(rec.content[i].equState == 2){
					$scope.publishList[i].equState="未成交";
				}
				else if(rec.content[i].equState == 1){
					$scope.publishList[i].equState="已成交";
				}else{
					$scope.publishList[i].equState="-";
				}
			}
			
			
			
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
	};
	
	$scope.searchPublish=function(pageNo){
		if(pageNo == 1){
			$scope.paginationConf.currentPage = 1;
		}
		function qSucc(rec){
			if(rec.content.length==0){
				$.messager.popup("没有符合条件的记录");
				return;
			}
			
			$scope.publishList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
			
			
			for(var i=0;i<rec.content.length;i++){
				//
				if(rec.content[i].dataType == 1){
					$scope.publishList[i].dataType="出租";
				}
				else if(rec.content[i].dataType == 2){
					$scope.publishList[i].dataType="出售";
				}
				else if(rec.content[i].dataType == 3){
					$scope.publishList[i].dataType="求租";
				}
				else if(rec.content[i].dataType == 4){
					$scope.publishList[i].dataType="求购";
				}
				//
/* 				if(rec.content[i].dataState == 1){
					$scope.publishList[i].dataState="待审核";
				}
				else if(rec.content[i].dataState == 2){
					$scope.publishList[i].dataState="审核中";
				}
				else if(rec.content[i].dataState == 3){
					$scope.publishList[i].dataState="审核通过";
				}
				else if(rec.content[i].dataState == 4){
					$scope.publishList[i].dataState="审核拒绝";
				} */
				//
				if(rec.content[i].equState == 2){
					$scope.publishList[i].equState="未成交";
				}
				else if(rec.content[i].equState == 1){
					$scope.publishList[i].equState="已成交";
				}else{
					$scope.publishList[i].equState="-";
				}
			}
			
			
			
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
 			busAuditSvc.unifydo({urlPath:param},qSucc3,qErr3);	
			
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
		
 		if(val.dataType == '出租'){
 			window.location.href = "../../../WebSite/Front/Publish/Infopub.jsp?id="+val.dataId+"&infoType=1";
 		}else if(val.dataType == '出售'){
 			window.location.href = "../../../WebSite/Front/Publish/InfopubSale.jsp?id="+val.dataId+"&infoType=2";
 		}else if(val.dataType == '求租'){
 			window.location.href = "../../../WebSite/Front/Publish/DemandInfoPub.jsp?id="+val.dataId+"&infoType=3";
 		}else if(val.dataType == '求购'){
 			window.location.href = "../../../WebSite/Front/Publish/DemandInfoPubShop.jsp?id="+val.dataId+"&infoType=4";
		}
	};
	
	
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
}).app.controller('searchIncludeController',function($scope,published,searchUrl,category){});


	      
</script>

<style>

.select-hover > option:hover  {
	background-color: #C0C0C0;
}	
a.styleA:hover {
	color: #E16600
} 
span.classSpan:hover{
	color: #E16600
}
.imghover:hover{
	border:5px solid;
	border-color: #CC0000;
	color: #CC0000;
}
.classSpan{
	color:#428BCA;
}
.labelSearch:link {
	text-decoration: none;
}
.labelSearch:visited {
	text-decoration: none;
}
.labelSearch:hover {
	text-decoration: none;
}
.labelSearch:active {
	text-decoration: none;
}

.container {width: 1150px !important;}

.form-horizontal .control-label {
	padding-top: 7px;
	margin-bottom: 0;
	text-align: right;
	min-width : 0px;
}

.Acolor{color:#333333; text-decoration:none;}/*链接设置*/
.Acolor:hover{color:#E4393C; text-decoration:none;}/*鼠标放上的链接设置*/
/* .Acolor:visited{color:#3399CC; text-decoration:none;font-weight:bold;}访问过的链接设置*/
/*
取消下划线只要把text-decoration:underline修改成text-decoration:none
文字加粗font-weight:bold 如不需要加粗显示，那么删除font-weight:bold;就可以了
其它更多的参数设置参考：css2.0手册 其中的"伪类"说明
*/
.page-list .pagination {float:left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float:left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left:3px;}
.page-list .page-total select {width: 50px;}
</style>

</head>

<body style="background-color: #fff;" ng-app="searchApp" ng-controller="searchController">
	<div class="container">
	 <jsp:include page="../../../WebSite/Front/Main/Top.jsp" flush="true"/>
		<!-- <div ng-include src="'../../../WebSite/Front/Main/Top.jsp'" /> -->
	</div>
	<div class="container" style="margin-top: 10px" >
		<ol class="breadcrumb">
			<li style="font-size: 13px">当前位置：<a href="HomePage.jsp?" style="text-decoration: none;">首页</a></li>
			<li style="font-size: 13px">我的鲁班</li>
			<li style="font-size: 13px">已发布的信息</li>
		</ol>
	</div>
	<div class="container" style="margin-top: -30px;margin-bottom: 10px;">
		<hr/>
	</div>
	<div class="container">
		<label contenteditable="false" class="col-xs-1 control-label" style="margin-top:8px;">信息类型</label>
		<div class="col-xs-2">
			<select name="state" id="state" class="form-control" style="margin-left:-25px;position:absolute;"
				    ng-model="dataTypeName"   class="select-hover">
				<option value="">全部</option>
				<option value="1">出租</option>
				<option value="2">出售</option>
				<option value="3">求租</option>
				<option value="4">求购</option>
			</select>
		</div>
		<label contenteditable="false" class="col-xs-1 control-label" style="margin-top:8px;">发布状态</label>
		<div class="col-xs-2">
			<select name="state" id="state" class="form-control" style="margin-left:-25px;position:absolute;"
				ng-model="dataStateName" >
				<option value="">全部</option>
				<option value="1">待审核</option>
				<option value="3">审核通过</option>
				<option value="4">审核不通过</option>
			</select>
		</div>
		<label contenteditable="false" class="col-xs-1 control-label" style="margin-top:8px;">发布日期</label>
		<div class="col-xs-3" style="float: left; width: 150px; margin-left: -25px;">
			<input id="beginDateId" type="text" ng-init="getBeforeDate();"  ng-change="complienStart();" 
			 ng-mouseleave="BeginOut();" 
			 class="form-control input-group date form_date" ng-model="condition.beginDate"> 
			 <!-- <button ng-click="cleanDateFunStart();" ng-show="flagStart==true" id="flagStart" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button> -->
				<span class="input-group-addon" style="display: none" > 
					<span class="glyphicon glyphicon-calendar">
					</span>
				</span>
		</div>
		<span style="float: left;margin-top:7px;margin-left:-10px;">—</span>
		<label contenteditable="false" class="col-xs-1 control-label"></label>
		<div class="col-xs-3" style="float: left; width: 150px; margin-left: -104px;">
			<input id="endDateId" type="text" ng-init="getNowDateStr();"  ng-change="complienEnd();"
			  ng-mouseleave="EndOut();" 
			class="form-control input-group date form_date" ng-model="condition.endDate">
			<!-- <button ng-click="cleanDateFunEnd();" ng-show="flagEnd==true" id="flagEnd" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button> -->
			<!-- 触发事件 --> 
			<span class="input-group-addon" style="display: none">
				<span class="glyphicon glyphicon-calendar">
				</span>
			</span>
		</div>
		<div class="col-xs-offset-6" style="text-align: center;">
			<input type="button" class="btn btn-primary" value=" 查  询 " ng-click="sarchPublishClick()">
		</div>
	</div>		 					 		
	<div class="container" >
		<!-- <div ng-show="outDiv" style="height: 150px;"></div> -->
		<div class="form-group" style="margin-top: 10px" ><!-- ng-show="FormDiv" -->
			<table class="table table-striped table-hover"  >
				<thead>
					<tr class="info">
						<th class="text-center">序号</th>
						<th class="text-center">信息类型</th>
						<th class="text-center">信息标题</th>
						<th class="text-center">联系人</th>
						<th class="text-center">联系电话</th>
						<th class="text-center">发布日期</th>
						<th class="text-center">发布状态</th>
						<th class="text-center">设备状态</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="p in publishList">
						<td class="text-center" >{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
						<td class="text-center" >{{p.dataType}} </td>
						<td class="text-center" title="{{p.infoTitle}}" ng-show="p.dataStateDesc=='审核通过'">
							<a ng-if="p.dataType=='出租'" href="../Publish/ViewInfo.jsp?id={{p.dataId}}&infoType=1" style="text-decoration: none;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='出售'" href="../Publish/ViewInfo.jsp?id={{p.dataId}}&infoType=2" style="text-decoration: none;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='求租'" href="../Publish/ViewInfo.jsp?id={{p.dataId}}&infoType=3" style="text-decoration: none;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='求购'" href="../Publish/ViewInfo.jsp?id={{p.dataId}}&infoType=4" style="text-decoration: none;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
						</td>
						<td class="text-center" title="{{p.infoTitle}}" ng-show="p.dataStateDesc=='待审核'">
							<a ng-if="p.dataType=='出租'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='出售'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='求租'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='求购'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
						</td>
						<td class="text-center" title="{{p.infoTitle}}" ng-show="p.dataStateDesc=='审核不通过'">
							<a ng-if="p.dataType=='出租'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='出售'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='求租'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
							<a ng-if="p.dataType=='求购'" href="" style="text-decoration: none;color: black;">【{{p.dataType}}】{{p.infoTitle | limitTo:3}}</a>
						</td>
						<td class="text-center" >{{p.contactPerson}}</td>
						<td class="text-center" >{{p.contactPhone}}</td>
						<td class="text-center" title="{{p.releaseDate}}">{{p.releaseDate | limitTo:10}}</td>
						<td class="text-center"  ng-show="p.dataStateDesc=='审核通过'"><span style="color: #FF9900;" >{{p.dataStateDesc}}</span></td>
						<td class="text-center"  ng-show="p.dataStateDesc=='待审核'"><span style="color: #FF9900;" >{{p.dataStateDesc}}</span></td>
						<td class="text-center" ng-show="p.dataStateDesc=='审核不通过'"><span style="color: #FF9900;" ng-mouseover="queryError(p.dataId)" title="{{message}}">{{p.dataStateDesc}}</span></td>
						<td class="text-center" >{{p.equState}}</td>
						<td class="text-center" >
							<span style="margin-left:5px;color: gray;" ng-show="p.dataStateDesc=='待审核'">刷新</span>
							<span style="margin-left:5px;color: gray;" ng-show="p.dataStateDesc=='审核不通过'">刷新</span>
							<a href="" style="text-decoration: none;margin-left:5px;" ng-show="p.dataStateDesc=='审核通过'" ng-click="refPublish(p.id);" >刷新</a>
							<span style="margin-left:5px;color: gray;" ng-show="p.dataStateDesc=='审核通过'" >修改</span>
							<a href="" style="text-decoration: none;margin-left:5px;" ng-click="updPublish(p);" ng-show="p.dataStateDesc=='待审核'">修改</a>
							<a href="" style="text-decoration: none;margin-left:5px;" ng-click="updPublish(p);" ng-show="p.dataStateDesc=='审核不通过'">修改</a>
							<a href="" style="text-decoration: none;margin-left:5px;" ng-click="delPublish(p.id);">删除</a>
						</td>
					</tr>
				</tbody>
			</table>
			<div style="float: right;">
				<tm-pagination conf="paginationConf" style="margin-left:0px;"></tm-pagination>
			</div>
		</div>
</div>
</body>
</html>

	