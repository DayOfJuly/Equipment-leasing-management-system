<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
/*********************************************************************************************************************************************************************************************************/
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
/* $(document).ready(function(){	 */

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
							    	window.location.href="./index.jsp";
							     }, 
							     error : function(xhr,error,exception) {
							    	/* console.info("xhr is : ",xhr," error is : ",error," exception is : ",exception); */
				        			$.messager.alert(xhr.responseText);
								    window.location.href="./index.jsp";
							     }  
							}); 
		 };
		 $("#logoutBtnId").click(logoutFun);
		 
/* 	}); */

</script>


<nav   class="navbar navbar-default " role="navigation" >

    <div class="navbar-header container" >              <!-- data-toggle="tooltip" title的样式 -->
  <!--     <a class="navbar-brand " href="../../../WebSite/Front/Main/HomePage.jsp" data-toggle="tooltip" data-placement="bottom" title="返回首页">
      	<span class="glyphicon glyphicon-circle-arrow-left"></span>
      	后台管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      </a> -->
   
   
      <ul class="nav navbar-nav "><!-- 整个导航栏 -->
      
		<li>
			<a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Audit/homePage.jsp#auditQueryList');">审核查询</a>
		</li>
		
		<li>
			<a href="javascript:void(0);" onclick="clickA(this,'/WebSite/Audit/homePage.jsp#messageAuditList');">信息审核</a>
		</li>

      </ul>
               <p  class=" navbar-right" style="margin-right:50px;margin-top:15px;">您好，<span id="spanId">${sessionScope.userInfo.loginId}</span>&nbsp;&nbsp;|&nbsp;&nbsp;<button id="logoutBtnId"  class="btn btn-link" style="color:blue">退出</button></p>
     </div>
</nav>


			
			
	 
	