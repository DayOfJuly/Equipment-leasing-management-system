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
        var app = angular.module('atCityApp', ['ngResource','ngRoute', 'unifyModule', 'ngMessages','Config','sysCodeConfigModule','sysCodeTranslateModule']);
        app.controller('atCityController', function ($scope,$anchorScroll,PicSvc,published,$location,PicUrl,SYS_CODE_CON,sysCodeTranslateFactory,IssuSvc,$route) {
        	
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
            var Str = theRequest.screenList.split("~|~");
        	var  screenList = {};
        	screenList.minPrice = Str[0];
        	screenList.maxPrice = Str[1];
        	screenList.myselect = Str[2];
        	screenList.dataType = Str[3];
        	screenList.atCity = Str[4];
        	screenList.equName_ = Str[5]
        	screenList.brand = Str[6];
        	var brandName = screenList.brand.split(",");
        	
        	/*
        	* -- 所在城市
        	*/	
        	$scope.cityClick=function(){
        			$scope.cityList=["A","B","C","D","E","F","G","H","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
        			
        			function qSucc(rec){
        						$scope.cityValueListA=$scope.encodeUrlParm(rec.A);
        						$scope.cityValueListB=$scope.encodeUrlParm(rec.B);
        						$scope.cityValueListC=$scope.encodeUrlParm(rec.C);
        						$scope.cityValueListD=$scope.encodeUrlParm(rec.D);
        						$scope.cityValueListE=$scope.encodeUrlParm(rec.E);
        						$scope.cityValueListF=$scope.encodeUrlParm(rec.F);
        						$scope.cityValueListG=$scope.encodeUrlParm(rec.G);
        						$scope.cityValueListH=$scope.encodeUrlParm(rec.H);
        						$scope.cityValueListI=$scope.encodeUrlParm(rec.I);
        						$scope.cityValueListJ=$scope.encodeUrlParm(rec.J);
        						$scope.cityValueListK=$scope.encodeUrlParm(rec.K);
        						$scope.cityValueListL=$scope.encodeUrlParm(rec.L);
        						$scope.cityValueListM=$scope.encodeUrlParm(rec.M);
        						$scope.cityValueListN=$scope.encodeUrlParm(rec.N);
        						$scope.cityValueListO=$scope.encodeUrlParm(rec.O);
        						$scope.cityValueListP=$scope.encodeUrlParm(rec.P);
        						$scope.cityValueListQ=$scope.encodeUrlParm(rec.Q);
        						$scope.cityValueListR=$scope.encodeUrlParm(rec.R);
        						$scope.cityValueListS=$scope.encodeUrlParm(rec.S);
        						$scope.cityValueListT=$scope.encodeUrlParm(rec.T);
        						$scope.cityValueListU=$scope.encodeUrlParm(rec.U);
        						$scope.cityValueListV=$scope.encodeUrlParm(rec.V);
        						$scope.cityValueListW=$scope.encodeUrlParm(rec.W);
        						$scope.cityValueListX=$scope.encodeUrlParm(rec.X);
        						$scope.cityValueListY=$scope.encodeUrlParm(rec.Y);
        						$scope.cityValueListZ=$scope.encodeUrlParm(rec.Z);
        			}
        			function qErr(){}
        			published.unifydoHM({Action:"RegionNameFpy"},{fpy:$scope.cityList},qSucc,qErr); 
        	};
        	$scope.cityClick();
        	$scope.encodeUrlParm=function(obj){
        		if(obj){
	        		for(var i=0;i<obj.length;i++){
		        		obj[i].encodeName=encodeURIComponent(obj[i].name);
	        		}
	        		return obj;
        		}
        	}
        	$scope.ScreenList = function(rec){
        		screenList.atCity = rec.a.name;
        		var screen = JSON.stringify(screenList); 
        		var urlStr = "/WebSite/Mobile/Index.jsp#/ScreenCity/"+screen+"/"+1;
        		window.location.href = urlStr;
        	}
        	 $anchorScroll.yOffset = 100;   
        	$scope.goTo = function (id) {
        		$location.hash(id);
                $anchorScroll();
            }
        	$scope.goTo('section-A');
        });
    </script>   
    
<style type="text/css">
    /* Custom Styles */
    ul.nav-tabs{
        width: 100px;
        margin-top: 50px;
        border-radius: 4px;
        border: 1px solid #ddd;
    }
     ul.nav-tabs li{
        margin: -5px -15px -14px -15px;
    } 
    ul.nav-tabs li:first-child{
        border-top: none;
    }
    ul.nav-tabs li a{
        margin-top: 5px;
        padding: 0px 22px;
        border-radius: 0;
    }
    ul.nav-tabs li.active a, ul.nav-tabs li.active a:hover a.active{
        color: #017cfe;
        background: #017cfe;
        border: 1px solid #017cfe;
    }
 
	 .nav-tabs>li>a:hover {
	    margin-left:15px;
	    width: 100px;
	    color: #fff;
	 	background: #017cfe;
		border-color: #017cfe
	}
	.nav>li>a:hover,.nav>li>a:focus {
		margin-left:15px;
	    width: 100px;
	    color: #fff;
		text-decoration: none;
		background-color: #017cfe
	}

    ul.nav-tabs li:first-child a{
        border-radius: 4px 4px 0 0;
    }
    ul.nav-tabs li:last-child a{
        border-radius: 0 0 4px 4px;
    }
    ul.nav-tabs.affix{
        top: 10px; /* Set the top position of pinned element */
    }
</style>
 <script type="text/javascript">
 $(document).ready(function(){
     $("#myNav").affix({
        offset: { 
           top: 0
     	}
    }); 
}); 
</script>
<style>
li {
	list-style-type:none;
	height:30px;
}
</style>

</head>
<body ng-app="atCityApp" ng-controller="atCityController" data-spy="scroll" data-target="#myScrollspy" >
<div>
	<div class="navbar navbar-default navbar-fixed-top" style="border-bottom:1px solid #ddd; background-color:#cc0001;color:#fff">
		<div class="navbar-inner">
			<div class="container">
				<div class="row">
					<div class="text-center col-xs-12">						
						<h4>
							<a href="/WebSite/Mobile/Index.jsp#/Screen">
								<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff;margin-top:5px"></span></small>
							</a>
							所在城市
						</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container" style="margin-top:70px;">
		<div class="row">
			<div class="col-xs-3" id="myScrollspy"  style="float:right;margin-right:20%">
				<ul class="nav nav-tabs nav-stacked" id="myNav" style="height:88%">
					<li ><a href="" class="active" ng-click="goTo('section-A');" style="margin-left:15px;">A</a></li>
					<li ><a href="" ng-click="goTo('section-B');" style="margin-left:15px;">B</a></li>
					<li ><a href="" ng-click="goTo('section-C');" style="margin-left:15px;">C</a></li>
					<li ><a href="" ng-click="goTo('section-D');" style="margin-left:15px;">D</a></li>
					<li ><a href="" ng-click="goTo('section-E');" style="margin-left:15px;">E</a></li>
					<li ><a href="" ng-click="goTo('section-F');" style="margin-left:15px;">F</a></li>
					<li ><a href="" ng-click="goTo('section-G');" style="margin-left:15px;">G</a></li>
					<li ><a href="" ng-click="goTo('section-H');" style="margin-left:15px;">H</a></li>
					<li ><a href="" ng-click="goTo('section-J');" style="margin-left:15px;">J</a></li>
					<li ><a href="" ng-click="goTo('section-K');" style="margin-left:15px;">K</a></li>
					<li ><a href="" ng-click="goTo('section-L');" style="margin-left:15px;">L</a></li>
					<li ><a href="" ng-click="goTo('section-M');" style="margin-left:15px;">M</a></li>
					<li ><a href="" ng-click="goTo('section-N');" style="margin-left:15px;">N</a></li>
					<li ><a href="" ng-click="goTo('section-P');" style="margin-left:15px;">P</a></li>
					<li ><a href="" ng-click="goTo('section-Q');" style="margin-left:15px;">Q</a></li>
					<li ><a href="" ng-click="goTo('section-R');" style="margin-left:15px;">R</a></li>
					<li ><a href="" ng-click="goTo('section-S');" style="margin-left:15px;">S</a></li>
					<li ><a href="" ng-click="goTo('section-T');" style="margin-left:15px;">T</a></li>
					<li ><a href="" ng-click="goTo('section-U');" style="margin-left:15px;">U</a></li>
					<li ><a href="" ng-click="goTo('section-V');" style="margin-left:15px;">V</a></li>
					<li ><a href="" ng-click="goTo('section-W');" style="margin-left:15px;">W</a></li>
					<li ><a href="" ng-click="goTo('section-X');" style="margin-left:15px;">X</a></li>
					<li ><a href="" ng-click="goTo('section-Y');" style="margin-left:15px;">Y</a></li>
					<li ><a href="" ng-click="goTo('section-Z');" style="margin-left:15px;">Z</a></li>
				</ul>
			</div>
			<div class="col-xs-6"  id="content">
				<a href="/WebSite/Mobile/Index.jsp#/Screen" >不限</a>
				<div id="section-A">
					<h2>A</h2>
					<ul style="margin-left:-5%">
						<li ng-repeat="a in cityValueListA" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
					</ul>
                </div>
                <div id="section-B">
					<h2>B</h2>
					<ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListB" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                </ul>
                 </div>
                 <div id="section-C">	
	                 <h2 >C</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListC" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
				<div id="section-D">
					<h2>D</h2>
					<ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListD" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                </ul>
	             </div>
	             <div id="section-E">
					<h2>E</h2>
					<ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListE" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                </ul>
	             </div>
	             <div id="section-F"> 
					 <h2>F</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListF" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>  
                 <div  id="section-G">
					<h2>G</h2>
					<ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListG" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
	             </div>  
	             <div id="section-H">  
				<h2>H</h2>
					<ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListH" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-J">
					 <h2>J</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListJ" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-K">
					 <h2>K</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListK" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-L">
					 <h2>L</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListL" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-M">
					 <h2>M</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListM" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
	             </div>
	             <div  id="section-N">
					 <h2>N</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListN" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div  id="section-P">
					 <h2>P</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListP" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div  id="section-Q">
					 <h2>Q</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListQ" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-R">
					 <h2>R</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListR" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div  id="section-S">
					 <h2>S</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListS" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div  id="section-T">
					 <h2>T</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListT" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div  id="section-U">
					 <h2>U</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListU" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div  id="section-V">
					 <h2>V</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListV" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div  id="section-W">
					 <h2>W</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListW" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-X">
					 <h2>X</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListX" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-Y">
					 <h2>Y</h2>
					 <ul style="margin-left:-5%">
	                 	<li ng-repeat="a in cityValueListY" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
                 <div id="section-Z">
					 <h2 >Z</h2>
					 <ul style="margin-left:-5%">
	                	 <li ng-repeat="a in cityValueListZ" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a></li>
	                 </ul>
                 </div>
			</div>
		</div>
	</div>
</div>
</body>
</html>


