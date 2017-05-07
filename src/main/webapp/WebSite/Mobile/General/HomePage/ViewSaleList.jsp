<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
 a{color:#000;text-decoration:none;}
 a:hover{text-decoration:none}
</style>
<div class="navbar navbar-default navbar-fixed-top" style="border-bottom:1px solid #ddd; background-color:#fff;">
	<div class="navbar-inner" style="background-color: #cc0001;">
		<div class="container">
			<div class="row" style="margin-bottom:20px;margin-top: 5px;">
					<div class="text-center col-xs-12">						
						<h4><a href="/WebSite/Mobile/Index.jsp#/homePage" >
							<small><span class="glyphicon glyphicon-chevron-left pull-left"  style="margin-top:10px;color:#fff"></span></small>
						</a></h4>
						<div class="col-xs-9">
							<input type="text" id="custNamePre" name="custNamePre" ng-click="goToSearch();" class="form-control" placeholder="请输入关键词检索" ng-model="formParms.queryName">
						</div>
						<div class="col-xs-1" style="margin-top: 2px;">
							<input type="button" class="btn btn-default btn-sm" style="border:1px;background-color: #017cfe;color:#fff" value="搜索" ng-click="search(this);">
						</div>
				</div>
			</div>
		</div> 
	</div>
	<hr style="margin-top:0px"/>
	<div class="row" style="margin-top:-10px">
		 <div class="col-xs-3 text-center">
				<span ng-click="returnList();">综合</span><span style="color:#D1D1D1;float:right;margin-right:-20px">|</span>
       	</div>
       	<div class="col-xs-3 text-center">
				<span ng-show="myVar" ng-click="toggle(2)">出售 <span class="glyphicon glyphicon-chevron-down"></span></span>
				<span ng-show="revel" ng-click="toggle(2)">出售 <span class="glyphicon glyphicon-chevron-up"></span></span>
				<span style="color:#D1D1D1;float:right;margin-right:-20px">|</span>
       	</div>
       	<div class="col-xs-3 text-center">
					<span  ng-show="priceDown"   ng-click="priceOrder(1);" >价格 <span class="glyphicon glyphicon-chevron-down"></span></span>
					<span  ng-show="priceUp"  ng-click="priceOrder(2);" >价格 <span class="glyphicon glyphicon-chevron-up"></span></span>
					<span style="color:#D1D1D1;float:right;margin-right:-20px">|</span>
       	</div>
       	<div class="col-xs-3 text-center">
				<a  href="" ng-click="selection();"><span class="glyphicon glyphicon-filter"></span>筛选</a>
       	</div>
	</div>
</div>
	<div class="container" style="margin-top:130px;" ng-show="revel">
		<ul class="media-list">
				<li style="padding:5px"><a href="" ng-click="toggle(1)"><div>出租</div></a></li>
				<li style="padding:5px"><a href="" ng-click="toggle(2)"><div>出售</div></a></li>
				<li style="padding:5px"><a href="" ng-click="toggle(3)"><div>求租</div></a></li>
				<li style="padding:5px"><a href="" ng-click="toggle(4)"><div>求购</div></a></li>
		</ul>
	</div>
<div class="container"  style="margin-top:130px;">
		<ul class="media-list">
			<li class="media col-xs-12" style="margin-top:5px;" ng-repeat="r in sresultList" id="saleList">
				<div>
					<a class="media-left" href="" ng-click="jump(this);" style="text-decoration:none"  >
						<img style="width:70px;height:100px;float:left;"  ng-src="{{PicUrlName}}/{{r.PicName}}/{{r.PicType}}" alt="list1">
							<div style="height:80px">
								<span>【出售】{{r.infoTitle}}</span><br>
								<span style="color:#D1D1D1">{{r.onProvince}}{{r.onCity}}{{r.onDistrict}}</span><br>
								<span style="color:#EEEE00">
									<p>￥{{r.price}}</p>
		                        </span>
							</div>
					</a>
					<hr style="margin-left:90px;"/>
				</div>
			</li>
		</ul>
		<div ng-show="available" class="container" style="margin-top:30%;margin-left:30%" >没有符合条件的记录</div>
</div>