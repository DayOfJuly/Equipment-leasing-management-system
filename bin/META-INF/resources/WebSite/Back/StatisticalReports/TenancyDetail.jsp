<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>租赁明细</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body class="container" >
<ol class="breadcrumb">
	<li style="font-size: 13px;">您的位置：后台管理</li>
	<li style="font-size: 13px">统计查询</li>
	<li style="font-size: 13px">租赁明细</li>
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
			<input ng-show="!equDtlQryBean.isOrgShowFlag" ng-model="equDtlQryBean.orgNameInput" type="text" class="form-control" style="width: 412px; margin-left: -30px; height: 22px; background-color: #fff;" readonly="readonly">
		</div>
		<div class="col-xs-1" style="margin-top: 3px; margin-left: -36px;">
			<input ng-show="equDtlQryBean.orgFlag==1 || equDtlQryBean.orgFlag==9" ng-disabled="equDtlQryBean.orgFlag!=1" ng-model="equDtlQryBean.isInclude" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: 68px; margin-top: 10px;">
			<label ng-show="equDtlQryBean.orgFlag==1 || equDtlQryBean.orgFlag==9" contenteditable="false" class="control-label" style="text-align: left; margin-left: 88px; position: absolute; z-index: 2;">包含下级单位</label>
		</div>

		<div class="col-xs-1">&nbsp;</div>

		<label contenteditable="false" class="col-xs-1 control-label">设备分类：</label>
		<div class="col-xs-1" style="margin-left: -28px; width: 160px;">
			<select id="equCategoryId" name="equCategoryId" class="form-control select-hover" ng-model="equDtlQryBean.equCategoryId" 
				ng-options="cateInfo.equCategoryId as cateInfo.equipmentCategoryName for cateInfo in categoryList" style="height: 22px;">
				<option value="">全部</option>
			</select>
		</div>

		<label contenteditable="false" class="col-xs-1 control-label">设备名称：</label>
		<div class="col-xs-1">
			<input ng-model="equDtlQryBean.equName" type="text" class="form-control" style="width: 180px; margin-left: -28px; height: 22px; background-color: #fff;">
		</div>
	</div>
	<div class="form-group" style="margin: 0px;">
		<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: 2px;">起止年月：</label>
		<div class="col-xs-3">
			<div class="col-xs-5">
				<input ng-model="equDtlQryBean.startMonth" id="startMonth" name="startMonth" type="text" class="form-control input-group input-append date form_date" style="height: 22px; width: 180px; margin-left: -45px;" data-date-format="yyyy-mm">
			</div>
			<div class="col-xs-1" style="margin-left: 16px;">_</div>
			<div class="col-xs-5">
				<input ng-model="equDtlQryBean.endMonth" id="endMonth" name="endMonth" type="text" class="form-control input-group input-append date form_date" style="height: 22px; width: 180px;" data-date-format="yyyy-mm">
			</div>
		</div>

		<div class="col-xs-1">&nbsp;</div>

		<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: -37px;">业务类型：</label>
		<div class="col-xs-1" style="margin-left: -29px; width: 160px;">
			<select name="equRentType" class="form-control select-hover" ng-model="equDtlQryBean.equRentType" ng-show="4==userInfo.orgParTypeId" 
				ng-options="row.id_ as row.name_ for row in sysCodeCon.EQU_RENT_DTL_QRY_TYPE" style="height: 22px;">
				<option value="">全部</option>
			</select>
			<select name="equRentType" class="form-control select-hover" ng-model="equDtlQryBean.equRentType" ng-show="4!=userInfo.orgParTypeId" 
				ng-options="row.id_ as row.name_ for row in sysCodeCon.EQU_RENT_DTL_QRY_TYPE_OUT" style="height: 22px;">
				<option value="">全部</option>
			</select>
			
		</div>

		<div class="col-xs-2">&nbsp;</div>

		<div class="col-xs-1" style="margin-left: -26px;">
			<input type="button" class="btn btn-primary" value="查询" style="margin-top: 8px; width: 60px;" contenteditable="true" ng-click="queryEquipmentData(1)"/>
		</div>
	</div>
</div>

<div style="padding-top: 30px;">
	<table class="table table-striped table-hover">
		<thead>
			<tr class="success">
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">设备编号</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">资产编号</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">设备名称</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">规格</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">型号</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">拥有单位</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">使用单位</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">租赁所属年月</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">业务类型</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">本期折旧金额（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">进场日期</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">出场日期</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">进出场费用（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">结算方式</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">租期数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">租期单位</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">租赁单价（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">租赁金额（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">报废残值（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">出售售价（万元）</td>
			</tr>
		</thead>
		<tbody>
			<tr ng-repeat="row in equipmentList">
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.equNo"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.asset"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.equName"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.specifications"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.models"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.disOrgName"></td><!-- 获取数据集合后，需要处理后显示 -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.disEquAtOrgName"></td><!-- 获取数据集合后，需要处理后显示 -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.month"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.equRentType, 'EQU_RENT_DTL_QRY_TYPE')"><!-- 获取数据集合后，需要处理后显示 --></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.depreciation"></td><!-- 获取数据集合后，需要处理后显示 -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.approachDate"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.exitDate"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.cost"></td><!-- 获取数据集合后，需要处理后显示 -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.settlementModeName,'COLSE_TYPE')"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.rentCount"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.rentType,'TENANCY_UNIT')"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.rent"></td><!-- 获取数据集合后，需要处理后显示 -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.rentTotalAmt"></td><!-- 获取数据集合后，需要处理后显示 -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.scrapPrice"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="row.sellPrice"></td>
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

<script type="text/javascript">
$('.form_date').datetimepicker({
	format: 'yyyy-mm',
	language : 'zh-CN',
	todayBtn : 1,
	autoclose : 1,
	todayHighlight : 1,
	startView : 3,
	minView : 3,
	forceParse : 0
});
</script>

</body>
</html>
