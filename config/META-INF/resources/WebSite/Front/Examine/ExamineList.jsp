<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>出租/出售信息审核</title>
<jsp:include page="../Include/Head.jsp" />

<link href="/WebFront/media/css/heightLight.css" rel="stylesheet">
<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<script type="text/javascript">
var app = angular.module('ExamineApp', ['ngResource','unifyModule','myPagination','ngMessages']);
app.controller('ExamineController', function($scope,$timeout,published,rentSvc,SaleSvc,regionSvc,PicUrl) {
	$scope.PicUrl_Copy = PicUrl;
	
	$scope.formParms={};
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
        	$scope.queryExamineData();
        }
    };
	
   
	
	
	/*
	 * 查询数据
	*/
	$scope.queryExamineData_copy=function(pageNo){
		if(pageNo)
		{
			$scope.paginationConf.currentPage=1;
		} 
		published.unifydo({
			Action:"RentSale",
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.pageRecord
			},
			qSucc,qErr);
		function qSucc(rec){
			$scope.cleanRadio();
			$scope.examineList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){}
	};
	
	
	
	
	
	/*
	查询出租出售的信息
	*/
	$scope.auditButton=false;//审核按钮显示和隐藏
	$scope.queryData={};
/* 	$scope.queryData.infoType=1;
	$scope.queryData.dataState=1; */
	$scope.queryExamineData=function(pageNo)
	{

		
		if(pageNo)
		{
			$scope.paginationConf.currentPage=1;
		} 
		
		function qurSuccess(rec)
		{
			if(rec.content.length>0){
				$scope.cleanRadio();
				$scope.auditButton=true;//审核按钮显示
				$scope.examineList=rec.content;
				$scope.paginationConf.totalItems=rec.totalElements;
			}else{
				$scope.cleanRadio();
				$.messager.popup("没有符合条件的记录!");
				$scope.auditButton=false;//审核按钮隐藏
				$scope.examineList=rec.content;
				$scope.paginationConf.totalItems=rec.totalElements;
			}
			
		}
		function qurError(rec)
		{
			$.messager.popup("没有符合条件的记录！");
			$scope.auditButton=false;//审核按钮隐藏
			$scope.examineList={};/* 没有查询对应的记录时，记录为空 */
		}		
		
		$scope.queryData.Action="RentSale";
		$scope.queryData.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryData.pageSize=$scope.paginationConf.pageRecord;
		
		if($scope.queryData.beginDate == null ){
			$scope.queryData.beginDate = $scope.saveStartBean;
		}
		if($scope.queryData.endDate == null ){
			$scope.queryData.endDate = $scope.saveEndBean;
		}
		published.unifydo($scope.queryData,qurSuccess,qurError);
	};
	
	
	
	
	
	
	//点行选取单选框并赋值
	$scope.radio_flag={};
	$scope.trBean=null;
	$scope.selectRow=function(obj){
		$scope.trBean=obj.t;
		$scope.radio_flag=obj.$index;
	};
	
	//清除赋值和单选框
	$scope.cleanRadio =function(){
		$scope.trBean=null;
		$scope.radio_flag=null;
	};
	
	
    /*
     * 地址查询--面向城市
     */
     $scope.atTemporary={};
     $scope.rentCity = function(parm){
	     	function qSucc(rec){
 			$scope.atDisName=rec.name;
 			$scope.atCitName=rec.parentName;
 			$scope.atTemporary=rec;
 			$scope.queryAtCities($scope.atTemporary);
			}
			function qErr(){}
			regionSvc.queryRegionByRegionId2({id:parm},qSucc,qErr);
     };
     
     $scope.queryAtCities = function(){
   	    function qSucc(rec){
  			$scope.atProName=rec.parentName;
		    $scope.formParms.atRegionName=$scope.atProName+'-'+$scope.atCitName+'-'+$scope.atDisName;
 		}
	    function qErr(){}
	    regionSvc.queryRegionByRegionId2({id:$scope.atTemporary.parentRegionId},qSucc,qErr);
    }; 
	
	
	
	
	//审批
	$scope.openDetailModal=function(){
		if ($scope.trBean) {
			$scope.titleMsg="详细信息";
			if($scope.trBean.dataType=='1'){
	 			rentSvc.unifydo({parm:$scope.trBean.dataId},
					qSucc=function(rec){
	 				
						$scope.formParms=rec;
						if(rec.atCity){
							$scope.rentCity(rec.atCity);
						}
						$scope.resolvePicture();
					},
					qErr=function(rec){}
				);
	 		}else if($scope.trBean.dataType=='2'){
	 			SaleSvc.unifydo({parm:$scope.trBean.dataId},
					qSucc=function(rec){
						$scope.formParms=rec;
						$scope.resolvePicture();
					},
					qErr=function(rec){}
				);
	 		}
			$('#examineDetailModalId').modal({backdrop: 'static', keyboard: false});
		}else{
			$.messager.popup("请选择一条信息！");
		}
		
	};
	
	$scope.openOpinionModal=function(){
		$scope.formParms.reason1=false;
		$scope.formParms.reason2=false;
		$scope.formParms.reason3=false;
		$scope.formParms.reason4=false;
		$scope.formParms.reasonOther=false;
		$scope.formParms.reasonOtherDesc="";
		$scope.titleMsg="请选择或手动填写不通过原因(可多选)";
		$('#examineOpinionModalId').modal({backdrop: 'static', keyboard: false});
	};
	
	$scope.resolvePicture=function(){
		$scope.formParms.equipmentPicList=[];
		if($scope.formParms.equipmentPic!=null){
			var picList=$scope.formParms.equipmentPic.split(",");
			for(var i=0,m=picList.length;i<m;i++){
				var picName=picList[i].split(".");
				$scope.formParms.equipmentPicList.push({"pic":picName

[0],"suffix":picName[1]});
			}
		}
		
	};
	
	$scope.submit=function(){
		if($scope.formParms.process.bizType=='1'){
			rentSvc.post({Action:"AuditThrough",parm:$scope.formParms.dataId},{},
				function(rec){
					$('#examineDetailModalId').modal('hide');
					$.messager.popup(rec.msg);
				},
				function(rec){
				}
			);
 		}else if($scope.formParms.process.bizType=='2'){
 			SaleSvc.post({Action:"AuditThrough",parm:$scope.formParms.dataId},{},
				qSucc=function(rec){
	 				$('#examineDetailModalId').modal('hide');
					$.messager.popup(rec.msg);
				},
				qErr=function(rec){
				}
			);
 		}
		$scope.queryExamineData();
	};
	
	/**
	 * 选中1号复选框方法
	 */
    $scope.Res={};
	$scope.check1 = function(parm) {
		//传入的参数是复选框对应的中文文字
		$scope.Res.chk1=parm;
	};
	
	/**
	 * 选中2号复选框方法
	 */
	$scope.check2 = function(parm) {
		$scope.Res.chk2=parm;

	};
    
	/**
	 * 选中3号复选框方法
	 */
	$scope.check3 = function(parm) {
		$scope.Res.chk3=parm;
	};
    
	/**
	 * 选中4号复选框方法
	 */
	 $scope.check4 = function(parm) {
			$scope.Res.chk4=parm;
		};
	
	/**
	 * 选中5号复选框方法
	 */
	 $scope.check5 = function(parm) {
			$scope.Res.chk5=parm;
			if($scope.formParms.reasonOther==true){
				$scope.reason = false;
			}else{
				$scope.reason = true;
			}
			
		};
		
	/**
	 * 设置输入框开始为不能输入
	 */
		$scope.reason = true;	
		
	
	$scope.submitResult=function(obj){
	
		if(!obj.$valid){
			if(!obj.reasonOtherDesc.$valid){
				$scope.showFlag = 'reasonOtherDesc';
			}
			return;
		}

		
	if(!($scope.formParms.reason1||$scope.formParms.reason2||$scope.formParms.reason3||

      $scope.formParms.reason4||$scope.formParms.reasonOther)){

		$.messager.popup("验证不通过请选择原因!");
		
		return;
	}
	
	if($scope.formParms.reasonOther==true&&$scope.formParms.reasonOtherDesc==""){
		$.messager.popup("请输入不通过原因!");
		return;
	}
	
	
	
	if($scope.formParms.process.bizType=='1'){
		rentSvc.post({Action:"AuditRefuse",parm:$scope.formParms.dataId},{},
			function(rec){
				$('#examineOpinionModalId').modal('hide');
				$('#examineDetailModalId').modal('hide');
				$.messager.popup(rec.msg);
			},
			function(rec){
			}
		);
		}else if($scope.formParms.process.bizType=='2'){
			SaleSvc.post({Action:"AuditRefuse",parm:$scope.formParms.dataId},{},
			qSucc=function(rec){
					$('#examineOpinionModalId').modal('hide');
 				$('#examineDetailModalId').modal('hide');
				$.messager.popup(rec.msg);
			},
			qErr=function(rec){
			}
		);
		}
	//$scope.queryExamineData();
};
	
//日期控件
/**
 * 获取当前日期的字符串表示形式
 */
 
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

});
/* function cleanDateFun()
{
	
    var saveEndBean = document.getElementById("endDateId").value;
    document.getElementById("endDateId").value = null;
    document.getElementById("endDateId").focus();
} */
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

<body ng-app="ExamineApp" ng-controller="ExamineController" class="container">
	<div ng-include src="'../../WebSite/Include/TopMenu.jsp'" ></div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">出租/出售信息审核</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;">
			<ul>
				<div class="form-group">
					<label contenteditable="false" class="col-xs-1 control-label">信息类型：</label>
					<div class="col-xs-2">
						<select class="form-control select-hover" ng-model="queryData.infoType" onmouseover="size=3" onmouseout="size=1" onclick="size=1"style="position: absolute;z-index:3;">
                            <option value="">全部</option>
							<option value="1">出租</option>
							<option value="2">出售</option>
						</select>
					</div>
					<label contenteditable="false" class="col-xs-1 control-label">状态：</label>
					<div class="col-xs-2" id="div_2">
						<select class="form-control select-hover" ng-model="queryData.dataState" onmouseover="size=4" onmouseout="size=1" onclick="size=1"style="position: absolute; z-index:3;">
						    <option value="">全部</option>
							<option value="1">待审核</option>
							<option value="3">审核通过</option>
							<option value="4">审核不通过</option>
						</select>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">开始日期：</label>
			 		<div class="col-xs-3" style="float: left; width: 160px; margin-right: -10px;">
						<input ng-click="clickDateFunStart();" ng-blur="cleanFlagFunStart();" id="beginDateId" type="text" ng-init="getBeforeDate();" ng-change="complienStart();" class="form-control input-group date form_date" ng-model="queryData.beginDate"> 
						<button ng-click="cleanDateFunStart();" ng-show="flagStart==true" id="flagStart" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button>
 							<span class="input-group-addon" style="display: none" > 
								<span class="glyphicon glyphicon-calendar">
								</span>
							</span>
					</div> 
				
					
					<!-- <span style="float: left;">-</span> -->
					<label contenteditable="false" class="col-xs-1 control-label">结束日期：</label>
					<div class="col-xs-3" style="float: left; width: 160px; margin-left: -10px;">
						<input ng-click="clickDateFunEnd();" ng-blur="cleanFlagFunEnd();" id="endDateId" type="text" ng-init="getNowDateStr();"  ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endDate"><!-- 触发事件 --> 
						<button ng-click="cleanDateFunEnd();" ng-show="flagEnd==true" id="flagEnd" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button>
 						<span class="input-group-addon" style="display: none">
							<span class="glyphicon glyphicon-calendar">
							</span>
						</span>
					</div>
				</div>
			</ul>
			<ul>
				<div class="form-group" id="div_1">
				<div class="col-xs-4" style="margin-left:26px">
						<input type="text" class="form-control" ng-model="queryData.searhParam" placeholder="查询 信息标题、企业名称、联系人、联系电话" style="z-index:1;">
				</div>
					<div class="col-xs-2">
						<input type="button" class="btn btn-primary" value="查询" ng-click="queryExamineData(1);" style="z-index:1;"/>
					</div>
				</div>
			</ul>
		</div>
		<div>
			<table class="table table-striped table-hover" style="margin-left: 50px;">
				<thead>
					<tr class="success">
						<th style="text-align:center;"><span style="margin-left:30px;">序号</span></th>
						<th></th>
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
					<tr ng-repeat="t in examineList" ng-click="selectRow(this)" style="text-align:center;">
						<td ><input style="margin-left:18px;" type="radio" name="id" ng-checked="radio_flag==$index"/>&nbsp;</td>					
						<td><span style="margin-left:-85px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.pageRecord}}</span></td>
                        <td>{{t.process.bizName}}</td>
						<td>{{t.infoTitle}}</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>{{t.enterpriseName}}</td>
						<td>{{t.contactPerson}}</td>
						<td>{{t.contactPhone}}</td>
						<td>{{t.updateTime}}</td>
						<td>{{t.dataState.note}}</td>
					</tr>
				</tbody>
			</table>
			<div class="form-horizontal" style="margin-top: 10px;">
				<ul>
					<div class="form-group">
						<div class="col-xs-2" style="margin-left:10px;margin-top:20px;">
							<input type="button" ng-show="auditButton" class="btn btn-primary" value="审核" ng-click="openDetailModal()">
						</div>
						<div class="col-xs-8" ng-show="auditButton" style="text-align:right;margin-left:200px;">
							<pagination-tag conf="paginationConf"></pagination-tag>
						</div>
					</div>
				</ul>
			</div>
		</div>
	</form>
	<div ng-include src="'/WebFront/WebSite/Examine/ExamineDetail.jsp'" ></div>
	<div ng-include src="'/WebFront/WebSite/Examine/ExamineOpinion.jsp'" ></div>
</body>
</html>