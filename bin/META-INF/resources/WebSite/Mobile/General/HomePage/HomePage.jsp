<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus{
	color: #F3F2F2;
    background-color: #017cfe;
    border: 1px solid #017cfe
}
</style>
<div  ng-controller="homePageController" class="container">
	<div class="row" style="margin-bottom:70px;">
			<div style="height:60px;"></div>
		<div id="adCarousel" class="carousel slide" data-ride="carousel" data-interval="1000">
			<ol class="carousel-indicators">
				<li data-target="#adCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#adCarousel" data-slide-to="1"></li>
				<li data-target="#adCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="/WebSite/Mobile/media/image/AD_01.png" alt="First slide">
				</div>
				<div class="item">
					<img src="/WebSite/Mobile/media/image/AD_01.png" alt="Second slide">
				</div>
				<div class="item">
					<img src="/WebSite/Mobile/media/image/AD_01.png" alt="Third slide">
				</div>
			</div>
			<a class="carousel-control left" href="/#adCarousel" data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="/#adCarousel" data-slide="next">&rsaquo;</a>
		</div>
		<div>&nbsp;</div>
		<div class="col-xs-12">
			<input type="text" id="custNamePre" name="custNamePre" class="form-control" placeholder="请输入关键词检索" 
				ng-click="goToSearch();"><!-- onclick="window.location.href='Index.jsp#search/'" -->
		</div>
		<div>&nbsp;</div>
		<div class="text-center">
			<div class="col-xs-3" style="background-color:#cc0001;" onclick="window.location.href='Index.jsp#viewRentList/1'">
				<img class="img-circle" src="media/image/Ico_Finance.png" style="width:30px; height:30px;">
				<h6 style="color:#fff">出租信息</h6>
	        </div>
	        <div class="col-xs-3" style="background-color:#cc0001;" onclick="window.location.href='Index.jsp#ViewDemandRentList/3'">
	        	<img class="img-circle" src="media/image/Ico_Finance.png" style="width:30px; height:30px;">
				<h6 style="color:#fff">求租信息</h6>
	        </div>
	        <div class="col-xs-3" style="background-color:#cc0001;" onclick="window.location.href='Index.jsp#ViewSaleList/2'">
	        	<img class="img-circle" src="media/image/Ico_Finance.png" style="width:30px; height:30px;">
				<h6 style="color:#fff">出售信息</h6>
	        </div>
	        <div class="col-xs-3" style="background-color:#cc0001;" onclick="window.location.href='Index.jsp#ViewDemandSaleList/4'">
	        	<img class="img-circle" src="media/image/Ico_Finance.png" style="width:30px; height:30px;">
				<h6 style="color:#fff">求购信息</h6>
	        </div>
        </div>
        <div ng-init="resourceCount();">
			<table class="table" text-align="left">
				<tbody>
					<tr>
						<th colspan="2">资源统计</th>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td>设备资源共计<span style="color:red">{{resourceMsg.outerEquNum+resourceMsg.innerEquNum}}</span>台</td>
						<td>注册企业共计<span style="color:red">{{resourceMsg.innerOrg+resourceMsg.outerOrg}}</span>家</td>
					</tr>
					<tr>
						<td>可出租设备<span style="color:red">{{resourceMsg.canRentNum}}</span>台</td>
						<td>可出售设备<span style="color:red">{{resourceMsg.canSaleNum}}</span>台</td>
					</tr>
					<tr>
						<td>求租设备<span style="color:red">{{resourceMsg.demandRentNum}}</span>台</td>
						<td>求购设备<span style="color:red">{{resourceMsg.demandSaleNum}}</span>台</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div>
        		<ul id="myTab" class="nav nav-tabs " >
   					<li class="active" ><a href="/#canRent" style="padding:5px 10px;" data-toggle="tab">最新出租</a></li>
   					<li class="" ng-click="saleListQury();"><a href="/#canSale" style="padding:5px 10px;" data-toggle="tab">最新出售</a></li>
   					<li class="" ng-click="demandRentListQury();"><a href="/#asd" style="padding:5px 10px;" data-toggle="tab">最新求租</a></li>
   					<li class="" ng-click="demandSaleListQury();"><a href="/#qwe" style="padding:5px 10px;" data-toggle="tab">最新求购</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
   					<div class="tab-pane fade in active" id="canRent">
	      				<div ng-repeat="r in resourceRentList">
	      					<div class="col-xs-6" style="padding:5px;text-align:center">
									<a href="" ng-click="jump(this);" class="list-group-item">
									<img class="img-circle" src="media/image/default.png" style="width:80%; height:100px;vertical-align:center"><br/>
									<text title="{{r.infoTitle}}">{{r.infoTitleTemp}}</text></a>
		        			</div>
	   					</div>
	   				</div>
   					<div class="tab-pane fade" id="canSale">
   						<div ng-repeat="r in resourceSaleList">
	      					<div class="col-xs-6" style="padding:5px;text-align:center">
									<a href="" ng-click="jump(this);" class="list-group-item">
									<img class="img-circle" src="media/image/default.png" style="width:80%; height:100px;vertical-align:center"><br/>
									<text title="{{r.infoTitle}}">{{r.infoTitleTemp}}</text></a>
		        			</div>
	   					</div>
   					</div>
   					<div class="tab-pane fade" id="asd">
   						<div ng-repeat="r in resourceDemandRentList">
   							<a href="" ng-click="jump(this);" class="list-group-item">【求租】{{r.infoTitleTemp}}<span style="float:right">{{r.releaseDateTemp}}</span></a>
   						</div>
   					</div>
   					<div class="tab-pane fade" id="qwe">
   						<div ng-repeat="r in resourceDemandSaleList">
   							<a href="" ng-click="jump(this);" class="list-group-item">【求购】{{r.infoTitleTemp}}<span style="float:right">{{r.releaseDateTemp}}</span></a>
   						</div>
   					</div>
				</div>
        </div>
	</div>

	<div class="row">
	<!-- bottom begin -->
		<div class="text-center">
			<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
				<div class="navbar-header col-xs-12" style="background-color: #017cfe;">
					<div class="navbar-brand col-xs-3" style="padding:5px;" onclick="window.location.href='Index.jsp#/'">
						<img class="img-circle" src="media/image/Ico_Index.png" alt="首页" style="width:20px; height:20px; margin:0 auto;">
						<h5 style="color:#fff">首页</h5>
					</div>
					<div class="navbar-brand col-xs-3" style="padding:5px;" onclick="window.location.href='Index.jsp#classify/'">
						<img class="img-circle" src="media/image/Ico_Invest.png" alt="分类" style="width:20px; height:20px; margin:0 auto;">
						<h5 style="color:#fff">分类</h5>
					</div>
					<div class="dropdown col-xs-3" style="padding:5px;">
						<div class="dropdown-toggle" data-toggle="dropdown">
							<img class="img-circle" src="media/image/Ico_Publish.png" alt="发布" style="width:20px; height:20px; margin:0 auto;">
               				<h5 style="color:#fff">发布 <b class="caret"></b></h5>
            			</div>
            			<ul class="dropdown-menu">
               				<li><a href="/WebSite/Mobile/Index.jsp#/Infopub">出租</a></li>
               				<li><a href="/WebSite/Mobile/Index.jsp#/InfopubSale">出售</a></li>
               				<li><a href="/WebSite/Mobile/Index.jsp#/DemandInfoPub">求租</a></li>
               				<li><a href="/WebSite/Mobile/Index.jsp#/DemandInfoPubSale">求购</a></li>
            			</ul>
					</div>
					<div class="navbar-brand col-xs-3" style="padding:5px;" onclick="window.location.href='Index.jsp#perCenter/'">
						<img class="img-circle" src="media/image/Ico_MyAsset.png" alt="个人中心" style="width:20px; height:20px; margin:0 auto;">
						<h5 style="color:#fff">个人中心</h5>
					</div>
				</div>
			</nav>
		</div>
	<!-- bottom end -->
	</div>
</div>