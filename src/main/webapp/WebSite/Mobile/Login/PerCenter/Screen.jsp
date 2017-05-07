<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

</style>
<body ng-controller="perScreenController">
<div class="navbar navbar-default navbar-fixed-top" style=" background-color: #CC0001;padding:5px;">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4 style="font-size:18px">
						<a ng-show="redirect==1" href="/WebSite/Mobile/Index.jsp#/alreadyPublishedInfor">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff;"></span></small>
						</a>
						<a ng-show="redirect==2" href="/WebSite/Mobile/Index.jsp#/publishFrontList">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff;"></span></small>
						</a>
						<span style="color:#fff;">筛选</span>
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container"  style="margin-top:70px;margin-bottom:70px" id="pageone">
	<div class="row "  >
		
		<div class="col-md-12 column">
			<ul class="list-unstyled">
				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
				<li ng-show="typeVar==0" ng-click="toggleType(0)">信息类型
					<small class="pull-right">
						<span>{{typeName}}<span class="glyphicon glyphicon-chevron-down"></span></span>
					</small>
				</li>
				<li ng-show="typeVar==1" ng-click="toggleType(1)">信息类型
					<small class="pull-right">
						<span>{{typeName}} <span class="glyphicon glyphicon-chevron-up"></span></span>
					</small>
				</li>
					<div class="container" ng-show="typeVar==1">
						<ul class="media-list">
							<li style="padding:5px"><a href="" ng-click="changeType(1)"><div>出租</div></a></li>
							<li style="padding:5px"><a href="" ng-click="changeType(2)"><div>出售</div></a></li>
							<li style="padding:5px"><a href="" ng-click="changeType(3)"><div>求租</div></a></li>
							<li style="padding:5px"><a href="" ng-click="changeType(4)"><div>求购</div></a></li>
						</ul>
					</div>
				
				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
				<li ng-show="stateVar==0" ng-click="toggleState(0)">设备状态
					<small class="pull-right">
						<span>{{stateName}}<span class="glyphicon glyphicon-chevron-down"></span></span>
					</small>
				</li>
				<li ng-show="stateVar==1" ng-click="toggleState(1)">设备状态
					<small class="pull-right">
						<span>{{stateName}} <span class="glyphicon glyphicon-chevron-up"></span></span>
					</small>
				</li>
					<div class="container" ng-show="stateVar==1">
						<ul class="media-list">
							<li style="padding:5px"><a href="" ng-click="changeState(1)"><div>待审核</div></a></li>
							<li style="padding:5px"><a href="" ng-click="changeState(2)"><div>审核通过</div></a></li>
							<li style="padding:5px"><a href="" ng-click="changeState(3)"><div>审核不通过</div></a></li>
						</ul>
					</div>
				
				<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
				<li>发布日期</li>
				<li>
					 <div class="col-sm-12">
						<div class="form-group ">
							<div class="col-xs-6">
								<input type="date" class="form-control" ng-init="getBeforeDate();"  name="startReleaseDate" id="startReleaseDate" ng-model="screen.startReleaseDate" placeholder="开始日期" >
							</div>
							<div class="col-xs-6">
								<input type="date" class="form-control" ng-init="getNowDateStr();"   name="endReleaseDate" id="endReleaseDate" ng-model="screen.endReleaseDate" placeholder="结束日期" >
							</div>	
						</div>
					</div> 
					<!-- <div class="col-sm-12">
						<div class="form-group ">
							<div data-role="fieldcontain">
     							    <label for="txtBirthday">出生日期：</label>
        							 <input type="date" data-role="datebox" ng-click="haha();"  id="txtBirthday" name="birthday" />
 								</div>
						</div>
					</div> -->
				</li>
			</ul>
		</div>
	</div>
	<nav class="navbar navbar-default navbar-fixed-bottom">
		<div class="navbar-inner">
			<div class="container">
				<div class="row">
					<div class="text-center col-xs-12">		
						<a href="" class="navbar-brand col-xs-6" ng-click="clear();"><button class="btn btn-lg btn-block"style="background: #0057b4;color: white;margin-top: -13px">清空</button></a>					
	        			<a ng-show="redirect==1" href="/WebSite/Mobile/Index.jsp#/alreadyPublishedInfor/{{screen}}" class="navbar-brand col-xs-6" 	><button class="btn btn-lg btn-block"style="background: #0057b4;color: white;margin-top: -13px">确定</button></a>
	        			<a ng-show="redirect==2" href="/WebSite/Mobile/Index.jsp#/publishFrontList/{{screen}}" class="navbar-brand col-xs-6" ><button class="btn btn-lg btn-block"style="background: #0057b4;color: white;margin-top: -13px">确定</button></a>				
					</div>
				</div>
			</div>
		</div>
	</nav>
	
</div>
<!-- <div class="navbar navbar-default navbar-fixed-bottom"> -->
	
<!-- </div> -->
</body>
</html>