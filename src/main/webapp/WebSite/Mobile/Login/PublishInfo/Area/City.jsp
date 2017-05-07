<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="/media/css/bootstrap.min.css" rel="stylesheet">	
	<link href="/media/css/style.css" rel="stylesheet">
	<link href="/media/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
	<link href="/css/heightLight.css" rel="stylesheet">
	<link href="/css/jquery.lightbox-0.5.css" rel="stylesheet">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/JsLib/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/media/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/media/js/jquery.bootstrap.min.js"></script>
	<script type="text/javascript" src="/media/js/scripts.js"></script>
	<script type="text/javascript">
	
	
	</script>
</head>
	<div class="container" ng-init="initQueryCitiesFun();">
		<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
			<div class="navbar-inner" style="height: 39px">
				<div class="container">
					<div class="navbar-header text-center col-xs-12">
						<h4>
							<a ng-if="goBack.type_ && goBack.type_.length == 1" href="/WebSite/Mobile/Index.jsp#/Infopubprovinces/{{goBack.type_}}/{{goBack.url_}}"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff"></span></small></a>
							<a ng-if="goBack.type_.length != 1" href="/WebSite/Mobile/Index.jsp#/Infopubprovinces/{{goBack.url_}}"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff"></span></small></a>
							<span style="color: #fff">所在城市</span>
						</h4>				
					</div>
				</div>
			</div>
	    </div>
	    
	    <div class="col-md-12 column" style="margin-top:15%">
			<p style="font-size: 18px">请选择城市:</p> 
			<hr style="margin-top: -10px">
	    </div>
	    
	    <div class="col-md-12 column" ng-repeat="city in cityList">
		     <a ng-click="toSelectCityFun(city.name,'/WebSite/Mobile/Index.jsp#/Infopubdistrict');" style="text-decoration : none "><!-- href="/WebSite/Mobile/Index.jsp#/Infopubdistrict" -->
		         <div>
					  <p>
						 <span style="color:black">{{city.name}}</span> 
						 <small><span class="glyphicon glyphicon-chevron-right pull-right"></span></small>
					 </p>
				 </div>
			</a><hr>
	    </div>
	</div>
</html>