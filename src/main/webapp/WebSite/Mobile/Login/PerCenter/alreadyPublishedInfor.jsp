<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/WebSite/Mobile/js/JsLib/scrollEditData.js"></script>
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
<body ng-controller="alreadyPubInforController">

<!-- 	<ul data-role="listview" class="swipe-delete ui-listview"> -->
<!-- 		<li class="ui-first-child"> -->
<!-- 			<div class="behind"> -->
<!-- 				<a class="ui-btn edit-btn">edit</a> -->
<!-- 				<a class="ui-btn delete-btn">Delete</a> -->
<!-- 			</div> <a class="ui-btn ui-btn-icon-right ui-icon-carat-r">item 1</a> -->
<!-- 		</li> -->
<!-- 		<li> -->
<!-- 			<div class="behind"> -->
<!-- 				<a class="ui-btn delete-btn">Delete</a> -->
<!-- 			</div> <a class="ui-btn ui-btn-icon-right ui-icon-carat-r">item 2</a> -->
<!-- 		</li> -->
<!-- 	</ul> -->


<div class="navbar navbar-default navbar-fixed-top" style=" background-color: #CC0001;padding:5px;">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4 style="font-size:18px">
						<a href="/WebSite/Mobile/Index.jsp#/perCenter">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff;"></span></small>
						</a>
						<span style="color:#fff;">已发布的信息</span>
						<a href="/WebSite/Mobile/Index.jsp#/pencenterScreen/1">
							<small><span class="glyphicon glyphicon-search pull-right" style="color:#fff;"></span></small>
						</a>
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="profitListId" class="container" ng-init="searchPublish();"; style="margin-top:70px;margin-bottom:70px">
	<div class="row "  >
		<div class="col-md-12 column" style="background:#f9f9f9;">
<!-- 			<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/> -->
			<div ng-repeat="r in publishList">
				<ul data-role="listview"  class="swipe-delete ui-listview">
					<li class="ui-first-child">
						<div class="behind">
<!-- 						<div> -->
							<a  class="ui-btn edit-btn" style="margin-top:1px"  ng-click="update(r);">编辑</a>
							<a  class="ui-btn delete-btn" style="margin-top:1px"  ng-click="delPublish_(r.id);">删除</a>
						</div> <a  class="ui-btn" href=" /WebSite/Mobile/Index.jsp#/pubDetailInfo/{{r}}" >
							<span ng-show="r.dataType==1"><b>【出租】</b></span>
							<span ng-show="r.dataType==2"><b>【出售】</b></span>
							<span ng-show="r.dataType==3"><b>【求租】</b></span>
							<span ng-show="r.dataType==4"><b>【求购】</b></span>
							<span style="color:#CFCFCF;float:right;">{{r.releaseDate}}</span></a>
					</li>
				</ul>
			</div>	
		</div>
		
	</div>
</div>

</body>
</html>