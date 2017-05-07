<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>测试页面</title>
<jsp:include page="../Include/Head.jsp" />

<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<script type="text/javascript">
var app = angular.module('indexApp', ['ngResource','unifyModule','myPagination']);
app.controller('indexController', function($scope,unifyTestSvc) {
	
	/*
	 *分页标签参数配置
	*/
	$scope.paginationConf = {
        currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        pageRecord:10,/*每页显示多少*/
        pageNum:10,/*分页标签数量显示*/
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        queryList:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	$scope.queryTestData();
        }
    };
	
	$scope.name="测试";
	/*
	 * 查询测试数据
	*/
	$scope.queryTestData=function(){
		unifyTestSvc.unifydo({name:$scope.name,pageNo:0,pageSize:99},qSucc,qErr);
		function qSucc(rec){
			
			$scope.tmpList=rec.content;
		}
		function qErr(rec){
			
		}
		
	};
	
	$scope.openAddModal=function(){
		$scope.judgeAddUpd="add";
		$scope.saveParms={};
		$('#InsuranceModal').modal('show');
	};
	
	$scope.openUpdModal=function(){
		$scope.judgeAddUpd="upd";
		$scope.saveParms={"person":"马云","note":"保险-test-001","amount":3000000,"rate":"8.6","term":24,"minAmt":1000,"prodType":"10"};
		$('#InsuranceModal').modal('show');
	};
	
	
});

</script>
</head>

<body ng-app="indexApp" ng-controller="indexController">
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：测试首页1</li>
		<li style="font-size: 13px">测试首页2</li>
		<li style="font-size: 13px">测试首页3</li>
	</ol>
<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;">
			<ul>
				<div class="form-group">
					<label contenteditable="false" class="col-sm-2 control-label">名称：</label>
					<div class="col-sm-4">
						<input type="text" id="loanNoPre" name="loanNoPre"
							class="form-control" ng-model="name">
					</div>
					<label contenteditable="false" class="col-sm-2 control-label">名称：</label>
					<div class="col-sm-4">
						<input type="text" id="custNamePre" name="custNamePre"
							class="form-control" ng-model="name">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-6">
						<input type="button" class="btn btn-primary" value="查询" contenteditable="true" ng-click="queryTestData();"/>
					</div>
				</div>
			</ul>
		</div>
		<div class="col-sm-offset-6">
		</div>
		<div style="margin-left: 30px">
			<table class="table table-striped" style="margin-left: 50px;">
			<tbody>
				<tr class="success">
					<th>序号</th>
					<th>名称</th>
					<!-- <th>备注</th> -->
					<th>金额</th>
					<th>日期Data</th>
					<th>日期TimeStamp</th>
					<th>操作 &nbsp;<input type="button" class="btn btn-primary" value="添加" ng-click="openAddModal();" > </th>
				</tr>
			</tbody>
			<tbody>
				<tr ng-repeat="t in tmpList">
					<td>{{$index+1}}</td>
					<td>{{t.name}}</td>
					<!-- <td>{{t.longTextTest}}</td> -->
					<td>{{t.amount}}</td>
					<td>{{t.dateTest}}</td>
					<td>{{t.timestampTest}}</td>
					<td>
						<input type="button" class="btn btn-primary" value="资料补充" ng-click="openUpdModal();" > 
						<input type="button" class="btn btn-primary" value="删除" >
					</td>
				</tr>
			</tbody>
		</table>
		<div style="text-align:right;">
			<pagination-tag conf="paginationConf"></pagination-tag>
		</div>
		</div>
<br>

<div ng-include src="'../../WebSite/Main/indexAdd.jsp'" ></div>
</form>
</body>
</html>
