<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>项目设置</title>
<link href="../../../css/heightLight.css" rel="stylesheet">

<style>
.container {width: 1500px !important;}  

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}

 textarea {
	width: 1400px;
	max-width: 900px;
	height: 60px;
	max-height: 60px;
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
<div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">系统管理</li>
		<li style="font-size: 13px">项目设置</li>
	</ol>
	<form action="" name="queryForm" style="width: 95%;" autocomplete="off">
		<div class="form-horizontal" style="margin-left: 30%; margin-bottom: 20px;">
			<div class="form-group" style="margin-top: 0px;">
				<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: -10%;">当前单位：</label>
				<div class="col-xs-4" >
					<div class="input-group" ng-show="!userInfo.proId && userInfo.orgLevel!=3">
						<input ng-model="proQryBean.name" type="text" class="form-control" style="height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
						<span class="input-group-btn" style="padding-top: 8px;">
							<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEmployerModel()">…</button>
						</span>
					</div>
					<input ng-show="userInfo.proId || userInfo.orgLevel==3" ng-model="proQryBean.nameInput" type="text" class="form-control" style="height: 22px; background-color: #fff;" readonly="readonly">
				</div>
				<div class="col-xs-1" style="margin-left: 60px;">
					<input type="button" class="btn btn-primary" value="查询" style=" margin-top: 10px; width: 60px;" contenteditable="true" ng-click="queryProjects(1)"/>
				</div>
			</div>
		</div>
		<div style="margin-left: 30px;">
			<table class="table table-hover" style="width: 95%; margin-left: 3%;">
				<tbody >
					<tr class="success" >
						<th style="white-space: nowrap;text-align: center; width: 1%;"></th>
						<th style="text-align: center; width: 3%;"><span>序号</span></th>
						<th style="text-align: center; width: 8%;">项目编号</th>
						<th style="text-align: center; width: 20%;">项目名称</th>
						<th style="text-align: center; width: 10%;">项目所属单位编号</th>
						<th style="text-align: center; width: 8%;">负责人</th>
						<th style="text-align: center; width: 10%;">联系电话</th>
						<th style="text-align: center; width: 20%;">所在城市</th>
						<th style="text-align: center; width: 8%;">状态</th>
						<th style="text-align: center; width: 12%;">最后更新时间</th>
					</tr>
				</tbody>
				<tbody>
					<tr ng-repeat="entity in proList" style="text-align: center;" ng-click="clickSelect(entity.currOrgId,entity.state, $index + 1);" ng-dblclick="queryProDetail(entity.currOrgId, $index + 1)">
						<td>
							<input style="margin: 2px -17px 0 0px;" type="radio" name="cliInfo" ng-checked="radioTrIndex==$index + 1" />
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px 19px;">{{$index + 1 + (paginationConf.currentPage - 1) * paginationConf.itemsPerPage}}</p> 
						</td>
						<td style="text-align:center;" title="{{entity.code}}">{{entity.codeCopy}}</td>
						<td style="text-align:center;" title="{{entity.name}}">{{entity.nameCopy}}</td>
						<td style="text-align:center;" title="{{entity.parentCode}}">{{entity.parentCodeCopy}}</td>
						<td style="text-align:center;" ng-bind="entity.contacts"></td>
						<td style="text-align:center;" ng-bind="entity.contactsMobile"></td>
						<td style="text-align:center;">
							{{entity.atProvinceName}}
							<span ng-show="entity.atCityName"> - {{entity.atCityName}}</span>
							<span ng-show="entity.atDistrictName"> - {{entity.atDistrictName}}</span>
						</td>
						<td style="text-align:center;">{{ct.codeTranslate(entity.state,"PRO_STATE")}}</td>
						<td style="text-align:center;" title="{{entity.updateTime}}">{{entity.updateTime | date:'shortDate'}}</td>
					</tr>
				</tbody>
			</table>
			<div style="margin-left: 10px">
				<div style="margin-top: -1%; margin-left: 5%;">
					<button type="button" class="btn btn-primary" ng-show="btnShow_" ng-click="queryProDetail()">查看</button>
					<button type="button" class="btn btn-primary" ng-disabled="!levelFlag||dis" ng-click="openAddModal()">添加</button>
					<button type="button" class="btn btn-primary" ng-show="btnShow_" ng-disabled="!levelFlag" ng-click="openUpdModal()">修改</button>
					<button type="button" class="btn btn-primary" ng-show="btnShow_&&btnShowFlag==true" ng-disabled="!levelFlag" ng-click="stopOrGoOn()">开工</button>
					<button type="button" class="btn btn-primary" ng-show="btnShow_&&btnShowFlag==false" ng-disabled="!levelFlag" ng-click="stopOrGoOn()">完工</button>
				</div>
				<div style="text-align: right; float: right; margin-right: 5%;">
					<tm-pagination conf="paginationConf" style="margin-top: -9%;" ></tm-pagination>
				</div>
			</div>
		</div>
	</form>
</div>

<div ng-include src="'./ProjectSetting/employer.jsp'"></div>
<div ng-include src="'./ProjectSetting/projectQuery/projectQuery.jsp'"></div>

<div ng-include src="'./ProjectSetting/projectAddandUpd/projectAddAndUpd.jsp'"></div>
<div ng-include src="'./ProjectSetting/projectStopOrGoOn/projectStopOrGoOn.jsp'"></div>
</body>
</html>