<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.Math" %>
<script type="text/javascript" src="../../../js/JsLib/myArray.js"></script>
<script type="text/javascript">

	    var showMenu=function(type){
		    switch(type){
			    case 'ziyuan' :{
					/* $('#ulTopId li:eq(1) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(1)').addClass("baidi")
					break;		
				}
			    case 'chuzu' :{
			    	/* $('#ulTopId li:eq(2) a').css('background','#CBCCCD'); */
			    	$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(2)').addClass("baidi")
			    	break;	
			    }
			    case 'qiuzu' :{
			    	/* $('#ulTopId li:eq(3) a').css('background','#CBCCCD'); */
			    	$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(3)').addClass("baidi")
			    	break;	
			    }
				case 'sale' :{
					/* $('#ulTopId li:eq(4) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(4)').addClass("baidi")
					break;			    	
				}
				case 'qiugou' :{
					/* $('#ulTopId li:eq(5) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(5)').addClass("baidi")
					break;		
				}case 'luban' :{
					/* $('#ulTopId li:eq(5) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(8)').addClass("baidi")
					break;		
				}
				default:{
					/* $('#ulTopId li:eq(0) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(0)').addClass("baidi")
					break;
				}
			}
		};
		
		function GetRequest() {
			  
			  var url = location.search; //获取url中"?"符后的字串
			   var theRequest = new Object();
			   if (url.indexOf("?") != -1) {
			      var str = url.substr(1);
			      strs = str.split("&");
			      for(var i = 0; i < strs.length; i ++) {
			         theRequest[strs[i].split("=")[0]]=(strs[i].split("=")[1]);
			      }
			   }
			   return theRequest;
			}
	$(function(){
		$("#searchType").val("chuzu");
		//
		var params = GetRequest();
		showMenu(params.searchType);
	});
	
	/* function selectSearch(type){
		$("#searchType").val(type);
	} */
	
	var cookiesJudge=function(jumpUrl,Flag,typeNum,alarmMsg){/* 判断cookies是否存在，如已存在直接进入页面，如不存在进入登录页面 */
		var isLogin = "${sessionScope.userInfo}";
	 	var isId = "${sessionScope.userInfo.partyTypeId}"
	 	
	 	

		    if(!isId && typeNum =='sszy'){
				$.messager.confirm("提示", "当前功能只有中国中铁的内部企业用户可以使用", function() {});	
				return;
		    }
		    
			 if(!isId){
		 			$.messager.confirm("提示", "您没有权限发布信息，请注册为企业用户", function() {});	
		 			return;
		 	 }
	 	
	 	
/* 		if(isLogin==null||isLogin==''){   跳转问题 没细看先注释
			if(alarmMsg){
				$.messager.confirm("提示", alarmMsg, function() { 
					if(typeNum){
						window.location.href="../../../WebSite/Front/Login/Login.jsp?flag="+typeNum;
					}else{
						window.location.href="../../../WebSite/Front/Login/Login.jsp?";
					}
				});
			}else{
					if(typeNum){
						window.location.href="../../../WebSite/Front/Login/Login.jsp?flag="+typeNum;
					}else{
						window.location.href="../../../WebSite/Front/Login/Login.jsp?";
					}
			}
				
		}else{ */
			if(Flag){/* 如果有标志就是新打开页面的模式 */
				if(typeNum=="rent"){
					window.open("../../../WebSite/Back/Publish/Infopub.jsp","_blank");
				}
				else if(typeNum=="demandRent"){
					if(isId==6){
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
					}
					window.open("../../../WebSite/Back/Publish/DemandInfoPub.jsp","_blank");
			    }
			     
				else if(typeNum=="sale"){
					window.open("../../../WebSite/Back/Publish/InfopubSale.jsp","_blank");
			    }
				else if(typeNum=="demandSale"){
					if(isId==6){
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
					}
					window.open("../../../WebSite/Back/Publish/DemandInfoPubShop.jsp","_blank");
			    }
			}else{
				 if(isId==6){
						$.messager.confirm("提示", "当前功能只有中国中铁的内部企业用户可以使用", function() {});	
						return;
					} 
				 if(!isId){
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
					} 
				window.open(jumpUrl,"_blank");
			}
			
		//}
	};
</script>
<div>
<div class="topcss">
  <div class="topcss_nr">
     <p>欢迎来到中国中铁采购电子商务平台</p>
     <p>客服热线-400-6988000</p>
    <ul>
        <li class="ihhalogin"><a href="###">登录</a></li>
        <li><a href="###">免费注册</a></li>
        <li><a href="###">会员中心</a></li>
        <li><a href="###">客户服务</a></li>
        <li><a href="###">网站导航</a></li>
     </ul>
  </div>
</div>

<div class="logocss">
  <p><a href="http://www.crecgec.com"><img src="../../../media/images/logo.png" width="384" height="62" /></a></p>
  <div class="mmt">
     <div class="ergkite" id="tt" style="height: 30px;">
          <ul id="searchTab" style="margin-bottom: -1px;" ng-init="judgeTab();">
           <li class="lefthui" id="lqq1"><a href="#" ng-click="selectSearch('chuzu')" ng-mouseover="selectSearch('chuzu')">出租</a></li>
           <li id="lqq2"><a href="#" ng-click="selectSearch('qiuzu')" ng-mouseover="selectSearch('qiuzu')">求租</a></li>
           <li id="lqq3"><a href="#" ng-click="selectSearch('sale')" ng-mouseover="selectSearch('sale')">出售</a></li>
           <li class="lefthui" id="lqq4"><a href="#" ng-click="selectSearch('qiugou')" ng-mouseover="selectSearch('qiugou')">求购</a></li>
          </ul>
      </div>
     <div class="ihhass" >
       <p class="logo_search logo_search_aa">
         <span  class="spanA" ng-click="search(1,searBean.infoTitleBean);">搜索</span> 
         <input style="height:30px;padding:3px 12px" ng-focus="myFunction(1);" ng-blur="myFunction(2);"
						data-toggle="dropdown" ng-model="searBean.infoTitleBean"
						type="text" id="searchContent" name="searchContent"
						class="form-control" select="setSelected(x)"
						list-items="suggestions" close="suggestionPicked()"
						selection-made="selectionMade" placeholder="请输入关键词检索"
						index="selected" maxlength="200"
						ng-change="KeyWordQuery(searBean.infoTitleBean);"
						ng-click="InputClick();" ng-keyup="inputKeyup($event)" />
	     <input type="text" focus-me focus-when="{{selectionMade}}" style="display:none;"/><span id="clearFlag" class="glyphicon glyphicon-remove" style="position: absolute;margin-left: -30px;margin-top: 8px; display:none;" ng-click="clearInput();"></span>
	     <input type="hidden" id="searchType" name="searchType">
		</p>
		<div class="ddfsf" style="position: absolute;margin-top:30px;">热门搜索词： <a href="#" ng-repeat="linkValue in linkValueList" ng-click="queryInfoLink(linkValue.equipmentName);">{{linkValue.equipmentName}}</a> </div>
		<div id="parentOrgs1"  style="display: none;" ng-mouseover="overChangeQueryFlag();" ng-mouseleave="leaveChangeQueryFlag();"><div class="input_xl" ng-if="LiNumA" id="parentOrgs">
			<!-- <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" > -->
           <ul>
				<li ng-repeat="RentInfo in KeyWordList |orderBy:'-rankLocation'" ng-click="InputShow($index,RentInfo.infoTitle);" ng-keyup="myKeyup($event)">
					<a id="keyWords{{$index}}" title="{{RentInfo.infoTitle}}" class="ss_link1" style="float:left; width:200px;" href="javascript:void(0)">{{RentInfo.infoTitleA}}</a>
					<lable style="float:right;">
						<font ng-show="$index==0">{{RentInfo.flagMsg}}&nbsp;</font>&nbsp;
						<font ng-show="RentInfo.flagMsg == null || RentInfo.flagMsg == '' || $index != 0">约{{RentInfo.itCount}}个设备</font>
					</lable>
				</li>
			</ul>
           <div class="clear"></div>
         </div></div>
        <div id="parentOrgs2"  style="display: none;" ng-mouseover="overChangeFlag();" ng-mouseleave="leaveChangeFlag();">
         	<div class="input_xl" ng-if="LiNumB" id="parentOrgs">
	           <span class="ihha_zjss">最近搜索：</span>
	           <ul >
	             <li ng-repeat="RentInfoB in KeyWordListB" ng-click="B(RentInfoB.infoTitleB);" ng-keyup="myKeyupHC($event)">
	             	<a class="ss_link1" href="###" style="float:left; width:220px;" title="{{RentInfoB.infoTitleB}}">{{RentInfoB.infoTitleB}}</a>
	             	<a class="ss_link1" id="delid{{$index}}" style="float:right;width:40px;" ng-mouseover="DelColorOverShow($index);" ng-mouseout="DelColorOutShow($index);" ng-click="DelCache(RentInfoB.infoTitleB,$index);" >删除</a>
					</li>
	           </ul>
	           <span class="ihha_qk">
	           		<a ng-mouseover="DelAllOver();" class="ihha_qk" ng-mouseout="DelAllOut();" ng-click="DelAll();">
	           			<span id="delAllAId"></span>
						<span id="delAllBId" style="margin-left:3px;color:#a8a8a8;" >×清空</span>
					</a>
				</span>
	           <div class="clear"></div>
	  	   </div>
       </div>
     </div>
                
  </div>
  <div class="logo_rigd">
       <a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Back/Publish/DemandInfoPub.jsp','Flag','demandRent','您没有权限发布信息，请注册为企业用户');">发布求租信息</a>
       <a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Back/Publish/Infopub.jsp','Flag','rent','您没有权限发布信息，请注册为企业用户');">发布出租信息</a>
       <a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Back/Publish/DemandInfoPubShop.jsp','Flag','demandSale','您没有权限发布信息，请注册为企业用户');" >发布求购信息</a>
       <a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Back/Publish/InfopubSale.jsp','Flag','sale','您没有权限发布信息，请注册为企业用户');">发布出售信息</a>
       <div class="clear"></div>
  </div>
</div>

<div class="daohangcss" style="position:initial;">
  <ul id="jsddm">
    <li ><a href="../../../WebSite/Front/Main/HomePage.jsp?random=${Math.random()}">首页</a></li>
    <li class="baidi"><a href="" onClick="cookiesJudge('../../../WebSite/Back/Main/Resource.jsp?searchType=ziyuan&random=${Math.random()}',false,'sszy','当前功能只有中国中铁的内部企业用户可以使用');">资源搜索</a></li>
    <li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=chuzu&random=${Math.random()}" target="_blank">出租信息</a></li>
    <li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=qiuzu&random=${Math.random()}" target="_blank">求租信息</a></li>
    <li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=sale&random=${Math.random()}" target="_blank">出售信息 </a></li>
    <li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=qiugou&random=${Math.random()}" target="_blank">求购信息 </a></li>
    <li><a href="###">出租人风采</a></li>
    <li><a href="###">承租人风采</a></li>
    <li style="width:146px;"><a href="###">我的鲁班</a>
    <ul style="width:146px;">
          <li><a href="../../../WebSite/Front/Main/publishBack.jsp?searchType=luban&random=${Math.random()}">已发布的信息</a></li>
          <li><a href="../../../WebSite/Front/Main/publishFront.jsp?searchType=luban&random=${Math.random()}">想交易的信息</a></li>
          <%-- <li><a href="" onClick="cookiesJudge('../../../WebSite/Back/index.jsp?random=${Math.random()}');">后台管理</a></li> --%>
          <li><a href="../../Back/index.jsp">后台管理</a></li>
		</ul></li>
  </ul>
</div></div>
<script type="text/javascript" src="../../../media/js/commonjs.js"></script>