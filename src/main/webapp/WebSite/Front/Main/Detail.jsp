<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>详细信息查看</title>
<jsp:include page="../Include/Head.jsp" />
<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>

<script type="text/javascript">
var app = angular.module('detailApp',['ngResource','unifyModule']);
app.controller('detailController',function($scope,SaleSvc,rentSvc){
	$(function(){
		var type=infotype.value;
		if(type=="newchuzu" || type=="newsale"){
			$scope.titleMesg="出租/出售";
		}
		
	});
	
	//获取详细信息
	$scope.queryDetailData = function() {
		var type=infotype.value;
		
		if(type=="newchuzu"){
			rentSvc.unifydo({parm : id.value}, qSucc, qErr);
			function qSucc(rec) {
				
				$scope.viewList = rec;
				$scope.rentV=rec.process;
			}
			function qErr(rec) {

			}
		}
		if(type=="newsale"){
			SaleSvc.unifydo({parm : id.value}, qSucc, qErr);
			function qSucc(rec) {
				
				$scope.viewList = rec;
				$scope.rentV=rec.process;
			}
			function qErr(rec) {

			}
		}

	};
	
});
</script>

</head>

<body style="background-color: #fff;" ng-app="detailApp" ng-controller="detailController" ng-init="queryDetailData()">
	
	<div class="container">
	<div ng-include src="'/WebFront/WebSite/Main/Top.jsp'" />
	</div>
	<%
			Object id = request.getParameter("id");
			Object infotype = request.getParameter("infoType");
	%>
	<input type=hidden name="id" id="id" ng-model="id" value=<%=id%>>
	<input type=hidden name="infotype" id="infotype" ng-model="infotype" value=<%=infotype%>>
	<div class="container" style="margin-top: 10px">
		<ol class="breadcrumb">
			<li style="font-size: 13px">您的位置：首页>></li>
			<li style="font-size: 13px">{{titleMesg}}</li>
			<li style="font-size: 13px">{{titleMesg}}</li>
			<li style="font-size: 13px"></li>
		</ol>
	</div>
		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div>
						<div class="row">
							<div class="col-md-8">
								<div class="panel panel-default" style="height: 450px">
									<div class="panel-body">
										<div id="myCarousel" class="carousel slide">
											<!-- 轮播（Carousel）指标 -->
											<ol class="carousel-indicators">
												<li data-target="#myCarousel" data-slide-to="0"
													class="active"></li>
												<li data-target="#myCarousel" data-slide-to="1"></li>
												<li data-target="#myCarousel" data-slide-to="2"></li>
											</ol>
											<!-- 轮播（Carousel）项目 -->
											<div class="carousel-inner">
												<div class="item active">
													<img
														src="http://www.runoob.com/wp-content/uploads/2014/07/slide1.png"
														alt="First slide">
												</div>
												<div class="item">
													<img
														src="http://www.runoob.com/wp-content/uploads/2014/07/slide2.png"
														alt="Second slide">
												</div>
												<div class="item">
													<img
														src="http://www.runoob.com/wp-content/uploads/2014/07/slide2.png"
														alt="Third slide">
												</div>
											</div>
											<!-- 轮播（Carousel）导航 -->
											<a class="carousel-control left" href="#myCarousel"
												data-slide="prev">&lsaquo;</a> <a
												class="carousel-control right" href="#myCarousel"
												data-slide="next">&rsaquo;</a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="panel panel-default">
									<div class="panel-heading">【出租】{{viewList.infoTitle}}</div>
									<div class="panel-body">设备归属：{{rentV.bizName}}</div>
									<div class="panel-body">设备报价：{{viewList.price}}元/天</div>
									<div class="panel-body">最后更新：2015-05-15 14:29</div>
									<div class="panel-body">浏览次数：24</div>
									<div class="panel-body">设备状态： {{viewList.dataState.note}}</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 col-sm-6">
								<div class="panel panel-default">
									<table class="table table-bordered">
										<tbody>
											<tr class="success"><td colspan="6">设备信息</td></tr>
											<tr>
												<th align="right">设备编号:</th>
												<td>XXXXXX</td>
												<th>设备名称:</th>
												<td>xxx</td>
												<th>品牌:</th>
												<td>xxxxxx</td>
											</tr>
											<tr>
												<th>型号:</th>
												<td>xxx</td>
												<th>规格:</th>
												<td>xxx</td>
												<th>功率（KW）:</th>
												<td>xxx</td>
											</tr>
											<tr>
												<th>技术情况:</th>
												<td>xxx</td>
												<th>生产厂家:</th>
												<td>xxx</td>
												<th>生产日期:</th>
												<td>xxx</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-md-12 col-sm-6">
								<div class="panel panel-default" >
									<div class="panel-heading">详细说明</div>
									<div  align="center " style="padding:25px;" >
										{{viewList.detailedDescription}}
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 边框开始 -->
				<div class="sidebar right-sidebar col-md-3">
					<div class="widget sidebar-widget widget-agents">
						<div class="panel panel-primary">
							<div class="panel-heading">企业基本资料</div>
							<div class="panel-body">企业名称：</div>
							<div class="panel-body">所在城市：北京</div>
							<div class="panel-body">联系人：张三</div>
							<div class="panel-body">联系手机：12333333333</div>
							<div class="panel-body">QQ：88888899988</div>
							<div class="panel-body">电子邮箱：1111@1111.com</div>
							<div class="panel-body">固定电话：010-88888888</div>
							<div class="panel-body">联系地址：{{rentviewList.contactAddress}}</div>
						</div>
					</div>
					<div class="widget sidebar-widget widget-properties">
						<div class="panel panel-primary">
							<div class="panel-heading">企业基本资料</div>
							<div class="panel-body">设备归属</div>
							<div class="panel-body">设备报价：1000元/天</div>
							<div class="panel-body">最后更新：2015-05-15 14:29</div>
							<div class="panel-body">浏览次数：24</div>
							<div class="panel-body">设备状态： 未成交</div>
						</div>
					</div>
					<div class="widget sidebar-widget widget-properties">
						<div class="panel panel-primary">
							<div class="panel-heading">详细说明</div>
							<div class="panel-body">{{rentviewList.detailedDescription}}</div>
						</div>
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
