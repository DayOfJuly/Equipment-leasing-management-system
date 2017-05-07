<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>求租信息</title>
<jsp:include page="../Include/Head.jsp" />
<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>

<script type="text/javascript">
var app = angular.module('DemandrentApp',['ngResource','unifyModule','myPagination']);
app.controller('DemandController',function($scope,DemandRentSvc){
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
			$scope.queryDemandRentInfo();
		}
	};
	 // 查询求租信息
	$scope.queryDemandRentInfo=function(){
		DemandRentSvc.unifydo({
			Action:"All",
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.pageRecord},
			qSucc,qErr);
		function qSucc(rec){
			
			$scope.demandRentList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){
			
		}
	};
	
});
</script>

</head>

<body style="background-color: #fff;" ng-app="DemandrentApp" ng-controller="DemandController">
	<div class="container">
	<div ng-include src="'/WebFront/WebSite/Main/Top.jsp'" />
	</div>
	
	<div class="container" style="margin-top: 10px">
		<ol class="breadcrumb">
			<li style="font-size: 13px">您的位置：首页</li>
			<li style="font-size: 13px">求租信息</li>
		</ol>
	</div>
	
	<div class="container" style="margin-top: 10px" ng-init="queryDemandRentInfo()">
			<div class="col-xs-12">
						<div class="row" style="margin-top:10px;">
							<table class="table table-striped">
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
									</tr>
								</tbody>
								<tbody>
									<tr ng-repeat="t in demandRentList">
										<td>{{$index+1}}</td>
										<td></td>
										<td><a target="_bank" href="../Publish/ViewDemandInfo.jsp?id={{t.dataId}}&infoType=3">{{t.infoTitle}}</a></td>
										<td>{{t.price}}</td>
										<td>{{t.rentDate}}</td>
										<td>{{t.contactPerson}}</td>
										<td>{{t.contactAddress}}</td>
										<td>{{t.contactPhone}}</td>
									</tr>
								</tbody>
							</table>
							<div style="text-align: right;">
								<pagination-tag conf="paginationConf"></pagination-tag>
							</div>
				</div>	
			</div>
	</div>
	<!-- 引入底文件 -->
	<div class="container" style="margin-top: 10px">
		<div ng-include src="'/WebFront/WebSite/Main/Bottom.jsp'" />
	</div>
	
</body>


</html>
