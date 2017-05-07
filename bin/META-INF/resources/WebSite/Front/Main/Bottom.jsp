<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<div>

			
	<div class="" style="background-color:#F4F4F4;width:1584px;margin-left:-248px;height:180px;">
		<div class="">
			<br/>
			<div style="margin-left:300px;margin-top:-20px;">
				<h2>
					<a href="#" title="中铁鲁班商务网">
						<img src="http://static.crecgec.com/crecgec/image/footer_log.png" alt="中铁鲁班商务网论坛" border="0" />
				</h2>
			</div>
			<div style="margin-left:550px;margin-top:-60px;">
				<div style="margin-left:34px;"><h4>新闻公告</h4></div>
				<ul>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">公司新闻</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">通知公告</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">行业资讯</a>
					</li>
				</ul>	
			</div>
			<div style="margin-left:680px;margin-top:-100px;">
				<div style="margin-left:34px;"><h4>采购信息</h4></div>
				<ul>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">招标公告</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">竞争性谈判</a>
					</li> 
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">询价采购</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">澄清补遗</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">中标告示</a>
					</li>
				</ul>
			</div>
			<div style="margin-left:820px;margin-top:-140px;">
				<div style="margin-left:24px;"><h4>供应商园地</h4></div>
				<ul>
					<li style="list-style-type:none;"> 
						<a href="#" style="text-decoration:none;" class="smalltype">下载中心</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">交易须知</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">操作手册</a>
					</li>
				</ul>
			</div>
			<div style="margin-left:980px;margin-top:-100px;">
				<div style="margin-left:34px;"><h4>快速入口</h4></div>
				<ul>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">政策法规</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">网上专卖店</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">官方论坛</a>
					</li>
					<li style="list-style-type:none;">
						<a href="#" style="text-decoration:none;" class="smalltype">常见问题</a>
					</li>
				</ul>
			</div>
			<div style="margin-left:1180px;margin-top:-120px;">
				<div style="margin-left:-14px;"><h4>中铁鲁班微信号</h4></div>
				<img src="http://static.crecgec.com/crecgec/image/weixin_erwei.png">
			</div>
		</div>
	</div>
	<!--  -->
	<br/>	
	<div>
		<hr/>
	</div>
	<div style="margin-top:30px; text-align: center;">
		<div>
			<div>
				<a href="#" style="text-decoration:none;" class="smalltype">集团网站</a>
				<span>|</span>
				<a href="#" style="text-decoration:none;" class="smalltype">鲁班服务</a>
				<span>|</span>
				<a href="#" style="text-decoration:none;" class="smalltype">联系我们</a>
				<span>|</span>
				<a href="#" style="text-decoration:none;" class="smalltype">合作伙伴</a>
				<span>|</span>
				<a href="#" style="text-decoration:none;" class="smalltype">法律声明</a>
				<span>|</span>
				<a href="#" style="text-decoration:none;" class="smalltype">关于我们</a>
				<span>|</span>
				联系邮箱 crecgec@lubanec.com
			</div>
			<div style="margin-top:10px;">
				<a href="#" style="text-decoration:none;" class="smalltype">©2013 中铁鲁班 All Rights Reserved 鲁班（北京）电子商务科技有限公司版权所有   京ICP备14004333号</a>
			</div>
			<div style="margin-top:10px;">
                <a href="#"  style="text-decoration:none;" class="smalltype">客服电话:400-6988000 公司地址:北京市丰台区西客站南广场中盐大厦西塔8楼</a>
               </div>
			<div style="margin-top:10px;margin-bottom: 10px;">
			   	 请使用IE9以上版本浏览页面，推荐使用
			   	 <a href="#" style="text-decoration:none;" class="smalltype">Chrome浏览器 </a>以获得更好的用户体验!
			   	 <a href="#" target="_blank" style="text-decoration:none;" class="smalltype">测试访问速度</a>
			</div>
		</div>
	</div>				
</div>
	
	 --%>
	 
	 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<script>
function toNewsList(newType){
	if(newType==0){
		 url = "http://124.205.89.213:8000/home?actionName=news";
	}else{
	var url = "http://124.205.89.213:8000/home?actionName=news&newsType="+newType;}
    window.open(url);
}

/* 招标列表页链接 */
function buttToBidding(val1) {
	var buttomPushType = val1;
	document.buttomForm.action = "http://124.205.89.213:8000/home?actionName=tendersHome";
	/* $("#buttomForm #actionName").val("tendersHome"); */
	$("#buttomForm #pushType").val(buttomPushType);
	$("#buttomForm #pageNo").val(0);
	$("#buttomForm #pageSize").val(10);
	$("#buttomForm #random").val(Math.random());
	document.buttomForm.submit();
}

</script>

<form id="buttomForm" name="buttomForm" action="#" method="post" target="_blank">
<input type="hidden" id="actionName" name="actionName" value="">
<input type="hidden" id="dataState" name="dataState" value="1">
<input type="hidden" id="BTMark" name="BTMark" value="3">
<input type="hidden" id="pushType" name="pushType" value="">
<input type="hidden" id="random" name="random" value="">
</form>

<!-- <div class="down_k"> -->
<!--     <div class="down"> -->
<!--     <div class="pwllk"><img src="/media/images/lgh.png"/></div> -->
<!--     <div class="dso bhod_a"  style="width: 169px;">  -->
<!--       <p >新闻公告</p>  -->
<!--         <a href="javascript:void(0)" onclick="toNewsList(1)">公司新闻 </a>  -->
<!--         <a href="javascript:void(0)" onclick="toNewsList(2)">通知公告 </a>  -->
<!--         <a href="javascript:void(0)" onclick="toNewsList(3)">行业资讯 </a> -->
<!--     </div> -->
<!--     <div class="dso dso_a"  style="width: 216px;">  -->
<!--         <p >采购信息</p>  -->
<!--         <a onclick="buttToBidding('1')">招标公告</a>  -->
<!--         <a onclick="buttToBidding('2')">竞争性谈判</a>  -->
<!--         <a onclick="buttToBidding('3')">询价采购</a>  -->
<!--         <a onclick="buttToBidding('5')">澄清补遗  </a>  -->
<!--         <a onclick="buttToBidding('6')">中标告示</a>  -->
<!--     </div> -->
<!--       <div class="dso"  style="width: 169px;">  -->
<!--       <p >供应商园地</p>  -->
<!--         <a href="http://124.205.89.213:8000/view/PCClient/DownloadCenter/DownloadServiceMain.jsp" target="_blank">下载中心</a>  -->
<!--         <a href="http://124.205.89.213:8000/view/PCClient/TransNotice/TransNoticeServiceMain.jsp" target="_blank">交易须知</a>  -->
<!--         <a href="http://124.205.89.213:8000/File/caozuoshouce.pdf/3/download" target="_blank">操作手册</a> -->
<!--     </div> -->
<!--      <div class="dso bhod"  style="width: 169px;">  -->
<!--         <p >快速入口</p>  -->
<!--         <a href="http://124.205.89.213:8000/view/PCClient/PoliciesLaws/PoliciesLawsMain.jsp" target="_blank">政策法规</a>  -->
<!--         <a href="http://mall.crecgec.com/" target="_blank">网上专卖店</a>  -->
<!--         <a href="http://bbs.crecgec.com/"  target="_blank">官方论坛</a>  -->
<!--         <a href="http://static.crecgec.com/zulin/php/FAQ1.php" target="_blank">常见问题</a> -->
<!--      </div> -->
<!--      <div class="dso_j">  -->
<!--        <p>中铁鲁班微信号</p> -->
<!--        <img src="/media/images/sm.png"/> -->
<!--     </div> -->
<!--    <div class="clear"></div> -->
<!--   </div> -->
<!-- </div> -->
<div class="bord_foot">
<!--    <div class="wopq"> -->
<!--         <a href="http://www.crec.cn/" target="_blank">集团网站</a>|  -->
<!--         <a href="http://www.crecgec.com/portal.php?mod=topic&topicid=4" target="_blank">鲁班服务</a>|	  -->
<!--         <a href="http://124.205.89.213:8000/view/PCClient/CustomerService/CustomerServiceMain.jsp?tab=aboutus&colls=service" target="_blank">联系我们</a>|  -->
<!--         <a href="http://124.205.89.213:8000/view/PCClient/CustomerService/CustomerServiceMain.jsp?tab=aboutus&colls=partner" target="_blank">合作伙伴</a>|   -->
<!--         <a href="http://124.205.89.213:8000/view/PCClient/CustomerService/CustomerServiceMain.jsp?tab=aboutus&colls=law" target="_blank">法律声明</a>|  -->
<!--         <a href="http://124.205.89.213:8000/view/PCClient/CustomerService/CustomerServiceMain.jsp?tab=aboutus&colls=jianjie" target="_blank">关于我们</a>|  -->
<!--         <a href="javascript:void(0)">联系邮箱 crecgec@lubanec.com </a> -->
<!--    </div> -->
   <p>©2013 中铁鲁班 All Rights Reserved 鲁班（北京）电子商务科技有限公司版权所有 京ICP备14004333号 | 京ICP证151026号</p>
   <p>客服电话:400-6988000 公司地址:北京市丰台区西客站南广场中盐大厦西塔8楼 </p>
   <p>请使用IE9以上版本浏览页面，推荐使用<a href="javascript:void(0)" class="col_slan">Chrome浏览器</a>以获得更好的用户体验！测试访问速度</p>
</div>