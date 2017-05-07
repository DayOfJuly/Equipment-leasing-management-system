<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>求租/求购信息审核</title>
<jsp:include page="../Include/Head.jsp" />

<link href="/WebFront/css/heightLight.css" rel="stylesheet">

<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<script type="text/javascript">
var app = angular.module('DemandExamineApp', ['ngResource','unifyModule','myPagination']);
app.controller('DemandExamineController', function($scope,published,DemandRentSvc,DemandSaleSvc,PicUrl) {
	
	$scope.PicUrl_Copy = PicUrl;
	
	/*
	 *分页标签参数配置
	*/
	$scope.paginationConf = {
        currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        pageRecord:10,/*每页显示多少*/
        pageNum:10,/*分页标签数量显示*/
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        queryList:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	$scope.queryDemandExamineData();
        	$scope.radioTrIndex=null;
        }
    };
	
	/*
	 * 查询已发布的求租/求购信息
	*/
	$scope.queryDemandExamineData_copy=function(pageNo){
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function qSucc(rec){
			$scope.demandExamineList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){}
		published.unifydo({
			Action:"DemandRentSale",
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.pageRecord},
			qSucc,qErr);
	};
	/*
	查询求租求购的信息
	*/
	$scope.queryData={};
	//$scope.queryData.infoType=3;
	$scope.queryDemandExamineData=function(pageNo)
	{
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function success(rec)
		{
			if(rec.content==""||rec.content==null){
				$.messager.popup("无相应记录");
				$scope.auditButton=false;//审核按钮隐藏
			}else{
				$scope.auditButton=true;//审核按钮显示
			}
			$scope.demandExamineList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function error(rec){}
		$scope.queryData.Action="DemandRentSale";
		$scope.queryData.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryData.pageSize=$scope.paginationConf.pageRecord;
		
		if(!$scope.queryData.infoType){
			$scope.queryData.infoType=3;
		}
		published.unifydo($scope.queryData,success,error);

	};
	
	$scope.selectRow=function(obj){
		$scope.formParms=obj;
	};
	
	$scope.openDetailModal=function(){

		var item=$(":radio:checked");
		var len=item.length;
		if(len<=0){
			$.messager.popup("请您选择一条信息");
			return;
		}
		$scope.titleMsg="详细信息";
		//infoType=3:求租;infoType=4:求购
		if($scope.formParms.dataType=='3'){
			DemandRentSvc.unifydo({parm:$scope.formParms.dataId},
				qSucc=function(rec){

					$scope.formParms=rec;
					$scope.resolvePicture();
				},
				qErr=function(rec){
				}
			);
 		}else if($scope.formParms.dataType=='4'){
 			DemandSaleSvc.unifydo({parm:$scope.formParms.dataId},
				qSucc=function(rec){

					$scope.formParms=rec;
					$scope.resolvePicture();
				},
				qErr=function(rec){
				}
			);
 		}
		$('#demandExamineDetailModalId').modal({backdrop:'static',keyboard:false});
	};
	
	$scope.openOpinionModal=function(){
		$scope.titleMsg="请选择或手动填写不通过原因(可多选)";
		$('#demandExamineOpinionModalId').modal({backdrop:'static',keyboard:false});
	};
	
	$scope.resolvePicture=function(){
		$scope.formParms.equipmentPicList=[];
		if($scope.formParms.equipmentPic!=null){
			var picList=$scope.formParms.equipmentPic.split(",");
			for(var i=0,m=picList.length;i<m;i++){
				var picName=picList[i].split(".");
				$scope.formParms.equipmentPicList.push({"pic":picName[0],"suffix":picName[1]});
			}
		}
	};
	
	//checkbox
	$scope.tmpCheck=[];
	$scope.changeNote = 'true';
	$scope.changeCheck=function(parm){
		if(parm == false){
			$scope.changeNote = 'true';
			
		}
		else{
			$scope.changeNote = '';
			$scope.checkSelect = true;
		}
	};
	
	//审核通过
	$scope.Through=function(){

		if($scope.formParms.dataType=='3'){//求租审核
			var id=$scope.formParms.dataId;
			DemandRentSvc.post({Action:"AuditThrough",parm:id},$scope.formParms,aSucc,aErr);
			function aSucc(rec){
				$('#demandExamineDetailModalId').modal('hide');
				$.messager.popup(rec.msg);
				$scope.queryDemandExamineData();
			}
			function aErr(rec){
				
			}
		}
		if($scope.formParms.dataType=='4'){//求购审核通过
			var id=$scope.formParms.dataId;
			DemandSaleSvc.post({Action:"AuditThrough",parm:id},$scope.formParms,aSucc,aErr);
			function aSucc(rec){
				$('#demandExamineDetailModalId').modal('hide');
				$.messager.popup(rec.msg);
				$scope.queryDemandExamineData();
			}
			function aErr(){}
		}
	};
	
	
	//审核不通过
	$scope.Refuse=function(){
		if(!$("input[type='checkbox']").is(':checked')){
			$.messager.popup("请选择拒绝原因！");
			return;
		}else if($scope.formParms.typeNo5){
			if($scope.formParms.note == "" || $scope.formParms.note == null){
				$.messager.popup("请输入不通过原因");
				return;
			}	
		}

		if($scope.formParms.dataType=='3'){//求租审核
			var id=$scope.formParms.dataId;
			DemandRentSvc.post({Action:"AuditRefuse",parm:id},$scope.formParms,aSucc,aErr);
			function aSucc(rec){
				$('#demandExamineDetailModalId').modal('hide');
				$('#demandExamineOpinionModalId').modal('hide');
				$.messager.popup(rec.msg);
				$scope.queryDemandExamineData();
			}
			function aErr(rec){
				
			}
		}
		if($scope.formParms.dataType=='4'){//求购审核通过
			var id=$scope.formParms.dataId;
			DemandSaleSvc.post({Action:"AuditRefuse",parm:id},$scope.formParms,aSucc,aErr);
			function aSucc(rec){
				$('#demandExamineDetailModalId').modal('hide');
				$('#demandExamineOpinionModalId').modal('hide');
				$.messager.popup(rec.msg);
				$scope.queryDemandExamineData();
			}
			function aErr(rec){
				
			}
		}
	};
	
	
	//日期控件
	/**
	 * 获取当前日期的字符串表示形式
	 */
	$scope.getNowDateStr=function()
	{
		var nowDate=new Date(),
		year=nowDate.getFullYear(),
		month=nowDate.getMonth()+1,
		day=nowDate.getDate();
		
		if(month<10){
			month="0"+month;
		}
	    var strDate=year+"-"+month+"-"+day;
	    
	    $scope.queryData.endDate = strDate;
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

	/**
	 * 限制日期空间的可选日期不能大于今天
	 */
	$scope.limitEndDate=function(dateId)
	{
	    $('#'+dateId).datetimepicker({
			format: 'yyyy-mm-dd',
			language : 'zh-CN',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			endDate:new Date(),
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0
		});
	};






	//当点击第一个日期控件给第二个日期控件赋开始值
	$scope.complienStart = function (){
		if($scope.queryData.beginDate.length == 16){
			$scope.queryData.beginDate=$scope.queryData.beginDate.substring(0, 10);
			$('#endDateId').datetimepicker('setStartDate', $scope.queryData.beginDate);
		}
		return;
		
	};
	//当点击第二个日期控件给第一个日期控件赋结束值
	$scope.complienEnd = function (){
		if($scope.queryData.endDate.length == 16){
			$scope.queryData.endDate=$scope.queryData.endDate.substring(0, 10);
			$('#beginDateId').datetimepicker('setEndDate', $scope.queryData.endDate);
		}
		
		return;

	};
	
/* 	//点击行选中radio
	$scope.radioList={};
	$scope.selectRadio = function(parm,obj){
		var num = 0;
		for(var rec in $scope.radioList){
			$scope.radioList['radioId'+num]=false;
		}
		$scope.radioList['radioId'+parm]=true;
		$scope.selectRow(obj);
	}; */
	
	$scope.radioList={};
	//选中订单ID
	$scope.check = function(params,varl){
		$scope.radioTrIndex=varl;
		$scope.radioCheckValue = params;
		$scope.selectRow(params);
	};

	/*
	* 清空开始日期
	*/
	$scope.removeBeginDate = function(){
		$scope.queryData.beginDate=null;
	};
	
	$scope.Dateout = function(){
		
	};
	
	
	/*
	* 清空结束日期
	*/
	$scope.removeEndDate = function(){
		$scope.queryData.endDate=null;
	};
	
	
	
	
	
	
});
</script>
<style>
.container {width: 1500px !important;}

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}
</style>
</head>

<body ng-app="DemandExamineApp" ng-controller="DemandExamineController" class="container">
	<div ng-include src="'../../WebSite/Include/TopMenu.jsp'" ></div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">求租/求购信息审核</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal">
			<ul>
				<div class="form-group">
					<div class="col-xs-3" style="margin-left:20px;">
						<input type="text" class="form-control" ng-model="queryData.searhParam" placeholder="查询 信息标题、企业名称、联系人、联系电话">
					</div>
					<label class="col-xs-1 control-label">信息类型：</label>
					<div class="col-xs-1">
						<select class="form-control select-hover" style="position: absolute;z-index:3;margin-left:-30px;" ng-model="queryData.infoType" onmouseover="size=3;" onmouseout="size=1;" ng-click="size=1;">
							<option value="3">全部</option>
							<option value="3">求租</option>
							<option value="4">求购</option>
						</select>
					</div>
					<label class="col-xs-1 control-label" style="margin-left:-20px;">状态：</label>
					<div class="col-xs-1">
						<select class="form-control select-hover" style="position: absolute;z-index:3;margin-left:-30px;" ng-model="queryData.dataState" onmouseover="size=5;" onmouseout="size=1;" ng-click="size=1">
							<option value="">全部</option>
							<option value="1">待审核</option>
							<option value="3">审核通过</option>
							<option value="4">审核不通过</option>
						</select>
					</div>
					<label contenteditable="false" class="col-xs-1 control-label">开始日期：</label>
					<div class="col-xs-3" style="float: left; width: 160px; margin-left:-30px;">
						<input id="beginDateId" type="text" ng-init="getBeforeDate();" ng-change="complienStart();" class="form-control input-group date form_date" ng-model="queryData.beginDate" >
						<button type="button" class="close" aria-hidden="true" ng-click="removeBeginDate();" style="margin-top:-30px;margin-right:15px;">&times;</button>
							<!-- <span class="input-group-addon" style="display: none" > 
								<span class="glyphicon glyphicon-calendar">
								</span>
							</span> -->
					</div>
					<label contenteditable="false" class="col-xs-1 control-label">结束日期：</label>
					<div class="col-xs-3" style="float: left; width: 160px; margin-left:-30px;">
						<input id="endDateId" type="text" ng-init="getNowDateStr();"  ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endDate"> 
						<button type="button" class="close" aria-hidden="true" ng-click="removeEndDate();" style="margin-top:-30px;margin-right:15px;">&times;</button>
						<span class="input-group-addon" style="display: none">
							<span class="glyphicon glyphicon-calendar">
							</span>
						</span>
					</div> 
					<div style="float:right;">
						<input style="margin-right:-35px;" type="button" class="btn btn-primary" value="查询" contenteditable="true" ng-click="queryDemandExamineData(1);"/>
					</div>
				</div>
			</ul>
		</div>
		<div>
			<table class="table table-striped table-hover" style="margin-left: 50px;">
				<thead>
					<tr class="success">
						<th style="text-align:center;">序号</th>
						<th style="text-align:center;">信息类型</th>
						<th style="text-align:center;">信息标题</th>
						<th style="text-align:center;">设备名称</th>
						<th style="text-align:center;">品牌</th>
						<th style="text-align:center;">型号</th>
						<th style="text-align:center;">规格</th>
						<th style="text-align:center;">企业名称</th>
						<th style="text-align:center;">联系人</th>
						<th style="text-align:center;">联系电话</th>
						<th style="text-align:center;">发布日期</th>
						<th style="text-align:center;">状态</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="t in demandExamineList" style="text-align:center;" ng-click="check(t,$index+1)" >
						<td>
							<input type="radio" name="demandid"  ng-click="selectRow(t)" ng-checked="radioTrIndex==$index+1" />
							<span  style="margin-right:-6px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.pageRecord}}</span></td>
						<td>{{t.process.bizName}}</td>
						<td>{{t.infoTitle}}</td>
						<td></td>
						<td>{{t.brandName}}</td>
						<td>{{t.models}}</td>
						<td>{{t.specifications}}</td>
						<td>{{t.enterpriseName}}</td>
						<td>{{t.contactPerson}}</td>
						<td>{{t.contactPhone}}</td>
						<td>{{t.releaseDate}}</td>
						<td>{{t.dataState.note}}</td>
					</tr>
				</tbody>
			</table>
			<div class="form-horizontal" >
				<ul>
					<div class="form-group">
						<div class="col-xs-2" style="margin-left:10px;margin-top:20px;">
							<input type="button" ng-show="auditButton" class="btn btn-primary" value="审核" ng-click="openDetailModal()">
						</div>
						<div class="col-xs-8" style="text-align: right;margin-left:200px;">
							<pagination-tag conf="paginationConf"></pagination-tag>
						</div>
					</div>
				</ul>
			</div>
		</div>
	</form>
	<div ng-include src="'/WebFront/WebSite/DemandExamine/DemandExamineDetail.jsp'" ></div>
	<div ng-include src="'/WebFront/WebSite/DemandExamine/DemandExamineOpinion.jsp'" ></div>	
	<script type="text/javascript">
	$('.form_date').datetimepicker({
		language : 'zh-CN',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		minView : 2,
		forceParse : 0
	});
</script>
</body>
</html>