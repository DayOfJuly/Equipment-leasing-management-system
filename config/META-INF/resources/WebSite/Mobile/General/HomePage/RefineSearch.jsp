<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	
	<link href="../../../../media/css/bootstrap.min.css" rel="stylesheet" />
	<link href="../../../../media/css/style.css" rel="stylesheet" />

	<!--[if lt IE 9]>
	<script src="media/js/html5shiv/html5shiv.min.js"></script>
	<script src="media/js/respond/respond.min.js"></script>
	<![endif]-->

	<script src="../../../../media/js/jquery-1.11.0.min.js"></script>
	<script src="../../../../media/js/jquery.bootstrap.min.js"></script>
	<script src="../../../../media/js/bootstrap.min.js"></script>
	<script src="../../../../media/js/scripts.js"></script>

	<script  src="../../../../js/JsLib/angular.js"></script>
	<script src="../../../../js/JsLib/angular-route.js"></script>
	<script src="../../../../js/JsLib/angular-resource.js"></script>
	<script src="../../../../js/JsLib/restangular.min.js"></script>


	<script  src="../../../../js/JsSvc/unifySvc.js"></script>
	<script src="../../../../js/JsSvc/Config.js"></script>
</head>
<body>
	<div class="row" style="margin-bottom:20px;margin-top: 5px;">
		<div class="col-xs-3" style="margin-top: 2px;">
			<input type="button" class="btn btn-default btn-sm" value="<"
		 		onclick="window.location.href='Index.jsp'"> 
		</div>
		<div class="col-xs-6">
			<input type="text" id="custNamePre" name="custNamePre" class="form-control" placeholder="请输入关键词检索" onclick="">
		</div>
		<div class="col-xs-1" style="margin-top: 2px;">
			<input type="button" class="btn btn-default btn-sm" value="搜索"
		 		onclick=""> 
		</div>
	</div>
	<div class="row" style="background-color:#F6F6F6;">
		<div class="col-xs-3" style="margin-top: 7px;">
			<h4 style="margin-left: 20px;">热搜</h4>
		</div>
		<div class="col-xs-3" style="margin-top: 12px;">
			<input type="button" class="btn btn-default btn-sm" value="电动空间压机" onclick=""> 
		</div>
		<div class="col-xs-3" style="margin-top: 12px;">
			<input type="button" class="btn btn-default btn-sm" value="发电机" onclick=""> 
		</div>
		<div class="col-xs-3" style="margin-top: 12px;">
			<input type="button" class="btn btn-default btn-sm" value="内燃空压机" onclick=""> 
		</div>
	</div>
	<div>&nbsp;</div>
	<div class="row" style="background-color:#F6F6F6;">
		<a href="#" class="list-group-item active">
  			 历史搜索
		</a>
		<a href="#" class="list-group-item">发电机</a>
		<a href="#" class="list-group-item">电动空间压机</a>
		<a href="#" class="list-group-item">内燃空压机</a>
		<a href="#" class="list-group-item">每年更新成本</a>
	</div>
</body>
</html>
