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
	<div class="container" ng-init="initQueryProvincesFun();">
	
	     <!-- 出租出售 -->
		    <!-- （求租或求购且没有1，2，3，4）或（出租出售这里有没有1，2，3，4忘了） -->
			<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;" ng-if="choseFlag.flag==''">
			<div class="navbar-inner" style="height: 39px">
				<div class="container">
					<div class="navbar-header text-center col-xs-12">
						<h4>
							<a href="/WebSite/Mobile/Index.jsp#/{{parm_}}"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff"></span></small></a>
							<span style="color: #fff">所在省份</span>
						</h4>				
					</div>
				</div>
			</div>
	    </div>
	    
	    
	    
	 <!-- 求租求购 -->   
	 <div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;" ng-if="(parm_ =='DemandInfoPub'||parm_ =='DemandInfoPubSale')&&(choseFlag.flag==3||choseFlag.flag==4)"><!-- 求租求购且有1，2，3，4等数值 -->
		<div class="navbar-inner" style="height: 39px">
			<div class="container">
				<div class="navbar-header text-center col-xs-12">
					<h4>
						<!-- <a href="/WebSite/Mobile/Index.jsp#/{{parm_}}/{{goBakeParm}}"><small><span class="glyphicon glyphicon-chevron-left pull-left"></span></small></a> -->
						<a ng-click="goBackFun('/WebSite/Mobile/Index.jsp#/');"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff"></span></small></a><!-- href="/WebSite/Mobile/Index.jsp#/{{parm_}}/{{goBakeParm}}" -->
						<span style="color: #fff">设备使用地点</span>
					</h4>				
				</div>
			</div>
		</div>
    </div>
      <div class="col-md-12 column" style="margin-top:15%" ng-if="(parm_ =='DemandInfoPub'||parm_ =='DemandInfoPubSale')&&(choseFlag.flag==3||choseFlag.flag==4)">
		<label class="checkbox-inline" style=""><input  type="checkbox" ng-model="Nationwide.chk" ng-change="checkBoxFun();">全国</label> <!-- 首先全国要为true  -->
    </div>  
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    <!-- 出租出售 -->
	    <div class="col-xs-12 column" style="margin-top:15%"  ng-if="parm_ == 'Infopub' ||parm_ =='InfopubSale'">
			<p style="font-size: 18px">请选择省份:</p> 
			<hr style="margin-top: -10px">
	    </div>
	    
	    <div class="col-xs-12 column" ng-repeat="province in provinceList" ng-if="parm_ == 'Infopub' ||parm_ =='InfopubSale'"><!-- ng-disabled="isChack" -->
	        <botton ng-click="toSelectProvincesFun(province.name,'/WebSite/Mobile/Index.jsp#/InfopubCity');" class="btn btn-link btn-block"  style="text-decoration : none;"><!-- href="/WebSite/Mobile/Index.jsp#/InfopubCity" -->
		        <div>
					<p>
					   <span style="color:black;float: left;margin-top: -10px">{{province.name}}</span>
					   <small style="float: right;margin-top: -10px"><span class="glyphicon glyphicon-chevron-right pull-right"></span></small>
					</p>
				</div>
			</botton><hr>
	   </div>
	   
	   
	   
	   <!-- 求租求购 -->
	   	<div class="col-md-12 column" style="margin-top:15%" ng-disabled="isChack.chk" ng-if="parm_ =='DemandInfoPub'||parm_ =='DemandInfoPubSale'">
			<p style="font-size: 18px">请选择省份:</p> 
			<hr style="margin-top: -10px">
	    </div>
	    
	    <div class="col-md-12 column" ng-repeat="province in provinceList" ng-if="parm_ =='DemandInfoPub'||parm_ =='DemandInfoPubSale'"><!-- ng-disabled="isChack" -->
	        <button ng-click="toSelectProvincesFun(province.name,'/WebSite/Mobile/Index.jsp#/InfopubCity');" class="btn btn-link btn-block" ng-disabled="isChack.chk" style="text-decoration : none "><!-- href="/WebSite/Mobile/Index.jsp#/InfopubCity" -->
		        <div>
					<p>
					   <span style="color:black;float: left;">{{province.name}}</span>
					   <small style="float: right;"><span class="glyphicon glyphicon-chevron-right pull-right"></span></small>
					</p>
				</div>
			</button><hr>
	   </div>
	   
	</div>
</html>