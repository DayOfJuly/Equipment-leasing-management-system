<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>	 --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="/media/css/bootstrap.min.css" rel="stylesheet" />
<link href="/media/css/style.css" rel="stylesheet" />

<!--[if lt IE 9]>
<script src="media/js/html5shiv/html5shiv.min.js"></script>
<script src="media/js/respond/respond.min.js"></script>
<![endif]-->
<jsp:include page="/WebSite/Mobile/Common/Head.jsp" />
<script src="/media/js/jquery-1.11.0.min.js"></script>
<script src="/media/js/jquery.bootstrap.min.js"></script>
<script src="/media/js/bootstrap.min.js"></script>
<script src="/media/js/scripts.js"></script>

<!-- <script  src="/js/JsLib/angular.js"></script> -->
<script src="/js/JsLib/angular-route.js"></script>
<script src="/js/JsLib/angular-resource.js"></script>
<script src="/js/JsLib/restangular.min.js"></script>

<script src="/WebSite/Mobile/js/JsSvc/sessionIdFactory.js"></script>
<script src="/WebSite/Mobile/js/JsSvc/angularjsFilter.js"></script>

<script src="/WebSite/Mobile/js/JsSvc/unifySvc.js"></script>
<script  src="/WebSite/Mobile/js/JsSvc/Config.js"></script>

<script src="/WebSite/Mobile/General/Login/js/login.js"></script>

<title>欢迎使用鲁班系统</title>
<link href="media/img/favicon.ico" rel="shortcut icon" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="author" content="" />
<script type="text/javascript">
</script>
<style>
/* #loginId {float:left;}    */
/* #password {float:left;}  */
/* #verificationCode {margin-top:20px;float:left;} */
/* #verificationCodeImg {margin-top:20px;float:left;}  */
#checkCode {background: url(/media/images/vcode.png);
	font-family: Arial;
	color: blue;
	font-size: 25px;
	cursor: pointer;
	text-align: center;
	vertical-align: middle;}
</style>
</head>
<body ng-app="loginApp" ng-controller="loginController"  style="margin-top:20px;">
<div class="navbar navbar-default navbar-fixed-top" style="background-color: #cc0001;color:#fff">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4 style="font-size:18px">
						<a href="/WebSite/Mobile/Index.jsp#/homePage">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff"></span></small>
						</a>
						登录
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div style="margin-top:70px" class="container">
	<div class="row">
			<div class="col-xs-12">
				<form name="input" class="form-horizontal" role="form" novalidate >
					<div class="pull-center" style="margin-bottom:50px;text-align:center">
						<img src="/media/images/login-logo.png" style="vertical-align:center"  height="100px;" width="130px;">
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
							<input type="text" class="form-control" name="userName" id="userName" ng-model="sysUser.userName" placeholder="手机号/用户登录ID" style="border-top:0; border-left:0; border-right:0; border-radius:0; box-shadow:inset 0px 0px 0px rgba(0,0,0,0.075);">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
							<input type="password" class="form-control" name="password" id="password" ng-model="sysUser.password" placeholder="登录密码" style="border-top:0; border-left:0; border-right:0; border-radius:0; box-shadow:inset 0px 0px 0px rgba(0,0,0,0.075);">
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-6">
							<input type="text" class="form-control"  name="VerificationCode" id="verificationCode" ng-model="sysUser.VerificationCode" placeholder="请输入验证码" style="border-top:0; border-left:0; border-right:0; border-radius:0; box-shadow:inset 0px 0px 0px rgba(0,0,0,0.075);">
						</div>
						<div class="col-xs-6" ng-init="GetVercode()">
							<div class="code" id="checkCode" ng-click="GetVercode()"></div>
						</div>
					</div>
				</form>	
				<div>&nbsp;</div>
				<button type="button" class="btn btn-danger btn-lg btn-block" ng-click="login(sysUser.VerificationCode);">
					登录
				</button>
				<div style="margin-bottom:40px;">&nbsp;</div>
				<div class="text-muted text-center" ng-click="returnUserRegPage();">
					<a href="/WebSite/Mobile/General/UserReg/UserReg.jsp">注册新帐号</a>
				</div>
			</div>
	</div>
</div>
</body>

</html>
