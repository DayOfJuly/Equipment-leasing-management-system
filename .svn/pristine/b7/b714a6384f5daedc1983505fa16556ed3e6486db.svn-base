<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<body ng-controller="percenterController">
<div class="navbar navbar-default navbar-fixed-top" style=" background-color: #CC0001; padding:5px; ">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4 style="font-size:18px">
						<a ng-show="!v" href="/WebSite/Mobile/General/Login/Login.jsp">
							<small><span class=" pull-right" style="color:#fff;">登录</span></small>
						</a>
						<a ng-show="v" href="">
							<small><span class=" pull-right" style="color:#fff;" ng-click="logoutFun();">退出登录</span></small>
						</a>
					</h4>
				</div>
				<div class="text-center col-xs-12">						
					<h4 style="font-size:18px;width:80px;text-align:center;margin-left:auto;margin-right:auto;margin-top:-16px;color:white;">
						个人中心
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container"  style="margin-top:70px;margin-bottom:70px">
	<div class="row "  >
		
		<div class="col-xs-12">
			<div class="form-group">
				<div class="col-xs-6" style="text-align:center">
					<img height="80px;" width="100px;" src="media/image/login-logo.png"  >
				</div>
				<div class="col-xs-6">
					<span style="float:left;padding-top:40px" >用户名:{{userInfo.loginId}}</span>
				</div>
			</div>
			
		</div>
		
		<div class="col-md-12 column" style="margin-top:20px;">
			<ul class="list-unstyled">
				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
				<a href="/WebSite/Mobile/Index.jsp#/alreadyPublishedInfor" style=" color:black">
					<li >
					已发布的信息
					<small><span class="glyphicon glyphicon-chevron-right pull-right" ></span></small>
					</li>
				</a>
				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
				<a href="/WebSite/Mobile/Index.jsp#/publishFrontList" style=" color:black">
					<li>
					想交易的信息
					<small><span class="glyphicon glyphicon-chevron-right pull-right" ></span></small>
					</li>
				</a>	
				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
				<a href="/WebSite/Mobile/Index.jsp#/aboutSystem" style=" color:black">
					<li>
					关于
					<small><span class="glyphicon glyphicon-chevron-right pull-right" ></span></small>
					</li>
				</a>
				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
			</ul>
			
		</div>
	</div>
</div>
	<div class="row">
	<!-- bottom begin -->
		<div class="text-center">
			<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
				<div class="navbar-header col-xs-12">
					<div class="navbar-brand col-xs-3" style="padding:5px;" onclick="window.location.href='Index.jsp#/'">
						<img class="img-circle" src="media/image/Ico_Index.png" alt="首页" style="width:20px; height:20px; margin:0 auto;">
						<h5>首页</h5>
					</div>
					<div class="navbar-brand col-xs-3" style="padding:5px;" onclick="window.location.href='Index.jsp#classify/'">
						<img class="img-circle" src="media/image/Ico_Invest.png" alt="分类" style="width:20px; height:20px; margin:0 auto;">
						<h5>分类</h5>
					</div>
					<div class="dropdown col-xs-3" style="padding:5px;">
						<div class="dropdown-toggle" data-toggle="dropdown">
							<img class="img-circle" src="media/image/Ico_Publish.png" alt="发布" style="width:20px; height:20px; margin:0 auto;">
               				<h5>发布 <b class="caret"></b></h5>
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
						<h5 style="color:red">个人中心</h5>
					</div>
				</div>
			</nav>
		</div>
	<!-- bottom end -->
	</div>
</body>	
</html>