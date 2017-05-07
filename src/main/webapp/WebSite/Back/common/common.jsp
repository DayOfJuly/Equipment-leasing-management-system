<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<js:JsTag path="/js/JsSvc" name="angularjsFilter,Config,sessionIdFactory,unifySvc,SysCodeConfig,SysCodeTranslate" />
<js:JsTag path="/media/js" name="tm.pagination" />


<script type="text/javascript">
var app = angular.module('IndexApp',['ngResource','ngRoute','unifyModule','angularFileUpload','ngMessages','tm.pagination','sysCodeConfigModule','sysCodeTranslateModule']);

<!--   注意：当删除浏览器的信息的时候对应的SEESION的信息也会被清空，因为JSP页面从新编译成了对应的Servlet -->
var SYS_USER_INFO={};
SYS_USER_INFO.orgParTypeId="${sessionScope.userInfo.orgParTypeId}";
SYS_USER_INFO.orgId="${sessionScope.userInfo.orgId}";
SYS_USER_INFO.orgCode="${sessionScope.userInfo.orgCode}";
SYS_USER_INFO.orgName="${sessionScope.userInfo.orgName}";
SYS_USER_INFO.orgParentCode="${sessionScope.userInfo.orgParentCode}";
SYS_USER_INFO.orgLevel="${sessionScope.userInfo.orgLevel}";
SYS_USER_INFO.perPartyId="${sessionScope.userInfo.perPartyId}";
SYS_USER_INFO.proId="${sessionScope.userInfo.proId}";
SYS_USER_INFO.proName="${sessionScope.userInfo.proName}";
SYS_USER_INFO.proAtProvince = "${sessionScope.userInfo.proAtProvinceName}";
SYS_USER_INFO.proAtProvinceId = "${sessionScope.userInfo.proAtProvince}";
SYS_USER_INFO.proAtCity = "${sessionScope.userInfo.proAtCityName}";
SYS_USER_INFO.proAtCityId = "${sessionScope.userInfo.proAtCity}";
SYS_USER_INFO.proAtDistrict = "${sessionScope.userInfo.proAtDistrictName}";
SYS_USER_INFO.proAtDistrictId = "${sessionScope.userInfo.proAtDistrict}";
SYS_USER_INFO.proOffAddr = "${sessionScope.userInfo.proOffAddr}";
SYS_USER_INFO.proContacts = "${sessionScope.userInfo.proContacts}";
SYS_USER_INFO.proContactsMobile = "${sessionScope.userInfo.proContactsMobile}";




app.controller('IndexController',function($scope){});
	
app.config(['$routeProvider',function($routeProvider){
	  $routeProvider.when('/enterPriseSet', {  
			templateUrl: ' /WebSite/Back/EnterPriseManagement/EnterpriseSet.jsp',  //企业设置
			controller:'EnterpriseController'
	    }).when('/employeeInformationMaintain', {  
			templateUrl: '/WebSite/Back/EmployeeInformationMaintain/EmployeeInformationMaintain.jsp',//员工信息维护
			controller:'EmployeeAppController'
	    }).when('/administrator',{
	    	templateUrl:'/WebSite/Back/AdministratorMng/AdministratorList.jsp',  //企业管理员维护
			controller:'AdministratorController'
	    }).when('/categoryList',{
	    	templateUrl:'/WebSite/Back/Category/CategoryList.jsp',  //机械管理
			controller:'CategoryController'
	    }).when('/categoryManage',{
	    	templateUrl:'/WebSite/Back/Category/CategoryManage.jsp',  //分类设备维护
			controller:'CategoryManageController'
	    }).when('/equipmentList',{
	    	templateUrl:'/WebSite/Back/Equipment/EquipmentList.jsp',  //资源维护
			controller:'EquipmentListController'
	    }).when('/depreciationCostList',{
	    	templateUrl:'/WebSite/Back/MessageCheckIn/depreciationCostList.jsp',  //折旧费登记
			controller:'DepreciationCostController'
	    }).when('/deviceHaveList',{
	    	templateUrl:'/WebSite/Back/MessageCheckIn/deviceHaveList.jsp',  //租赁费登记-设备拥有者
			controller:'DeviceHaveListController'	
	    }).when('/deviceUsageQuestionnaireCheckInList',{
	    	templateUrl:'/WebSite/Back/MessageCheckIn/deviceUsageQuestionnaireCheckInList.jsp',  //租赁费登记-设备使用者
			controller:'DeviceUsageQuestionnaireCheckInController'
	    }).when('/rentCheckInList',{
	    	templateUrl:'/WebSite/Back/MessageCheckIn/rentCheckInList.jsp',  //发布结果登记
			controller:'RentCheckInListController'
	    }).when('/projectList',{
	    	templateUrl:'/WebSite/Back/ProjectSetting/projectList.jsp',  //项目管理
			controller:'projectListController'
	    }).when('/outEquipmentList',{
	    	templateUrl:'/WebSite/Back/externalCompany/outEquipment/outEquipmentList.jsp',  //外资源管理
			controller:'outEquipmentListController'
	    }).when('/outDepreciationCostList',{
	    	templateUrl:'/WebSite/Back/externalCompany/outMessageCheckIn/outDepreciationCostList.jsp',  //外折旧费登记
			controller:'outDepreciationCostListController'
	    }).when('/outDeviceUsageQuestionnaireCheckInList',{
	    	templateUrl:'/WebSite/Back/externalCompany/outMessageCheckIn/outDeviceUsageQuestionnaireCheckInList.jsp',  //外发布结果登记
			controller:'outDeviceUsageQuestionnaireCheckInListController'
	    }).when('/outRentCheckInList',{
	    	templateUrl:'/WebSite/Back/externalCompany/outMessageCheckIn/outRentCheckInList.jsp',  //外租赁费-拥有者
			controller:'outRentCheckInListController'
	    }).when('/outUserRentCheckInList',{
	    	templateUrl:'/WebSite/Back/externalCompany/outMessageCheckIn/outUserRentCheckInList.jsp',  //外租赁费-使用者
			controller:'outUserRentCheckInListController'
	    }).when('/outRelationWay',{
	    	templateUrl:'/WebSite/Back/externalCompany/outRelationWay/outRelationWay.jsp',  //联系方式维护
			controller:'outRelationWayController'
	    }).when('/outEmployeeInformationMaintain',{
	    	templateUrl:'/WebSite/Back/OutEmployeeInformationMaintain/OutEmployeeInformationMaintain.jsp',  //外部管理员维护
			controller:'OutEmployeeAppController'
	    }).when('/outEmployeeMaintain',{
	    	templateUrl:'/WebSite/Back/OutEmployeeMaintain/OutEmployeeList.jsp',  //外部员员维护
			controller:'OutEmployeeController'
	    }).when('/parameterList',{
	    	templateUrl:'/WebSite/Back/Category/CategoryParameterList.jsp',  //设备参数维护
			controller:'CategoryParameterListController'
	    }).when('/manufactureList',{
	    	templateUrl:'/WebSite/Back/Category/Production.jsp',  //生产厂家维护 
			controller:'productionController'
	    }).when('/brandList',{
	    	templateUrl:'/WebSite/Back/Category/BrandList.jsp',  //生产厂家维护 
			controller:'brandListController'
	    }).when('/resourceAggregate',{
	    	templateUrl:'/WebSite/Back/StatisticalReports/ResourceAggregate.jsp',  //资源汇总
			controller:'resourceAggregateController'
	    }).when('/resourceDetail',{
	    	templateUrl:'/WebSite/Back/StatisticalReports/ResourceDetail.jsp',  //资源明细
			controller:'resourceDetailController'
	    }).when('/tenancyAggregate',{
	    	templateUrl:'/WebSite/Back/StatisticalReports/TenancyAggregate.jsp',  //租赁汇总
			controller:'tenancyAggregateController'
	    }).when('/tenancyDetail',{
	    	templateUrl:'/WebSite/Back/StatisticalReports/TenancyDetail.jsp',  //租赁明细
			controller:'tenancyDetailController'
	    }).when('/messageAggregate',{
	    	templateUrl:'/WebSite/Back/StatisticalReports/MessageAggregate.jsp',  //信息发布汇总
			controller:'messageAggregateController'
	    }).when('/messageDetail',{
	    	templateUrl:'/WebSite/Back/StatisticalReports/MessageDetail.jsp',  //信息发布明细
			controller:'messageDetailController'
	    }).when('/',{
	    	templateUrl:'/WebSite/Back/Welcome/welcomeLogin.jsp',  //企业设置
			/* controller:'EnterpriseController' */
	    }); 
	}]);  
	
	

	
	
</script>
<script type="text/javascript" src="./AdministratorMng/Administrator.js"></script>
<script type="text/javascript" src="./Category/Category.js"></script>
<script type="text/javascript" src="./Category/CategoryManage.js"></script>
<script type="text/javascript" src="./Category/CategoryParameterList.js"></script>
<script type="text/javascript" src="./Category/Production.js"></script>
<script type="text/javascript" src="./Category/BrandList.js"></script>
<script type="text/javascript" src="./EnterPriseManagement/EnterpriseSet.js"></script>
<script type="text/javascript" src="./Equipment/EquipmentList.js"></script>
<script type="text/javascript" src="./MessageCheckIn/depreciationCost/depreciationCostList.js"></script>
<script type="text/javascript" src="./MessageCheckIn/DeviceUsageQuestionnaireCheckIn/deviceUsageQuestionnaireCheckInList.js"></script>
<script type="text/javascript" src="./MessageCheckIn/rentCheckIn/rentCheckInList.js"></script>
<script type="text/javascript" src="./ProjectSetting/projectList.js"></script>
<script type="text/javascript" src="./EmployeeInformationMaintain/EmployeeInformationMaintain.js"></script>
<script type="text/javascript" src="./MessageCheckIn/DeviceHave/deviceHave.js"></script>
<script type="text/javascript" src="./externalCompany/outEquipment/outEquipmentList.js"></script>
<script type="text/javascript" src="./externalCompany/outMessageCheckIn/outDepreciationCost/outDepreciationCostList.js"></script>
<script type="text/javascript" src="./externalCompany/outMessageCheckIn/outDeviceUsageQuestionnaireCheckIn/outDeviceUsageQuestionnaireCheckInList.js"></script>
<script type="text/javascript" src="./externalCompany/outMessageCheckIn/outRentCheckIn/outRentCheckInList.js"></script>
<script type="text/javascript" src="./externalCompany/outRelationWay/outRelationWay.js"></script>
<script type="text/javascript" src="./OutEmployeeInformationMaintain/OutEmployeeInformationMaintain.js"></script>
<script type="text/javascript" src="./StatisticalReports/resourceAggregate.js"></script>
<script type="text/javascript" src="./StatisticalReports/resourceDetail.js"></script>
<script type="text/javascript" src="./StatisticalReports/tenancyAggregate.js"></script>
<script type="text/javascript" src="./StatisticalReports/tenancyDetail.js"></script>
<script type="text/javascript" src="./StatisticalReports/messageAggregate.js"></script>
<script type="text/javascript" src="./StatisticalReports/messageDetail.js"></script>
<script type="text/javascript" src="./externalCompany/outMessageCheckIn/outUserRentCheckIn/outUserRentCheckInList.js"></script>
<script type="text/javascript" src="./OutEmployeeMaintain/OutEmployee.js"></script>



