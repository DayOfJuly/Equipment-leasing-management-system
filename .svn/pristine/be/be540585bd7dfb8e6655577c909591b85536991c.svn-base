<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>企业管理员维护</title>

<style>
.container {width: 1500px !important;}  

.modal-dialog{
min-width : 0px;
}
.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}
</style>

</head>
<body  class="container">
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理{{tmpDataA}}</li>
		<li style="font-size: 13px">系统管理</li>
		<li style="font-size: 13px">企业管理员维护</li>
	</ol>
<form action="" style="width: 95%;margin-top: 10px;margin-bottom: 10px;">
		<div style="margin-left: 30px">
			<table class="table table-hover" style="margin-left: 20px;">
			<tbody>
				<tr class="success">
					<th style="white-space: nowrap; text-align: center;">序号</th>
					<th style="white-space: nowrap; text-align: center;"></th>
					<th style="white-space: nowrap; text-align: center;">登录用户名</th>
					<th style="white-space: nowrap; text-align: center;">联系人姓名</th>
					<th style="white-space: nowrap; text-align: center;">移动电话</th>
					<th style="white-space: nowrap; text-align: center;">电子邮箱</th>
					<th style="white-space: nowrap; text-align: center;">企业名称</th>
					<th style="white-space: nowrap; text-align: center;">最后更新时间</th>
					<!-- <th style="white-space: nowrap; text-align: center;">状态</th> -->
				</tr>
			</tbody>
			<tbody>
			    <!-- 从js拿到的数组遍历 -->
				<tr  ng-repeat="x in PersonList" ng-click="check(x,$index+1);">
					 <td style="white-space: nowrap; text-align: center;"><input style="margin-left:-13px;" type="radio" name="radioName" ng-click="selectRadio(x);" ng-checked="radioTrIndex==$index+1"></td> 
					<td style="white-space: nowrap; text-align: center;"><span  style="margin-left:-85px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</span></td> 
				<!-- 	<td style="text-align:center;">
							<input style="margin-right:-130px;" type="radio" name="radioName" ng-click="selectRadio(x);" ng-checked="radioTrIndex==$index+1">
							<label></label>
							<p style="margin-left:0px;margin-top:-21px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
					</td> -->
					
					<!-- 遍历数值 -->
					<td style="white-space: nowrap; text-align: center;width:200px;">{{x.loginId}}</td>
					<td style="white-space: nowrap; text-align: center;">{{x.name}}</td>
					<td style="white-space: nowrap; text-align: center;">{{x.mobile}}</td>
					<td style="white-space: nowrap; text-align: center;">{{x.email}}</td>
					<td style="white-space: nowrap; text-align: center;">{{x.orgName}}</td>
					<td style="white-space: nowrap; text-align: center;">{{x.updateTime}}</td>
					<!-- <td style="white-space: nowrap; text-align: center;">{{x.stateTemp}}</td> -->
				</tr>
			</tbody>
		</table>
		<div style="margin-left: 20px">
		    <!-- 分页 -->
			<div style="text-align:right; float: right;">
				<tm-pagination conf="paginationConf" style="margin-left:500px;"></tm-pagination>
			</div>
			<label></label>
			<div>
				<button type="button" class="btn btn-primary" ng-click="queAdministrator()">查看</button>
				<button type="button" class="btn btn-primary" ng-click="addAdministrator()">创建</button>
				<button type="button" ng-disabled="enterpriseState==1" id="updBtnId" class="btn btn-primary" ng-click="updAdministrator()">修改</button>
				<!-- <button type="button" class="btn btn-primary" ng-click="opstAdministrator()">启用/停用</button> -->
				<button type="button" class="btn btn-primary" ng-click="delAdministrator();">删除</button>
			</div>
		</div>
		</div>
	</form>
	<!-- 页面引用 -->
	<div ng-include src="'./AdministratorMng/AdministratorAdd.jsp'" ></div> 
    <div ng-include src="'./AdministratorMng/AdministratorUpd.jsp'" ></div> 
    <div ng-include src="'./AdministratorMng/AdministratorQuery.jsp'" ></div> 
    <div ng-include src="'./AdministratorMng/AdministratorOpSt.jsp'" ></div>
    <div ng-include src="'./AdministratorMng/AdministratorOpStOne.jsp'" ></div> 
</body>
