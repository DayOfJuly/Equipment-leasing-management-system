<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>审核查询</title>


<style>
 ::-ms-clear, ::-ms-reveal{display: none;}
.container {width: 1500px !important;}
::-ms-clear, ::-ms-reveal{display: none;}
.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}

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

<body  class="container">
	<div ng-include src="'./Include/TopMenu.jsp'" ></div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：审核查询</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: -10px;margin-left: 8%">
			<ul>
				<div class="form-group" style="">
					<label class="col-xs-1 control-label">信息类型：</label>
					<div class="col-xs-1">                                                                <!-- ng-change="changeValue();" -->
						<select class="form-control select-hover" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.MESSAGE_TYPE"  style="position: absolute;z-index:3;margin-left:-30px;" ng-model="queryData.dataType"  >
							<option value="">全部</option>
						</select>
					</div>
					<label class="col-xs-1 control-label" style="margin-left:-20px;">审核状态：</label>
					<div class="col-xs-1">
						<select class="form-control select-hover" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.AUDIT_STATE" style="position: absolute;z-index:3;margin-left:-30px;" ng-model="queryData.dataState" >
							<option value="">全部</option>
						</select>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">发布日期：</label>
					<div class="col-xs-3" style="float: left; width: 160px; margin-left:-30px;">
						<input id="beginDateId" type="text" ng-blur="cleanFlagFunStart(queryData.startReleaseDate);" ng-init="getBeforeDate();" ng-change="complienStart();" class="form-control input-group date form_date" ng-model="queryData.startReleaseDate" >
						<!-- <button type="button" class="close" aria-hidden="true" ng-click="removeBeginDate();" style="margin-top:-30px;margin-right:15px;">&times;</button> -->
							<!-- <span class="input-group-addon" style="display: none" > 
								<span class="glyphicon glyphicon-calendar">
								</span>
							</span> -->
					</div>
					<span style="float: left;margin-top:5px;">——</span>
					<div class="col-xs-3" style="float: left; width: 160px; ">
						<input id="endDateId" type="text"  ng-blur="cleanFlagFunEnd(queryData.endReleaseDate);" ng-init="getNowDateStr();"  ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endReleaseDate"> 
						<!-- <button type="button" class="close" aria-hidden="true" ng-click="removeEndDate();" style="margin-top:-30px;margin-right:15px;">&times;</button> -->
						<span class="input-group-addon" style="display: none">
							<span class="glyphicon glyphicon-calendar">
							</span>
						</span>
					</div> 
					<div style="">
						<input style="margin-top: 6px" type="button" class="btn btn-primary" value="查询" contenteditable="true" ng-click="queryDemandExamineData(1);"/>
					</div>
				</div>
			</ul>
		</div>
		<div>
			<table class="table table-striped table-hover" style="margin-left: 5%;width:84%">
				<thead>
					<tr class="success">
						<th style="text-align:center;width: 1%;"></th>
						<th style="text-align:center;width:3%">序号</th >
						<th style="text-align:center;">信息类型</th>
						<th style="text-align:center;">信息标题</th>
						<th style="text-align:center;width: 9%;">设备名称</th>
						<th style="text-align:center;width: 15%;">单位名称</th>
						<th style="text-align:center;width: 11%;">联系人</th>
						<th style="text-align:center;width: 7%;">联系电话</th>
						<th style="text-align:center;width: 15%;">发布日期</th>
						<th style="text-align:center;width: 6%;">审核状态</th>
					</tr>
				</thead>
				<tbody ng-show="showTable == true">
					<tr ng-repeat="t in demandExamineList" style="text-align:center;" ng-click="check(t,$index+1)" ng-dblclick="openDetailModal()" >
					<!-- 	<td>
							<input style="margin-left:-10px;margin-top:1px;" type="radio" name="demandid" ng-checked="radioTrIndex==$index+1"/>&nbsp;
							<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
						</td> -->
						<td>
							<input style="margin: 2px -17px 0 14px;" type="radio" name="demandid" ng-checked="radioTrIndex==$index+1"/>
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px 19px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
						</td>
				        <td>{{ct.codeTranslate(t.dataType,"MESSAGE_TYPE")}}</td>
						<td title="{{t.infoTitle}}">{{t.infoTitleTemp}}</td>
						<td title="{{t.equName}}">{{t.equNameTemp}}</td><!-- 设备名称 -->
						<td title="{{t.enterpriseName}}">{{t.enterpriseNameTemp}}</td>
						<td title="{{t.contactPerson}}">{{t.contactPersonTemp}}</td>
						<td>{{t.contactPhone}}</td>
						<td>{{t.releaseDate}}</td>
						<td>{{ct.codeTranslate(t.dataState.dataState,"AUDIT_STATE")}}</td>
					</tr>
				</tbody>
			</table>
			<div class="form-horizontal" >
				<ul>
					<div class="form-group">
						<div class="col-xs-2" style="margin-left:10px;margin-top:-12px;">
							<input type="button" ng-show="auditButton" class="btn btn-primary" value="查看" ng-click="openDetailModal()">
						</div>
						<div style="margin-top: -38px;float: right;margin-right: 150px"  ng-show="demandExamineList.length!==0">
							<tm-pagination conf="paginationConf" style="margin-left:200px;"></tm-pagination>
						</div>
					</div>
				</ul>
			</div>
		</div>
	</form>
	<div ng-include src="'./auditQuery/auditQueryDemandRentBtn.jsp'" ></div>	
	<div ng-include src="'./auditQuery/auditQueryDemandSaleBtn.jsp'" ></div>
	<div ng-include src="'./auditQuery/auditQueryRentBtn.jsp'" ></div>
	<div ng-include src="'./auditQuery/auditQuerySaleBtn.jsp'" ></div>
</body>
</html>