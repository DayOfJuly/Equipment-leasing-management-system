<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>资源管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
textarea {width: 1200px; max-width: 730px; height: 60px; max-height: 60px;}
.div_Modify{padding-left: 0px;}
::-ms-clear, ::-ms-reveal{display: none;}
.Infopub_a1:link {text-decoration: none;}
.Infopub_a1:visited {text-decoration: none;}
.Infopub_a1:hover {text-decoration: none;}
.Infopub_a1:active {text-decoration: none;}
.page-list .pagination {float: left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top: none; border-bottom: none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float: left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left: 3px;}
.page-list .page-total select {width: 50px;}
</style>
</head>

<body  class="container" >
<ol class="breadcrumb">
	<li style="font-size: 13px;">您的位置：后台管理</li>
	<li style="font-size: 13px;">资源管理</li>
</ol>
<form action="" style="width: 95%; margin-left: 8.7%;" autocomplete="off">
	<div class="form-horizontal">
		<div class="form-group" style="margin-top: -10px;">
			<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: -10%;">当前单位：</label>
			<div class="col-xs-2" >
				<div class="input-group" ng-show="!userInfo.proId">
					<input ng-model="equQryBean.orgName" type="text" class="form-control" style="width: 120%; margin-left: -20%; height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
					<span class="input-group-btn" style="padding-top: 8px;">
						<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEmployerModel()">…</button>
					</span>
				</div>
				<input ng-show="userInfo.proId" ng-model="equQryBean.orgNameInput" type="text" class="form-control" style="width: 117%; margin-left: -17%; height: 22px; background-color: #fff;" readonly="readonly">
			</div>
			<div class="col-xs-2" style="margin-top: 3px; margin-left: -153px;" ng-show="!userInfo.proId && (equQryBean.orgFlag==9 || equQryBean.orgFlag==1)">
				<input ng-model="equQryBean.isInclude" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: 56%; margin-top: 10px;">
				<label contenteditable="false" class="control-label" style="text-align: left; margin-left: 64%; position: absolute; z-index: 2;">包含下级单位</label>
			</div>

			<div class="col-xs-9" style="margin-left: 30%; margin-top: -2%;">
				<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: 10%;">设备使用单位：</label>
				<div class="col-xs-3" >
					<div ng-show="equQryBean.isCrecOrg==0" class="input-group">
						<input ng-model="equQryBean.equAtOrgNameSelect" type="text" class="form-control" style="margin-top: 6px; width: 112%; margin-left: -12%; height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
						<span class="input-group-btn" style="padding-top: 6px;">
							<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEquAtEmployerModel()">…</button>
						</span>
					</div>
					<input style="margin-left: -23px;" ng-show="equQryBean.isCrecOrg==1" ng-model="equQryBean.equAtOrgNameInput" type="text" class="form-control" />
				</div>
				<div class="col-xs-1">
					<input ng-model="equQryBean.isCrecOrg" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: -22px; margin-top: 10px;">
					<label contenteditable="false" class="control-label" style="text-align: left; position: absolute; z-index: 2; margin-left: -3px;">非中铁单位</label>
				</div>
			</div>
		</div>

		<div class="form-group" style="margin-top: 10px;">
			<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: -10%;">设备状态：</label>
			<div class="col-xs-1" style="margin-left: -35px;">
				<select ng-model="equQryBean.equState" class="form-control">
					<option value="">全部</option>
					<option value="1">闲置</option>
					<option value="2">使用中</option>
				</select>
			</div>
			<div class="col-xs-2" style="margin-top: 3px; margin-left: -122px;" ng-show="userInfo.orgLevel_show!=3">
				<input ng-model="equQryBean.isSaled" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: 56%; margin-top: 10px;">
				<label contenteditable="false" class="control-label" style="text-align: left; margin-left: 64%; position: absolute; z-index: 2;">包含已出售</label>
			</div>
			<div class="col-xs-2" style="margin-top: 3px; margin-left: -112px;" ng-show="userInfo.orgLevel_show!=3">
				<input ng-model="equQryBean.isScraped" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: 56%; margin-top: 10px;">
				<label contenteditable="false" class="control-label" style="text-align: left; margin-left: 64%; position: absolute; z-index: 2;">包含已报废</label>
			</div>

			<div class="col-xs-9" style="margin-left: 30%; margin-top: -2%;">
				<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: 10%;">设备名称：</label>
				<div class="col-xs-3" style="margin-left: -23px;">
					<input ng-model="equQryBean.equName" type="text" class="form-control" />
				</div>
				<div class="col-xs-1">
					<input type="button" class="btn btn-primary" value="查询" style="margin-top: 7px; width: 60px;" contenteditable="true" ng-click="queryEquipmentData(1)"/>
				</div>
			</div>
		</div>
	</div>

	<div style="overflow: auto; margin-left: 50px; margin: 14px 62px 0px -123px;">
		<table class="table table-striped table-hover">
			<thead>
				<tr class="success">
					<th style="white-space: nowrap; text-align: center; width: 1%"></th>
					<th style="white-space: nowrap; text-align: center; width: 3%">序号</th>
					<th style="white-space: nowrap; text-align: center; width: 10%;">局级单位</th>
					<th style="white-space: nowrap; text-align: center; width: 12%;">子公司名称</th>
					<th style="white-space: nowrap; text-align: center; width: 12%;">项目名称</th>
					<th style="white-space: nowrap; text-align: center; width: 6%;">设备编号</th>
					<th style="white-space: nowrap; text-align: center; width: 8%;">设备来源分类</th>
					<th style="white-space: nowrap; text-align: center; width: 4%;">资产编号</th>
					<th style="white-space: nowrap; text-align: center; width: 8%;">设备名称</th>
					<th style="white-space: nowrap; text-align: center; width: 6%;">品牌</th>
					<th style="white-space: nowrap; text-align: center; width: 4%;">型号</th>
					<th style="white-space: nowrap; text-align: center; width: 4%;">规格</th>
					<th style="white-space: nowrap; text-align: center; width: 10%;">生产厂家</th>
					<th style="white-space: nowrap; text-align: center; width: 6%">出厂日期</th>
					<th style="white-space: nowrap; text-align: center; width: 6%">购置日期</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="t in equipmentList" style="text-align: center;" ng-click="equipSelect(t.equipmentId, t.equFlag, t.equState, $index + 1)" ng-dblclick="openQueryModal(t.equipmentId, t.equFlag, t.equState, $index + 1)">
					<td><input style="margin: 2px -53px 0 0px;" type="radio" name="selectEquId" ng-checked="selectFlag==$index + 1" /></td>
					<td><p align="left" style="margin: 0px -9px -2px 30px;">{{$index + 1 + (paginationConf.currentPage - 1) * paginationConf.itemsPerPage}}</p></td>
					<td style="text-align: center;" title="{{t.bureauOrgPartyName}}">{{t.bureauOrgPartyNameCopy}}</td>
					<td style="text-align: center;" title="{{t.sonOrgName}}">{{t.sonOrgNameCopy}}</td>
					<td style="text-align: center;" title="{{t.proOrgName}}">{{t.proOrgNameCopy}}</td>
					<td style="text-align: center;" title="{{t.equNo}}">{{t.equNoCopy}}</td>
					<td style="text-align: center;">
						<span ng-show="t.equFlag==1" ng-bind="ct.codeTranslate(t.equipmentSourceNo,'SOURCE_TYPE')"></span>
						<span ng-show="t.equFlag==0" ng-bind="ct.codeTranslate(t.busState,'WORK_STATE')"></span>
					</td>
					<td style="text-align: center;" title="{{t.asset}}">{{t.assetCopy}}</td>
					<td style="text-align: center;" title="{{t.equName}}">{{t.equNameCopy}}</td>
					<td style="text-align: center;" title="{{t.brandName}}">{{t.brandNameCopy}}</td>
					<td style="text-align: center;" title="{{t.models}}">{{t.modelsCopy}}</td>
					<td style="text-align: center;" title="{{t.specifications}}">{{t.specificationsCopy}}</td>
					<td style="text-align: center;" title="{{t.manufacturerName}}">{{t.manufacturerNameCopy}}</td>
					<td style="text-align: center;">{{t.productionDate}}</td>
					<td style="text-align: center;">{{t.purchaseDate}}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="form-horizontal" style="margin-top: -30px;">
		<div class="form-group" style="margin-top: 2%;">
			<div>
				<input type="button" class="btn btn-primary" ng-show="btnShow_" value="查看" ng-click="openQueryModal()" style="width: 60px;">
				<input type="button" class="btn btn-primary" ng-disabled="!levelFlag" value="添加" ng-click="openAddModal()" style="width: 60px;">
				<input type="button" class="btn btn-primary" ng-show="btnShow_" ng-disabled="!levelFlag || qryEquDetail.equFlag==0" value="修改" ng-click="openUpdModal()" style="width: 60px;">
				<input type="button" class="btn btn-primary" ng-show="btnShow_" ng-disabled="!levelFlag || qryEquDetail.equFlag==0 || qryEquDetail.equState==1 || qryEquDetail.equState==2" value="删除" ng-click="openDelModal()" style="width: 60px;">
			</div>
			<div style="text-align: right;margin-left: 50%;margin-top:-50px;" ng-if="equipmentList.length!=0">
				<tm-pagination conf="paginationConf" ></tm-pagination>
			</div>
		</div>
	</div>
</form>

<div ng-include src="'./Equipment/employer.jsp'" ></div>
<div ng-include src="'./Equipment/equAtEmployer.jsp'" ></div>
<div ng-include src="'./Equipment/EquipmentMessage.jsp'"></div>
<div ng-include src="'./Equipment/EquipmentAdd-Modify.jsp'" ></div>
<div ng-include src="'./Equipment/project.jsp'" ></div>
<div ng-include src="'./Equipment/equName.jsp'" ></div>
<div ng-include src="'./Equipment/equAtProject.jsp'" ></div>
</body>
</html>
