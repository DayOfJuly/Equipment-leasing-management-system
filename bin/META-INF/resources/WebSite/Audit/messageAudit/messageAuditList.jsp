<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>信息审核</title>


<style>
 ::-ms-clear, ::-ms-reveal{display: none;}
.container {width: 1500px !important;}

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

.Infopub_a1:link {
	text-decoration: none;
}
.Infopub_a1:visited {
	text-decoration: none;
}
.Infopub_a1:hover {
	text-decoration: none;
}
.Infopub_a1:active {
	text-decoration: none;
}

</style>
</head>

<body  class="container">
		<div ng-include src="'./Include/TopMenu.jsp'" ></div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：信息审核</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: -10px">
			<ul>
				<div class="form-group" style="margin-left: 14%">
					<label class="col-xs-1 control-label">信息类型：</label>
					<div class="col-xs-1">
						<select class="form-control select-hover" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.MESSAGE_TYPE"
						 style="position: absolute;z-index:3;margin-left:-30px;" ng-model="queryData.dataType" ng-click="a();" >
							<option value="">全部</option>
						</select>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">发布日期：</label>
					<div class="col-xs-3" style="float: left; width: 160px; margin-left:-10px;">
						<input id="beginDateId" type="text"  ng-blur="cleanFlagFunStart(queryData.startReleaseDate);" ng-init="getBeforeDate();" ng-change="complienStart();" 
						class="form-control input-group date form_date" ng-model="queryData.startReleaseDate" >
						<!-- <button type="button" class="close" aria-hidden="true" ng-click="removeBeginDate();" style="margin-top:-30px;margin-right:15px;">&times;</button> -->
							<!-- <span class="input-group-addon" style="display: none" > 
								<span class="glyphicon glyphicon-calendar">
								</span>
							</span> -->
					</div>
					<span style="float: left;margin-top:5px;">——</span>
					<div class="col-xs-3" style="float: left; width: 160px; ">
						<input id="endDateId" type="text" ng-init="getNowDateStr();"  ng-blur="cleanFlagFunEnd(queryData.endReleaseDate);"  ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endReleaseDate"> 
						<!-- <button type="button" class="close" aria-hidden="true" ng-click="removeEndDate();" style="margin-top:-30px;margin-right:15px;">&times;</button> -->
						<span class="input-group-addon" style="display: none">
							<span class="glyphicon glyphicon-calendar">
							</span>
						</span>
					</div> 
					<div class="col-xs-2">
						<input  type="button" class="btn btn-primary" value="查询" contenteditable="true" style="margin-top: 6px" ng-click="queryDemandExamineData(1);"/>
					</div>
				</div>
			</ul>
		</div>
		<div>
			<table class="table table-striped table-hover" style="margin-left: 5%;width:84%">
				<thead>
					<tr class="success">
						<th style="text-align:center;width: 4%;"><span><input type="checkbox" name="checkName" ng-model="checkObj.isAllCheck" ng-click="changAllCheck();"/>全选</span></th>
						<th style="text-align:center;width: 1%;"></th>
						<th style="text-align:center;">信息类型</th>
						<th style="text-align:center;">信息标题</th>
						<th style="text-align:center;width: 9%;">设备名称</th>
						<th style="text-align:center;">单位名称</th>
						<th style="text-align:center;">联系人</th>
						<th style="text-align:center;width: 8%;">联系电话</th>
						<th style="text-align:center;">发布日期</th>
						<th style="text-align:center;">状态</th>
					</tr>
				</thead>
				<tbody >
					<tr ng-repeat="t in demandExamineListCopy" style="text-align:center;" ng-click="check(this)"  >
					<!-- 	<td>
							<input style="margin-left:-28px;margin-top:1px;" type="checkbox" name="demandid"  ng-checked="t.check_" />
							<p class="copyP" style="margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
						</td> -->
						<td>
							<input style="margin: 2px -17px 0 -45px;" type="checkbox" name="demandid"  ng-checked="t.check_" />
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px -28px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
						</td>
						<td>{{ct.codeTranslate(t.dataType,"MESSAGE_TYPE")}}</td>
						<td title="{{t.infoTitle}}">{{t.infoTitleTemp}}</td>
						<td title="{{t.equName}}">{{t.equNameTemp}}</td><!-- 设备名称 -->
						<td title="{{t.enterpriseName}}">{{t.enterpriseNameTemp}}</td><!-- 单位名称 -->
						<td title="{{t.contactPerson}}">{{t.contactPersonTemp}}</td>
						<td>{{t.contactPhone}}</td>
						<td>{{t.releaseDate}}</td>
						<td>{{ct.codeTranslate(t.dataState.dataState,"AUDIT_STATE")}}</td>
					</tr>
				</tbody>
			</table>
			<div class="form-horizontal" >
				<ul>
					<div class="form-group" >
						<div class="col-xs-1" style="margin-left:10px;margin-top:-13px;">
							<input type="button" ng-show="auditButton" class="btn btn-primary" ng-disabled="disabledValue" value="审核" ng-click="openDetailModal(checkValueList,demandExamineListCopy)">
						</div>
						<div class="col-xs-1" style="text-align:left;margin-top:-13px;margin-left:-76px;">
							<input type="button" ng-show="auditButton" class="btn btn-primary" value="批量审核" ng-click="batchAudit()">
						</div>
						<div style="margin-top: -38px;float: right;margin-right: 155px"  >
							<tm-pagination conf="paginationConf" style="margin-left:500px;"></tm-pagination>
						</div>
					</div>
				</ul>
			</div>
		</div>
	</form>
	<div ng-include src="'./messageAudit/demandRentDetail.jsp'" ></div>
	<div ng-include src="'./messageAudit/demandSaleDetail.jsp'" ></div>	
	<div ng-include src="'./messageAudit/rentDetail.jsp'" ></div>	
	<div ng-include src="'./messageAudit/saleDetail.jsp'" ></div>
	<div ng-include src="'./messageAudit/demandRentOpinion.jsp'" ></div>	
</body>
</html>