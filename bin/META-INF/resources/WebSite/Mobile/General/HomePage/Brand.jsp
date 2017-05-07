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
        var app = angular.module('barndApp', ['ngResource', 'unifyModule','ngRoute', 'ngMessages','Config','sysCodeConfigModule','sysCodeTranslateModule']);
        app.controller('barndController', function ($scope,PicSvc,published,PicUrl,SYS_CODE_CON,sysCodeTranslateFactory,IssuSvc,$route) {
        	
        	

            var url = location.search;/* jsp后面的参数 ：?id=432&infoType=1 */
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {/* 如果有？ */
                var str = url.substr(1);/* 去掉？ ：id=432&infoType=1 */
                strs = str.split("&");/* 去掉& ：["id=432", "infoType=1"] */
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
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
			
        	/*
        	* -- 品牌
        	*/

        	$scope.uploadBrand = function(){
        		$scope.brandList=["A","B","C","D","E","F","G","H","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X"];
    			function qSucc(rec){
					$scope.brandListA=$scope.encodeUrlParm(rec.A);
					$scope.circulat($scope.brandListA);
					$scope.brandListB=$scope.encodeUrlParm(rec.B);
					$scope.circulat($scope.brandListB);
					$scope.brandListC=$scope.encodeUrlParm(rec.C);
					$scope.circulat($scope.brandListC);
					$scope.brandListD=$scope.encodeUrlParm(rec.D);
					$scope.circulat($scope.brandListD);
					$scope.brandListE=$scope.encodeUrlParm(rec.E);
					$scope.circulat($scope.brandListE);
					$scope.brandListF=$scope.encodeUrlParm(rec.F);
					$scope.circulat($scope.brandListF);
					$scope.brandListG=$scope.encodeUrlParm(rec.G);
					$scope.circulat($scope.brandListG);
					$scope.brandListH=$scope.encodeUrlParm(rec.H);
					$scope.circulat($scope.brandListH);
					$scope.brandListI=$scope.encodeUrlParm(rec.I);
					$scope.circulat($scope.brandListI);
					$scope.brandListJ=$scope.encodeUrlParm(rec.J);
					$scope.circulat($scope.brandListJ);
					$scope.brandListK=$scope.encodeUrlParm(rec.K);
					$scope.circulat($scope.brandListK);
					$scope.brandListL=$scope.encodeUrlParm(rec.L);
					$scope.circulat($scope.brandListL);
					$scope.brandListM=$scope.encodeUrlParm(rec.M);
					$scope.circulat($scope.brandListM);
					$scope.brandListN=$scope.encodeUrlParm(rec.N);
					$scope.circulat($scope.brandListN);
					$scope.brandListO=$scope.encodeUrlParm(rec.O);
					$scope.circulat($scope.brandListO);
					$scope.brandListP=$scope.encodeUrlParm(rec.P);
					$scope.circulat($scope.brandListP);
					$scope.brandListQ=$scope.encodeUrlParm(rec.Q);
					$scope.circulat($scope.brandListQ);
					$scope.brandListR=$scope.encodeUrlParm(rec.R);
					$scope.circulat($scope.brandListR);
					$scope.brandListS=$scope.encodeUrlParm(rec.S);
					$scope.circulat($scope.brandListS);
					$scope.brandListT=$scope.encodeUrlParm(rec.T);
					$scope.circulat($scope.brandListT);
					$scope.brandListU=$scope.encodeUrlParm(rec.U);
					$scope.circulat($scope.brandListU);
					$scope.brandListV=$scope.encodeUrlParm(rec.V);
					$scope.circulat($scope.brandListV);
					$scope.brandListW=$scope.encodeUrlParm(rec.W);
					$scope.circulat($scope.brandListW);
					$scope.brandListX=$scope.encodeUrlParm(rec.X);
					$scope.circulat($scope.brandListX);
					$scope.brandListY=$scope.encodeUrlParm(rec.Y);
					$scope.circulat($scope.brandListY);
					$scope.brandListZ=$scope.encodeUrlParm(rec.Z);
					$scope.circulat($scope.brandListZ);
					
				}
				function qErr(){}
				published.unifydoHM({Action:"EquBrandFpy"},{fpy:$scope.brandList},qSucc,qErr); 
		};
		
		$scope.circulat =  function(pram){
			if(pram){
				for(var i=0;i<pram.length;i++)
				{
					pram[i].check=false;
				}
			}
		}
		
		$scope.uploadBrand();
		$scope.encodeUrlParm=function(obj){
			if(obj){
				for(var i=0;i<obj.length;i++){
	        		obj[i].encodeBrandName=encodeURIComponent(obj[i].name);
	    		}
	    		return obj;
			}
    	}
	 	$scope.brandArrayList = [];
	 	
	 	$scope.ScreenList = function(p){
            if(p.a.fpy=="A"){
	    		$scope.brandListA[p.$index].check=!$scope.brandListA[p.$index].check;
	            }
            if(p.a.fpy=="B"){
	    		$scope.brandListB[p.$index].check=!$scope.brandListB[p.$index].check;
	            }
            if(p.a.fpy=="C"){
	    		$scope.brandListC[p.$index].check=!$scope.brandListC[p.$index].check;
	            }
            if(p.a.fpy=="D"){
	    		$scope.brandListD[p.$index].check=!$scope.brandListD[p.$index].check;
	            }
            if(p.a.fpy=="E"){
	    		$scope.brandListE[p.$index].check=!$scope.brandListE[p.$index].check;
	            }
            if(p.a.fpy=="F"){
	    		$scope.brandListF[p.$index].check=!$scope.brandListF[p.$index].check;
	            }
            if(p.a.fpy=="G"){
	    		$scope.brandListG[p.$index].check=!$scope.brandListG[p.$index].check;
	            }
            if(p.a.fpy=="K"){
	    		$scope.brandListK[p.$index].check=!$scope.brandListK[p.$index].check;
	            }
            if(p.a.fpy=="L"){
	    		$scope.brandListL[p.$index].check=!$scope.brandListL[p.$index].check;
	            }
            if(p.a.fpy=="M"){
	    		$scope.brandListM[p.$index].check=!$scope.brandListM[p.$index].check;
	            }
            if(p.a.fpy=="N"){
	    		$scope.brandListN[p.$index].check=!$scope.brandListN[p.$index].check;
	            }
            if(p.a.fpy=="O"){
	    		$scope.brandListO[p.$index].check=!$scope.brandListO[p.$index].check;
	            }
            if(p.a.fpy=="P"){
	    		$scope.brandListP[p.$index].check=!$scope.brandListP[p.$index].check;
	            }
            if(p.a.fpy=="Q"){
	    		$scope.brandListQ[p.$index].check=!$scope.brandListQ[p.$index].check;
	            }
            if(p.a.fpy=="R"){
	    		$scope.brandListR[p.$index].check=!$scope.brandListR[p.$index].check;
	            }
            if(p.a.fpy=="S"){
	    		$scope.brandListS[p.$index].check=!$scope.brandListS[p.$index].check;
	            }
            if(p.a.fpy=="T"){
	    		$scope.brandListT[p.$index].check=!$scope.brandListT[p.$index].check;
	            }
            if(p.a.fpy=="U"){
	    		$scope.brandListU[p.$index].check=!$scope.brandListU[p.$index].check;
	            }
            if(p.a.fpy=="V"){
	    		$scope.brandListV[p.$index].check=!$scope.brandListV[p.$index].check;
	            }
            if(p.a.fpy=="W"){
	    		$scope.brandListW[p.$index].check=!$scope.brandListW[p.$index].check;
	            }
            if(p.a.fpy=="X"){
	    		$scope.brandListX[p.$index].check=!$scope.brandListX[p.$index].check;
	            }
            if(p.a.fpy=="Y"){
	    		$scope.brandListY[p.$index].check=!$scope.brandListY[p.$index].check;
	            }
            if(p.a.fpy=="Z"){
	    		$scope.brandListZ[p.$index].check=!$scope.brandListZ[p.$index].check;
	            }
    	} 
	 	
	 	$scope.check=function(){
	 		
	 		$scope.brandArrayList=[];
	 		for(var i=0;i<$scope.brandListA.length;i++){
	 			if($scope.brandListA[i].check == true)
				{
					$scope.brandArrayList.push($scope.brandListA[i].name);
				}
    		}
	 		if($scope.brandArrayList.length>3){
	 			$.messager.popup("最多只能选择3个品牌");
	 			return;
	 		}
	 		screenList.brand = $scope.brandArrayList;
	 		var ScreenList = JSON.stringify(screenList); 
	 		
      		var urlStr = "/WebSite/Mobile/Index.jsp#/ScreenList/"+ScreenList;
      		window.location.href = urlStr;  
	 	}
	 	
	 	
	 	
	 	
});
</script>
<style type="text/css">
    /* Custom Styles */
    ul.nav-tabs{
        width: 100px;
        margin-top: 5px;
        border-radius: 4px;
        border: 1px solid #ddd;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
    }
    ul.nav-tabs li{
        margin: -5px -15px -15px -15px;
      
    }
    ul.nav-tabs li:first-child{
        border-top: none;
    }
    ul.nav-tabs li a{
        margin-top: 5px;
        padding: 0px 22px;
        border-radius: 0;
    }
    ul.nav-tabs li.active a, ul.nav-tabs li.active a:hover{
        color: #fff;
        background: #0088cc;
        border: 1px solid #0088cc;
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
li {list-style-type:none;height:30px}
</style>
</head>
<body ng-app="barndApp" ng-controller="barndController" data-spy="scroll" data-target="#myScrollspy">

<div class="navbar navbar-default navbar-fixed-top" style="border-bottom:1px solid #ddd; background-color:#cc0001;color:#fff">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/Screen">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff"></span></small>
						</a>
						品牌
							<input type="button" class="btn btn-default btn-sm" ng-click="check();" style="border:1px;background-color: #017cfe;color:#fff;float:right" value="确定">
					</h4>
				
				</div>
			</div>
		</div>
	</div>
</div>
	<div class="container"  style="margin-top:70px;">
		<div class="row">
			<div class="col-xs-3" id="myScrollspy" style="float:right;margin-right:20%">
				<ul class="nav nav-tabs nav-stacked"  id="myNav" >
					<li class="active"><a href="#section-A">A</a></li>
					<li><a href="#section-B">B</a></li>
					<li><a href="#section-C">C</a></li>
					<li><a href="#section-D">D</a></li>
					<li><a href="#section-E">E</a></li>
					<li><a href="#section-F">F</a></li>
					<li><a href="#section-G">G</a></li>
					<li><a href="#section-H">H</a></li>
					<!-- <li><a href="#section-I">I</a></li> -->
					<li><a href="#section-J">J</a></li>
					<li><a href="#section-K">K</a></li>
					<li><a href="#section-L">L</a></li>
					<li><a href="#section-M">M</a></li>
					<li><a href="#section-N">N</a></li>
					<!-- <li><a href="#section-O">O</a></li> -->
					<li><a href="#section-P">P</a></li>
					<li><a href="#section-Q">Q</a></li>
					<li><a href="#section-R">R</a></li>
					<li><a href="#section-S">S</a></li>
					<li><a href="#section-T">T</a></li>
					<li><a href="#section-U">U</a></li>
					<li><a href="#section-V">V</a></li>
					<li><a href="#section-W">W</a></li>
					<li><a href="#section-X">X</a></li>
					<li><a href="#section-Y">Y</a></li>
					<li><a href="#section-Z">Z</a></li>
				</ul>
			</div>
			<div class="col-xs-6">
				<a href="/WebSite/Mobile/Index.jsp#/Screen" >不限</a>
				<div id="section-A">
					<h2>A</h2>
					<ul>
						<li ng-repeat="a in brandListA" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
					</ul>
                </div>
                <div id="section-B">
					<h2>B</h2>
					<ul>
	                 	<li ng-repeat="a in brandListB" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                </ul>
                 </div>
                 <div id="section-C">	
	                 <h2 >C</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListC" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
				<div id="section-D">
					<h2>D</h2>
					<ul>
	                 	<li ng-repeat="a in brandListD" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                </ul>
	             </div>
	             <div id="section-E">
					<h2>E</h2>
					<ul>
	                 	<li ng-repeat="a in brandListE" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                </ul>
	             </div>
	             <div id="section-F"> 
					 <h2>F</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListF" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>  
                 <div  id="section-G">
					<h2>G</h2>
					<ul>
	                 	<li ng-repeat="a in brandListG" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
	             </div>  
	             <div id="section-H">  
				<h2>H</h2>
					<ul>
	                	 <li ng-repeat="a in brandListH" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
				<!-- <h2 id="section-I">I</h2>
				<ul>
                 <li ng-repeat="i in brandListi" ><a href="javascript:void(0);">{{i.name}}</a></li>
                 </ul> -->
                 <div id="section-J">
					 <h2>J</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListJ" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div id="section-K">
					 <h2>K</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListK" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div id="section-L">
					 <h2>L</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListL" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div id="section-M">
					 <h2>M</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListM" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
	             </div>
	             <div  id="section-N">
					 <h2>N</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListN" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
				<!-- <h2 id="section-O">O</h2>
				<ul>
                 <li ng-repeat="o in brandListO" ><a href="javascript:void(0);">{{o.name}}</a></li>
                 </ul> -->
                 <div  id="section-P">
					 <h2>P</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListP" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div  id="section-Q">
					 <h2>Q</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListQ" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div id="section-R">
					 <h2>R</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListR" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div  id="section-S">
					 <h2>S</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListS" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div  id="section-T">
					 <h2>T</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListT" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div  id="section-U">
					 <h2>U</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListU" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div  id="section-V">
					 <h2>V</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListV" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div  id="section-W">
					 <h2>W</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListW" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div id="section-X">
					 <h2>X</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListX" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div id="section-Y">
					 <h2>Y</h2>
					 <ul>
	                 	<li ng-repeat="a in brandListY" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
                 <div id="section-Z">
					 <h2>Z</h2>
					 <ul>
	                	 <li ng-repeat="a in brandListZ" ><a href="" ng-click="ScreenList(this);">{{a.name}}</a><span class="glyphicon glyphicon-ok" style="float: right" ng-show="a.check"></span></li>
	                 </ul>
                 </div>
			</div>
		</div>
	</div>
</body>
</html>


