<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业设置</title>
<link href="../../../css/bootstrapAfter.css">
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
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">系统管理</li>
		<li style="font-size: 13px">企业设置</li>
	</ol>
	<form action="" name="queryForm" style="width: 95%" autocomplete="off">
		<div style="margin-left: 2%">
			<table class="table table-hover " style="width: 55%;margin-left: 18%;">
				<tbody>
					<tr class="success ">
						<th style="white-space: nowrap;text-align: center;"></th>
						<th style="white-space: nowrap;text-align: center;"><span>序号</span></th>
						<th style="white-space: nowrap;text-align: center;width: 18%;">单位编号</th>
						<th style="white-space: nowrap;text-align: center;width: 33%;">单位名称</th>
					    <th style="white-space: nowrap;text-align: center;width: 11%;">组织级别</th>
						<th style="white-space: nowrap;text-align: center;width: 15%;">上级单位编号</th>
						<th style="white-space: nowrap;text-align: center;width: 19%;">最后更新时间</th>
					</tr>
				</tbody>
				<tbody>
					<tr  ng-repeat="entity in entityList" style="text-align: center;" ng-click="check(entity,$index+1);" ng-dblclick="queryPersonList('que')">
						<td>
							<input style="margin: 2px -17px 0 0px;" type="radio" name="cliInfo" id="cliInfo"   value="" ng-click="selectObj(entity.currOrgId);" ng-checked="radioTrIndex==$index+1"/>
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px 19px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
						</td>
						<td style="text-align: center;" title="{{entity.code}}">{{entity.codeTemp}}</td>
						<td style="text-align: center;" title="{{entity.name}}">{{entity.nameTemp}}</td>
						<td style="text-align: center;">{{ct.codeTranslate(entity.orgLevel,"ENTERPRISE_LEVEL_ALL")}}</td>
						<td style="text-align: center;" title="{{entity.parentCode}}">{{entity.parentCodeTemp}}</td>
						<td style="text-align: center;" title="{{entity.updateTime}}">{{entity.updateTime}}</td> 
					</tr> 
				</tbody>
			</table>
			
			<div style="margin-left: 10px;margin-top:-30px;" >
				<div style="margin-left: 17.5%;margin-top: 3%;">
					<button ng-show="btnShow_" type="button" class="btn btn_  btn-primary" ng-click="queryPersonList('que')">查看</button>
					<button ng-show="btnShowAdd_"  type="button" class="btn btn_ btn-primary" ng-click="openAddModal('add')">添加</button>
					<button ng-show="btnShow_" type="button" class="btn btn_ btn-primary" ng-click="openUpdModal('upd')">修改</button>
					<button ng-show="btnShow_" type="button" class="btn btn_ btn-primary" ng-click="deleteLoanApply()">删除</button>
				</div>
				<label></label>
				<div style="margin-top: -5%;margin-left: -0.4%;" ng-if="entityList.length!=0">
					<tm-pagination conf="paginationConf" style="margin-left:500px;" ></tm-pagination>
				</div>
			</div>
		</div>
	</form>
	<div ng-include="'./EnterPriseManagement/add/EnterpriesAdd.jsp'"></div>
	<div ng-include="'./EnterPriseManagement/query/EnterpriesList.jsp'"></div>
</body>
</html>