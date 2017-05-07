<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>资源汇总</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body class="container" >
<ol class="breadcrumb">
	<li style="font-size: 13px;">您的位置：后台管理</li>
	<li style="font-size: 13px">统计查询</li>
	<li style="font-size: 13px">资源汇总</li>
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

		<div class="col-xs-1">
			<input type="button" class="btn btn-primary" value="查询" style="margin-top: 8px; width: 60px;" contenteditable="true" ng-click="queryEquipmentData()"/>
		</div>
	</div>
</div>

<div style="padding-top: 30px;">
	<table class="table table-striped table-hover">
		<thead>
			<tr class="success">
				<td rowspan="2" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">设备名称</td>
				<td rowspan="2" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">计量</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">小计</td>
				<td colspan="3" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">自有</td>
				<td colspan="2" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">内租</td>
				<td colspan="2" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">外租</td>
				<td colspan="2" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">外协</td>
			</tr>
			<tr class="success">
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">数量</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">数量</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">原值（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">净值（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">数量</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">原值（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">数量</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">原值（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">数量</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">原值（万元）</td>
			</tr>
		</thead>
		<tbody>
			<tr ng-repeat="row in equipmentList">
				<td style="white-space: nowrap; text-align: left; height: 22px; padding-left: 30px; padding-right: 10px;" >
					<span class="glyphicon glyphicon-plus" ng-click="openCategory($index, row.equCategoryId, row.result)" ng-show="row.result.type=='OPEN_'"></span>
	            	<span class="glyphicon glyphicon-minus" ng-click="closeCategory($index, row.equCategoryId, row.result)" ng-show="row.result.type=='CLOSE_'"></span>
	            	<span ng-show="row.result.type=='TAB_' && row.equCategoryId!='999999999999'" style="padding-left: 40px;">&nbsp;</span>
	            	<span ng-show="row.result.type=='TAB_' && row.equCategoryId=='999999999999'" style="padding-left: 10px;">&nbsp;</span>
					<span ng-show="row.result.type!='TAB_' || row.equCategoryId=='999999999999'" ng-bind="row.result.equCategoryName" style="font-size: 15px; font-weight: bolder;"></span>
					<span ng-show="row.result.type=='TAB_' && row.equCategoryId!='999999999999'" ng-bind="row.result.equCategoryName"></span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;" ng-bind="ct.codeTranslate(row.result.second, 'UNIT_NAME')"></td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum1 || row.result.totalNum2 || row.result.totalNum3 || row.result.totalNum4" ng-bind="row.result.totalNum1 + row.result.totalNum2 + row.result.totalNum3 + row.result.totalNum4"></span>
					<span ng-if="!row.result.totalNum1 && !row.result.totalNum2 && !row.result.totalNum3 && !row.result.totalNum4">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum1" ng-bind="row.result.totalNum1"></span>
					<span ng-if="!row.result.totalNum1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.equipmentCost1" ng-bind="row.result.equipmentCost1"></span>
					<span ng-if="!row.result.equipmentCost1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.netValue1" ng-bind="row.result.netValue1"></span>
					<span ng-if="!row.result.netValue1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum2" ng-bind="row.result.totalNum2"></span>
					<span ng-if="!row.result.totalNum2">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.equipmentCost2" ng-bind="row.result.equipmentCost2"></span>
					<span ng-if="!row.result.equipmentCost2">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum3" ng-bind="row.result.totalNum3"></span>
					<span ng-if="!row.result.totalNum3">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.equipmentCost3" ng-bind="row.result.equipmentCost3"></span>
					<span ng-if="!row.result.equipmentCost3">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum4" ng-bind="row.result.totalNum4"></span>
					<span ng-if="!row.result.totalNum4">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.equipmentCost4" ng-bind="row.result.equipmentCost4"></span>
					<span ng-if="!row.result.equipmentCost4">0</span>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="form-horizontal" >
	<div class="form-group" style="margin: 0px;" ng-show="isShowFlag" >
		<div>
			<input type="button" class="btn btn-primary" value="导出&nbsp;&nbsp;Excel" ng-click="exportExcel()" style="width: 90px;">
		</div>
	</div>
</div>

<div ng-include src="'./StatisticalReports/employer.jsp'" ></div>

<div class="modal fade" id="exportExcelModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" >
	<div class="modal-dialog" style="width: 350px;margin-top:13%">
		<div class="modal-content">
			<div class="modal-header">
				<div style="margin:20px 0 20px 20px;">数据导出需要一点儿时间，请您耐心等待</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>
