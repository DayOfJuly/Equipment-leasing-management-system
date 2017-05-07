<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>出售信息</title>
<jsp:include page="../Include/Head.jsp" />

<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<style>
#uploadImg {
	font-size: 12px;
	overflow: hidden;
	position: absolute
}

#file {
	position: absolute;
	z-index: 100;
	margin-left: -180px;
	font-size: 60px;
	opacity: 0;
	filter: alpha(opacity = 0);
	margin-top: -5px;
}
</style>
<script type="text/javascript">
	var app = angular.module('saleApp', [ 'ngResource', 'unifyModule',
			'myPagination' ]);
	app.controller('saleController', function($scope, SaleSvc, equipment) {

		/*
		 *分页标签参数配置
		 */
		$scope.paginationConf = {
			currentPage : 1,/*当前页数*/
			totalItems : 1,/*数据总数*/
			pageRecord : 5,/*每页显示多少*/
			pageNum : 10,/*分页标签数量显示*/
			/*
			 * parm1:当前选择页数
			 * parm2:每页显示多少
			 */
			queryList : function(parm1, parm2) {
				$scope.paginationConf.currentPage = parm1;
				$scope.querySaleData();
			}
		};

		/*
		 * 查询test数据
		 */
		$scope.querySaleData = function() {
			
			SaleSvc.unifydo({
				Action : "All"
			}, qSucc, qErr);
			function qSucc(rec) {
				
				$scope.saleList = rec.content;
			}
			function qErr(rec) {

			}
		};

		/*
		 *获取设备信息
		 */
		$scope.queryequiData = function() {
			equipment.unifydo({
				parm : 22
			}, qSucc, qErr);
			function qSucc(rec) {
				
				$scope.equiList = rec.content;
			}
			function qErr(rec) {

			}
		};
		/*
		 * 弹出添加页面模态框
		 */
		$scope.openAddModal = function() {
			$scope.formParms = {rentRadio:2};
			$scope.judge = "add";
			$scope.titleMsg = "免费发布出售信息步骤：";
			$scope.titleMsg2 = "填写详细内容";
			$scope.titleMsg3 = "> 审核详细内容 > 发布成功";
			$('#saleModalId').modal('show');
		};

		/*
		 * 弹出选择设备信模态框
		 */
		$scope.openChoModal = function() {
			$scope.formParms = {};
			$scope.judge = "add";
			$scope.titleMsg = "免费发布出租信息步骤：";
			$scope.titleMsg2 = "填写详细内容";
			$scope.titleMsg3 = "> 审核详细内容 > 发布成功";
			$('#saleModalId').modal('show');
		};
		/*
		 * 添加出售信息
		 */
		$scope.add = function() {
			
			SaleSvc.put({
				data : $scope.formParms
			}, aSucc, aErr);
			function aSucc(rec) {
				$('#saleModalId').modal('hide');
				$.messager.popup("出售" + rec.msg);
			}
			function aErr(rec) {

			}
		};
		/*
		 * 弹出修改页面模态框
		 */
		$scope.openUpdModal = function(obj) {
			$scope.formParms = obj;
			$scope.judge = "upd";
			$scope.titleMsg = "Rent修改:";
			$('#saleModalId').modal('show');
			//window.open("'"+$scope.urlPath+"'"+$scope.formParms);
		};

		/*
		 *预览
		 */
		$scope.openView = function(id) {
			window.location.href = "SaleView.jsp?id=" + (id - 1);
		};
		/*
		 * 修改
		 */
		$scope.upd = function() {
			
			var id = $scope.formParms.id;
			SaleSvc.post({
				parm : id
			}, sSucc, sErr);
			function sSucc(rec) {
				$('#saleModalId').modal('hide');
				$.messager.popup(rec.msg);
			}
			function sErr(rec) {

			}
		};

		/*
		 * 删除
		 */
		$scope.del = function(obj) {
			$.messager.confirm("提示", "是否删除？", function() {
				var id = obj.id;
				SaleSvc.del({
					parm : id
				}, dSucc, dErr);
				function dSucc(rec) {
					$.messager.popup(rec.msg);
				}
				function dErr(rec) {
					$.messager.popup("Failed");
				}
			});
		};
	});
</script>
</head>

<body ng-app="saleApp" ng-controller="saleController">
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：测试首页1</li>
		<li style="font-size: 13px">测试首页2</li>
		<li style="font-size: 13px">测试首页3</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;">
			<ul>
				<div class="form-group">
					<label contenteditable="false" class="col-sm-2 control-label">编号：</label>
					<div class="col-sm-4">
						<input type="text" id="loanNoPre" name="loanNoPre"
							class="form-control" ng-model="queryData.code">
					</div>
					<label contenteditable="false" class="col-sm-2 control-label">名称：</label>
					<div class="col-sm-4">
						<input type="text" id="custNamePre" name="custNamePre"
							class="form-control" ng-model="queryData.name">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-6">
						<input type="button" class="btn btn-primary" value="添加"
							ng-click="openAddModal();"> <input type="button"
							class="btn btn-primary" value="查询" contenteditable="true"
							ng-click="querysaleData()" />
					</div>
				</div>
			</ul>
		</div>
		<div style="margin-left: 30px">
			<table class="table table-striped" style="margin-left: 50px;">
				<tbody>
					<tr class="success">
						<th>序号</th>
						<th>信息类型</th>
						<th>标题</th>
						<th>价格</th>
						<th>发布时间日期</th>
						<th>联系人</th>
						<th>地址</th>
						<th>联系方式</th>
						<th>操作 &nbsp;</th>
					</tr>
				</tbody>
				<tbody>
					<tr ng-repeat="t in saleList">
						<td>{{$index+1}}</td>
						<td><span ng-if=(t.infoType==1)>出租</span></td>
						<td><a href="" ng-click="openView(t.id)">{{t.infoTitle}}</a></td>
						<td>{{t.price}}</td>
						<td>{{t.rentDate}}</td>
						<td>{{t.contactPerson}}</td>
						<td>{{t.contactAddress}}</td>
						<td>{{t.contactPhone}}</td>
						<td><input type="button" class="btn btn-primary" value="修改"
							ng-click="openUpdModal(t);"> <input type="button"
							class="btn btn-primary" value="删除" ng-click="del(t);"></td>
					</tr>
				</tbody>
			</table>
			<div style="text-align: right;">
				<pagination-tag conf="paginationConf"></pagination-tag>
			</div>
		</div>

		<div ng-include src="'/WebFront/WebSite/Sale/SaleAM.jsp'"></div>
		 
	</form>
</body>
</html>
