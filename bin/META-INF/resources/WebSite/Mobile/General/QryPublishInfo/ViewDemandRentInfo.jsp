<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar navbar-default navbar-fixed-top" style="border-bottom:1px solid #ddd; background-color:#cc0001;color:#fff">
	<div class="navbar-inner" >
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4>
						<a href="" ng-click="back();">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff" ></span></small>
						</a>
						求租详情
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container" style="margin-top:50px;">
	<div class="row "  >
		<div class="col-md-12 column">
			<h3 class="text-left">
				【求租】{{viewList.infoTitle}}
			</h3>
			<ul class="list-unstyled">
				<li>
					单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:<b>{{viewList.price}}</b>元/月（数量:100个）
				</li>
				<li>
				设备使用地点:{{viewList.atCity}}
				</li>
				<li>
					详细地址:{{viewList.address}}
				</li>
				<li>
					意向承租人:{{dealCount}}<span ng-if="dealCount==''" class="col_chen txt14">0</span>人
				</li>
				<li style="color:#CFCFCF;font-size:12px">
					<span >最后更新:{{viewList.updateTime}}</span><span style="float:right">浏览次数：{{viewList.viewCount}}</span>
				</li>
			</ul>
			<hr style="height:5px;border:none;border-top:2px double #017cfe"/>
			<h3>
				单位基本资料
			</h3>
			<ul class="list-unstyled">
				<li>
					联系单位:请<a href="/WebSite/Mobile/General/Login/Login.jsp"><span style="color:red">登录</span></a>查看
				</li>
				<li>
					所在城市:请<a href="/WebSite/Mobile/General/Login/Login.jsp"><span style="color:red">登录</span></a>查看
				</li>
				<li>
					详细地址:请<a href="/WebSite/Mobile/General/Login/Login.jsp"><span style="color:red">登录</span></a>查看
				</li>
				<li>
					联&nbsp;系&nbsp;&nbsp;人:请<a href="/WebSite/Mobile/General/Login/Login.jsp"><span style="color:red">登录</span></a>查看
				</li>
				<li>
					联系电话:请<a href="/WebSite/Mobile/General/Login/Login.jsp"><span style="color:red">登录</span></a>查看
				</li>
				<li>
					Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:请<a href="/WebSite/Mobile/General/Login/Login.jsp"><span style="color:red">登录</span></a>查看
				</li>
			</ul>
			<hr style="height:5px;border:none;border-top:2px double #017cfe"/>
			<h3>
				设备信息
			</h3>
			<ol class="list-unstyled">
				<li>
					设备名称:{{viewList.equName}}
				</li>
				<li>
					品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌:{{viewList.brandName}}
				</li>
				<li>
					型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:{{viewList.modelName}}
				</li>
				<li>
					规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:{{viewList.standardName}}
				</li>
			</ol>
			<hr style="height:5px;border:none;border-top:2px double #017cfe"/>
			<h3>
				详细说明
			</h3>
			<p class="text-left">
				 <span id="rePayMsg" style="text-indent:2em"></span>
				 <div ng-show="viewList.detailedDescription==null"><span>该信息无详细描述</span></div>
			</p>
			<hr style="height:5px;border:none;border-top:2px double #017cfe"/>
		</div>
	</div>
</div>
