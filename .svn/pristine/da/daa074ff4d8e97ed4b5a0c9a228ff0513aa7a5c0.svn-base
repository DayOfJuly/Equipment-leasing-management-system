<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"> 
<head>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>想交易的信息</title>
<link rel="stylesheet"  type="text/css" href="../../../media/css/home.css">
<jsp:include page="../../Front/Include/Head.jsp" />
<jsp:include page="../../Front/conmmon/publicSession.jsp" />
<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
<!-- <script src="../../../media/js/lrtk.js" type="text/javascript"></script> -->
<script language="javascript" type="text/javascript" src="../../../media/js/ss.js"></script><!--左右GUNDONG-->
<script type="text/javascript" src="../../../js/JsLib/chinesepyi.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../../media/js/pagination.js"></script>
<script type="text/javascript" src="../../../js/JsLib/angular-sanitize.min.js"></script>
<script type="text/javascript" src="../../../js/userJs/useCookie.js"></script>
<script type="text/javascript" src="../../../media/js/tm.paginations.js"></script>
<script src="../../../js/JsLib/angular.min.js"></script>
<script type="text/javascript">
var app = angular.module('searchApp',['ngResource','unifyModule','tm.paginations','ngSanitize','Config']);
app.controller('searchController',function($scope,category,busDealInfo,published){
		
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
	        	 if($scope.dataTypeName || $scope.equStateName){ 
	        			$scope.searchPublish();;
	        	}else{
	        		$scope.searchPublish();
	        	}  
	        }
		};
	
	/*
	*多余字体用...代替
	*/
	$scope.KWList = function(val){
		for(var i=0;i<val.length;i++){
			if(val[i].infoTitle.length >20){
				$scope.KeyWordList[i].infoTitleA = val[i].infoTitle.substring(0,20)+"...";
        	}else{
        		$scope.KeyWordList[i].infoTitleA = val[i].infoTitle;
        	}
		}
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
		 
		/*
		 * 限制日期控件的可选日期不能大于今天
		 */
		$scope.limitEndDate=function()
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
		/*
		 * 鼠标移除事件
		 */
		$scope.BeginOut = function(){
			if($scope.queryData.beginDate.length == 0){
				$scope.getBeforeDate();
			}
		};
		
		/*
		 * 鼠标移除事件
		 */
		$scope.today={};
		$scope.EndOut = function(){
			if($scope.queryData.endDate.length == 0){
				var year = new Date().getFullYear(); //年
				var month = new Date().getMonth() + 1; //月
				var day = new Date().getDate(); //日
				 $scope.queryData.endDate=year+"-"+month+"-"+day;
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
	$scope.outDivs = false;
	$scope.sarchPublishClick=function(type,state){
		$scope.dataTypeName = type;
		$scope.equStateName = state;
		function qSucc(rec){
			
			$scope.KeyWordList=rec.content;
			$scope.KWList(rec.content);
			if(rec.content==""){
				$scope.outDivs = true;
				$.messager.popup("没有符合条件的记录！");
				return;
			}else{
				$scope.outDivs = false;
			}
			
			for(var i=0;i<rec.content.length;i++){
				if(rec.content[i].dataType == 1){
					$scope.KeyWordList[i].dataType="出租";
				}
				else if(rec.content[i].dataType == 2){
					$scope.KeyWordList[i].dataType="出售";
				}
				else if(rec.content[i].dataType == 3){
					$scope.KeyWordList[i].dataType="求租";
				}
				else if(rec.content[i].dataType == 4){
					$scope.KeyWordList[i].dataType="求购";
				}
				
				if(rec.content[i].equState == 1){
					$scope.KeyWordList[i].equState="已成交";
				}
				else if(rec.content[i].equState == 2){
					$scope.KeyWordList[i].equState="未成交";
				}else{
					$scope.KeyWordList[i].equState="-";
				}
			}
		}
		function qErr(rec){} 
		
		busDealInfo.post({
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage,
			dataType:$scope.dataTypeName,
			equState:$scope.equStateName,
			startReleaseDate:$scope.queryData.beginDate,
			endReleaseDate:$scope.queryData.endDate
		},qSucc,qErr);
	};
	
	
	$scope.searchPublish=function(pageNo){
		if(pageNo == 1){
			$scope.paginationConf.currentPage = 1;
		}
		function qSucc(rec){
			$scope.paginationConf.totalItems=rec.totalElements;
			$scope.KeyWordList=rec.content;
			$scope.KWList(rec.content);
			if(rec.content==""){
				$scope.outDivs = true;
				$.messager.popup("没有符合条件的记录！");
				return;
			}else{
				$scope.outDivs = false;
			}
			
			for(var i=0;i<rec.content.length;i++){
				//
				if(rec.content[i].dataType == 1){
					$scope.KeyWordList[i].dataType="出租";
				}
				else if(rec.content[i].dataType == 2){
					$scope.KeyWordList[i].dataType="出售";
				}
				else if(rec.content[i].dataType == 3){
					$scope.KeyWordList[i].dataType="求租";
				}
				else if(rec.content[i].dataType == 4){
					$scope.KeyWordList[i].dataType="求购";
				}
				
				if(rec.content[i].equState == 1){
					$scope.KeyWordList[i].equState="已成交";
				}
				else if(rec.content[i].equState == 2){
					$scope.KeyWordList[i].equState="未成交";
				}else{
					$scope.KeyWordList[i].equState="-";
				}
			}
		}
		function qErr(rec){} 
		
		busDealInfo.post({
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage,
			dataType:$scope.dataTypeName,
			equState:$scope.equStateName,
			startReleaseDate:$scope.queryData.beginDate,
			endReleaseDate:$scope.queryData.endDate
		},qSucc,qErr);
	}
	
	/*
	*删除
	*/
	$scope.delPublish=function(parm){
		$.messager.confirm("提示", "是否删除？",function (){
			function qSucc(rec){
				$scope.KeyWordList=rec.content;
				$scope.paginationConf.currentPage=1;
				$scope.paginationConf.totalItems=rec.totalElements;
				$.messager.popup("删除成功！");
			}
			function qErr(){
				$.messager.popup("删除失败！");
			} 
			busDealInfo.del({ urlPath:parm },qSucc,qErr);
		});
	};
	
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
});
</script>
<style>

.table-hover>tbody>tr:hover>td,.table-hover>tbody>tr:hover>th {
	background-color: #f5f5f5
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
<jsp:include page="../../Front/Main/Top.jsp"/>

<div class="main">
   <div class="position">&nbsp;  <span>></span>  &nbsp;首页&nbsp; <span>></span> &nbsp;我的鲁班   &nbsp;<span>></span>  &nbsp; 想交易的信息</div>
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
    <td width="6%">设备状态：</td>
    <td width="13%">
     <select  class="sel_a form-control" name="PayerAcNo" ng-model="equStateName" ng-click="size=1;" >
          <option value="">全部</option>
          <option value="1">已成交</option>
          <option value="2">未成交</option>
        </select>
    </td>
    <td width="6%">发布日期：</td>
    <td width="26%">
       <input  id="beginDateId"  ng-init="getBeforeDate();" ng-mouseleave="BeginOut();" ng-change="complienStart();" ng-model="queryData.beginDate" type="text" class="inpt_a jfdk inpt_o span126 form-control" />
       <span class="jfoiwp">-</span>
       <input    ng-init="getNowDateStr();" ng-mouseleave="EndOut();"  ng-change="complienEnd();" id="endDateId" type="text" class="inpt_a inpt_o span126 form-control" ng-model="queryData.endDate"/>
    </td>
    <td width="31%">  <input  type="button"  class="inpt_booom inpt_booom_pol" value="查询" ng-click="sarchPublishClick(dataTypeName,equStateName)" />
    </td>                                                                                               
  </tr>
</table>
     <div class="clear"></div>

   </div>
  <div style=" margin-top:10px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj table-hover">
       <thead>
        <tr class="success">
          <th>序号</th>
          <th>信息类型</th>
          <th width="346px">信息标题</th>
          <th>联系人</th>
          <th>联系电话</th>
          <th>发布日期</th>
          <th>设备状态</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr  ng-repeat="p in KeyWordList|orderBy:'releaseDate':true">
          <td data-ng-bind="$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage"></td>
          <td data-ng-bind="p.dataType" ></td>
          <td title="{{p.infoTitle}}" >
          			<a ng-if="p.dataType=='出租'" target="_bank" href="../Publish/ViewInfo.jsp?id={{p.dataId}}&infoType=1" style="text-decoration: none;color: blue;">【<span style="text-decoration: none;color: blue" data-ng-bind="p.dataType"></span>】<span style="text-decoration: none;color: blue" data-ng-bind="p.infoTitleA"></span></a>
					<a ng-if="p.dataType=='出售'" target="_bank" href="../Publish/ViewInfo.jsp?id={{p.dataId}}&infoType=2" style="text-decoration: none;color: blue;">【<span style="text-decoration: none;color: blue" data-ng-bind="p.dataType"></span>】<span style="text-decoration: none;color: blue" data-ng-bind="p.infoTitleA"></span></a>
					<a ng-if="p.dataType=='求租'" target="_bank" href="../Publish/ViewDemandRentInfo.jsp?id={{p.dataId}}&infoType=3" style="text-decoration: none;color: blue;" >【<span style="text-decoration: none;color: blue" data-ng-bind="p.dataType"></span>】<span style="text-decoration: none;color: blue" data-ng-bind="p.infoTitleA"></span></a>
					<a ng-if="p.dataType=='求购'" target="_bank"  href="../Publish/ViewDemandSaleInfo.jsp?id={{p.dataId}}&infoType=4" style="text-decoration: none;color: blue;">【<span style="text-decoration: none;color: blue" data-ng-bind="p.dataType"></span>】<span style="text-decoration: none;color: blue" data-ng-bind="p.infoTitleA"></span></a>
		  </td>
          <td data-ng-bind="p.contactPerson"></td>
          <td data-ng-bind="p.contactPhone"></td>
          <td title="{{p.releaseDate}}" data-ng-bind="p.releaseDate  | limitTo:10" style="text-align: center;"></td>
          <td data-ng-bind="p.equState" style="text-align: center;"></td>
          <td><a href="" style="text-decoration: none;color: blue;margin-left:5px;" ng-click="delPublish(p.id);">删除</a></td>
        </tr>
        </tbody>
      </table>
   </div>
				<div style="float: right;">
				<tm-paginations ng-if="!outDivs" conf="paginationConf"  style="margin-right:0px; " ></tm-paginations>
				<span ng-if="outDivs">没有符合条件的记录</span>
   				</div>
   <div class="clear"></div>
</div>
	<jsp:include page="../../Front/Include/Bottom.jsp" />
</body>
</html>




 