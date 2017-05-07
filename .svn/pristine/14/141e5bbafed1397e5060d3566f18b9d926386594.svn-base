<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/WebSite/Mobile/js/JsLib/scrollDeleteData.js"></script>
<link href="/WebSite/Mobile/media/css/jquery.mobile-1.4.5.css" rel="stylesheet">
<script type="text/javascript" src="/WebSite/Mobile/media/js/jquery.mobile-1.4.5.js"></script>
<style>
.behind {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	right: 0;
}
.behind a.ui-btn {
	width: 68px;
	margin: 0px;
	float: right;
	border: none;
}
.behind a.delete-btn, .behind a.delete-btn:active, .behind a.delete-btn:visited, .behind a.delete-btn:focus, .behind a.delete-btn:hover {
	color: white;
	background-color: red;
	text-shadow: none;
}
.behind a.ui-btn.pull-left {
	float: left;
}
.behind a.edit-btn, .behind a.edit-btn:active, .behind a.edit-btn:visited, .behind a.edit-btn:focus, .behind a.edit-btn:hover {
	color: white;
	background-color: orange;
	text-shadow: none;
}
</style>
<body ng-controller="pubFrontListController">

<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001;padding:5px;">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4 style="font-size:18px">
						<a href="/WebSite/Mobile/Index.jsp#/perCenter">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff;"></span></small>
						</a>
						<span style="color:#fff;">想交易的信息</span>
						<a href="/WebSite/Mobile/Index.jsp#/pencenterScreen/2">
							<small><span class="glyphicon glyphicon-search pull-right" style="color:#fff;"></span></small>
						</a>
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container" ng-init="searchPublish();"; style="margin-top:70px;margin-bottom:70px">
	<div class="row "  >
		
		<div class="col-md-12 column" style="background:#f9f9f9;">
			<div ng-repeat="r in KeyWordList">
				<ul data-role="listview"  class="swipe-delete ui-listview">
					<li class="ui-first-child">
						<div class="behind">
<!-- 						<div> -->
<!-- 							<a  class="ui-btn edit-btn" ng-click="update(r);">编辑</a> -->
							<a  class="ui-btn delete-btn" style="margin-top:1px" ng-click="delPublish_(r.id);">删除</a>
						</div> 
						<a  class="ui-btn" href=" /WebSite/Mobile/Index.jsp#/pubFrontDetailInfo/{{r}}" >
							<span ng-show="r.dataType==1"><b>【出租】</b></span>
							<span ng-show="r.dataType==2"><b>【出售】</b></span>
							<span ng-show="r.dataType==3"><b>【求租】</b></span>
							<span ng-show="r.dataType==4"><b>【求购】</b></span>
							<span style="color:#CFCFCF;float:right;">{{r.releaseDate}}</span></a>
						</a>
					</li>
				</ul>
			</div>	
		
		
<!-- 			<div ng-repeat="r in KeyWordList"> -->
<!-- 				<a href=" /WebSite/Mobile/Index.jsp#/pubFrontDetailInfo/{{pubDetailInfoQuer}}" style=" color:black"><ul class="list-unstyled" ng-click="pubDetailInfo(r);"> -->
<!-- 					<li style="font-size:16px"> -->
<!-- 						<span ><b>【求购】</b></span><span style="color:#CFCFCF;float:right">{{r.releaseDate}}</span> -->
<!-- 					</li> -->
<!-- 					<li style="font-size:16px;" ng-show="r.infoTitle.length &gt;5">{{r.infoTitle|limitTo:5}}...</li> -->
<!-- 					<li style="font-size:16px;" ng-show="r.infoTitle.length &lt;5">{{r.infoTitle|limitTo:5}}</li> -->
<!-- 					<li style="font-size:16px;" ng-show="r.infoTitle.length ==5">{{r.infoTitle|limitTo:5}}</li> -->
<!-- 				</ul></a> -->
<!-- 				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/> -->
<!-- 			</div> -->
		</div>
		
	</div>
</div>

</body>
</html>