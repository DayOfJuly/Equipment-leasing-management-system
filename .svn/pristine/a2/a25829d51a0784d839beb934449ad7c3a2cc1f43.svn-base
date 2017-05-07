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
	<li style="font-size: 13px;">外部企业用户</li>
	<li style="font-size: 13px;">资源管理</li>
</ol>
<form action="" style="width: 95%; margin-left: 8.7%;" autocomplete="off">
	<div class="form-horizontal">
		<div class="form-group" style="margin-top: -10px;">
			<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: -10%;">当前单位：</label>
			<div class="col-xs-4" style="margin-top: 8px;">
				<span ng-bind="userInfo.orgName" style="margin-left: -30px;"></span>
			</div>

			<div class="col-xs-9" style="margin-left: 30%; margin-top: -2%;">
				<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: 10%;">设备使用单位：</label>
				<div class="col-xs-3" >
					<div ng-show="equQryBean.isCrecOrg==0" class="input-group">
						<input ng-model="equQryBean.equAtOrgNameSelect" type="text" class="form-control" style="margin-top: 6px; width: 112%; margin-left: -12%; height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
						<span class="input-group-btn" style="padding-top: 6px;">
							<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEquAtEmployerModel(1)">…</button>
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
					<th style="white-space: nowrap; text-align: center; width: 10%;">设备编号</th>
					<th style="white-space: nowrap; text-align: center; width: 8%;">资产编号</th>
					<th style="white-space: nowrap; text-align: center; width: 10%;">设备名称</th>
					<th style="white-space: nowrap; text-align: center; width: 10%;">品牌</th>
					<th style="white-space: nowrap; text-align: center; width: 8%;">型号</th>
					<th style="white-space: nowrap; text-align: center; width: 8%;">规格</th>
					<th style="white-space: nowrap; text-align: center; width: 13%;">生产厂家</th>
					<th style="white-space: nowrap; text-align: center; width: 8%">出厂日期</th>
					<th style="white-space: nowrap; text-align: center; width: 8%">购置日期</th>
					<th style="white-space: nowrap; text-align: center; width: 13%">设备使用单位</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="t in equipmentList" style="text-align: center;" ng-click="equipSelect(t.equipmentId, t.equFlag, t.equState, $index + 1)" ng-dblclick="openQueryModal(t.equipmentId, t.equFlag, t.equState, $index + 1)">
					<td><input style="margin: 2px -53px 0 0px;" type="radio" name="selectEquId" ng-checked="selectFlag==$index + 1" /></td>
					<td><p align="left" style="margin: 0px -9px -2px 30px;">{{$index + 1 + (paginationConf.currentPage - 1) * paginationConf.itemsPerPage}}</p></td>
					<td style="text-align: center;" title="{{t.equNo}}">{{t.equNoCopy}}</td>
					<td style="text-align: center;" title="{{t.asset}}">{{t.assetCopy}}</td>
					<td style="text-align: center;" title="{{t.equName}}">{{t.equNameCopy}}</td>
					<td style="text-align: center;" title="{{t.brandName}}">{{t.brandNameCopy}}</td>
					<td style="text-align: center;" title="{{t.models}}">{{t.modelsCopy}}</td>
					<td style="text-align: center;" title="{{t.specifications}}">{{t.specificationsCopy}}</td>
					<td style="text-align: center;" title="{{t.manufacturerName}}">{{t.manufacturerNameCopy}}</td>
					<td style="text-align: center;">{{t.productionDate}}</td>
					<td style="text-align: center;">{{t.purchaseDate}}</td>
					<td style="text-align: center;" title="{{t.equAtName}}">{{t.equAtNameCopy}}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="form-horizontal" style="margin-top: -30px;">
		<div class="form-group" style="margin-top: 2%;">
			<div>
				<input type="button" class="btn btn-primary" value="查看" ng-click="openQueryModal()" style="width: 60px;">
				<input type="button" class="btn btn-primary" value="添加" ng-click="openAddModal()" style="width: 60px;">
				<input type="button" class="btn btn-primary" value="修改" ng-disabled="qryEquDetail.equFlag==0" ng-click="openUpdModal()" style="width: 60px;">
				<input type="button" class="btn btn-primary" value="删除" ng-disabled="qryEquDetail.equFlag==0 || qryEquDetail.equState==1 || qryEquDetail.equState==2" ng-click="openDelModal()" style="width: 60px;">
			</div>
			<div style="text-align: right;margin-left: 50%;margin-top:-50px;" ng-if="equipmentList.length!=0">
				<tm-pagination conf="paginationConf" ></tm-pagination>
			</div>
		</div>
	</div>
</form>

<div ng-include src="'./externalCompany/outEquipment/outEquAtEmployer.jsp'" ></div>
<div ng-include src="'./externalCompany/outEquipment/outEquipmentMessage.jsp'"></div>
<div ng-include src="'./externalCompany/outEquipment/outEquipmentAdd-Modify.jsp'" ></div>
<div ng-include src="'./externalCompany/outEquipment/outEquName.jsp'" ></div>
<div ng-include src="'./externalCompany/outEquipment/equAtProject.jsp'" ></div>
</body>
</html>
