<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>发布结果登记</title>


<style>
 ::-ms-clear, ::-ms-reveal{display: none;}
.container {width: 1500px !important;}

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}
/**
*新分页的样式css
*/
.page-list .pagination {float:left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float:left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left:3px;}
.page-list .page-total select {width: 50px;}
</style>
<input type="hidden" id="USER_INFO_ORG_ID" value="${sessionScope.userInfo.orgId}">
<input type="hidden" id="USER_INFO_PARENT_CODE" value="${sessionScope.userInfo.code}">
<input type="hidden" id="USER_INFO_ORG_NAME" value="${sessionScope.userInfo.orgName}">
</head>

<body  class="container">
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">外部企业用户</li>
		<li style="font-size: 13px">发布结果登记</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;">
			<ul>
				<div class="form-group" style="margin-top:-10px;padding-bottom: 10px;margin-left: 14%">
					<label contenteditable="false" class="col-xs-2 control-label">流程状态：</label>
					<div class="col-xs-2" id="div_2">
						<select class="form-control select-hover" ng-model="queryData.dataState" style="position: absolute; z-index:3;">
						    <option value="">全部</option>
							<option value="2">未成交</option>
							<option value="1">已成交</option>
						</select>
					</div>  
					<label contenteditable="false" class="col-xs-3 control-label">发布日期：</label>
			 		<div class="col-xs-3" style="float: left; width: 160px; margin-right: -10px;">
						<input ng-click="clickDateFunStart();" ng-blur="cleanFlagFunStart();" id="beginDateId" type="text" ng-init="getBeforeDate();complienStart();" ng-change="complienStart();" class="form-control input-group date form_date" ng-model="queryData.beginDate"> 
						<!-- <button ng-click="cleanDateFunStart();" ng-show="flagStart==true" id="flagStart" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button> -->
 							<span class="input-group-addon" style="display: none" > 
								<span class="glyphicon glyphicon-calendar">
								</span>
							</span>
					</div> 
					<span style="float: left;margin-top:5px;">—</span>
					<div class="col-xs-3" style="float: left; width: 160px; margin-left: -10px;">
						<input ng-click="clickDateFunEnd();" ng-blur="cleanFlagFunEnd();" id="endDateId" type="text" ng-init="getNowDateStr();"  ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endDate"><!-- 触发事件 --> 
						<!-- <button ng-click="cleanDateFunEnd();" ng-show="flagEnd==true" id="flagEnd" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button> -->
 						<span class="input-group-addon" style="display: none">
							<span class="glyphicon glyphicon-calendar">
							</span>
						</span>
					</div>
					<div class="col-xs-2" style="margin-left:20px;margin-top:6px">
						<input type="button" class="btn btn-primary" value="查询" ng-click="queryClick(1);" style="z-index:1;"/>
					</div>
				</div>
			</ul>
		</div>
		<div>
			<table class="table table-striped table-hover" style="margin-left: 12%;width:70%">
				<thead>
					<tr class="success">
						<th style="text-align:center;width: 1%;"></th>
						<th style="text-align:center;width: 3%;">序号</th>
						<th style="text-align:center;width: 6%;">设备编号</th>
						<th style="text-align:center;width: 6%;">资产编号</th>
						<th style="text-align:center;width: 7%;">设备名称</th>
						<th style="text-align:center;width: 4%;">品牌</th>
						<th style="text-align:center;width: 5%;">流程状态</th>
						<th style="text-align:center;width: 5%;">业务状态</th>
						<th style="text-align:center;width: 12%;">设备成交单位</th>
						<th style="text-align:center;width: 5%;">发布日期</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="b in busPublishList" style="text-align:center;" ng-click="check(b,$index+1);" ng-dblclick="queryBusPublishClick()">
					<!-- 	<td >
							 <input style="margin-left:-15px;margin-top:1px;" type="radio" name="id" ng-checked="radioTrIndex==$index+1"/>&nbsp;
							 <p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
						</td>	 -->	
						<td>
							<input style="margin: 2px -17px 0 8px;" type="radio" name="id" ng-checked="radioTrIndex==$index+1"/>&nbsp;
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px 19px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
						</td>								
                        <td title="{{userInfo.code}}-{{b.equNo}}">{{userInfo.code}}-{{b.equNoTemp}}</td>
						<td title="{{b.asset}}">{{b.assetTemp}}</td>
						<td title="{{b.equipmentName}}">{{b.equipmentNameTemp}}</td>
						<td>{{b.brandName}}</td>
						<td>
						<span ng-show="b.state==2">未成交</span>
						<span ng-show="b.state==1">已成交</span>
						</td>
						<td>
					    <span ng-show="b.busState==1">自用</span>
						<span ng-show="b.busState==2">调拨</span>
						<span ng-show="b.busState==3">局内租</span>
						<span ng-show="b.busState==4">外局租</span>
						<span ng-show="b.busState==5">外租</span>
						</td>
					    <td title="{{b.depName}}">{{b.depNameTemp}}</td>
						<td>{{b.releaseDate | limitTo:10}}</td>
					</tr>
				</tbody>
			</table>
			<div class="form-horizontal" style="margin-top: 10px;" ng-show="busPublishList.length!=0">
				<ul>
					<div class="form-group" style="margin-top: -15px;">
						<div class="col-xs-1" style="margin-left:8%;">
							<input type="button" class="btn btn-primary" value="查看" ng-click="queryBusPublishClick();">
						</div>
						<div class="col-xs-1" style="text-align:left;margin-left:-80px;">
							<input type="button" class="btn btn-primary" value="登记" ng-click="addBusPublishClick();">
						</div>
						<div style="float :right; margin-right:18%;margin-top: -25px">
							<tm-pagination conf="paginationConf" ></tm-pagination>
						</div> 
					</div>
				</ul>
			</div>
		</div>
	</form>
	<div ng-include src="'./externalCompany/outMessageCheckIn/outDeviceUsageQuestionnaireCheckIn/outDeviceUsageQuestionnaireCheckInAdd.jsp'" ></div>
    <div ng-include src="'./externalCompany/outMessageCheckIn/outDeviceUsageQuestionnaireCheckIn/outDeviceUsageQuestionnaireCheckInQuery.jsp'" ></div>
    <div ng-include src="'./externalCompany/outMessageCheckIn/outDeviceUsageQuestionnaireCheckIn/outDeviceUsageQuestionnaireCheckInUpd.jsp'" ></div>

</body>
</html>