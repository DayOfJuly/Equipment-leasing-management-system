<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	
    .dropdown-submenu {
        position: relative;
    }
    .dropdown-submenu > .dropdown-menu {
        top: 0;
        left: 100%;
        margin-top: -6px;
        margin-left: -1px;
        -webkit-border-radius: 0 6px 6px 6px;
        -moz-border-radius: 0 6px 6px;
        border-radius: 0 6px 6px 6px;
    }
    .dropdown-submenu:hover > .dropdown-menu {
        display: block;
    }
    .dropdown-submenu > a:after {
        display: block;
        content: " ";
        float: right;
        width: 0;
        height: 0;
        border-color: transparent;
        border-style: solid;
        border-width: 5px 0 5px 5px;
        border-left-color: #ccc;
        margin-top: 5px;
        margin-right: -10px;
    }
    .dropdown-submenu:hover > a:after {
        border-left-color: #fff;
    }
    .dropdown-submenu.pull-left {
        float: none;
    }
    .dropdown-submenu.pull-left > .dropdown-menu {
        left: -100%;
        margin-left: 10px;
        -webkit-border-radius: 6px 0 6px 6px;
        -moz-border-radius: 6px 0 6px 6px;
        border-radius: 6px 0 6px 6px;
    }
    .dropdown-submenu1 {
        position: relative;
        float: left;
    }
	.dropdown-submenu1:hover > .dropdown-menu {
        display: block; /* 鼠标移到下拉标题自动展开 */
    }
    
    .line-hr{
    	color:"#999999";
    	width:150px;
    	margin:0px;
    }
    
    @media ( min-width :0px) {
	.navbar-nav {
		float: left;
		margin: 0
	}
	.navbar-nav>li {
		float: left
	}
	.navbar-nav>li>a {
		padding-top: 15px;
		padding-bottom: 15px
	}
	.navbar-nav.navbar-right:last-child {
		margin-right: -15px
	}
}
@media ( min-width :768px) {
	.navbar>.container .navbar-brand,.navbar>.container-fluid .navbar-brand
		{
		margin-left: 0px;
	}
}
 
</style>
<script type="text/javascript">

	$(function () { $("[data-toggle='tooltip']").tooltip(); });
	//点击更新页面
	function clickA(varl,varl1){
		$($(varl).attr("href",varl1+"?param="+Math.random()));
		return true;
	};
	
	$("button").focus(function(){this.blur();});
	
	/*
	注销用户的方法
	*/
	 var logoutFun =function ()
		 {
            $.ajax( {  
			    url:'http://localhost:8080/Sys/User',  
			    data:{Action:"Logout"},  
			    type:'get',  
			    cache:false,  
			    dataType:'text',  
			    success:function(data) {
    				$.messager.alert("注销陈功！");
    				window.location.href="../Front/Login/Login.jsp";
// 			    	window.location.href="http://122.113.40.170:8090/CAS/logout?client_id=http://124.205.89.215:8086/WebSite/Front/Main/HomePage.jsp&amp;service=http://122.113.40.170:9080/luban-ids/logout";
			     }, 
			     error : function(xhr,error,exception) {
     			$.messager.alert(xhr.responseText);
				    window.location.href="../Front/Login/Login.jsp";
			     }  
			}); 
		 };
	
	 /*当鼠标浮动到菜单上时，让所有控件失去焦点*/
	 var blurAll = function(){
		 $('#blurInputId').focus();
		 $('#blurInputId').blur();
	 };
</script>

<nav  class="navbar navbar-default " role="navigation" style="width:111%;">
	<!-- 当鼠标浮动到菜单上时，让所有控件失去焦点，临时隐藏域 -->
	<input type="text" id="blurInputId" style="width:0px;height:0px;border:0px;">
    <div class="navbar-header container" >              <!-- data-toggle="tooltip" title的样式 -->
      <a class="navbar-brand " href="../../../WebSite/Front/Main/HomePage.jsp" data-toggle="tooltip" data-placement="bottom" title="返回到前台首页">
      	<span class="glyphicon glyphicon-circle-arrow-left"></span>
      	返回到前台首页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      </a>
      <ul id="ROOT_MENU" class="nav navbar-nav " onmouseover="blurAll();"><!-- 整个导航栏 -->
      
	 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
			<c:if test="${fun.funName=='#equipmentList'}">
				<li class=""><a href="/WebSite/Back/index.jsp#equipmentList">资源管理</a></li>
			</c:if>
	    </c:forEach>	    
	    
		<li class="dropdown-submenu1 ">
			<a href="javascript:void();" class="dropdown-toggle" data-toggle="dropdown">信息登记<b class="caret"></b></a>
			<ul class="dropdown-toggle nav navbar-nav dropdown-menu">
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#depreciationCostList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#depreciationCostList');">折旧费登记</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			    <c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#deviceHaveList'}">
		   			 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#deviceHaveList');">租赁费登记-出租方</a></li>
		   			 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#deviceUsageQuestionnaireCheckInList'}">
		   			 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#deviceUsageQuestionnaireCheckInList');">租赁费登记-承租方</a></li>
<!-- 		   			 	<li><hr class="line-hr"></li> -->
					</c:if>
			    </c:forEach>
<%-- 			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}"> --%>
<%-- 					<c:if test="${fun.funName=='#rentCheckInList'}"> --%>
<!-- 	 	  			 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#rentCheckInList');">发布结果登记</a></li> -->
<%-- 					</c:if> --%>
<%-- 			    </c:forEach> --%>
			</ul>
		</li>	      

		<li class="dropdown-submenu1 ">
			<a href="javascript:void();" class="dropdown-toggle" data-toggle="dropdown">统计查询<b class="caret"></b></a>
			<ul class="dropdown-toggle nav navbar-nav dropdown-menu">
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#resourceSumList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#resourceAggregate');">资源汇总</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>	
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#resourceDetailedList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#resourceDetail');">资源明细</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#rentSaleSumList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#tenancyAggregate');">租赁汇总</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>	
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#rentSaleDetailedList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#tenancyDetail');">租赁明细</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#releasedSumList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#messageAggregate');">信息发布汇总</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>	
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#releasedDetailedList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#messageDetail');">信息发布明细</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>			    			    
			</ul>                                                         
		</li>	 

		<li class="dropdown-submenu1 ">
			<a href="javascript:void();" class="dropdown-toggle" data-toggle="dropdown">基础管理<b class="caret"></b></a>
			<ul class="dropdown-toggle nav navbar-nav dropdown-menu">
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#categoryManage'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#categoryManage');">分类设备维护</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>	
			    
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#manufactureList'}">
		   			 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#manufactureList');">生产厂家维护</a></li>
		   			 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach> 			    
			    
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#brandList'}">
		   			 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#brandList');">品牌维护</a></li>
		   			 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>			    
			    
			 <c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#parameterList'}">
		   			 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#parameterList');">设备参数维护</a></li>
					</c:if>
			    </c:forEach>		  
			</ul>                                                         
		</li>	    	
      
		<li class="dropdown-submenu1 ">
			<a href="javascript:void();" class="dropdown-toggle" data-toggle="dropdown">系统管理<b class="caret"></b></a>
			<ul class="dropdown-toggle nav navbar-nav dropdown-menu">
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#enterPriseSet'}">
					 	<li><a  href="/WebSite/Back/index.jsp#enterPriseSet">企业设置</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#projectList'}">
					 	<li><a  href="/WebSite/Back/index.jsp#projectList">项目设置</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#employeeInformationMaintain'}">
			 	       <li><a href="/WebSite/Back/index.jsp#employeeInformationMaintain">内部员工信息维护</a></li>
			 	       <li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>		
			    <c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outEmployeeInformationMaintain'}">
			 	       <li><a href="/WebSite/Back/index.jsp#outEmployeeInformationMaintain">外部管理员信息维护</a></li>
					</c:if>
			    </c:forEach>		    			    			 	
			</ul>
		</li>
		
<!-- 		<li class="dropdown-submenu1 "> -->
<!-- 			<a href="javascript:void();" class="dropdown-toggle" data-toggle="dropdown">统计报表<b class="caret"></b></a> -->
<!-- 			<ul class="dropdown-toggle nav navbar-nav dropdown-menu"> -->
<!-- 			 	<li><a  href="/WebSite/Back/index.jsp#resourceAggregate">资源汇总</a></li> -->
<!-- 			 	<li><hr class="line-hr"></li> -->
<!-- 				<li><a  href="/WebSite/Back/index.jsp#resourceDetail">资源明细</a></li> -->
<!-- 				<li><hr class="line-hr"></li> -->
<!-- 		 	    <li><a href="/WebSite/Back/index.jsp#tenancyAggregate">租赁汇总</a></li> -->
<!-- 		 	    <li><hr class="line-hr"></li> -->
<!-- 		 	    <li><a href="/WebSite/Back/index.jsp#tenancyDetail">租赁明细</a></li>     -->
<!-- 		 	    <li><hr class="line-hr"></li> -->
<!-- 		 	    <li><a href="/WebSite/Back/index.jsp#messageAggregate">信息发布汇总</a></li>     -->
<!-- 		 	    <li><hr class="line-hr"></li>	 -->
<!-- 		 	    <li><a href="/WebSite/Back/index.jsp#messageDetail">信息发布明细</a></li>    			 	 -->
<!-- 			</ul> -->
<!-- 		</li> -->



		<li class="dropdown-submenu1">
		  	<a href="javascript:void();" class="dropdown-toggle" data-toggle="dropdssown">外部企业用户<b class="caret"></b></a>
		  	<ul class="dropdown-toggle nav navbar-nav  dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outEquipmentList'}">
				  	    <li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#outEquipmentList');">资源管理</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outRelationWay'}">
		   			 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#outRelationWay');">联系方式维护</a></li>
		   			 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outDepreciationCostList'}">
			  				<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#outDepreciationCostList');">折旧费登记</a></li>
			  				<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outRentCheckInList'}">
			  				<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#outRentCheckInList');">租赁费登记-出租方</a></li>
			  				<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			    <c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outUserRentCheckInList'}">
			  				<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#outUserRentCheckInList');">租赁费登记-承租方</a></li>
			  				<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
<%-- 			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}"> --%>
<%-- 					<c:if test="${fun.funName=='#outDeviceUsageQuestionnaireCheckInList'}"> --%>
<!-- 			  				<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#outDeviceUsageQuestionnaireCheckInList');">发布结果登记</a></li> -->
<%-- 					</c:if> --%>
<%-- 			    </c:forEach> --%>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outEmployeeList'}"> 
			  				<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#outEmployeeMaintain');">外部员信息工维护</a></li>
					</c:if>
			    </c:forEach>
			</ul>
		</li>
		
	    <li class="dropdown-submenu1 ">
			<a href="javascript:void();" class="dropdown-toggle" data-toggle="dropdown">统计查询<b class="caret"></b></a>
			<ul class="dropdown-toggle nav navbar-nav dropdown-menu">
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outResourceSumList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#resourceAggregate');">资源汇总</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>	
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outResourceDetailedList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#resourceDetail');">资源明细</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outRentSaleSumList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#tenancyAggregate');">租赁汇总</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>	
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outRentSaleDetailedList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#tenancyDetail');">租赁明细</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outReleasedSumList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#messageAggregate');">信息发布汇总</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>	
			 	<c:forEach var="fun" items="${sessionScope.userInfo.funs}">
					<c:if test="${fun.funName=='#outReleasedDetailedList'}">
					 	<li><a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Back/index.jsp#messageDetail');">信息发布明细</a></li>
					 	<li><hr class="line-hr"></li>
					</c:if>
			    </c:forEach>			    			    
			</ul>                                                         
		</li>	 
		
		
		<li style="margin-left: 100px;">
			<a href="javascript:void();"   id="time"></a>
		</li>
		<li style="margin-left: -20px;">
           <a href="javascript:void();"   id="bjtime"></a>
		</li>
      </ul >
      
      
      <span class=" navbar-right" style="margin-right:205px;margin-top:15px;">您好，<span id="spanId">${sessionScope.userInfo.loginId}</span>&nbsp;&nbsp;|&nbsp;&nbsp;<button id="logoutBtnId" onClick="logoutFun();" class="btn btn-link" style="color:blue">退出</button></span>
     
     <%--  <p   class=" navbar-right" style="margin-right:250px;margin-top:15px;">您好，<span id="spanId">${sessionScope.userInfo.loginId}</span>&nbsp;&nbsp;|&nbsp;&nbsp;
       <a id="logoutBtnId" href="http://122.113.40.170:8090/CAS/logout?client_id=http://192.168.0.192:8080/WebSite/Front/Main/HomePage.jsp&amp;service=http://122.113.40.170:9080/luban-ids/logout" 
       class="btn btn-link" style="color:blue">退出</a></p> --%>
 
 </div>
     
     <script type="text/javascript">
     
/*       function timeShow(){
         var years,months,dates,hours,minutes,seconds,weeks;
         
         var intYears,intMonths,intDates,intHours,intMinutes,intSeconds,intWeeks;
         
         var today;
         
         var timeString;
         
         today = new Date();//获得系统当前时间
         
         intYears = today.getFullYear();//获得年
         intMonths = today.getMonth() + 1;//获得月份+1
         intDates = today.getDate();//获得天数
         intHours = today.getHours();//获得小时
         intMinutes = today.getMinutes();//获得分钟
         intSeconds = today.getSeconds();//获得秒
         intWeeks = today.getDay();//获得星期
         
         years = intYears + '年     ';
         
         if(intMonths < 10){
        	 months = '0' + intMonths + '月';
         }else{
        	 months = intMonths + '月';
         }
         
         if(intDates < 10){
        	 dates = '0' + intDates + '日     ';
         }else{
        	 dates = intDates + '日     ';
         }
         
         var weekArray = new Array(7);
         
         weekArray[0] = '星期日';
         weekArray[1] = '星期一';
         weekArray[2] = '星期二';
         weekArray[3] = '星期三';
         weekArray[4] = '星期四';
         weekArray[5] = '星期五';
         weekArray[6] = '星期六';
         
         weeks =weekArray[intWeeks] + ' ';
             
         if(intHours == 0){
        	 hours = '00:';
         }else if(intHours < 10){
        	 hours = '0' + intHours + ':';
         }else{
        	 hours = intHours + ":";
         }
         
         if(intMinutes == 0){
        	 minutes = '00';
         }else if(intMinutes < 10){
        	 minutes = '0' + intMinutes ;
         }else{
        	 minutes = intMinutes;
         }
         
         timeString = years + months + dates + weeks + hours + minutes
         
         
         $("#time").text(timeString);
         window.setInterval('timeShow()',60000);
      } */
      
      
    /*
      进入页面加载的方法
    */
    window.onload=function()
    {
  	     var date=new Date(),time=date.getTime();
	     setInterval(function() {set(time);time = Number(time);time += 1000;},1000);
	     setTodayDate(date);
    }
      
      /*
       设置日期的方法，针对年月日星期的显示
      */
      function setTodayDate(today)
      {
          var years,months,dates,weeks, intYears,intMonths,intDates,intWeeks,today,timeString;
          
          /* today = new Date();//获得系统当前时间 */
          
          intYears = today.getFullYear();//获得年
          intMonths = today.getMonth() + 1;//获得月份+1
          intDates = today.getDate();//获得天数
          intWeeks = today.getDay();//获得星期
          
          years = intYears + '年     ';
          
          if(intMonths < 10){
         	 months = '0' + intMonths + '月';
          }else{
         	 months = intMonths + '月';
          }
          
          if(intDates < 10){
         	 dates = '0' + intDates + '日     ';
          }else{
         	 dates = intDates + '日     ';
          }
          
          var weekArray = new Array(7);
          
          weekArray[0] = '星期日';
          weekArray[1] = '星期一';
          weekArray[2] = '星期二';
          weekArray[3] = '星期三';
          weekArray[4] = '星期四';
          weekArray[5] = '星期五';
          weekArray[6] = '星期六';
          
          weeks =weekArray[intWeeks] + ' ';

          timeString = years + months + dates + weeks;
          
          $("#time").text(timeString);
          
       }

     /*
       设置北京时间的方法，针对时分秒的显示
     */
     function set(time)
     {
	     var beijingTimeZone = 8;
	     var timeOffset = ((-1 * (new Date()).getTimezoneOffset()) - (beijingTimeZone * 60)) * 60000;
	     var now = new Date(time - timeOffset);
	     document.getElementById('bjtime').innerHTML = p(now.getHours())+':'+p(now.getMinutes())+':'+p(now.getSeconds());
     }
     
     /*
       格式化时间的显示方式
     */
     function p(s) 
     {
        return s < 10 ? '0' + s : s;
     }

     </script>
</nav>