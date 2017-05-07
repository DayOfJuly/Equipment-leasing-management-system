<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="description" content="">
<meta name="author" content="">


<link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
<link href="/media/css/bootstrap.min.css" rel="stylesheet">
<link href="/media/css/style.css" rel="stylesheet">
<link href="/media/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<link href="/css/heightLight.css" rel="stylesheet">

<script type="text/javascript" src="/media/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/JsLib/jquery-ui.min.js"></script>
<script type="text/javascript" src="/media/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/media/js/jquery.bootstrap.min.js"></script>
<script type="text/javascript" src="/media/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="/media/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="/media/js/emailstylejs.js"></script>
<script type="text/javascript" src="/js/JsLib/angular.js"></script>
<script type="text/javascript" src="/js/JsLib/angular-route.js"></script>
<script type="text/javascript" src="/js/JsLib/angular-resource.js"></script>
<script type="text/javascript" src="/js/JsLib/restangular.min.js"></script>
<script type="text/javascript" src="/js/JsLib/angular-messages.min.js"></script>
<script type="text/javascript" src="/js/JsLib/cookies.js"></script>
<script type="text/javascript" src="/js/JsLib/placeholder.js"></script>
<script type="text/javascript" src="/js/JsSvc/sessionIdFactory.js"></script>
<js:JsTag path="/WebSite/Mobile/js/JsSvc" name="angularjsFilter,Config,sessionIdFactory,unifySvc,SysCodeConfig,SysCodeTranslate" />
<script type="text/javascript">
	var app = angular.module('agreeApp', [ 'ngResource', 'ngRoute',
			'unifyModule', 'ngMessages', 'Config', 'sysCodeConfigModule',
			'sysCodeTranslateModule' ]);
	app.controller('agreeController', function($scope, PicSvc, published,
			PicUrl, SYS_CODE_CON, sysCodeTranslateFactory, IssuSvc, $route) {

		var url = location.search;// jsp后面的参数 ：?id=432&infoType=1
		var theRequest = new Object();
		if (url.indexOf("?") != -1) {// 如果有？ 
			var str = url.substr(1);// 去掉？ ：id=432&infoType=1
			strs = str.split("&");// 去掉& ：["id=432", "infoType=1"] 
			for (var i = 0; i < strs.length; i++) {
				var ss = strs[i].split("=");
				theRequest[ss[0]] = (ss[1]);
			}
		}
		
		var Str = theRequest.messageStr.split("~|~");
		var messageStr = {};
		messageStr.userName = Str[0];
		messageStr.password = Str[1];
		messageStr.confPassword = Str[2];
		messageStr.phone = Str[3];
		messageStr.VerificationCode = Str[4];
		messageStr.checkBox = Str[5];

		
		
		/*信息同步*/
		$scope.messageSync = function(){
			var messageStrs = "";
			messageStrs = messageStrs + (messageStr.userName ? messageStr.userName : "") + "~|~";
			messageStrs = messageStrs + (messageStr.password ? messageStr.password : "") + "~|~";
			messageStrs = messageStrs + (messageStr.confPassword ? messageStr.confPassword : "") + "~|~";
			messageStrs = messageStrs + (messageStr.phone  ? messageStr.phone : "") + "~|~";
			messageStrs = messageStrs + (messageStr.VerificationCode  ? messageStr.VerificationCode : "") + "~|~";
			messageStrs = messageStrs + (messageStr.checkBox  ? messageStr.checkBox : "") + "~|~";
			
			var urlStr = "/WebSite/Mobile/General/UserReg/UserReg.jsp?messageStrs="+messageStrs;
			
			window.location.href = urlStr;
		};

	});
</script>


</head>
<body ng-app="agreeApp" ng-controller="agreeController" data-spy="scroll" data-target="#myScrollspy">
<div  class="navbar navbar-default navbar-fixed-top" style="background-color: #cc0001;color:#fff">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4 style="font-size:18px">
						<a ng-click="messageSync();">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff"></span></small>
						</a>
						注册协议
						<a ng-click="messageSync();">
							<small><span class="glyphicon glyphicon-remove pull-right" ></span></small>
						</a>
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container" style="margin-top:70px;margin-bottom:70px">
	<div class="row "  >
		
		<div class="col-md-12 column" style="align:center;">
			<div>
				<ul class="list-unstyled">
					<li style="font-size:13px;text-indent:10px; background-color:#333333">
						<span ><p style="display: block;  height:30px; color: #FFFFFF;">注册协议

</p></span>
					</li>
				</ul>
			</div>
		</div>
		<div class="col-md-12 column" style="align:center;">
			<div>
				<ul class="list-unstyled">
					<li style="font-size:13px;">
						<span ><p style="display: block;">Lorem ipsum dolor sit amet,consectetur 

adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin 

sodales pulvinar tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam fermentum, nulla 

luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus sapien nunc eget odio.</p></span>
					</li>
				</ul>
			</div>
		</div>
		
	</div>
</div>

</body>
</html>


