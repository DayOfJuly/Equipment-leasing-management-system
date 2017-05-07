<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>设备租赁首页</title>
<jsp:include page="../Include/Head.jsp" />

<script type="text/javascript">
var app = angular.module('indexApp',['ngResource']);
app.controller('indexController',function($scope){
	
	$scope.selectTop = function(param){
		var tabs=document.getElementById("ulTopId").getElementsByTagName('a');
		for(var i=0;i<tabs.length;i++){
			var tab = tabs[i];
			if(i==param){
				tab.style.backgroundColor='#EA544A';
				tab.style.color='#fff';
			}else{
				tab.style.backgroundColor='';
				tab.style.color='#000';
			}
		}
	};
	
});
</script>

</head>

<body style="background-color: #fff;" ng-app="indexApp" ng-controller="indexController">
	<div class="container">
		<div class="col-xs-12 form-inline" style="margin-left:100px;">
			<div class="col-xs-6">
				<ul class="nav nav-tabs" style="border:0px;">
				   <li class="active"><a href="#chuzu" data-toggle="tab">出租</a></li>
				   <li><a href="#qiuzu" data-toggle="tab">求租</a></li>
				   <li><a href="#chushou" data-toggle="tab">出售</a></li>
				   <li><a href="#qiugou" data-toggle="tab">求购</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<div class="tab-pane fade in active" id="chuzu">
						<div class="col-sm-12 form-inline">
							<a href="#">
					          <span class="glyphicon glyphicon-search" style="margin-left:-3px;"></span>
					        </a>
				            <input type="text" class="form-control" style="margin-left:-30px;padding: 0px 30px">
							<input type="button" value="查询" class="btn btn-primary"> 
						</div>
					</div>
					<div class="tab-pane fade" id="qiuzu">
						<div class="col-sm-12 form-inline">
							<a href="#">
					          <span class="glyphicon glyphicon-search" style="margin-left:0px;"></span>
					        </a>
				            <input type="text" class="form-control" style="margin-left:-30px;padding: 0px 30px">
							<input type="button" value="查询" class="btn btn-primary"> 
						</div>
					</div>
					<div class="tab-pane fade" id="chushou">
						<div class="col-sm-12 form-inline">
							<a href="#">
					          <span class="glyphicon glyphicon-search" style="margin-left:0px;"></span>
					        </a>
				            <input type="text" class="form-control" style="margin-left:-30px;padding: 0px 30px">
							<input type="button" value="查询" class="btn btn-primary"> 
						</div>
					</div>
					<div class="tab-pane fade" id="qiugou">
						<div class="col-sm-12 form-inline">
							<a href="#">
					          <span class="glyphicon glyphicon-search" style="margin-left:0px;"></span>
					        </a>
				            <input type="text" class="form-control" style="margin-left:-30px;padding: 0px 30px">
							<input type="button" value="查询" class="btn btn-primary"> 
						</div>
					</div>
				</div>	
			</div>
			<div class="col-xs-6" style="margin-top:45px;margin-left:-50px;">
				<h4 style="float:left;"><strong>热门搜索词：</strong></h4>
				<h5 style="margin-top:12px;">
					<a href="">挖掘机&nbsp;&nbsp;&nbsp;&nbsp;</a>
					<a href="">吊塔&nbsp;&nbsp;&nbsp;&nbsp;</a>
					<a href="">发电机&nbsp;&nbsp;&nbsp;&nbsp;</a>
					<a href="">推土机&nbsp;&nbsp;&nbsp;&nbsp;</a>
					<a href="">搅拌机&nbsp;&nbsp;&nbsp;&nbsp;</a>
				</h5>
			</div>
		</div>
		<div class="col-xs-12" style="margin-top:10px; margin-bottom:10px;margin-left:150px;">
			<ul id="ulTopId" class="nav nav-pills" style="font-size:18px;">
				<li><a href="" ng-click="selectTop(0);" style="background:#EA544A; padding-left:20px; padding-right:20px; padding-top:5px; padding-bottom:5px; color:#fff;">首页</a></li>
				<li><a href="" ng-click="selectTop(1);" style="padding-left:20px; padding-right:20px; padding-top:5px; padding-bottom:5px; color:#000;">出租信息</a></li>
				<li><a href="" ng-click="selectTop(2);" style="padding-left:20px; padding-right:20px; padding-top:5px; padding-bottom:5px; color:#000;">求租信息</a></li>
				<li><a href="" ng-click="selectTop(3);" style="padding-left:20px; padding-right:20px; padding-top:5px; padding-bottom:5px; color:#000;">出售信息</a></li>
				<li><a href="" ng-click="selectTop(4);" style="padding-left:20px; padding-right:20px; padding-top:5px; padding-bottom:5px; color:#000;">求购信息</a></li>
				<li><a href="" ng-click="selectTop(5);" style="padding-left:20px; padding-right:20px; padding-top:5px; padding-bottom:5px; color:#000;">行业动态</a></li>
				<li><a href="" ng-click="selectTop(6);" style="padding-left:20px; padding-right:20px; padding-top:5px; padding-bottom:5px; color:#000;">政策法规</a></li>
			</ul>
		</div>
		
	</div>
	<div id="myCarousel" class="carousel slide">
	   <!-- 轮播（Carousel）指标 -->
	   <ol class="carousel-indicators">
	      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	      <li data-target="#myCarousel" data-slide-to="1"></li>
	      <li data-target="#myCarousel" data-slide-to="2"></li>
	   </ol>   
	   <!-- 轮播（Carousel）项目 -->
	   <div class="carousel-inner">
	      <div class="item active">
	         <img src="../../media/images/lbPic1.jpg" alt="First slide">
	         <div class="carousel-caption">标题 1</div>
	      </div>
	      <div class="item">
	         <img src="../../media/images/lbPic2.jpg" alt="Second slide">
	         <div class="carousel-caption">标题 2</div>
	      </div>
	      <div class="item">
	         <img src="../../media/images/lbPic1.jpg" alt="Third slide">
	         <div class="carousel-caption">标题 3</div>
	      </div>
	   </div>
	   <!-- 轮播（Carousel）导航 -->
	   <a class="carousel-control left" href="#myCarousel" 
	      data-slide="prev">&lsaquo;</a>
	   <a class="carousel-control right" href="#myCarousel" 
	      data-slide="next">&rsaquo;</a>
	</div> 
	
	<div class="container" style="margin-top:10px;">
		<div class="col-xs-9">
			<ul class="nav nav-tabs" style="margin-left:15px;">
			   <li class="active"><a href="#newchuzu" data-toggle="tab">最新出租</a></li>
			   <li><a href="#newqiuzu" data-toggle="tab">最新求租</a></li>
			   <li><a href="#newchushou" data-toggle="tab">最新出售</a></li>
			   <li><a href="#newqiugou" data-toggle="tab">最新求购</a></li>
			</ul>
			<div id="myTabContent" class="tab-content">
				<div class="tab-pane fade in active" id="newchuzu">
					<div class="row" style="margin-top:10px;">
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					</div>
					<div class="row" style="margin-top:10px;">
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/wjj.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					            <a href="#" class="btn btn-default" role="button">租用</a>
					         </div>
					      </div>
					   </div>
					</div>
				</div>
				<div class="tab-pane fade" id="newqiuzu">
					<div class="row" style="margin-top:10px;">
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					</div>
					<div class="row" style="margin-top:10px;">
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					   <div class="col-sm-2" style="margin-left:15px;">
					      <div class="thumbnail" style="width:150px;">
					         <img src="../../media/images/tank.png">
					      </div>
					      <div class="caption">
					         <p>学挖掘机,找蓝翔</p>
					         <div class="text-right" style="width:150px;">
					            <a href="#" class="btn btn-primary" role="button">查看</a> 
					         </div>
					      </div>
					   </div>
					</div>
				</div>
				<div class="tab-pane fade" id="newchushou">
				</div>
				<div class="tab-pane fade" id="newqiugou">
				</div>
			</div>	
		</div>
		
		<div class="col-xs-3">
			<div class="panel panel-primary">
			   <div class="panel-heading">
			      <h3 class="panel-title">资源统计</h3>
			   </div>
			   <div class="panel-body">
					<p>内部资源有500台设备</p>
					<p>原值：3 亿元</p><br>
					<p>外部资源有400台  </p>
					<p>原值：2 亿元</p><br>
					<p>内部供应商共计500家</p><br>
					<p>外部供应商共计1000家</p><br>
					<p>可出租设备100台</p><br>
					<p>可出售设备50台</p><br>
				</div>
			</div>
		</div>
	</div>
	
	<div style="background-color:#323232;">
		<div class="container">
			<div class="row" style="padding-top:30px; padding-bottom:30px;">
				<div class="col-xs-8">
					<h5 style="color:#C0C0C0;">
						<a href="###" style="text-decoration:none; margin-right:15px; color:#C0C0C0;">鲁班设备租赁</a>|
						<a href="###" style="text-decoration:none; margin-left:13px; margin-right:15px; color:#C0C0C0;">关于设备</a>|
						<a href="###" style="text-decoration:none; margin-left:13px; margin-right:15px; color:#C0C0C0;">关于租赁</a>|
						<a href="###" style="text-decoration:none; margin-left:13px; margin-right:15px; color:#C0C0C0;">联系我们</a>|
						<a href="###" style="text-decoration:none; margin-left:13px; color:#C0C0C0;">免责声明</a>
					</h5>
					<h5 style="color: #C0C0C0;">
						Copyright © 2010-202015 中铁 版权所有<span style="margin-left:15px; margin-right:15px;">|</span>投资有风险，购买需谨慎
					</h5>
				</div>
				<div class="col-xs-4">
					<h5 style="color: #C0C0C0;">联系我们（9:00-22:00）<span style="margin-left:13px; margin-right:15px;">|</span>
						<span class="glyphicon glyphicon-earphone"></span>
						&nbsp;在线客服</h5>
					<h5 style="color: #C0C0C0;">
						400-XXX-XXXX<small style="color: #C0C0C0;">（个人业务）</small>
					</h5>
					<h5 style="color: #C0C0C0;">400-XXX-XXXX<small style="color: #C0C0C0;">（企业业务）</small></h5>
				</div>
			</div>
		</div>
	</div>	
	
</body>


</html>
