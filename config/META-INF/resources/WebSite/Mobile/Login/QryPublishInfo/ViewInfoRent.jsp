<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar navbar-default navbar-fixed-top" style="border-bottom:1px solid #ddd;background-color:#cc0001;color:#fff">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4>
						<a href="" ng-click="back();">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff"></span></small>
						</a>
						出租详情
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container"  style="margin-top:70px;margin-bottom:70px">
	<div class="row "  >
		<div class="col-md-12 column">
			<div class="carousel slide" id="carousel-733748"  >
				<ol class="carousel-indicators">
					<li data-slide-to="0" data-target="/#carousel-733748">
					</li>
					<li data-slide-to="1" data-target="/#carousel-733748" class="active">
					</li>
					<li data-slide-to="2" data-target="/#carousel-733748">
					</li>
				</ol> 
				<div class="carousel-inner">
					<div class="item active">
						 <img alt="" src="/WebSite/Mobile/media/image/01.jpg" />
						<div class="carousel-caption">
						</div>
					</div>
					<div class="item">
						<img alt="" src="/WebSite/Mobile/media/image/02.png" /> 
						<div class="carousel-caption">
						</div>
					</div>
					<div class="item">
						 <img alt="" src="/WebSite/Mobile/media/image/03.png" /> 
						<div class="carousel-caption">
						</div>
					</div>
				</div> 
			<a class="left carousel-control" href="/#carousel-733748" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
			 <a class="right carousel-control" href="/#carousel-733748" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
			</div>
			<h3 class="text-left">
				【出租】{{viewList.infoTitle}}
			</h3>
			<ul class="list-unstyled">
				<li>
					   <span ng-show="viewList.priceType==1">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:<b style="">{{viewList.price}}</b>元/月</span>
                       <span  ng-show="viewList.priceType==2">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:<b style="font-size:16px">{{viewList.price}}</b>元/天</span>
                       <span  ng-show="viewList.priceType==3">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:<b style="font-size:16px">{{viewList.price}}</b>元/小时</span>
                       <span  ng-show="viewList.priceType==null">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价:</span>
                       <span class="col_chen txt14"> 最短租期:{{viewList.shortestLease}}天</span> 
				</li>
				<li>
				设备归属:{{viewList.enterpriseName}}
				</li>
				<li>
					设备状态:{{ct.codeTranslate(equState,"VIEWINFO_EQU_STATE")}}
				</li>
				<li>
					意向承租人:{{dealCount}}<span ng-if="dealCount==''" class="col_chen txt14">0</span>人
				</li>
				<li>
					<span>最终承租人:{{depName  | limitTo:10}}</span>
				</li>
				<li style="color:#CFCFCF;font-size:12px">
					<span >最后更新:{{viewList.updateTime}}</span><span style="float:right">浏览次数:{{viewList.viewCount}}</span>
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
					设备编号:{{viewList.equipmentTable.equNo}}
				</li>
				<li>
					设备名称:{{viewList.equName}}
				</li>
				<li>
					品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌:{{viewList.brandName}}
				</li>
				<li>
					型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:{{viewList.equipmentTable.models}}
				</li>
				<li>
					规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:{{viewList.equipmentTable.specifications}}
				</li>
				<li>
					功率(kw):{{viewList.power}}
				</li>
				<li>
					技术状况:{{viewList.technicalStatus}}
				</li>
				<li>
					生产厂家:{{viewList.equipmentTable.manufacturer}}
				</li>
				<li>
					出厂日期:{{viewList.releaseDate | limitTo:10}}
				</li>
			</ol>
			<hr style="height:5px;border:none;border-top:2px double #017cfe"/>
			<h3>
				详细说明
			</h3>
			<div class="text-left">
				 <span id="rePayMsg" style="text-indent:2em"></span>
				 <div ng-show="viewList.detailedDescription==null"><span>该信息无详细描述</span></div>
			</div>
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