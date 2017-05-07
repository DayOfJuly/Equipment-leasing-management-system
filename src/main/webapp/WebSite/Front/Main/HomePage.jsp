<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.Math"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>设备租赁首页</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../media/css/home.css"> -->
<style type="text/css">

</style>
<jsp:include page="../Include/Head.jsp" />
<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
<script src="../../../media/js/lrtk.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../../../media/js/ss.js"></script><!--左右GUNDONG-->

<script type="text/javascript" src="../../../js/JsLib/chinesepyi.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
<link href="../../../css/heightLight.css" rel="stylesheet">
<script type="text/javascript">

var app = angular.module('indexApp_',['ngResource','unifyModule','Config']);/* $location, */
app.controller('indexController_',function($scope,category,searchUrl,rentSvc,SaleSvc,DemandRentSvc,DemandSaleSvc,published,PicUrl){
	
	//页面初始化
	$(function(){
		function qSucc(rec){
			//定义一个类别
			$scope.infoType="newchuzu";
			$scope.czresultList=rec.content;
			$scope.getFirstPic($scope.czresultList);//拿到图片信息如果没有图片就启用备份图片
			$scope.titleList=[];
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>5){
					$scope.czresultList[i].infoTitleTemp = $scope.titleList[i].substring(0,4)+"...";
				}else{
					$scope.czresultList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
		}
		function qErr(rec){}
		//初始化最新出租信息
		published.unifydoHM({Action:"Rent"},{pageNo:0,pageSize:10,dataType:1},qSucc,qErr);
		//$scope.queryUpdHotWordCount();
	});

	
	var SYS_USER_INFO={};
	SYS_USER_INFO.orgId="${sessionScope.userInfo.orgId}";
	SYS_USER_INFO.orgCode="${sessionScope.userInfo.orgCode}";
	SYS_USER_INFO.orgName="${sessionScope.userInfo.orgName}";
	SYS_USER_INFO.orgParentCode="${sessionScope.userInfo.orgParentCode}";
	SYS_USER_INFO.orgLevel="${sessionScope.userInfo.orgLevel}";
	SYS_USER_INFO.perPartyId="${sessionScope.userInfo.perPartyId}";
	$scope.SYS_USER_INFO = {};
	
	if(SYS_USER_INFO.perPartyId){
		$scope.SYS_USER_INFO.perPartyId = SYS_USER_INFO.perPartyId;
	}
	
	
	/*
	*复用的替换关键字方法
	*/
	$scope.searBean={};
	$scope.changeListTitleFun = function(resultList,fontColorObj)/* 传入数值的集合，改变颜色后的数值 */
	{
		for(var i=0;i<resultList.length;i++)/* 遍历数值集合，把每个值和输入的值匹配 */
		{
			if($scope.searBean.infoTitleBean)/* 如果有输入的值 */
			{
				var ib=$scope.searBean.infoTitleBean;/* 把输入的值放入一个变量 */
				var reg=new RegExp(ib,"g");/* 用js中的正则方法去格式化输入的值，因为直接在replace中用replace独有的格式化方式是无法实现格式变量的，浏览器不识别 */   
				resultList[i].infoTitleTemp=resultList[i].infoTitleTemp.replace(reg,fontColorObj);/* 将格式好的输入值和改变后需要展现的值用replace替换，达到如果这个集合有输入框输入的值，就把输入值替换成改变后有颜色的值，然后在赋值给原值，因为会产生一个新对象(replace方法规则)*/	
			}
		} 
		return  resultList;/* 返回改变好的集合 */
	};
	
	//初始化数据
		//1、标签页(最新出租)触发
		//2、产品供应分类 触发查询
		//3、资源统计 触发查询 
		//4、最新加入企业
		//5、行业动态
		//标签页处理流程
		// 通过名称选取标签页
		//出租
	$('#myTab a[href="#newchuzu"]').click(function querInfo(){
		published.unifydoHM({Action:"Rent"},{pageNo:0,pageSize:10,dataType:1},qSucc,qErr);
		function qSucc(rec){
			//定义一个类别
			$scope.infoType="newchuzu";
			$scope.czresultList=rec.content;
			$scope.titleList=[];
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>5){
					$scope.czresultList[i].infoTitleTemp = $scope.titleList[i].substring(0,4)+"...";
				}else{
					$scope.czresultList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
			
			$scope.getFirstPic($scope.czresultList);
			}
		function qErr(rec){
			}
	});
	//求租
	$scope.newQiuzu = function(){
		published.unifydoHM({Action:"DemandRent"},{pageNo:0,pageSize:12,dataType:3},qSucc,qErr);
			function qSucc(rec){
				$scope.infoType="newqiuzu";
				$scope.qzresultList=rec.content;
				
				 $scope.titleList=[];
				for(var i=0;i<rec.content.length;i++){
					$scope.titleList.push(rec.content[i].infoTitle);
				}
				for(var i=0;i<$scope.titleList.length;i++){
					if($scope.titleList[i].length>30){
						$scope.qzresultList[i].infoTitleTemp = $scope.titleList[i].substring(0,50)+"...";
					}else{
						$scope.qzresultList[i].infoTitleTemp = rec.content[i].infoTitle;
					}
				} 
				 $scope.releaseDateList=[];
					for(var i=0;i<rec.content.length;i++){
						$scope.releaseDateList.push(rec.content[i].releaseDate);
					}
					for(var i=0;i<$scope.releaseDateList.length;i++){
						if($scope.releaseDateList[i].length>10){
							$scope.qzresultList[i].releaseDate = $scope.releaseDateList[i].substring(0,10);
						}
					} 
				$scope.getFirstPic($scope.qzresultList);
			}
			function qErr(){}
	};
	//出售
	$scope.newSale = function(){
		published.unifydoHM({Action:"Sale"},{pageNo:0,pageSize:10,dataType:2},qSucc,qErr);
		function qSucc(rec){
			$scope.infoType="newsale";
			$scope.sresultList=rec.content;
			
			$scope.titleList=[];
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>5){
					$scope.sresultList[i].infoTitleTemp = $scope.titleList[i].substring(0,4)+"...";
				}else{
					$scope.sresultList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
			
			$scope.getFirstPic($scope.sresultList);
		}
		function qErr(rec){
		}
	};
	
	//求购
	$scope.newBuy = function(){
		published.unifydoHM({Action:"DemandSale"},{pageNo:0,pageSize:12,dataType:4},qSucc,qErr);
		function qSucc(rec){
			$scope.infoType="newbuy";
			$scope.buyresultList=rec.content;
			
			$scope.titleList=[];//截取标题
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>30){
					$scope.buyresultList[i].infoTitleTemp = $scope.titleList[i].substring(0,50)+"...";
				}else{
					$scope.buyresultList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
			  $scope.releaseDateList=[];//截取发布日期
				for(var i=0;i<rec.content.length;i++){
					$scope.releaseDateList.push(rec.content[i].releaseDate);
				}
				for(var i=0;i<$scope.releaseDateList.length;i++){
					if($scope.releaseDateList[i].length>10){
						$scope.buyresultList[i].releaseDate = $scope.releaseDateList[i].substring(0,10);
					}
				} 
			
			$scope.getFirstPic($scope.buyresultList);
		}
		function qErr(rec){}
	};
	//$scope.PicUrl = "http://124.205.89.214:8080/Picture";
	$scope.PicUrlName = PicUrl;
	//处理获取的list得到图片
	$scope.getFirstPic=function(list){
		if(list)/* 防止图片没刷出来的时候报length错误，当有list值的时候在执行下面的代码 */
		{
			for(var i=0;i<list.length;i++){
				if(list[i].equipmentPic!=null && list[i].equipmentPic!=""){
					var pic=list[i].equipmentPic.split(',');
					var fullname = pic[0].split('.');
					var PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};
					list[i].PicName=fullname[0];
					list[i].PicType=fullname[1];
				}else{
					list[i].PicName="18c07505-700d-4667-83df-cdf1465188ce";
					list[i].PicType="png";
				}
			}
		}
	};
	
	//产品分类
	$scope.queryProType=function(){
		function qSucc(rec){
			$scope.proTypeList=rec;
			/* for(var i=0;i<$scope.proTypeList.length;i++){
				$scope.queryEquipment($scope.proTypeList[i].equCategoryId);
			} */
		}
		function qErr(){}
		published.getEquNames({Action:"HomePage"},qSucc,qErr);
	};
	
	//资源统计
	$scope.resourceCount1=function(){
		function qSucc(rec){
			$scope.resourceMsg = rec;
		}
		function qErr(){}
		published.getResources({Action:"ResourceCount"},{pageNo:0,pageSize:10},qSucc,qErr);
	};
	
	
	//产品名称
	$scope.queryEquipmentList={};
	$scope.queryEquipment=function(parm){
		function qSucc(rec){
			//$scope.queryEquipmentList=rec;
			
			if(rec[0].equCategory.equCategoryId == parm){
				$scope.queryEquipmentList=rec;
			}
		}
		function qErr(){}
		published.getEquNames({Action:"ByCategoryId",equCategoryId:parm},qSucc,qErr);
	};
	
	//资源统计
	$scope.resourceCount=function(){
		category.unifydo({Action:"All"},qSucc,qErr);
		function qSucc(rec){
			//模拟数据
// 			$scope.resourceList=["内部资源有500台设备原值：3 亿元","","","",];
			//$scope.resourceList=rec.content;
		}
		function qErr(rec){
			
		}
	};
	//最新企业
	$scope.queryEntInfo=function(){
// 		category.unifydo({Action:"All"},qSucc,qErr);
// 		function qSucc(rec){
// 			$scope.categoryList=rec.content;
// 		}
// 		function qErr(rec){
			
// 		}
		function qSucc(rec){
			$scope.newEntList=rec.content;
		}
		function qErr(){}
		published.unifydoHM({Action:"GetProviders"},{pageNo:0,pageSize:10},qSucc,qErr);
	};
	
	//行业动态
	$scope.industryActive=function(){
		category.unifydo({Action:"All"},qSucc,qErr);
		function qSucc(rec){
			$scope.categoryList=rec.content;
		}
		function qErr(rec){
			
		}
	};
	//鼠标移入显示功能
	/*  $(function () { $("[data-toggle='tooltip']").tooltip(); });
	$('li.dropdown').mouseover(function(){$(this).addClass('open');}).mouseout(function() {$(this).removeClass('open');}); 
	
	$('#myCarousel').carousel({
		  interval: 5000
	}); */
	
	
	
	
	/* $scope.searchHref=function(){
		 if($location.hash("searchId")){
			 $location.hash("searchId");
	         $anchorScroll();
		 }
		
	}; */

  //资源搜索定位事件
    $scope.testA=function(){
    	document.getElementById("searchContentHM").focus(); 
   	};
   	
	var cookiesJudge=function(jumpUrl,Flag,typeNum){// 判断cookies是否存在，如已存在直接进入页面，如不存在进入登录页面 
		var isLogin = "${sessionScope.userInfo}";
	    var isId = "${sessionScope.userInfo.partyTypeId}"

			if(Flag){// 如果有标志就是新打开页面的模式 
				if(typeNum=="rent"){
					window.open("../../../WebSite/Front/Publish/Infopub.jsp","_blank");
				}
				else if(typeNum=="demandRent"){
		
					window.open("../../../WebSite/Front/Publish/DemandInfoPub.jsp","_blank");
			    }
			     
				else if(typeNum=="ViewDemandRentInfo"){
					window.open("../Publish/ViewDemandRentInfo.jsp","_blank");
			    }
				else if(typeNum=="demandSale"){
			
					window.open("../../../WebSite/Front/Publish/DemandInfoPubShop.jsp","_blank");
			    }
			}else{
				window.open(jumpUrl,"_blank");
			}
			
		//}
	};
});
//app.controller('searchIncludeController',function($scope,published,searchUrl,category){});
</script>
<style>
	.container {width: 1150px !important;}
	.form-horizontal .control-label {
		padding-top: 7px;
		margin-bottom: 0;
		text-align: right;
		min-width : 0px;
	}
</style>
</head>

<body ng-app="indexApp_" ng-controller="indexController_" >
	 <jsp:include page="../../../WebSite/Front/Main/Top.jsp" />
	 <div class="main">
   <div class="position"> <span>&gt;</span>  &nbsp;首页  &nbsp; </div>
     <div style="width:1200px; height:245px;">
		  <div id="playBox" class="ihhabanner ihhabanner1">
		    <div class="pre"></div>
		    <div class="next"></div>
		    <div class="smalltitle">
		      <ul>
		        <li class="thistitle"></li>
		        <li></li>
		        <li></li>
		      </ul>
		    </div>
		    <ul class="oUlplay">
		       <li><a href="####"><img src="../../../media/images/0001.png" width="1200" height="245" /></a></li>
		       <li><a href="####"><img src="../../../media/images/0002.png" width="1200" height="245" /></a></li>
		       <li><a href="####"><img src="../../../media/images/0003.png" width="1200" height="245" /></a></li>
		    </ul>
		  </div>
  </div>
<div class=" mar_t20">
  <div class="bdi_left">
       <div class="">
               <div class="ergkite bd_lan" id="ttt" style="height:30px;">
                    <ul>
                     <li class="lefthui" id="lqqa1"><a href="#" onmouseover="changebg21('lqqa1');">最新出租 </a></li>
                     <li id="lqqa2"><a href="#" onmouseover="changebg21('lqqa2');">最新出售</a></li>
                     <li id="lqqa3"><a href="#" onmouseover="changebg21('lqqa3');">最新求租</a></li>
                     <li id="lqqa4"><a href="#" onmouseover="changebg21('lqqa4');">最新求购</a></li>
                    </ul>
                </div>
               <div class="jh_zx liok jokk" id="nirt">
                    <ul ng-if="SYS_USER_INFO.perPartyId==''||SYS_USER_INFO.perPartyId == null||!SYS_USER_INFO.perPartyId" class="gads" id="lqqa11">
                      	<a target="_bank" href="../Publish/ViewInfo.jsp?id={{r.dataId}}&infoType=1" ng-repeat="r in czresultList" title="{{r.infoTitle}}">
                      		<img ng-src="{{PicUrlName}}/{{r.PicName}}/{{r.PicType}}" width="136" height="103" onerror="javascript:this.src='/media/images/default.png';"/><br />【出租】<span ng-bind="r.infoTitleTemp"></span>
                      	</a>
                    </ul>
                
                    <ul ng-if="SYS_USER_INFO.perPartyId" class="gads" id="lqqa11">
                      	<a target="_bank" href="../../Back/Publish/ViewInfo.jsp?id={{r.dataId}}&infoType=1" ng-repeat="r in czresultList" title="{{r.infoTitle}}">
                      		<img ng-src="{{PicUrlName}}/{{r.PicName}}/{{r.PicType}}" width="136" height="103" onerror="javascript:this.src='/media/images/default.png';"/><br />【出租】<span ng-bind="r.infoTitleTemp"></span>
                      	</a>
                    </ul>
                    
                    <ul ng-if="SYS_USER_INFO.perPartyId==''||SYS_USER_INFO.perPartyId == null||!SYS_USER_INFO.perPartyId" class="gads" id="lqqa21" style="display:none;" ng-init="newSale()">
                    	<a target="_bank" href="../Publish/ViewInfo.jsp?id={{r.dataId}}&infoType=2" ng-repeat="r in sresultList" title="{{r.infoTitle}}">
                    		<img ng-src="{{PicUrlName}}/{{r.PicName}}/{{r.PicType}}" width="136" height="103" onerror="javascript:this.src='/media/images/default.png';"/><br />【出售】<span ng-bind="r.infoTitleTemp"></span>
                    	</a>
                    </ul>
                    
                    <ul ng-if="SYS_USER_INFO.perPartyId" class="gads" id="lqqa21" style="display:none;" ng-init="newSale()">
                    	<a target="_bank" href="../../Back/Publish/ViewInfo.jsp?id={{r.dataId}}&infoType=2" ng-repeat="r in sresultList" title="{{r.infoTitle}}">
                    		<img ng-src="{{PicUrlName}}/{{r.PicName}}/{{r.PicType}}" width="136" height="103" onerror="javascript:this.src='/media/images/default.png';"/><br />【出售】<span ng-bind="r.infoTitleTemp"></span>
                    	</a>
                    </ul>
                    
                    <ul ng-if="SYS_USER_INFO.perPartyId==''||SYS_USER_INFO.perPartyId == null||!SYS_USER_INFO.perPartyId" class="jh_zx width100" id="lqqa31" style="display:none;" ng-init="newQiuzu();">
                    	 <li ng-repeat="r in qzresultList">
	                    	 <a target="_bank" href="../Publish/ViewDemandRentInfo.jsp?id={{r.dataId}}&infoType=3" title="{{r.infoTitle}}">
                   	 	 		<div class="col-xs-8">
	                    			<div style="float:left;">▪ 【求租】</div><div style="float:left;" ng-bind="r.infoTitleTemp"></div> 
	                    		</div>
		                    	<div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 89px;">&#91;</div> 
	                    	    <div class="col-xs-2" style="padding-left: 40px;" ng-bind="r.releaseDate"></div>
	                    	    <div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 -45px;">&#93;</div>
				             </a>
                    	 </li>
                    </ul>
                     <ul ng-if="SYS_USER_INFO.perPartyId" class="jh_zx width100" id="lqqa31" style="display:none;" ng-init="newQiuzu();">
                    	 <li ng-repeat="r in qzresultList">
	                    	 <a target="_bank" href="../../Back/Publish/ViewDemandRentInfo.jsp?id={{r.dataId}}&infoType=3" title="{{r.infoTitle}}">
	                    	 		<div class="col-xs-8">
		                    			<div style="float:left;">▪ 【求租】</div><div style="float:left;" ng-bind="r.infoTitleTemp"></div> 
		                    		</div>
			                    	<div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 89px;">&#91;</div> 
	                    	        <div class="col-xs-2" style="padding-left: 40px;" ng-bind="r.releaseDate"></div>
	                    	        <div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 -45px;">&#93;</div>
			                 </a>
                    	 </li>
                    </ul>
                     <ul ng-if="SYS_USER_INFO.perPartyId==''||SYS_USER_INFO.perPartyId == null||!SYS_USER_INFO.perPartyId" class="jh_zx width100" id="lqqa41" style="display:none;" ng-init="newBuy();">
                    	<li ng-repeat="r in buyresultList" >
	                    	<a target="_bank" href="../Publish/ViewDemandSaleInfo.jsp?id={{r.dataId}}&infoType=4" title="{{r.infoTitle}}">
	                    		<div class="col-xs-8">
	                    			<div style="float:left;">▪ 【求购】</div><div style="float:left;" ng-bind="r.infoTitleTemp"></div> 
	                    		</div>
		                    	<div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 89px;">&#91;</div> 
	                    	    <div class="col-xs-2" style="padding-left: 40px;" ng-bind="r.releaseDate"></div>
	                    	    <div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 -45px;">&#93;</div>
		                   </a>
                    	</li>
                    </ul>
                   
                    <ul ng-if="SYS_USER_INFO.perPartyId" class="jh_zx width100" id="lqqa41" style="display:none;" ng-init="newBuy();">
                    	<li ng-repeat="r in buyresultList" >
                    		<a target="_bank" href="../../Back/Publish/ViewDemandSaleInfo.jsp?id={{r.dataId}}&infoType=4" title="{{r.infoTitle}}">
	                    		<div class="col-xs-8">
	                    			<div style="float:left;">▪ 【求购】</div><div style="float:left;" ng-bind="r.infoTitleTemp"></div> 
	                    		</div>
	                    	    <div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 89px;">&#91;</div> 
	                    	    <div class="col-xs-2" style="padding-left: 40px;" ng-bind="r.releaseDate"></div>
	                    	    <div class="col-xs-1" style="width: 1%;margin: 0 -51px 0 -45px;">&#93;</div>
                    		</a>
                    	</li>
                    </ul>
                <div class=" clear"></div>    
               </div>
               <div class=" clear"></div>
           </div>
   </div>
   <div class="zb_right"> 
      <div class="gao_fe liok jokk_a" style=" margin-top:30px;">
       <div class="ergkite_dd bd_hui" style="font-weight:bold;">资源统计</div>
       <ul class="dvsd"  ng-init="resourceCount1();">
          <li><a href="#">内部资源有<span class="col_red txt14" ng-bind="resourceMsg.innerEquNum"></span>台设备<br /> 
          原值：<span class="col_red txt14" ng-bind="resourceMsg.innerEquCost"></span>亿元</a></li>
          <li><a href="#">外部资源有<span class="col_red txt14" ng-bind="resourceMsg.outerEquNum"></span>台设备<br /> 
          原值：<span class="col_red txt14" ng-bind="resourceMsg.outerEquCost"></span>亿元</a></li>
          <li><a href="#">内部供应商共计<span class="col_red txt14" ng-bind="resourceMsg.innerOrg"></span>家<br /> 
          <li><a href="#">外部供应商共计<span class="col_red txt14" ng-bind="resourceMsg.outerOrg"></span>家<br /> 
          <li><a href="#">可出租设备<span class="col_red txt14" ng-bind="resourceMsg.canRentNum"></span>台<br /> 
          <li><a href="#">可出售设备<span class="col_red txt14" ng-bind="resourceMsg.canSaleNum"></span>台<br />  
        <div class=" clear"></div>
      </ul>
       <div class=" clear"></div>
    </div>
   </div>
  <div class="clear"></div> 
</div>
 <div class="fopwq_img mar_t20"> 
  <a class="left" href="#"><img src="../../../media/images/gwegw.png" /></a>
  <a class="right" href="#"><img src="../../../media/images/hstewyr.png" /></a> 
  </div> 
  <div class=" mar_t20">
  <div class="bdi_left liok" style="height:620px;">
       <div class="ergkite_dd bd_hui" style="font-weight:bold;">产品供应分类</div>
       <div class="fpwoq" ng-init="queryProType()" >
         <ul>
           <li ng-repeat="t in proTypeList" class="col-xs-6">
             <a href="Search.jsp?id={{t.equCategoryId}}&name={{t.equipmentCategoryName}}&type=bigType&searchType=chuzu&searchBtnType=search_Id" ><h2 ng-bind="t.equipmentCategoryName"></h2></a>
               <font ng-repeat="v in t.equNameInfos">
              	 <a  href="Search.jsp?id={{v.equNameId}}&name={{v.equipmentName}}&type=smallType&searchType=chuzu&searchBtnType=search_Id" ng-bind="v.equipmentName"></a>|
              </font>
              <a class="col_chen" href="Search.jsp?type=smallType&searchType=chuzu&searchBtnType=search_Id">更多</a>
            </li>
         </ul>
         <div class="clear"></div> 
       </div>
   </div>
  <div class="zb_right"> 
      <div class="gao_fe liok nedgwg">
       <div class="ergkite_dd bd_hui" ng-init="queryEntInfo();"><span class="left txt14 col_3" style="font-weight:bold;">最新加入企业</span><a class="right" href="#">更多</a></div>
        <ul class="news_nr">
              <li ng-repeat=" e in newEntList"><a href="###" ng-bind="e.name"></a></li>
         <div class=" clear"></div>     
        </ul>
       <div class=" clear"></div>
    </div>
    <div class="liok nedgwg mar_t20">
                 <div class="ergkite bd_hui kkk" style="height: 30px;">
                    <ul>
                     <li><a href="#" style="font-weight:bold;">行业动态</a></li>
                    </ul>
                    <a class="right" style="margin-right: 15px;" href="http://124.205.89.213:8000/home?actionName=news&newsType=3" target="_blank">更多</a>
                 </div>
                 <div class=" clear"></div>
           </div>
   </div>
  <div class="clear"></div> 
</div>

  <div class="clear"></div>
</div>
<div class="opwe mar_t30">
	<a href="#"><img src="../../../media/images/iopj.png" /></a>
</div>
	<jsp:include page="../Include/Bottom.jsp" />
	<script>
 /** Change the style **/
 function outStyle(object){
    object.style.color = 'black';
    // Restore the rest ...
 }
 function overStyle(object){
    object.style.color = 'red';
    // Change some other properties ...
 }</script>
</body>
</html>
