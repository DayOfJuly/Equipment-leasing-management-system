<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar navbar-default navbar-fixed-top" style="border-bottom:1px solid #ddd;background-color:#cc0001;color:#fff">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4>
						<a href="" ng-click="back();">
							<small><span class="glyphicon glyphicon-chevron-left pull-left"  style="color:#fff" ></span></small>
						</a>
						求租详情
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container"  style="margin-top:70px;margin-bottom:70px">
	<div class="row "  >
		<div class="col-md-12 column">
			<h3 class="text-left">
				【求租】{{viewList.infoTitle}}
			</h3>
			<ul class="list-unstyled">
				<li>
					单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:<b>{{viewList.price}}</b>元/月（数量:<span>{{viewList.quantity}}</span>个）
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
					联系单位:{{viewList.enterpriseName}}
				</li>
				<li>
					所在城市:{{AtCity}}
				</li>
				<li>
					详细地址:{{viewList.contactAddress}}
				</li>
				<li>
					联&nbsp;系&nbsp;&nbsp;人:{{viewList.contactPerson}}
				</li>
				<li>
					联系电话:{{viewList.contactPhone}}
				</li>
				<li>
					Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:{{viewList.qqNo}}
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
 <div class="navbar navbar-default navbar-fixed-bottom" ng-show="reveal==2">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">	
				 <input ng-show="addButton==''"  type="button" class="inpt_booom" style="width:100%;height:100%"  ng-click="addClick(viewList);"  value="我想交易">
	                    <input ng-show="addButton==true" type="button" disabled="disabled" style="width:100%;height:100%" class="inpt_booom inpt_booom1" value="我想交易" />					
				</div>
			</div>
		</div>
	</div>
</div>
<style>
input.inpt_bottom:hover,input.inpt_bot_ds:hover,input.inpt_booom:hover{  filter:alpha(opacity=80);

  -moz-opacity:0.8;

  -khtml-opacity: 0.8;

  opacity: 0.8;}
input.inpt_booom{ 
line-height:40px; 
color:#fff; 
font-size:14px;
border:none;
cursor: pointer;
background-color:#0057b4;
border-radius: 5px;    /*IE9 Firefox4 浏览器圆角边框*/ 
-webkit-border-radius: 5px; /*苹果谷歌浏览器 圆角边框*/    
-moz-border-radius: 5px;    /*火狐浏览器 圆角边框*/  
behavior: url(js/PIE.htc);
position:relative;
}  
input.inpt_booom1{
	background-color: #CCCCCC;
	color:#666;
}
input.inpt_booom1:hover{  filter:alpha(opacity=100);

  -moz-opacity:1;

  -khtml-opacity: 1;

  opacity: 1;}
input.inpt_booom1{
	background-color: #CCCCCC;
	color:#666;
}
</style>