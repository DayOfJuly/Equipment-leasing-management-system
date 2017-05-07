<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<js:JsTag path="/WebSite/Mobile/js/JsSvc" name="angularjsFilter,Config,sessionIdFactory,unifySvc,SysCodeConfig,SysCodeTranslate" />
<script type="text/javascript">
var app = angular.module('IndexApp',['ngResource','ngRoute','ngMessages','unifyModule','sysCodeConfigModule','sysCodeTranslateModule']);

<!--   注意：当删除浏览器的信息的时候对应的SEESION的信息也会被清空，因为JSP页面从新编译成了对应的Servlet -->
var SYS_USER_INFO={};
SYS_USER_INFO.orgId="${sessionScope.userInfo.orgId}";
SYS_USER_INFO.orgCode="${sessionScope.userInfo.orgCode}";
SYS_USER_INFO.orgName="${sessionScope.userInfo.orgName}";
SYS_USER_INFO.orgParentCode="${sessionScope.userInfo.orgParentCode}";
SYS_USER_INFO.orgLevel="${sessionScope.userInfo.orgLevel}";
SYS_USER_INFO.perPartyId="${sessionScope.userInfo.perPartyId}";
SYS_USER_INFO.loginUserId = "${sessionScope.userInfo.loginUserId}";
SYS_USER_INFO.loginId = "${sessionScope.userInfo.loginId}";
  
var area_ = "";//用于接收地区误删
var area_Demand = '';//接收求租求购的地区信息误删
var equipmentName_ = {}; //接收国才页面的参数
var parm_Classify = '';
var minPrice_ = '';
var maxPrice_ = '';

var publicParms="";   //详细信息变量
 
var InfopubParms = "";  //出租页面表单信息变量

var InfopubSaleParms = ""; // 出售页面表单信息变量 

var selectListParms = ""; //求租页面表单变量

var selectListSaleParms = "";//求购页面表单变量

var updDemandInfoPub = "";

var updDemandInfoPubSale = "" ;

var updInfoPub = "" ;

var updInfopubSale = "";

app.controller('IndexController',function($scope){
	$scope.name = SYS_USER_INFO.orgName;
	$scope.userInfo = SYS_USER_INFO;
	
	$scope.InfopubList={};
	$scope.$on('InfopubList',function(event,data){ //出租
		$scope.InfopubList = data.saveParm;
	
		});
	$scope.InfopubSaleList={};
	$scope.$on('InfopubListSale',function(event,data){ //出售
		$scope.InfopubSaleList = data.saveParm;
	
		});
	$scope.selectList={};
	$scope.$on('selectList',function(event,data){ //求租
		$scope.selectList = data.saveParm;

		});
	$scope.selectListSale={};
	$scope.$on('selectListSale',function(event,data){ //求购
		$scope.selectListSale = data.saveParm;

		});
    //求租求购筛选
	$scope.$on('equ_List',function(event,data){
		$scope.equ_List = data.saveParm;	
		})
	//出租出售筛选
	$scope.Info_List={};
	$scope.$on('Info_List',function(event,data){
	$scope.Info_List = data.saveParm;	
	})
});
	
app.config(['$routeProvider',function($routeProvider){
	

	  $routeProvider.when('/homePage', {  
			templateUrl: '/WebSite/Mobile/General/HomePage/HomePage.jsp',  //首页
			controller:'homePageController'
	 	}).when('/search',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Search.jsp',  //首页跳转搜索页面  
	    	controller:'searchIncludeController'
	 	}).when('/searchs/:parms',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Search.jsp',  //分类-跳转搜索页面  
	    	controller:'searchIncludeController'
	    }).when('/search/:parm_url',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Search.jsp',  //首页跳转搜索页面  
	    	controller:'searchIncludeController'
	    }).when('/search/:parm_url/:gotoParm_',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Search.jsp',  //国才页面跳转搜索页面 
	    	controller:'searchIncludeController'
	    }).when('/searchOfPublic',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/SearchOfPublic.jsp',  //模糊查询搜索页面
	    	controller:'searchOfPublicIncludeController'
	    	 	
	
	    }).when('/viewRentList/:dataType',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewRentList.jsp',  //首页出租筛选列表 
	    	controller:'ViewRentListController'
	    }).when('/viewRentList/:screenList/:dataType/:name',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewRentList.jsp',  //出租筛选列表 
	    	controller:'ViewRentListController'
	    }).when('/viewRentList/:id/:buttonValue',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewRentList.jsp',  //搜索跳转到对应的出租列表
	    	controller:'ViewRentListController'
	    	
	    }).when('/ViewSaleList/:dataType',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewSaleList.jsp',  //首页出售筛选列表 
	    	controller:'ViewSaleListController'
	    }).when('/ViewSaleList/:screenList/:dataType/:name',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewSaleList.jsp',  //出售筛选列表 
	    	controller:'ViewSaleListController'
	    }).when('/ViewSaleList/:id/:buttonValue',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewSaleList.jsp',  //搜索跳转到对应的出租列表
	    	controller:'ViewSaleListController'
	    	
	    }).when('/ViewDemandSaleList/:dataType',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewDemandSaleList.jsp',  //首页求购筛选列表 
	    	controller:'ViewDemandSaleListController'
	    }).when('/ViewDemandSaleList/:screenList/:dataType/:name',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewDemandSaleList.jsp',  //求购筛选列表 
	    	controller:'ViewDemandSaleListController'
	    }).when('/ViewDemandSaleList/:id/:buttonValue',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewDemandSaleList.jsp',  //搜索跳转到对应的出租列表
	    	controller:'ViewDemandSaleListController'
	    	
	    }).when('/ViewDemandRentList/:dataType',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewDemandRentList.jsp',  //首页求租筛选列表 
	    	controller:'ViewDemandRentListController'
	    }).when('/ViewDemandRentList/:screenList/:dataType/:name',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewDemandRentList.jsp',  //求租筛选列表 
	    	controller:'ViewDemandRentListController'
	    }).when('/ViewDemandRentList/:id/:buttonValue',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/ViewDemandRentList.jsp',  //搜索跳转到对应的出租列表
	    	controller:'ViewDemandRentListController'
	    	
	    	
	    	
	    	
	    	
	    }).when('/perCenter',{
	    	templateUrl:'/WebSite/Mobile/General/PerCenter/PerCenter.jsp',  //首页个人中心
	    	controller:'percenterController'
	    }).when('/classify',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Classify.jsp',  //首页分类 
	    	controller:'classifyController'
// 	    }).when('/login',{
// 	    	templateUrl:'/WebSite/Mobile/General/Login/Login.jsp',  //登录 
// 	    	controller:'loginController'
	    }).when('/alreadyPublishedInfor',{
	    	templateUrl:'/WebSite/Mobile/Login/PerCenter/alreadyPublishedInfor.jsp',  //个人中心-我已发布的
	    	controller:'alreadyPubInforController'
	    }).when('/pubDetailInfo/:parm',{
	    	templateUrl:'/WebSite/Mobile/Login/PerCenter/pubDetailInfo.jsp',  //个人中心-我已发布的详情
			controller:'pubDetailController' 		
	    }).when('/publishFrontList',{
	    	templateUrl:'/WebSite/Mobile/Login/PerCenter/publishFrontList.jsp',  //个人中心-我想交易的
			controller:'pubFrontListController'
	    }).when('/pubFrontDetailInfo/:parm',{
	    	templateUrl:'/WebSite/Mobile/Login/PerCenter/publishFrontDetail.jsp',  //个人中心-我想交易的的详情
			controller:'publishFrontDetailController' 
	    }).when('/pencenterScreen/:parm',{
	    	templateUrl:'/WebSite/Mobile/Login/PerCenter/Screen.jsp',  //个人中心-筛选
			controller:'perScreenController'
	    }).when('/alreadyPublishedInfor/:parm',{
	    	templateUrl:'/WebSite/Mobile/Login/PerCenter/alreadyPublishedInfor.jsp',  //筛选-我已发布的
	    	controller:'alreadyPubInforController'
	    }).when('/publishFrontList/:parm',{
	    	templateUrl:'/WebSite/Mobile/Login/PerCenter/publishFrontList.jsp',  //筛选-我想交易的
	    	controller:'pubFrontListController'
	    }).when('/aboutSystem',{
	    	templateUrl:'/WebSite/Mobile/General/PerCenter/AboutSystem.jsp',  //个人中心-关于
			controller:'' 
 	    }).when('/ViewDemandRent/:id/:infoType', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewDemandRentInfo.jsp',  //求租详情-未登录
			controller:'ViewDemandRentController'
	    }).when('/ViewDemandRent/:id/:infoType/:numb', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewDemandRentInfo.jsp',  //首页跳转求租详情-未登录
			controller:'ViewDemandRentController'
	    }).when('/ViewDemandSale/:id/:infotype', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewDemandSaleInfo.jsp',  //求购详情-未登录
			controller:'ViewDemandSaleController'
	    }).when('/ViewDemandSale/:id/:infotype/:numb', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewDemandSaleInfo.jsp',  //首页跳转求购详情-未登录
			controller:'ViewDemandSaleController'
	    }).when('/ViewInfoRent/:id/:infoType', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewInfoRent.jsp',  //出租详情-未登录
			controller:'ViewInfoRentController'
	    }).when('/ViewInfoRent/:id/:infoType/:numb', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewInfoRent.jsp',  //首页跳转出租详情-未登录
			controller:'ViewInfoRentController'
	    }).when('/ViewInfoSale/:id/:infoType', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewInfoSale.jsp',  //出售详情-未登录
			controller:'ViewInfoSaleController'
	    }).when('/ViewInfoSale/:id/:infoType/:numb', {  
			templateUrl: '/WebSite/Mobile/General/QryPublishInfo/ViewInfoSale.jsp',  //首页跳转出售详情-未登录
			controller:'ViewInfoSaleController'
	    }).when('/ViewSale/:id/:infoType', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewInfoSale.jsp',  //出售详情-登录
			controller:'ViewSaleController'
	    }).when('/ViewSale/:id/:infoType/:numb', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewInfoSale.jsp',  //首页跳转出售详情-登录
			controller:'ViewSaleController'
	    }).when('/ViewRent/:id/:infoType', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewInfoRent.jsp',  //出租详情 -登录
			controller:'ViewRentController'
	    }).when('/ViewRent/:id/:infoType/:numb', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewInfoRent.jsp',  //首页跳转出租详情 -登录
			controller:'ViewRentController'
	    }).when('/ViewDemandSaleInfo/:id/:infoType', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewDemandSaleInfo.jsp',  //求购详情 -登录
			controller:'ViewDemandSaleInfoController'
	    }).when('/ViewDemandSaleInfo/:id/:infoType/:numb', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewDemandSaleInfo.jsp',  //首页跳转求购详情 -登录
			controller:'ViewDemandSaleInfoController'
	    }).when('/ViewDemandRentInfo/:id/:infoType', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewDemandRentInfo.jsp',  //求租详情  -登录
			controller:'ViewDemandRentInfoController'
	    }).when('/ViewDemandRentInfo/:id/:infoType/:numb', {  
			templateUrl: '/WebSite/Mobile/Login/QryPublishInfo/ViewDemandRentInfo.jsp',  //首页跳转求租详情  -登录
			controller:'ViewDemandRentInfoController'
	    }).when('/Screen',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Screen.jsp',  //出租出售求租求购-筛选
			 controller:'screenController'
	    }).when('/Scree/:screenList',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Screen.jsp',  //出租出售求租求购-第二次点筛选
			 controller:'screenController'
	    }).when('/Screen/:id/:buttonValue',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Screen.jsp',  //出租出售求租求购-筛选
			controller:'screenController'
				 
		//=========================================================	 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
	    }).when('/ScreenList/:screenList',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Screen.jsp',  //出租出售求租求购-所在城市
			 controller:'screenController'
	    }).when('/ScreenCity/:screenList/:id',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/Screen.jsp',  //出租出售求租求购筛选-所在城市类型
			 controller:'screenController'
	    }).when('/Infopub',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/Infopub.jsp',   //出租发布
			 controller:'infoPubController' 
	    }).when('/Infopubpublish',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/Infopubpublish.jsp', 
			 controller:'infoPublishController' 
	    }).when('/InfopubpublishDetail/:detail',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/InfopubpublishDetail.jsp',  
			 controller:'infoPubDetailController' 
	    }).when('/Infopubdescription/:InfopubId',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/Infopubdescription.jsp',  
			 controller:'InfopubdescriptionController' 
			
	 /*    }).when('/Infopubprovinces',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/provinces.jsp', //省 2016.3.2 15：50 没通用之前
			 controller:'provincesController' 
	    }).when('/InfopubCity/:proRegionId/:provincesName',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/City.jsp',   //市
			 controller:'CityController' 
	    }).when('/Infopubdistrict/:cityRegionId/:cityName/:pId/:pName',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/district.jsp',  //区 
			 controller:'districtController'  */
			 
	     }).when('/Infopubprovinces/:parm_',{ 
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Area/provinces.jsp', //省不传1.2.3.4的所在城市出租到求购四种皆用(原出租出售去掉1.2.3.4)
			 controller:'provincesController'  
	     }).when('/Infopubprovinces/:obj_/:parm_/',{ 
		    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Area/provinces.jsp', //省求租求购
				 controller:'provincesController'
	    }).when('/Infopubprovinces/:obj_/:parm_/:formParms_',{ 
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Area/provinces.jsp', //省求租求购（有当前值）
			 controller:'provincesController'
	    }).when('/InfopubCity/:proRegionId/:provincesName/:parms_url/:obj_type',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Area/City.jsp',   //市(有1.2.3.4)
			 controller:'CityController' 
	    }).when('/InfopubCity/:proRegionId/:provincesName/:parms_url',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Area/City.jsp',   //市(无1.2.3.4)
			 controller:'CityController' 
	    }).when('/Infopubdistrict/:cityRegionId/:cityName/:pId/:pName/:obj_type/:parms_url',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Area/district.jsp',  //区 (有1.2.3.4)
			 controller:'districtController' 
	    }).when('/Infopubdistrict/:cityRegionId/:cityName/:pId/:pName/:parms_url',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Area/district.jsp',  //区 (无1.2.3.4)
			 controller:'districtController' 
			 
				 	
	    }).when('/DemandInfoPubSale',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPubSale/DemandInfoPubSale.jsp', //求购 
			 controller:'DemandInfoPubSaleController' 
	    }).when('/DemandInfoPubSale/:goBakeParm',{                                           //求购发布(与全国与否)
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPubSale/DemandInfoPubSale.jsp',  
			controller:'DemandInfoPubSaleController'
			
	 
			 
	    }).when('/DemandInfoPub',{                                                        //求租发布
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/DemandInfoPub.jsp',  
			controller:'DemandInfoPubController'
	    }).when('/DemandInfoPub/:goBakeParm',{                                           //求租发布(与全国与否)
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/DemandInfoPub.jsp',  
			controller:'DemandInfoPubController'
			
			
	    }).when('/Screeningequipment',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/Screeningequipment.jsp',  
			 controller:'InfopubScreeningequipmentController' 	
	    }).when('/DemandInfoPubdescription/:description/:InfopubId',{                                                        //求租发布
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/Infopubdescription.jsp',  
	    	controller:'InfopubdescriptionController'
	    }).when('/DemandInfoPubprovinces',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/provinces.jsp', 
			/* controller:'EnterpriseController' */
	    }).when('/DemandInfoPubCity',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/City.jsp', 
			/* controller:'EnterpriseController' */
	    }).when('/DemandInfoPubdistrict',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/district.jsp', 
			/* controller:'EnterpriseController' */
	    }).when('/DemandInfopublish',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/DemandInfopublish.jsp',  
			 controller:'DemandInfoPublishController' 
	    }).when('/DemandInfopubScreeningequipment',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/DemandInfopubScreeningequipment.jsp',  
			 controller:'DemandInfoPubScreeningController' 
	    }).when('/DemandInfopubEquipmentlocation',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPub/Equipmentlocation.jsp',  
			/* controller:'EnterpriseController' */
	    }).when('/DemandInfopubSalelish',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPubSale/DemandInfopubSalelish.jsp',  
			 controller:'DemandInfopubSalelishController' 
	    }).when('/DemandInfopubSaleScreening',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/DemandInfoPubSale/DemandInfopubSaleScreening.jsp',  
			 controller:'DemandInfoPubSaleScreeningController' 
	    }).when('/InfopubSale',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/InfopubSale/InfopubSale.jsp',  
			 controller:'infoPubSaleController' 
	    }).when('/InfopubSalepublish',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/InfopubSale/InfopubSalepublish.jsp', 
			 controller:'InfopubSalelishController' 
	    }).when('/InfopubSalepublishDetail/:detail',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/InfopubSale/InfopubpublishSaleDetail.jsp',  
			 controller:'InfopubSaleDetailController' 
	    }).when('/InfopubSaledescription/:InfopubId',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/Infopub/Infopubdescription.jsp',  
			 controller:'InfopubdescriptionController' 
	    }).when('/InfopubSaleScreeningequipment',{
	    	templateUrl:'/WebSite/Mobile/Login/PublishInfo/InfopubSale/Screeningequipment.jsp',  
			 controller:'InfopubSaleScreeningequipmentController' 
	    }).when('/',{
	    	templateUrl:'/WebSite/Mobile/General/HomePage/HomePage.jsp',  //默认首页
			controller:'homePageController'
	    }); 
	}]);  
</script>
<script type="text/javascript" src="General/HomePage/js/homePage.js"></script><!-- 首页 -->

<!-- <script type="text/javascript" src="./Login/PublishInfo/Infopub/js/City.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/district.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/provinces.js"></script> 
<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/provinces.js"></script> 2016.3.2 15：50 没通用之前 -->

<script type="text/javascript" src="./Login/PublishInfo/Area/js/City.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/Area/js/district.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/Area/js/provinces.js"></script>

<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/Infopub.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/Infopubpublish.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/InfopubpublishDetail.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/Infopubdescription.js"></script> 
<script type="text/javascript" src="./Login/PublishInfo/Infopub/js/Screeningequipment.js"></script> 
<script type="text/javascript" src="./Login/PublishInfo/InfopubSale/js/InfopubSale.js"></script>


<script type="text/javascript" src="General/HomePage/js/viewRentList.js"></script><!-- 出租列表-->
<script type="text/javascript" src="General/HomePage/js/viewSaleList.js"></script><!-- 出售列表-->
<script type="text/javascript" src="General/HomePage/js/viewDemandSaleList.js"></script><!--求购列表-->
<script type="text/javascript" src="General/HomePage/js/viewDemandRentList.js"></script><!-- 求租列表-->
<script type="text/javascript" src="General/HomePage/js/screen.js"></script><!-- 筛选-->
<script type="text/javascript" src="General/QryPublishInfo/js/ViewInfoRent.js"></script><!--出租详情-未登录-->
<script type="text/javascript" src="General/QryPublishInfo/js/ViewInfoSale.js"></script><!--出售详情-未登录-->
<script type="text/javascript" src="General/QryPublishInfo/js/ViewDemandSaleInfo.js"></script><!--求购详情-未登录-->
<script type="text/javascript" src="General/QryPublishInfo/js/ViewDemandRentInfo.js"></script><!--求租详情-未登录-->
<script type="text/javascript" src="./Login/PublishInfo/InfopubSale/js/InfopubSalepublish.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/InfopubSale/js/InfopubSalepublishDetail.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/InfopubSale/js/InfopubSaleScreeningequipment.js"></script>

<script type="text/javascript" src="Login/PublishInfo/InfopubSale/js/InfopubSaleScreeningequipment.js"></script>
<script type="text/javascript" src="Login/QryPublishInfo/js/ViewSale.js"></script><!--出售详情-登录-->
<script type="text/javascript" src="Login/QryPublishInfo/js/ViewRent.js"></script><!--出租详情-登录-->
<script type="text/javascript" src="Login/QryPublishInfo/js/ViewDemandRent.js"></script><!--求租详情-登录-->
<script type="text/javascript" src="Login/QryPublishInfo/js/ViewDemandSale.js"></script><!--求购详情-登录-->

<script type="text/javascript" src="./Login/PublishInfo/DemandInfoPub/js/DemandInfoPub.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/DemandInfoPub/js/DemandInfopublish.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/DemandInfoPub/js/DemandInfopubScreeningequipment.js"></script>
<script type="text/javascript" src="./Login/PublishInfo/DemandInfoPubSale/js/DemandInfoPubSale.js"></script><%--求购js--%>
<script type="text/javascript" src="./Login/PublishInfo/DemandInfoPubSale/js/DemandInfopubSalelish.js"></script><%--求购js--%>
<script type="text/javascript" src="./Login/PublishInfo/DemandInfoPubSale/js/DemandInfopubSaleScreening.js"></script><%--求购js--%>


<script type="text/javascript" src="/WebSite/Mobile/General/HomePage/js/classify.js"></script><!-- 首页-分类 -->
<script type="text/javascript" src="/WebSite/Mobile/General/PerCenter/js/perCenter.js"></script><!-- 个人中心 -->
<script type="text/javascript" src="/WebSite/Mobile/Login/PerCenter/js/alreadyPublishedInfor.js"></script><!-- 个人中心-我已发布 -->
<script type="text/javascript" src="/WebSite/Mobile/Login/PerCenter/js/pubDetailInfo.js"></script><!-- 个人中心-我已发布详情 -->
<script type="text/javascript" src="/WebSite/Mobile/Login/PerCenter/js/publishFrontList.js"></script><!-- 个人中心-我想交易的-->
<script type="text/javascript" src="/WebSite/Mobile/Login/PerCenter/js/publishFrontDetail.js"></script><!-- 个人中心-我想交易的详情-->
<script type="text/javascript" src="/WebSite/Mobile/Login/PerCenter/js/screen.js"></script><!-- 个人中心-筛选-->


<script type="text/javascript" src="/WebSite/Mobile/General/HomePage/js/search.js"></script><!-- yy -->
<script type="text/javascript" src="/WebSite/Mobile/General/HomePage/js/searchOfPublic.js"></script><!-- yy -->
<script type="text/javascript" src="/WebSite/Mobile/General/HomePage/js/myArray.js"></script>
