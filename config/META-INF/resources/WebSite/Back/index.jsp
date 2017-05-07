<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="../Front/Include/HeadAfter.jsp" />
<jsp:include page="../Back/common/common.jsp" />

<style type="text/css">

.container {width: 1500px !important;}

a:focus { 
outline: none; /* 去掉超链接外的虚线边框 */
} 
</style>
</head>
<body style="background-color: #fff">
<jsp:include page="../Back/common/TopMenu.jsp" />

<%-- ${sessionScope.userInfo} --%>


<div class="container"  ng-app="IndexApp" ng-controller="IndexController"> <!-- style="background-color:#fff;width: 1580px;" -->
	<div class="row"> 
<!-- 		<div class="col-xs-2 text-center" style="border-left:1px solid #ddd; padding-left:0px; padding-right:0px;" >
				<div class="panel-group" id="accordion" >
				
			 		<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" data-target="#collapseOne" href="/WebSite/Back/test/index.jsp#administrator" style="color:#fff; font-size:20px; font-weight:bold; text-decoration:none;"> 系统管理 </a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse ">
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#administrator" style="color:#000; font-size:16px; text-decoration:none;">企业管理员维护</a></div>
						    <div class="panel-body"><a href="/WebSite/Back/test/index.jsp#enterPriseSet" style="color:#000; font-size:16px; text-decoration:none;">企业设置</a></div>
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#employeeInformationMaintain" style="color:#000; font-size:16px; text-decoration:none;">员工信息维护</a></div>
						    <div class="panel-body"><a href="/WebSite/Back/test/index.jsp#projectList" style="color:#000; font-size:16px; text-decoration:none;">项目管理</a></div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" data-target="#collapseTwo" href="/WebSite/Back/test/index.jsp#categoryList" style="color:#fff; font-size:20px; font-weight:bold; text-decoration:none;">机械设备分类管理</a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse">
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#categoryList" style="color:#000; font-size:16px; text-decoration:none;">机械设备分类管理</a></div>
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#categoryManage" style="color:#000; font-size:16px; text-decoration:none;">分类设备维护</a></div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" data-target="#collapseThree" href="/WebSite/Back/test/index.jsp#equipmentList" style="color:#fff; font-size:20px; font-weight:bold; text-decoration:none;">资源管理</a>
							</h4>
						</div>
						<div id="collapseThree" class="panel-collapse collapse">
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#equipmentList" style="color:#000; font-size:16px; text-decoration:none;">资源管理</a></div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" data-target="#collapseFour" href="/WebSite/Back/test/index.jsp#depreciationCostList" style="color:#fff; font-size:20px; font-weight:bold; text-decoration:none;">信息登记 </a>
							</h4>
						</div>
						<div id="collapseFour" class="panel-collapse collapse" >
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#depreciationCostList" style="color:#000; font-size:16px; text-decoration:none;">折旧费登记</a></div>
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#deviceUsageQuestionnaireCheckInList" style="color:#000; font-size:16px; text-decoration:none;">租赁费登记</a></div>
							<div class="panel-body"><a href="/WebSite/Back/test/index.jsp#rentCheckInList" style="color:#000; font-size:16px; text-decoration:none;">发布结果登记</a></div>
						</div>
					</div> 
					
				</div>
			</div> -->
		<!--  <div class="col-xs-10" style="background-color:#e5e5e5;margin-top: 30px;"> -->
		<div style="background-color:#FFF;padding-left: 10px;padding-right: 10px;min-height: 600px;"><ng-view></ng-view></div>
		</div>
	</div>
<!-- <script type="text/javascript">
	//获取超链接url
	var a_url=window.location.href
	//判断是否有#号
	var divId="collapseOne";//定义一个字符串变量divId方便下面divId不用加var
	if(a_url.indexOf("#")!=-1)
	{
		var a_url_after=a_url.substr(a_url.indexOf("#")+2,a_url.length);//截取位置之后字符串加2是因为有#/需要之后的参数得多截取2位
		if(a_url_after=="administrator"||a_url_after=="enterPriseSet"||a_url_after=="employeeInformationMaintain"||a_url_after=="projectList")
		{
			divId="collapseOne";//选择div的id
		}
			else if(a_url_after=="categoryList"||a_url_after=="categoryManage")
		{
			divId="collapseTwo";//选择div的id
		}
			else if(a_url_after=="equipmentList")
		{
			divId="collapseThree";//选择div的id
		}
			else if(a_url_after=="depreciationCostList"||a_url_after=="deviceUsageQuestionnaireCheckInList"||a_url_after=="rentCheckInList")
		{
			divId="collapseFour";//选择div的id
		}
		
			
	}
	var select_div=document.getElementById(divId);//获取到id对应的div
	select_div.className="panel-collapse collapse in";//给div的class属性加in
</script> -->
<script>
	 /**
	  * 拿到所有的类是dropdown-submenu1的li标签，然后循环遍历判断她下面的子标签ul是否有子元素，如果没有将对应的li删除
	  */
	 (function(){
			var i=0,menus=$('.dropdown-submenu1');//获取所有的菜单标签
			for(;i<menus.length;i++)//循环处理每一个菜单标签，判断是否有至少一个叶子几点，否则删除此菜单
			{
				if(menus[i].children.length>1)//判断菜单是否包含菜单项
				{
					/* if(menus[i].children[1].children.length==0){menus[i].remove();} *///如果对应的菜单项没有菜单，则删除对应的菜单项，注意：此种方式、IE浏览器删除DOM元素不成功
					
					if(menus[i].children[1].children.length==0)
					{
						var li=menus[i];
						var $li=$(li);//将DOM对象转换成jQuery对象，然后调用其对应的方法
						$li.remove();
					}
				}
			}
	}()) 
</script>
</body>
</html>