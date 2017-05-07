<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>发布出租信息</title>
<jsp:include page="../Include/Head.jsp" />

<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<script type="text/javascript">
var app = angular.module('EquipmentApp', ['ngResource','unifyModule','myPagination']);
app.controller('EquipmentController', function($scope,equipment,category) {
	var url = location.search; //获取url中"?"符后的字串
	var theRequest = new Object();
	if (url.indexOf("?") != -1) {
	   var str = url.substr(1);
	   strs = str.split("&");
	   for(var i = 0; i < strs.length; i ++) {
	      theRequest[strs[i].split("=")[0]]=(strs[i].split("=")[1]);
	   }
	}
	$scope.requestParms=theRequest;
	
});
</script>
</head>

<body ng-app="EquipmentApp" ng-controller="EquipmentController">
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">设备资源管理</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;">
			发布出租信息
		</div>
		
	</form>
</body>
</html>