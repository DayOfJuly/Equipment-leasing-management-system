<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<js:JsTag path="/js/JsSvc/" name="angularjsFilter,Config,sessionIdFactory,unifySvcAudit,SysCodeConfig,SysCodeTranslate" />
<js:JsTag path="/media/js/" name="tm.pagination" /><!-- ,emailstylejs -->
<script type="text/javascript">
var app = angular.module('IndexApp',['ngResource','ngRoute','unifyModuleAudit','angularFileUpload','ngMessages','tm.pagination','sysCodeConfigModule','sysCodeTranslateModule']);

app.controller('IndexController',function($scope){});
	
app.config(['$routeProvider',function($routeProvider){
	  $routeProvider.when('/auditQueryList', { 
			templateUrl: '/WebSite/Audit/auditQuery/auditQueryList.jsp',  //审核查询
			controller:'auditQueryListController'
	    }).when('/messageAuditList', {  
			templateUrl: '/WebSite/Audit/messageAudit/messageAuditList.jsp',//信息审核
			controller:'messageAuditListController'
	    }).when('/',{
	    	templateUrl:'/WebSite/Audit/auditQuery/auditQueryList.jsp',  //审核查询
			controller:'auditQueryListController'
	    });	
	}]);  
</script>
<script type="text/javascript" src="./auditQuery/auditQuery.js"></script>
<script type="text/javascript" src="./messageAudit/messageAudit.js"></script>






