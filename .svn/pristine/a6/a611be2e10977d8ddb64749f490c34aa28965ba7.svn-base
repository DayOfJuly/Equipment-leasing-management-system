<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>资源明细</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body class="container" >
<ol class="breadcrumb">
	<li style="font-size: 13px;">您的位置：后台管理</li>
	<li style="font-size: 13px">统计查询</li>
	<li style="font-size: 13px">资源明细</li>
</ol>
<div class="form-horizontal">
	<div class="form-group">
		<label contenteditable="false" class="col-xs-1 control-label">当前单位：</label>
		<div class="col-xs-2" >
			<div class="input-group" ng-show="equDtlQryBean.isOrgShowFlag">
				<input ng-model="equDtlQryBean.orgName" type="text" class="form-control" style="width: 270px; margin-left: -30px; height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
				<span class="input-group-btn" style="padding-top: 8px;">
					<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEmployerModel()">…</button>
				</span>
			</div>
			<input ng-show="!equDtlQryBean.isOrgShowFlag" ng-model="equDtlQryBean.orgNameInput" type="text" class="form-control" style="width: 300px; margin-left: -30px; height: 22px; background-color: #fff;" readonly="readonly">
		</div>
		<div class="col-xs-1" style="margin-top: 3px; margin-left: -36px;">
			<input ng-model="equDtlQryBean.isInclude" ng-show="equDtlQryBean.orgFlag==1 || equDtlQryBean.orgFlag==9" ng-disabled="equDtlQryBean.orgFlag!=1" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: 68px; margin-top: 10px;">
			<label contenteditable="false" ng-show="equDtlQryBean.orgFlag==1 || equDtlQryBean.orgFlag==9" class="control-label" style="text-align: left; margin-left: 88px; position: absolute; z-index: 2;">包含下级单位</label>
		</div>

		<div class="col-xs-1">&nbsp;</div>
		<label contenteditable="false" class="col-xs-1 control-label" ng-show="4==userInfo.orgParTypeId">来源：</label>
		<div class="col-xs-1" style="margin-left: -28px;" ng-show="4==userInfo.orgParTypeId">
			<select id="equTrsType" name="equTrsType" class="form-control select-hover" ng-model="equDtlQryBean.equTrsType" 
				ng-options="row.id_ as row.name_ for row in sysCodeCon.EQU_DTL_QRY_TYPE" style="height: 22px;">
				<option value="">全部</option>
			</select>
		</div>

		<label contenteditable="false" class="col-xs-1 control-label">设备分类：</label>
		<div class="col-xs-1" style="margin-left: -28px;">
			<select id="equCategoryId" name="equCategoryId" class="form-control select-hover" ng-model="equDtlQryBean.equCategoryId" 
				ng-options="cateInfo.equCategoryId as cateInfo.equipmentCategoryName for cateInfo in categoryList" style="height: 22px;">
				<option value="">全部</option>
			</select>
		</div>

		<label contenteditable="false" class="col-xs-1 control-label">设备名称：</label>
		<div class="col-xs-1">
			<input ng-model="equDtlQryBean.equName" type="text" class="form-control" style="width: 180px; margin-left: -28px; height: 22px; background-color: #fff;">
		</div>

		<div class="col-xs-1 pull-right">
			<input type="button" class="btn btn-primary" value="查询" style="margin-top: 8px; width: 60px;" contenteditable="true" ng-click="queryEquipmentData(1)"/>
		</div>
	</div>
</div>

<div style="padding-top: 30px;">
	<table class="table table-striped table-hover">
		<thead>
			<tr class="success">
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">设备编号</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">来源</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">资产编号</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">设备名称</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">规格</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">型号</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">品牌</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">生产厂家</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">技术状况</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">功率（KW）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">原值（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">累计折旧（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">净值（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">出厂日期</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">出厂编号</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">购置日期</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">牌照号码</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">设备状态</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">业务状态</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">进场日期</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">使用单位</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">联系人</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">联系电话</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">设备所在地</td>
			</tr>
		</thead>
		<tbody>
			<tr ng-repeat="row in equipmentList">
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.equNo"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.equTrsType, 'EQU_DTL_QRY_TYPE')"><!-- 获取数据集合后，需要处理后显示 --></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.asset"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.equName"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.specifications"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.models"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.brandName"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.manufacturerName"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.technicalStatus, 'TECHNOLOGY_STATE')"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.power"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.equipmentCost"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.totalDepreciation"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.equipmentCost - row.totalDepreciation"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.productionDate"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.facortyNo"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.purchaseDate"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.licenseNo"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.equState,'EQU_STATE')"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.busState,'WORK_STATE')"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.approachDate"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.disEquAtName"></td><!-- 获取数据集合后，需要处理后显示 -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.custodian"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.contactPersonPhone"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" >{{row.onProvince}} - {{row.onCity}} - {{row.onDistrict}}</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="form-horizontal" >
	<div class="form-group" style="margin: 0px;" ng-show="isShowFlag" >
		<div>
			<input type="button" class="btn btn-primary" value="导出&nbsp;&nbsp;Excel" ng-click="openExportExcelModal()" style="width: 90px;">
		</div>
		<div style="text-align: right; margin-left: 900px; margin-top: -50px;">
			<tm-pagination conf="paginationConf" ></tm-pagination>
		</div>
	</div>
</div>

<div ng-include src="'./StatisticalReports/employer.jsp'" ></div>

<div class="modal fade" id="exportExcelModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 550px; margin-top: 13%;">
		<div class="modal-content">
			<div class="modal-header">
				<div style="margin: 20px 0 20px 20px;">
					从第<input type="text" style="width: 40px;" ng-model="equDtlQryBean.start"/>条，
					导出<input type="text" style="width: 50px;" ng-model="equDtlQryBean.itemCount"/>条
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-primary" value="导出" ng-click="exportExcel()" style="width: 60px;">
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>