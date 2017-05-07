<%@ page  contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" import="java.util.Map,java.util.HashMap"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>	

<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
	    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>设备租赁审核系统用户登录</title>
		<link href="../../media/css/login.css" rel="stylesheet">
        <jsp:include page="../Front/Include/Head.jsp"/> 
	    <script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
		<script type="text/javascript" src="../../js/JsSvc/unifySvcAudit.js"></script>
		<script type="text/javascript" src="../../media/js/pagination.js"></script>
	   <script type="text/javascript">
	   var app = angular.module('sysUserApp',['ngResource','unifyModuleAudit','myPagination','ngMessages']);
	   app.controller('sysUserController',function($scope,sysUserSvc){
		   
		   /* 截取url方法 */
		   $scope.getUrlParm=function(url)
			  {				
				    var theRequest = new Object();
		            if (url!=null && url.indexOf("?") != -1)/* 如果有？ */
		            {
		                var str = url.substr(1);/* 去掉？ */
		                strs = str.split("&");/* 把参数打碎成数组形式 */
		                for (var i = 0; i < strs.length; i++)
		                {
		                    theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);/* 把所有参数赋值给这个数组    {flag: "rentSale"} 去掉了=*/
		                }
		            }
		            return theRequest;
		      };
		   
		   
		   
		   
		    /* 验证用户名密码加跳转页面方法 */
			$scope.login = function(obj){
				var url = location.search;/* 获取？后面的参数 */
				if(url){
					var data_=$scope.getUrlParm(url);/* 调用上面的方法得到所有有关参数的数组 */
				}
				var flag=null;/* 初始化条件标志 */
				if(data_)
				{
					flag=data_.flag;/* 给标志赋值 */
				}
				 if (!obj.$valid) {
					 if(!obj.userName.$valid){
						 $scope.showFlag = "userName";
						 return;
					 }
					 if(!obj.password.$valid){
						 $scope.showFlag = "password";
						 return;
					 }
				 }
				 function success(rec){
					 if(rec.state==1){
						 $.messager.popup("您无权限登录到此管理系统，请与系统管理员联系");
						 $scope.sysUser.userName = null;
						 $scope.sysUser.password = null;
						 $scope.showFlag = null;
						 $("#userName").focus();
						 return;
					 }
					 if(rec.loginId!=null){
						 if(flag=="rent"||flag=="Sale"){/* 根据标志判断跳转哪个页面 */
							 window.location.href="../../Front/Main/HomePage.jsp";/* 原页面展示主页 */
							 window.open("../../Front/Publish/Infopub.jsp","_blank");/* 新打开一个页面用于跳转出租出售 */
							 return;
						 }
						 
						 if(flag=="demandRent"||flag=="demandSale"){
							 window.location.href="../../Front/Main/HomePage.jsp";/* 原页面展示主页 */
							 window.open("../../Front/Publish/DemandInfoPub.jsp","_blank");/* 新打开一个页面用于跳转求租求购 */
							 return;
						 }
						 //window.location.href="/WebSite/Back/Equipment/EquipmentList.jsp";
						 window.location.href="./homePage.jsp";
					 }else{
						 $.messager.popup("用户名或密码错误，请新输入！！");
						 $scope.sysUser.userName = null;
						 $scope.sysUser.password = null;
						 $scope.showFlag = null;
						 $("#userName").focus();
					 }
				 }
				 
				 function error(rec){
					$.messager.popup(rec.data.message);
				 }
			     sysUserSvc.loginUser({userName:$scope.sysUser.userName,password:$scope.sysUser.password,Action:'Login',isAudit:'TRUE'},success,error);
				 
			};
			
		    /**
		     * 键盘事件
		     */
		     $('html').bind('keyup', function(e)
		    {
    	          //当按下回车的时候
    			  if(e.keyCode == 13)
    			  {
    				  $("#purId").click();
    			  }
		    }); 
	    });
		</script>
		
		<style type="text/css">
         #aId {
			text-decoration: none;
		}
		 #aId {
			text-decoration: none;
		}
		 #aId {
			text-decoration: none;
		}
		 #aId {
			text-decoration: none;
		}
        </style>
	</head>
	
	<body ng-app="sysUserApp" ng-controller="sysUserController"   style="background-color: rgba(46, 114, 181, 1);">
			<div class="content" >
					<div class="logo_info">
						<img alt="ChuXuanArt" src="../../../media/images/apple-touch-icon-57-precomposed.png" class="logo"><span class="logo_font"><a id="aId" href="#"  style="color:white">设备租赁审核系统</a></span>
					</div>
					<div class="contentMidel">
						<div class="cont_left"></div> 
						<div class="cont_right">
							<div class="inputs">
								<div class="col-xs-12 column">
								<form class="form-horizontal" role="form" novalidate  name="LoginForm">
								
										<div class="form-group">
											 <label class="col-xs-3 control-label">登录名：</label>
											 <div class="col-xs-7">
												<input id="userName" class="form-control" name="userName" type="text" required ng-model="sysUser.userName"/>
											 </div>
											 <div class="col-xs-3" style="margin-left:40px;margin-top:-35px;" ng-messages="LoginForm.userName.$error" ng-show="showFlag == 'userName'">
						                        <p class="form-control-static" style="color:red;" ng-message="required"> 请输入用户名</p> 
						                     </div>
										</div>
										
										 <div class="form-group">
											 <label class="col-xs-3 control-label" for="inputPassword3">密码：</label>
											 <div class="col-xs-7">
												<input id="inputPassword3" class="form-control" name="password" type="password" required ng-model="sysUser.password" />
											</div>
											<div class="col-xs-3" style="margin-left:40px;margin-top:-35px;" ng-messages="LoginForm.password.$error" ng-show="showFlag == 'password'">
						                        <p class="form-control-static" style="color:red;" ng-message="required"> 请输入密码</p> 
						                     </div>
										</div> 
										
							<!-- 			<div class="form-group">
											   <div class="col-xs-offset-4 col-xs-8">
												<div class="col-xs-12">
													 <div style="margin-left:-50px;">
													      <input type="checkbox" />
													 </div>
													 <label class="col-xs-7" style="margin-top:-33px;margin-left:-30px;">Remember Me</label>
												</div>
											</div>
										</div>  -->
										
										</form>
								</div>
							</div>
							<div class="log_button">
								<div class="form-group">
									<div class="col-xs-offset-9 col-xs-3">
										 <input class="btn btn-primary" id="purId" type="button" style="margin-top:-1230%" ng-click="login(LoginForm);" value="登录"/>
									</div>
								</div>
							</div>
						</div>
					</div>
				<div class="footer">2015 © 中国中铁股份有限公司</div>
			</div>
	</body>
</html>
