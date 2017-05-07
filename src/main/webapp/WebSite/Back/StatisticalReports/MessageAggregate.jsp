<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>信息发布汇总</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body class="container" >
<ol class="breadcrumb">
	<li style="font-size: 13px;">您的位置：后台管理</li>
	<li style="font-size: 13px">统计查询</li>
	<li style="font-size: 13px">信息发布汇总</li>
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
				<td colspan="5" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">出租信息</td>
				<td colspan="5" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">出售信息</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">求租信息</td><!-- 求租只有发布数，没有发布结果登记功能 -->
<!-- 				<td colspan="5" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">求租信息</td> -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">求购信息</td><!-- 求购只有发布数，没有发布结果登记功能 -->
<!-- 				<td colspan="5" style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-bottom: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">求购信息</td> -->
			</tr>
			<tr class="success">
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">发布数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">作废数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">成交数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">预估金额（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">待成交数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">发布数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">作废数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">成交数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">预估金额（万元）</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">待成交数</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">发布数</td>
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">作废数</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">成交数</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">预估金额（万元）</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">待成交数</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">发布数</td> -->
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">发布数</td><!-- 求购只有发布数，没有发布结果登记功能 -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">作废数</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">成交数</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; border-right: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">预估金额（万元）</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px; border-left: #dddddd solid 1px; font-size: 15px; font-weight: bolder;">待成交数</td> -->
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
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum1" ng-bind="row.result.totalNum1"></span>
					<span ng-if="!row.result.totalNum1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.cancelNum1" ng-bind="row.result.cancelNum1"></span>
					<span ng-if="!row.result.cancelNum1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.turnoveredNum1" ng-bind="row.result.turnoveredNum1"></span>
					<span ng-if="!row.result.turnoveredNum1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.forecastSum1" ng-bind="row.result.forecastSum1"></span>
					<span ng-if="!row.result.forecastSum1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.turnoveringNum1" ng-bind="row.result.turnoveringNum1"></span>
					<span ng-if="!row.result.turnoveringNum1">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum2" ng-bind="row.result.totalNum2"></span>
					<span ng-if="!row.result.totalNum2">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.cancelNum2" ng-bind="row.result.cancelNum2"></span>
					<span ng-if="!row.result.cancelNum2">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.turnoveredNum2" ng-bind="row.result.turnoveredNum2"></span>
					<span ng-if="!row.result.turnoveredNum2">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.forecastSum2" ng-bind="row.result.forecastSum2"></span>
					<span ng-if="!row.result.forecastSum2">0</span>
				</td>
				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.turnoveringNum2" ng-bind="row.result.turnoveringNum2"></span>
					<span ng-if="!row.result.turnoveringNum2">0</span>
				</td>

				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum3" ng-bind="row.result.totalNum3"></span>
					<span ng-if="!row.result.totalNum3">0</span>
				</td>
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.cancelNum3" ng-bind="row.result.cancelNum3"></span> -->
<!-- 					<span ng-if="!row.result.cancelNum3">0</span> -->
<!-- 				</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.turnoveredNum3" ng-bind="row.result.turnoveredNum3"></span> -->
<!-- 					<span ng-if="!row.result.turnoveredNum3">0</span> -->
<!-- 				</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.forecastSum3" ng-bind="row.result.forecastSum3"></span> -->
<!-- 					<span ng-if="!row.result.forecastSum3">0</span> -->
<!-- 				</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.turnoveringNum3" ng-bind="row.result.turnoveringNum3"></span> -->
<!-- 					<span ng-if="!row.result.turnoveringNum3">0</span> -->
<!-- 				</td> -->

				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;">
					<span ng-if="row.result.totalNum4" ng-bind="row.result.totalNum4"></span>
					<span ng-if="!row.result.totalNum4">0</span>
				</td>
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.cancelNum4" ng-bind="row.result.cancelNum4"></span> -->
<!-- 					<span ng-if="!row.result.cancelNum4">0</span> -->
<!-- 				</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.turnoveredNum4" ng-bind="row.result.turnoveredNum4"></span> -->
<!-- 					<span ng-if="!row.result.turnoveredNum4">0</span> -->
<!-- 				</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.forecastSum4" ng-bind="row.result.forecastSum4"></span> -->
<!-- 					<span ng-if="!row.result.forecastSum4">0</span> -->
<!-- 				</td> -->
<!-- 				<td style="white-space: nowrap; text-align: center; height: 22px; padding: 10px;"> -->
<!-- 					<span ng-if="row.result.turnoveringNum4" ng-bind="row.result.turnoveringNum4"></span> -->
<!-- 					<span ng-if="!row.result.turnoveringNum4">0</span> -->
<!-- 				</td> -->
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
