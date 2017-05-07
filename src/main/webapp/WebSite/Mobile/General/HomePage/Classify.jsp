<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="js" tagdir="/WEB-INF/tags"%>

<style>
.row {
    margin-right: -15px;
    margin-left: -15px;
    padding-bottom: 15px;
}
.nav>li>a:hover{
background-color: #fff;
  border-color: #fff;
}
.nav .open>a,.nav .open>a:hover, .nav .open>a:focus {
  background-color: #fff;
  border-color: #fff;
}
a.dropdown-toggle{
width:75px;
height:40px;
padding-top:100px;
}
</style>
<div class="container" ng-init="queryProType();">
		<div class="row" style="background-color: #cc0001;">
			<div style="margin-top:10.5px;color:#fff">
			
					<small><span class="glyphicon glyphicon-chevron-left pull-left" onclick="window.location.href='Index.jsp#/'" style="margin-top:10px;margin-left: 15px;"></span></small>
			</div>
			<div class="col-xs-9" style="padding-top: 2.5px">
				<div style="z-index:1;">
					<a href="/WebSite/Mobile/Index.jsp#/searchs/{{type}}"><input type="text" style="text-indent:50px;margin-left: 15px;" id="custNamePre" name="custNamePre" class="form-control" placeholder="请输入关键词检索" ng-click="gotoSearchFun();"></a>
				</div>
				<div style="z-index:11;">
					<li style="list-style-type:none;position:absolute; margin-left:23px;margin-top:-28px;z-index:100;width:50px;height:32px;"  ng-show="typeVar==0" ng-click="toggleType(0)">
						<small>
							<span>{{typeName}}<span class="glyphicon glyphicon-chevron-down"></span></span>
						</small>
					</li>
					<li style="list-style-type:none;position:absolute; margin-left:23px;margin-top:-28px;z-index:100;width:50px;height:32px;" ng-show="typeVar==1" ng-click="toggleType(1)">
						<small >
							<span>{{typeName}} <span class="glyphicon glyphicon-chevron-up"></span></span>
						</small>
					</li>
					<div class="container" ng-show="typeVar==1">
						<ul  class="dropdown-menu_ " role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs" style="position:absolute;display: block; margin-left:30px;margin-top:-1px;width:70px;height:120px;"><!--  -->
				           <li class="lable-lablecss" role="menuitem" tabindex="-1">            
				         	  <a ng-click="changeType(1)">出租</a>
				         	  <a ng-click="changeType(2)">出售</a>
				         	  <a ng-click="changeType(3)">求租</a>
				         	  <a ng-click="changeType(4)">求购</a>
				           </li>
					    </ul>  
					</div>
		 	</div>
			</div>
			<div ng-show="type==1" class="col-xs-1" style="margin-top: 5px;">
				<a href="/WebSite/Mobile/Index.jsp#/viewRentList/1"><input type="button" class="btn btn-default btn-sm" style="border:1px;background-color: #017cfe;color:#fff" value="搜索"></a> 
			</div>
			<div ng-show="type==2" class="col-xs-1" style="margin-top: 5px;">
				<a href="/WebSite/Mobile/Index.jsp#/ViewSaleList/2"><input type="button" class="btn btn-default btn-sm" style="border:1px;background-color: #017cfe;color:#fff" value="搜索"></a> 
			</div>
			<div ng-show="type==3" class="col-xs-1" style="margin-top: 5px;">
				<a href="/WebSite/Mobile/Index.jsp#/ViewDemandRentList/3"><input type="button" class="btn btn-default btn-sm" style="border:1px;background-color: #017cfe;color:#fff" value="搜索"></a> 
			</div>
			<div ng-show="type==4" class="col-xs-1" style="margin-top: 5px;">
				<a href="/WebSite/Mobile/Index.jsp#/ViewDemandSaleList/4"><input type="button" class="btn btn-default btn-sm" style="border:1px;background-color: #017cfe;color:#fff" value="搜索"></a> 
			</div>
		</div>
		
		
		
		<div class="row" style="background-color:#fff;">
			<div class="col-xs-4 text-center" style=" margin-top:5px; padding-left: 0px; padding-right: 0px;background-color:#fff;">
				<div id="ulTabId" style="padding-bottom:10px;background:#eae9e9;font-size:13px;display:inline;">
				    <dl>
				    	<div ng-repeat="t in proTypeList" >
				    		<dd ng-show="t.equCategory.equipmentCategoryName.length >5 &&t.equCategory.equipmentCategoryName.length !=6" style="padding:5px;margin-top:-5px;">
				    			<a class="btn" ng-click="showProType($index);"  style="display: block;height: 53px;line-height: 50px;background-color:#eae9e9;border-radius: 3px;color: #000;text-decoration: none;">{{t.equCategory.equipmentCategoryName|limitTo:5}}...</a>
				    		</dd>
				    		 <dd ng-show="t.equCategory.equipmentCategoryName.length &lt;7" style="padding:5px;margin-top:-5px;">
				    			<a class="btn" ng-click="showProType($index);"  style="display: block;height: 53px;line-height: 50px;background-color:#eae9e9;border-radius: 3px;color: #000;text-decoration: none;">{{t.equCategory.equipmentCategoryName|limitTo:5}}</a>
				    		</dd>
						</div>
					</dl>
				</div>
			</div>
			<div class="col-xs-8" style="background-color: #FFF;">
				<div class="row" style="margin-top: 5px;margin-left: -10px;">
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
				</div>
				<div class="row" style="margin-top: 10px;margin-left: -10px;">
					<h4><small>热门分类</small></h4>
				</div>
				<div class="row" style="margin-top: 10px;margin-left: -10px;">
				<!-- 	<div ng-repeat="v in equipmentName" >
						<div class="col-xs-4 " style="border:1px solid #ddd;">
							<a href="/WebSite/Mobile/Index.jsp#/viewRentList/1">
								<h5 ng-show="v.equipmentName.length >1 &&v.equipmentName.length !=2 &&v.equipmentName.length !=3">{{v.equipmentName|limitTo:3}}...</h5>
								<h5 ng-show="v.equipmentName.length &lt;4">{{v.equipmentName|limitTo:4}}</h5>
							</a>
					    </div>
					</div> -->
					<div ng-repeat="v in proTypeList[subscript].equNameInfos" >
						<div class="col-xs-4 " style="border:1px solid #ddd;">
							<a href="/WebSite/Mobile/Index.jsp#/viewRentList/1">
								<h5 ng-show="v.equipmentName.length >1 &&v.equipmentName.length !=2 &&v.equipmentName.length !=3">{{v.equipmentName|limitTo:3}}...</h5>
								<h5 ng-show="v.equipmentName.length &lt;4">{{v.equipmentName|limitTo:4}}</h5>
							</a>
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
               				<li><a href="/WebSite/Mobile/Index.jsp#/Infopub">求租</a></li>
               				<li><a href="/WebSite/Mobile/Index.jsp#/Infopub">求购</a></li>
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