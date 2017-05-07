<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>外部管理员信息维护</title>
<style>
.container {width: 1500px !important;}  

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}

 textarea {
	width: 1200px;
	max-width: 550px;
	height: 60px;
	max-height: 60px;
 }

::-ms-clear, ::-ms-reveal{display: none;}

.abc {
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	float: left;
	min-width: 160px;
	padding: 5px 0;
	margin: 2px 0 0;
	font-size: 14px;
	text-align: left;
	list-style: none;
	background-color: #fff;
	-webkit-background-clip: padding-box;
	background-clip: padding-box;
	border: 1px solid #ccc;
	border: 1px solid rgba(0, 0, 0, .15);
	border-radius: 4px;
	-webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	box-shadow: 0 6px 12px rgba(0, 0, 0, .175)
}

.page-list .pagination {float:left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float:left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left:3px;}
.page-list .page-total select {width: 50px;}

p.copyP{
  margin: 0 0 0px;
}

</style>

</head>
<body class="container">
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">系统管理</li>
		<li style="font-size: 13px">外部管理员信息维护</li>
	</ol>
	<form action="" style="width: 95%" autocomplete="off">
		<div class="form-horizontal" style="margin-top: 10px;">
			<div class="form-group">
			 		<div class="col-xs-12">
			 			<div class="col-xs-3 col-xs-offset-5" style="margin-top: -16px;margin-left: 36%;">
<!-- 							<button ng-click="cleanDateFunEndNew('_fuzzyDataOut','purId','formParm','fuzzyData');" ng-show="flagShow_fuzzyDataOut" id="flagEnd" type="button" class="btn btn-link" style="outline: none;color:#000;margin-left:291px;margin-top:7px;z-index:2;position: absolute;"><span class="glyphicon glyphicon-remove" style="border: 0px solid transparent;"></span></button>
 -->							<input  id="purId" class="form-control" ng-model="formParm.fuzzyData" placeholder="查询 员工姓名、注册手机号码、企业名称" style="padding:0px -15px 0px 20px;"
							ng-click="clickInputNew(formParm.fuzzyData,'_fuzzyDataOut');" ng-change="changeProFunNew(formParm.fuzzyData,'a','_fuzzyDataOut');" ng-blur="blurInputNew('_fuzzyDataOut');">
						</div>
					    <div class="col-xs-4" style="margin-top:-8px;">
							<input type="button" id="searchBtnId" class="btn btn-primary" value="查询"  ng-click="queryTemPartyList(1);"/>
					    </div>
					</div> 
			</div>
			<table class="table table-hover" style="margin: 10px 0px 0px 119px;width: 79%;">
				<tbody>
					<tr class="success">
						<th style="white-space: nowrap; text-align: center;"></th>
						<th style="white-space: nowrap; text-align: center;width: 1%;"><span>序号</span></th>
						<th style="white-space: nowrap; text-align: center;">登录用户名</th>
						<th style="white-space: nowrap; text-align: center;">员工姓名</th>
						<th style="white-space: nowrap; text-align: center;">员工编号</th>
						<th style="white-space: nowrap; text-align: center;">注册手机号码</th>
						<th style="white-space: nowrap; text-align: center;">注册电子邮箱</th>
						<th style="white-space: nowrap; text-align: center;">企业名称</th>
						<th style="white-space: nowrap; text-align: center;">最后更新时间</th>
						<th style="white-space: nowrap; text-align: center;">状态</th>
					</tr>
				</tbody>
				<tbody>
					<tr  ng-repeat="entity in entityList" style="text-align: center;" ng-click="check(entity,$index+1);">
						<!-- <td>
							<input style="margin-left:-15px;margin-top:1px;" type="radio" name="onlyOne" ng-click="chooseEmployee(entity.partyId,entity.state)" ng-checked="radioTrIndex==$index+1">
							<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
						</td>  -->
						<td>
							<input style="margin: 2px -17px 0 0px;" type="radio" name="onlyOne" ng-click="chooseEmployee(entity.partyId,entity.state)" ng-checked="radioTrIndex==$index+1"/>
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px 19px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
						</td>
						<td style="text-align: center;" title="{{entity.loginId}}">{{entity.loginIdCopy}}</td>
						<td style="text-align: center;" title="{{entity.name}}">{{entity.nameCopy}}</td>
						<td style="text-align: center;" title="{{entity.code}}">{{entity.codeCopy}}</td>
						<td style="text-align: center;" title="{{entity.phoneNo}}">{{entity.phoneNoCopy}}</td><!-- {{entity.mobile}} -->
						<td style="text-align: center;" title="{{entity.mail}}">{{entity.mailCopy}}</td>
						<td style="text-align: center;" title="{{entity.orgName}}">{{entity.orgNameCopy}}</td>
						<td style="text-align: center;" title="{{entity.updateTime}}">{{entity.updateTimeCopy}}</td>
						<td style="text-align: center;">{{ct.codeTranslate(entity.state,"PERSON_STATE")}}</td>
					</tr>
				</tbody>
			</table>
	 		<div style="margin-left: 3.3%;;margin-top:-0.5%;">
				<div  style="text-align: right; float: right;height: 1px" ng-show="btnShow_">
					<tm-pagination conf="paginationConf" style="margin-left: -35%;"></tm-pagination>
				</div>
				<label></label>
				<div style="margin-left: 5.3%;">
					<button ng-show="btnShow_"  type="button" class="btn btn-primary" ng-click="openCheckDetail(1)">查看</button>
					<button ng-show="btnShowAdd_" id="nb123"  type="button" class="btn btn-primary" ng-click="openAddEmployee()">添加</button>
					<button ng-show="btnShow_" ng-disabled="enterpriseState=='1'"  type="button" class="btn btn-primary" ng-click="openUpdEmployee()">修改</button>
					<button ng-show="btnShow_" type="button" class="btn btn-primary" ng-click="openCheckDetail(4)">启用/停用</button>
				</div>
			</div> 
		</div>
	</form>
	
	<div ng-include src="'./OutEmployeeInformationMaintain/OutEmployeeInformationMaintainAdd.jsp'"></div> 
	<div ng-include src="'./OutEmployeeInformationMaintain/OutEmployeeInformationMaintainDetail.jsp'"></div> 
	<div ng-include src="'./OutEmployeeInformationMaintain/OutEmployeeInformationMaintainUpdate.jsp'"></div> 
	<div ng-include src="'./OutEmployeeInformationMaintain/OutEmployeeInformationMaintainState.jsp'"></div> 
</body>