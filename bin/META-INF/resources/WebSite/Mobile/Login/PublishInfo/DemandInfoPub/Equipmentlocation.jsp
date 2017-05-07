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
<div class="container">
	<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
		<div class="navbar-inner" style="height: 39px">
			<div class="container">
				<div class="navbar-header text-center col-xs-12">
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/DemandInfoPub"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff;"></span></small></a>
						<span style="color: #fff">设备使用地点</span>
					</h4>				
				</div>
			</div>
		</div>
    </div>
     <div class="col-md-12 column" style="margin-top:15%">
		<label class="checkbox-inline" style=""><input  type="checkbox" ng-model="tmp.reason2" ng-click="zuQiClick(tmp.reason2);">全国</label> 
    </div>
    
    
    
    
    
    
    
    
    <div >
    <div class="col-md-12 column" style="margin-top:5%">
		<p style="font-size: 18px;color: gray;" >请选择省份:</p> 
		<hr style="margin-top: -10px">
    </div>
     <div class="col-md-12 column" >
        <a href="" disabled="true" style="text-decoration : none ">
        <div>
		<p ><span style="color: gray;">河北省</span> <small><span class="glyphicon glyphicon-chevron-right pull-right"></span></small></p>
		</div>
		</a>
		<hr>
    </div>
    <div class="col-md-12 column" >
        <a href="" style="text-decoration : none ">
        <div>
		<p ><span style="color: gray;">邯郸市</span> <small><span class="glyphicon glyphicon-chevron-right pull-right"></span></small></p>
		</div>
		</a>
		<hr>
    </div>
    <div class="col-md-12 column" >
        <a href="" style="text-decoration : none ">
        <div>
		<p ><span style="color: gray;">磁县</span> <small><span class="glyphicon glyphicon-chevron-right pull-right"></span></small></p>
		</div>
		</a>
		<hr>
    </div>
    
</div>
</div>
</html>