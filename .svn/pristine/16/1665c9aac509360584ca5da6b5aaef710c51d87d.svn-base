<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>机械设备分类管理</title>


<style>
.container {width: 1500px !important;}

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
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

<body  ng-init="queryCategory();" class="container">
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">机械设备分类</li>
		<li style="font-size: 13px">机械设备分类管理</li>
	</ol>
	<div>
		<form action="" style="width: 95%" autocomplete="off">
			<div class="form-horizontal" style="margin-top: 10px;">
				<ul>
					<div class="form-group">
						<label contenteditable="false" class="col-xs-1 control-label"></label>
						<div class="col-xs-4" style="margin-top: -19px;margin-left: 21%;">
<!-- 								<button  ng-click="cleanDateFunEnd('_searchParam','_searchParamId','queryData','searchParam');" ng-show="flagShow_searchParam" id="flagEnds" type="button" class="btn btn-link" style="outline: none;color:#000;margin-left:403px;margin-top:7px;z-index:2;position: absolute;"><span class="glyphicon glyphicon-remove" style="border: 0px solid transparent;"></span></button>
 -->								<input type="text" ng-click="clickInput(queryData.searchParam,'_searchParam');"  ng-blur="blurInput('_searchParam');" ng-change="changeProFun(queryData.searchParam,'a','_searchParam')"  class="form-control" id="_searchParamId" ng-model="queryData.searchParam" placeholder="查询 类别号、设备分类、设备名称">
						</div>
						<div class="col-xs-3">
							<input type="button" class="btn btn-primary" style="  margin-top: -22px;" value="查询" contenteditable="true" ng-click="queryCategoryDataA(1);"/>
						</div>
					</div>
				</ul>
			</div>
			<div style="margin-top: -10px;">
				<table class="table table-striped table-hover" style="margin-left: 28%;width: 45%;">
					<thead>
						<tr class="success">
							<th style="text-align:center;width: 7%;">序号</th>
							<th style="text-align:center;">类别号</th>
							<th style="text-align:center;">设备分类</th>
							<th style="text-align:center;">设备名称</th>
							<th style="text-align:center;">操作</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="t in categoryList" style="text-align:center;">
							<td>
								<p align="left" style="margin: 0px -9px -2px 7px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
							</td>
							<!-- <td>{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td> -->
							<td>{{t.typeNo}}</td>
							<td>{{t.equCategory.equipmentCategoryName}}</td>
							<td>{{t.equName.equipmentName}}</td>
							<td>
								<a href="javascript:void(0);" ng-click="openUpdModal(t);" ng-if="userInfo.orgLevel == 1">修改</a>
								<a href="javascript:void(0);" ng-click="del(t);"ng-if="userInfo.orgLevel == 1">删除</a>
					<!-- 			<input type="button" class="btn btn-link btn-xs" value="修改" ng-click="openUpdModal(t);" ng-if="userInfo.orgLevel == 1"> 
								<input type="button" class="btn btn-link btn-xs" value="删除" ng-click="del(t);" ng-if="userInfo.orgLevel == 1"> -->
							</td>
						</tr>
					</tbody>
				</table>
				<div class="form-group">
					<label contenteditable="false" class="col-xs-1 control-label" ng-show="categoryList.length > 0"></label>
					<div class="col-xs-2"style="margin-left:-82px;margin-top:-10px;" ng-show="categoryList.length > 0">
						<input type="button" class="btn btn-primary" value="添加" style="margin-left: 168%;margin-top: 17%;" contenteditable="true" ng-click="openAddModal();" ng-if="userInfo.orgLevel == 1"/>
					</div>
					
					<label contenteditable="false" class="col-xs-1 control-label" ng-show="categoryList.length == 0"></label>
					<div class="col-xs-2 col-xs-offset-2"style="margin-top:-10px;" ng-show="categoryList.length == 0">
						<input type="button" class="btn btn-primary" value="添加" style="margin-top: 17%;margin-left:13%" contenteditable="true" ng-click="openAddModal();" ng-if="userInfo.orgLevel == 1"/>
					</div>
					
					<label contenteditable="false" class="col-xs-1 control-label" ng-show="categoryList.length > 0"></label>
					<div style="text-align: right;height: 1px;  margin-top: -36px;margin-left: 37.6%;" ng-show="categoryList.length > 0">
						<!-- <pagination-tag conf="paginationConf"></pagination-tag> -->
						<tm-pagination conf="paginationConf" ></tm-pagination>
					</div>
				</div>
		</form>
	</div>
	<div ng-include src="'./Category/CategoryAdd-Modify.jsp'" ></div>
	<div ng-include src="'./Category/CategoryDel-Modify.jsp'" ></div>
	<div ng-include src="'./Category/CategoryUpd-Modify.jsp'" ></div>
</body>
</html>
