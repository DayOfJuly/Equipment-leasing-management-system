<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../Front/Include/HeadAfter.jsp" />
<jsp:include page="./common/common.jsp" />
<style type="text/css">
a:focus { 
outline: none; /* 去掉超链接外的虚线边框 */
} 
</style>
</head>
<body style="background-color: #fff">
<div class="container" style="background-color:#fff;width: 1580px;" ng-app="IndexApp" ng-controller="IndexController"> 
	<div class="row"> 
		<div style="background-color:#FFF;padding-left: 10px;padding-right: 10px;min-height: 800px;"><ng-view></ng-view></div>
		</div>
	</div>
</body>
</html>