<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" ng-app="searchApp" ng-controller="searchController">
<head>
<title>{{pageTitle}}</title>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../Include/Head.jsp" />
<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
<script src="../../../media/js/lrtk.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../../../media/js/ss.js"></script><!--左右GUNDONG-->
<jsp:include page="../conmmon/publicSession.jsp" />
<script type="text/javascript" src="../../../js/JsLib/chinesepyi.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/SysCodeConfig.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/SysCodeTranslate.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../../media/js/pagination.js"></script>
<script type="text/javascript" src="../../../js/JsLib/angular-sanitize.min.js"></script>
<script type="text/javascript" src="../../../js/JsLib/myArray.js"></script>
<script type="text/javascript" src="../../../js/userJs/useCookie.js"></script>
<style>
    .page-list .pagination {float:left;}
    .page-list .pagination span {cursor: pointer;}
    .page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
    .page-list .pagination .separate span:hover {background: none;}
    .page-list .page-total {float:left; margin: 25px 20px;}
    .page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
    .page-list .page-total input {width: 40px; padding-left:3px;}
    .page-list .page-total select {width: 50px;}
    .tab_hj tr:hover{
background: #f3f3f3;
}
</style>
<script type="text/javascript" src="../../../media/js/tm.pagination.js"></script>
<script type="text/javascript">
var app = angular.module('searchApp',['ngResource','unifyModule','tm.pagination','ngSanitize','Config','sysCodeConfigModule','sysCodeTranslateModule']);
app.controller('searchController',function($scope,$sanitize,unifyTestSvc1,category,busEquParameterSvc,proSvc ,rentSvc,SaleSvc,DemandRentSvc,DemandSaleSvc,regionSvc,published,entSvc,equipment,IssuSvc,searchUrl,sysCodeTranslateFactory,SYS_CODE_CON){
	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
	    
	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	//获取页面传递过来的信息
	var url = location.search;
	var theRequest = new Object();
	if (url.indexOf("?") != -1) {
	    var str = url.substr(1);
	    strs = str.split("&");
	    for (var i = 0; i < strs.length; i++) {
	        theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
	    }
	}
	$scope.searchBtnType=theRequest.searchBtnType;
	$scope.searBean={};  
	SYS_USER_INFO.orgCode="${sessionScope.userInfo.orgCode}";
	SYS_USER_INFO.cityName="${sessionScope.userInfo.cityName}";
	$scope.isLogin =((SYS_USER_INFO.orgCode!=null&&SYS_USER_INFO.orgCode !="")?true:false);
	$scope.oreCode = SYS_USER_INFO.orgCode;
	$scope.showLevel = SYS_USER_INFO.orgLevel;
	//定义一个搜索内容显示
	$scope.daohang={};
	$scope.titleContent="";
	$scope.decodeURIVal="";
	$scope.isSearchRequest = (theRequest.searchContent==null?false:true);//判断是否是从搜索页面过来的请求
	$scope.decodeURIVal = decodeURI(theRequest.searchContent);
	$scope.requestParms = theRequest;
	$scope.ltype = $scope.requestParms.searchType;
	$scope.actionName = "";
	$scope.searchType = "";
	$scope.searBean.infoTitleBean = (($scope.decodeURIVal!=null && !($scope.decodeURIVal === 'undefined'))?$scope.decodeURIVal:"");
	/*
	   判断当好标签的方法
	*/
	$scope.judgeTab=function(){
		switch($scope.ltype){
			case 'ziyuan' :{
				$scope.daohang=1;
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(0)').addClass('lefthui');
				$scope.CZshow=true;
				$scope.CSshow=false;
				$scope.QZshow=false;
				$scope.QGshow=false;
				$scope.actionName = "Rent";
				$scope.searchType = 1;
				$scope.pageTitle="资源搜索页";
				$scope.urlTitle="发布信息搜索页";
				$scope.departments="所属单位";
				break;	
			}
			case 'chuzu' :{
				$scope.daohang=1;
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(0)').addClass('lefthui');
				$scope.CZshow=true;
				$scope.CSshow=false;
				$scope.QZshow=false;
				$scope.QGshow=false;
				$scope.actionName = "Rent";
				$scope.searchType=1;
				$scope.pageTitle="出租信息搜索页";
				$scope.urlTitle="出租信息搜索页";
				$scope.departments="所属单位";
				break;	
			}
			case 'qiuzu' :{
				$scope.daohang=3;
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(1)').addClass('lefthui');
				$scope.CZshow=false;
				$scope.CSshow=false;
				$scope.QZshow=true;
				$scope.QGshow=false;
				$scope.actionName = "DemandRent";
				$scope.searchType=3;
				$scope.pageTitle="求租信息搜索页";
				$scope.urlTitle="求租信息搜索页";
				$scope.departments="发布单位";
				break;	
			}
			case 'sale' :{
				$scope.daohang=2;
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(2)').addClass('lefthui');
				$scope.CZshow=false;
				$scope.CSshow=true;
				$scope.QZshow=false;
				$scope.QGshow=false;
				$scope.actionName = "Sale";
				$scope.searchType=2;
				$scope.pageTitle="出售信息搜索页";
				$scope.urlTitle="出售信息搜索页";
				$scope.departments="所属单位";
				break;			    	
			}
			case 'qiugou' :{
				$scope.daohang=4;
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(3)').addClass('lefthui');
				$scope.CZshow=false;
				$scope.CSshow=false;
				$scope.QZshow=false;
				$scope.QGshow=true;
				$scope.actionName = "DemandSale";
				$scope.searchType = 4;
				$scope.pageTitle="求购信息搜索页";
				$scope.urlTitle="求购信息搜索页";
				$scope.departments="发布单位";
				break;		
			}
			default:{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(1)').addClass('lefthui');
				$scope.actionName = "Rent";
				$scope.searchType=1;
				$scope.pageTitle="出租信息搜索页";
				$scope.urlTitle="出租信息搜索页";
				$scope.departments="所属单位";
				break;
			}
		}
		$scope.showMenu();
	};
	 
	/*
	   控制显示菜单的方法
	*/
    $scope.showMenu=function(){
	    switch($scope.ltype){
		    case 'sszy' :{
				$('#ulTopId li:eq(1) a').css('background','#CBCCCD');
				break;		
			}
		    case 'chuzu' :{
		    	$('#ulTopId li:eq(2) a').css('background','#CBCCCD');
		    	break;	
		    }
		    case 'qiuzu' :{
		    	$('#ulTopId li:eq(3) a').css('background','#CBCCCD');
		    	break;	
		    }
			case 'sale' :{
				$('#ulTopId li:eq(4) a').css('background','#CBCCCD');
				break;			    	
			}
			case 'qiugou' :{
				$('#ulTopId li:eq(5) a').css('background','#CBCCCD');
				break;		
			}
			default:{
				$('#ulTopId li:eq(2) a').css('background','#CBCCCD');
				break;
			}
		}
	    initShow=$('#jsddm >li.baidi:eq(0)');
	};
	    

	$scope.sContent = $scope.requestParms.searchContent;
	if($scope.sContent!=null && $scope.sContent!=""){
		 $scope.titleContent=$scope.sContent;
	}
	//从产品类型传递过来的参数
	//产品类别id
	$scope.protypeid = $scope.requestParms.id;
	//产品类别名称
	$scope.protypename=$scope.requestParms.name;
	//产品类别类型(大类，小类)
	$scope.protype=$scope.requestParms.type;
	if($scope.protypeid!=null &&  $scope.protypeid!=""){
		$scope.titleContent=$scope.protypename;
	}
	    
	
	/*
	*非首页点击资源搜索事件
	*/
	$scope.testA = function(){
		$('#ulTopId li:eq(1) a').css('background','#000');
		$.messager.popup("当前页面无资源搜索操作");
	};

	/*
	*分页标签参数配置
	*/
	$scope.paginationConf = {
		currentPage: 1,		/*当前页数*/
        totalItems: 0,		/*数据总数*/
        itemsPerPage: 20,	/*每页显示多少*/
        pagesLength: 20,		/*分页标签数量显示*/
        perPageOptions: [20, 30, 40, 50],
        onChange : function(parm1){
        	$scope.paginationConf.currentPage = parm1;
			/* if($scope.searBean.infoTitleBean == "" || $scope.searBean.infoTitleBean == null){ */
				// $scope.queryUpdHotWordCount();   //自动查询热门搜索词
				 $scope.uploadBrand();   	  //品牌查询
				 $scope.queryResourec();//页面搜索
			/* } */
        }
	};

	 $scope.queryCity=function(){
	     	function aSucc(rec){
	 			$scope.areaList=[];
	 			$scope.areaList=rec;
	 		}
	 		function aErr(rec){}
	 		regionSvc.queryRegionArea({}, aSucc,aErr);//查询省级单位
	     };
	     $scope.queryCity();
		/*
		 *省份
		*/
		$scope.formParms = {};
		$scope.province="";//省份标识名
		$scope.changePro=function(parm){
			/*选择空*/
			
			if(!parm.proModel){
				$scope.pList=[];
				$scope.cList={};
				setTimeout(function(){
					$("#city").val("");
					$("#district").val("");
				},500);
				return;
			}
			
			var regionId = "";
			
			for(var i=0;i<$scope.areaList.length;i++){
				if($scope.areaList[i].name==parm.proModel){
					regionId=$scope.areaList[i].regionId;
					break;
				}
			}
			
			$scope.formParms.onProvince=parm.proModel;
			function qSucc(rec){
				
				$scope.pList=[];
				$scope.pList=rec;
				$scope.cList={};
				setTimeout(function(){
					$("#city").val("");
					$("#district").val("");
				},500);
				
				
			}
			function qErr(rec){}
			regionSvc.queryRegionArea({regionId:regionId},qSucc,qErr);
			}
		
	
		/*设备大类 */
		$scope.queryCategoryData=function(){
			$scope.equipmentList = [];
			$scope.showTime = false;
			function qSucc(rec){
				
				$scope.categoryList=rec.content;
				$scope.paginationConf.totalItems = rec.totalElements;/*查询出来的数据总数*/
			}
			function qErr(rec){}
			
			category.unifydo({
				Action:"EquCategory",
				pageNo :0,// 当前页数
				pageSize : 99
			},qSucc,qErr);
		};	
		$scope.queryCategoryData();
		
		//查询设备小类 
		$scope.changeEqu = function(pram){
			if(pram.equCategoryId){
				function qSucc(rec){
					
					$scope.equipmentList=[];//在IE10浏览器中，如果没有定义，走不通
					$scope.equipmentList=rec.content;
				}
				function qErr(rec){}
				category.unifydo({
					Action:"EquName",
					equCategoryId:pram.equCategoryId,
					pageNo : 0,// 当前页数
					pageSize : 999
				},qSucc,qErr);
			}else{
				$scope.equipmentList=[];
			}
			
		}
	$scope.recPro={};
	$scope.recCit={};
	$scope.equ = {};
	$scope.e={};
	$scope.recPro.proModel = '';	
	$scope.recCit.recModel = '';
	$scope.equ.equCategoryId = '';
	$scope.e.equNameId = '';
	$scope.queryParams={};
	
	 $scope.userInfo = {};

		$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
		$scope.userInfo.orgId = SYS_USER_INFO.orgId;
		$scope.userInfo.orgCode = SYS_USER_INFO.orgCode;
		$scope.userInfo.orgName = SYS_USER_INFO.orgName;
		$scope.userInfo.proId = SYS_USER_INFO.proId;
		$scope.userInfo.proName = SYS_USER_INFO.proName;
		$scope.userInfo.partyId = SYS_USER_INFO.partyId;

	/*
	   出租、出售、求租、求购四个发布信息的搜索方法
	*/
	$scope.queryResourec=function(){
		
		if($scope.isSearchRequest){//搜索页面发起的搜索请求
			
			$scope.pageParams={};
			if(SYS_USER_INFO.orgName){
				if(SYS_USER_INFO.proName){
					   $scope.pageParams.orgName = SYS_USER_INFO.proName;
					   $scope.pageParams.orgPartyId = SYS_USER_INFO.proId;
					   $scope.pageParams.isInclude = 1;
					   
					   $scope.equQryBean.orgFlag = 3;

				}else{
					   $scope.pageParams.orgName = SYS_USER_INFO.orgName;
					   $scope.pageParams.orgPartyId = SYS_USER_INFO.orgId;
					   $scope.pageParams.isInclude = 1;
					   
					   if(1==$scope.userInfo.orgLevel){
							$scope.equQryBean.orgFlag = 9;
						}
						else if(2==$scope.userInfo.orgLevel){
							$scope.equQryBean.orgFlag = 1;
						}
						else if(3==$scope.userInfo.orgLevel){
							$scope.equQryBean.orgFlag = 2;
						}
				}

			}
			
			$scope.pageParams.pageSize=$scope.paginationConf.itemsPerPage;
			$scope.pageParams.pageNo=$scope.paginationConf.currentPage-1;
	        $scope.fontColor="<font color='blue'>"+$scope.searBean.infoTitleBean+"</font>";
			if(!$scope.actionName){
				$scope.judgeTab();
			}
			$scope.pageParams.dataType=$scope.searchType;
			IssuSvc.post({Action:"GetAll"},$scope.pageParams,qSuccChuZu,qErrChuZu);
		}else{
			$scope.initSearchParms();//调用初始化页面搜索条件的方法
			if(!$scope.actionName){//如果actionName为空的话，调用判断现在是处在哪个搜索界面的方法
				$scope.judgeTab();
			}
			if($scope.recPro.proModel){
				$scope.queryParams.onProvince = $scope.recPro.proModel;
			}
			if($scope.recCit.recModel){
				$scope.queryParams.onCity = $scope.recCit.recModel;
			}
			
			
			if($scope.equ.equCategoryId){
				$scope.queryParams.equCategoryId = $scope.equ.equCategoryId;
			}
			if($scope.e.equNameId){
				$scope.queryParams.equNameId = $scope.e.equNameId;
			}
			
			if($scope.equQryBean.equAtOrgPartyId){
				$scope.queryParams.orgPartyId = $scope.equQryBean.equAtOrgPartyId;
			}else if(SYS_USER_INFO.proId){
				$scope.queryParams.orgPartyId = SYS_USER_INFO.proId;
			}else if(SYS_USER_INFO.orgId){
				$scope.queryParams.orgPartyId = SYS_USER_INFO.orgId;
			}
			
			if($scope.equQryBean.isCrecOrg){
				$scope.queryParams.isProvider = $scope.equQryBean.isCrecOrg;
			}else{
				$scope.queryParams.isProvider = 0;
			}
			$scope.queryParams.isInclude = 0;
			
			if($scope.equQryBean.equAtOrgFlag){
				$scope.queryParams.orgFlag = $scope.equQryBean.equAtOrgFlag
			}else{
			   if(SYS_USER_INFO.proId){
				   $scope.queryParams.orgFlag = 3;//项目
			   }
			   else if(1==$scope.userInfo.orgLevel){
					$scope.queryParams.orgFlag = 9;//总公司
				}
				else if(2==$scope.userInfo.orgLevel){
					$scope.queryParams.orgFlag = 1;//局
				}
				else if(3==$scope.userInfo.orgLevel){
					$scope.queryParams.orgFlag = 2;//处
				}
			}
			
			
			$scope.queryParams.dataType = $scope.searchType;
			$scope.queryParams.isInclude = $scope.equQryBean.isInclude;
			
			if($scope.searchType==3){
				if($scope.equQryBean.equAtOrgPartyId){
					$scope.queryParams.orgCode = $scope.equQryBean.orgCode;
				}else{
					$scope.queryParams.orgCode = $scope.userInfo.orgCode;
				}
			}
			if($scope.searchType==4){
				if($scope.equQryBean.equAtOrgPartyId){
					$scope.queryParams.orgCode = $scope.equQryBean.orgCode;
				}else{
					$scope.queryParams.orgCode = $scope.userInfo.orgCode;
				}
			}
			if($scope.equQryBean.isCrecOrg==1){
				if($scope.equQryBean.equAtOrgNameSelect){
					$scope.equQryBean.equAtOrgNameSelect = '';
				}
				$scope.queryParams.orgName = $scope.equQryBean.equAtOrgNameInput;
				$scope.queryParams.pageNo=$scope.paginationConf.currentPage-1;
				$scope.queryParams.pageSize=$scope.paginationConf.itemsPerPage;
				$scope.queryParams.dataType=$scope.searchType;
				$scope.queryParams.isInclude = $scope.queryParams.isInclude;
				$scope.queryParams.orgCode = $scope.equQryBean.orgCode;
				$scope.queryParams.isProvider = 1;
				var valuejson={"dept":$scope.equQryBean.equAtOrgNameInput};
				var namejson={"dept":$scope.equQryBean.equAtOrgNameInput};
				$scope.displayCondition(namejson); 
				if($scope.external == 1){
					IssuSvc.post({Action:"GetAll"},$scope.queryParams,qSuccChuZu,qErrChuZu);
				}else{
					IssuSvc.post({Action:"GetAll"},$scope.queryParams,qSuccChuZu,qErrChuZu);
				}
				
			}else{
				$scope.queryParams.orgName = $scope.equQryBean.equAtOrgNameSelect;
					var valuejson={"dept":$scope.queryParams.orgName};
					var namejson={"dept":$scope.queryParams.orgName};
				$scope.displayCondition(namejson);
				
				if($scope.external == 1){
					$scope.queryParams.orgPartyId = null;
					$scope.queryParams.orgFlag = null;
					$scope.queryParams.orgName = null;
					IssuSvc.post({Action:"GetAll"},$scope.queryParams,qSuccChuZu,qErrChuZu);
				}else{
					IssuSvc.post({Action:"GetAll"},$scope.queryParams,qSuccChuZu,qErrChuZu);
				}
				
			}
		}
		
		function qSuccChuZu(rec){
			for(var i = 0; i < rec.content.length; ++i){
				var frontCity = "";
				if(rec.content[i].onProvince != null){
					frontCity += rec.content[i].onProvince;
				}
				if(rec.content[i].onCity != null){
					frontCity += rec.content[i].onCity;
				}
				if(rec.content[i].onDistrict != null){
					frontCity += rec.content[i].onDistrict;
				}
				rec.content[i].frontCity=frontCity;
				if(frontCity.length > 14){
					rec.content[i].frontCityA = (frontCity.substring(0,13)+"...");
				}else{
					rec.content[i].frontCityA = frontCity;
				}
				var frontModel = "";
				if(rec.content[i].modelName != null){
					frontModel +=rec.content[i].modelName;
				}
				if(rec.content[i].standardName != null){
					frontModel = frontModel+":"+rec.content[i].standardName;
				}
				rec.content[i].frontModel=frontModel;
				if(frontModel.length > 9){
					rec.content[i].frontModelA = frontModel.substring(0,7)+"..."
				}else{
					rec.content[i].frontModelA = frontModel;
				}
			}
			if(rec.content.length == 0){
				$scope.showView=false;
				$scope.FormDiv=false;
				$scope.outDiv=true;
		    	$.messager.popup("没有符合条件的纪录");
		    }else{
		    	$scope.outDiv=false;
		    	$scope.FormDiv=true;
		    	$scope.showView=true;
		    	/* if($scope.searBean.infoTitleBean == "" || $scope.searBean.infoTitleBean == null){
		    		$scope.searBean.infoTitleBean=($scope.ltype == "chuzu"?"出租":$scope.ltype=="qiuzu"?"求租":$scope.ltype=="sale"?"出售":"求购");
		    	} */
		    }
			if($scope.isSearchRequest){
				$scope.resultList=rec.content;
				$scope.changeListValue(rec.content);
				$scope.paginationConf.totalItems=rec.totalElements;
				$scope.totalElement = rec.totalElements;
				$scope.changeListTitleFun($scope.resultList,$scope.fontColor,$scope.pageParams.infoTitle);/* 调用替换关键字方法 */
				//如果parm不为空，并且查询成功，则放入方法querySearchHotWords()中
				if($scope.searBean.infoTitleBean != "" || $scope.searBean.infoTitleBean != null){
					$scope.querySearchHotWords($scope.searBean.infoTitleBean);
				}
				$scope.isSearchRequest = false;
				/* if($scope.actionName == "Rent"){ */
					//将城市字段进行处理
					
				/* } */
				return;
			}
			$scope.resultList=rec.content;
			$scope.changeListValue(rec.content);
			$scope.paginationConf.totalItems=rec.totalElements;
	    }
		function qErrChuZu(rec){}
	}
	
	
	
	if(!$scope.priceUnit){
		$scope.priceUnit={};
	}
	$scope.initSearchParms = function(){
		$scope.queryParams = {};
		$scope.queryParams.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryParams.pageSize=$scope.paginationConf.itemsPerPage;
		//$scope.queryParams.infoTitle=$scope.searBean.infoTitleBean;
		for(var i = 0; i < $scope.arraynameArray.length;i++){
			if($scope.arraynameArray[i].type == "dept"){
				$scope.queryParams.orgName = $scope.arraynameArray[i].name;
			}else if($scope.arraynameArray[i].type == "city"){
				$scope.queryParams.onCity = $scope.arraynameArray[i].name;
			}else if($scope.arraynameArray[i].type == "brandImg"){
				$scope.queryParams.brandNames = $scope.arraynameArray[i].name.split(",");
			}else if($scope.arraynameArray[i].type == "device"){
				$scope.queryParams.equName = $scope.arraynameArray[i].name;
			}else if($scope.arraynameArray[i].type == "model"){
				$scope.queryParams.modelNames = $scope.arraynameArray[i].name.split(",");
			}else if($scope.arraynameArray[i].type == "standard"){
				$scope.queryParams.standardNames = $scope.arraynameArray[i].name.split(",");
			}else if($scope.arraynameArray[i].type == "price"){
				var tempPrice = $scope.arraynameArray[i].name;
				tempPrice = tempPrice.split('-');
				$scope.queryParams.minPrice = Number(tempPrice[0]);
				tempPrice = tempPrice[1].split(' ');
				$scope.queryParams.maxPrice = Number(tempPrice[0]);
				if($scope.queryParams.maxPrice==0){
					$scope.queryParams.maxPrice=null;
				} 
				if($scope.CZshow || $scope.QZshow){
						var priceTypeTemp=(tempPrice[1] == "元/月"?'1':tempPrice[1] == "元/天"?'2':tempPrice[1] == "元/小时"?'3':null)
						$scope.queryParams.priceType = priceTypeTemp!=null?Number(priceTypeTemp):null;
				}	
			}
		}
		/* 
		if($scope.minPrice != null && $scope.minPrice != ""){
			$scope.queryParams.minPrice = Number($scope.minPrice);
		}
		if($scope.maxPrice != null && $scope.maxPrice != ""){
			$scope.queryParams.maxPrice = Number($scope.maxPrice);
		}
		if($scope.priceUnit.price != null && $scope.priceUnit.price != "" &&(($scope.minPrice != null && $scope.minPrice != "")||($scope.maxPrice != null && $scope.maxPrice != ""))){
			if($scope.CZshow || $scope.QZshow)$scope.queryParams.priceType = Number($scope.priceUnit.price);
		} */
		$scope.queryParams.isInclude=($scope.reason2.rec?1:2);	
	};
	
	
		
	/*
	 * 搜索
	*/
	$scope.showView=false;//你搜索的关键字是:的ng-show
	$scope.search=function(varl,parm){
		//$scope.queryInfo(varl,parm);
		/* if($scope.searBean.infoTitleBean == "" || $scope.searBean.infoTitleBean == null){
			$scope.showView=false;
		}else{ */
			$scope.showView=true;
			$scope.insertCache(parm);
			$scope.querySearchHotWords(parm);
			var searchType=$("#searchType").val();
			var searchContent=$("#searchContent").val();
			if($scope.selectSearchName){
				$('#searchVal').attr("href",searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm);
				setTimeout(function(){
				window.open(searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm,"_self");
				}/* ,500 */,0);
			}else{
				$('#searchVal').attr("href",searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm);
				setTimeout(function(){
				window.open(searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm,"_self");
				}/* ,500 */,0);
			}
		/* }
		$scope.LiNumA=false;
		$scope.LiNumB=false; */
		//var searchContent=$("#searchContent").val();
		//window.location.href = "Search.jsp?searchType="+searchType+"&searchContent="+searchContent+"&searchBtnType="+butId;
	};
	
	
	/*
	* 复用的替换关键字方法
	*/
	$scope.changeListTitleFun = function(resultList,fontColorObj,inputFlag)/* 传入数值的集合，改变颜色后的数值 */
	{
		for(var i=0;i<resultList.length;i++)/* 遍历数值集合，把每个值和输入的值匹配 */
		{
			if(inputFlag)/* 如果有输入的值 */
			{
				var ib=inputFlag;/* 把输入的值放入一个变量 */
				var reg=new RegExp(ib,"g");/* 用js中的正则方法去格式化输入的值，因为直接在replace中用replace独有的格式化方式是无法实现格式变量的，浏览器不识别 */   
				resultList[i].infoTitleTemp=resultList[i].infoTitleTemp.replace(reg,fontColorObj);/* 将格式好的输入值和改变后需要展现的值用replace替换，达到如果这个集合有输入框输入的值，就把输入值替换成改变后有颜色的值，然后在赋值给原值，因为会产生一个新对象(replace方法规则)*/	
			}
		} 
		return  resultList;/* 返回改变好的集合 */
	};
	      
	
	
	/*
	* 判断搜索的热词是否在三百三十三个设备小类中，如果是更新热词艘多的次数
	*/
	$scope.queryUpdHotWordCount=function(){
		$scope.linkValueList=[];
		function qSucc(rec){
			$scope.linkValueList=rec.content;
		}
		function qError(){}
		published.unifydo({Action:"SearchHotWords",pageNo:0,pageSize:5},qSucc,qError); 
	};
	$scope.queryUpdHotWordCount();
	
	
	/*
	* 获取热词搜索频率最高的记录集
	*/
	$scope.querySearchHotWords=function(parm){
		function qSucc(){}
		function qError(){}
		if(parm != "" || parm != null){
			published.unifydo({Action:"UpdHotWordCount",hotWord:parm},qSucc,qError);
		}
	};
	
	/*
	*点击搜索文本框事件
	*/
	var a=0;
	$scope.KeyWordListB=[];
	$scope.minIndexFlag = -1;
	$scope.maxIndexFlag = 0;
	$scope.LiNumB = false;
	$scope.InputClick = function(){

		/* if($scope.searBean.infoTitleBean == null || $scope.searBean.infoTitleBean == ""){
			$scope.LiNumA=false;
			$scope.KeyWordListB=[];
		}else{
			$scope.LiNumB=false;
			return;
		} */
		
		if($scope.searBean.infoTitleBean == null || $scope.searBean.infoTitleBean == ""){
			$scope.LiNumA=false;
			$scope.KeyWordListB=[];
			cf.getCookies('ashow');//对Cookies进行读取
			if(cf.getCookies('ashow')){
				windowOnload(cf.getCookies('ashow'));//向外部chinesepyi.js的方法windowOnload传递参数
				for(var i=0;i<cf.getCookies('ashow').length;i++){//$scope.KeyWordListB遍历接收getCookies的值
					$scope.KeyWordListB.push({infoTitleB:cf.getCookies('ashow')[cf.getCookies('ashow').length-1-i]});
				}
			}
		}else{
			$scope.LiNumB=false;
			return;
		}
		
		if(a == 0){//input为空时，如果缓存有值，点击一次显示下拉框，点击一次隐藏下拉框
			if($scope.KeyWordListB.length>=1){
				$scope.LiNumB=true;
				$('#parentOrgs2')[0].style.display = 'block';
				$scope.delCookAll=true;
			}
			
			a=a+1;
		}else{
			$scope.LiNumB=false;
			a = 0;
		}
	}; 
	
	/*
	* 点击点击热门搜索词搜索查询的方法
	*/
	$scope.queryInfoLink=function(parm){
		$scope.insertCache(parm);
		$scope.querySearchHotWords(parm);
		var searchType=$("#searchType").val();
		setTimeout(function(){
		window.open(searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm,"_self");
		},/* 500 */0);
	};	
     
     /*
     *文本框回车事件
     */
     $scope.inputKeyup = function(e){
    	  if(e && e.keyCode == 13){
	    	  $scope.LiNumA=false;
	    	  $scope.LiNumB=false;
	    	  if($scope.searBean.infoTitleBean == "" || $scope.searBean.infoTitleBean == null){
     				$scope.search();
	       	  }else{
	       			$scope.search(1,$scope.searBean.infoTitleBean);
	       	  }
	     }else{
	    	 $scope.maxIndexFlag = $('#parentOrgs ul li').length-1;
	    	 if(e && e.keyCode==38){//上,左
	    		 if($scope.minIndexFlag > 0 && $scope.minIndexFlag <=  $scope.maxIndexFlag){
		          	  $scope.minIndexFlag = $scope.minIndexFlag-1;
		         }
		    	 if($scope.minIndexFlag == -1){
		    		 return;
		    	 }
	        	  var indexFlag = '#parentOrgs ul li:eq('+$scope.minIndexFlag+') a';
	          	  $scope.searBean.infoTitleBean=$(indexFlag).attr('title');
	          	$("#clearFlag")[0].style.display = "";
	          	indexFlag = '#parentOrgs ul li'; 
	        	  $(indexFlag).css("background-color","white");
	        	  indexFlag = '#parentOrgs ul li:eq('+$scope.minIndexFlag+')';
	        	  $(indexFlag).css("background-color","rgba(196, 214, 226, 1)");
	        	 /*  var indexFlag = '#parentOrgs ul li:eq('+$scope.minIndexFlag+')'; */
	          }
	          else if(e && e.keyCode==40){//下,右
	        	  if($scope.minIndexFlag >= -1 && $scope.minIndexFlag <  $scope.maxIndexFlag){
		          	  $scope.minIndexFlag = $scope.minIndexFlag+1;
		          }
		          if($scope.minIndexFlag > $scope.maxIndexFlag){
		        	  return;
		          }
	          	  var indexFlag = '#parentOrgs ul li:eq('+$scope.minIndexFlag+') a';
	          	  $scope.searBean.infoTitleBean=$(indexFlag).attr('title');
	          	$("#clearFlag")[0].style.display = "";
	          	indexFlag = '#parentOrgs ul li'; 
	        	  $(indexFlag).css("background-color","white");
	        	  indexFlag = '#parentOrgs ul li:eq('+$scope.minIndexFlag+')';
	        	  $(indexFlag).css("background-color","rgba(196, 214, 226, 1)");
	        	 /*  var indexFlag = '#parentOrgs ul li:eq('+$scope.minIndexFlag+')'; */
	          }
	     } 
    };
     

	//截取字符串js，超出八位截取，不超出直接赋值给新变量
	$scope.changeListValue = function(objList){
		for(var i=0;i<objList.length;i++)
		{
			if(objList[i].infoTitle&&objList[i].infoTitle.length>5)
			{
				objList[i].infoTitleTemp=objList[i].infoTitle.substr(0,4)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
			}
			else
			{
				objList[i].infoTitleTemp=objList[i].infoTitle;
			}
		}
	};
	

	
	/*
	*关键字搜索点击事件(出租-求租-出售-求购)
	*/
	$scope.selectSearchName="";
	$scope.selectSearch=function(parm){
		$scope.LiNumA = false;
		$scope.LiNumB = false;
		$scope.selectSearchName=parm;
		//修改样式显示
		switch(parm){
			case 'ziyuan' :{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(0)').addClass('lefthui');
				break;	
			}
			case 'chuzu' :{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(0)').addClass('lefthui');
				break;	
			}
			case 'qiuzu' :{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(1)').addClass('lefthui');
				break;	
			}
			case 'sale' :{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(2)').addClass('lefthui');
				break;			    	
			}
			case 'qiugou' :{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(3)').addClass('lefthui');
				break;		
			}
			default:{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(1)').addClass('lefthui');
				break;
			}
		}
	};
	
	$scope.insertCache = function(parm){
		if(parm==null || parm.trim() == ""){
			return;
		}else{
			published.unifydo({Action:"RecentSearch",hotWord:parm},qSucc,qError);
		}
		function qSucc(rec){
			if(rec.msg == "TRUE"){
			}
		}
		function qError(){}
	};
	
	
	/*
	*input输入框,ng-change事件
	*/
	$scope.totalElement = "0";
	$scope.KeyWordQuery = function(parm){
		if ((navigator.userAgent.indexOf('Firefox')<0) && (navigator.userAgent.indexOf('Chrome')<0) && (navigator.userAgent.indexOf('Safari')<0)  && (navigator.userAgent.indexOf('Opera')<0)){
		}else{
			if(parm && parm.trim() != ""){
				$("#clearFlag")[0].style.display = "";
			}
		}
		$scope.queryData={};
		$scope.KeyWordList=[];
		if($scope.selectSearchName=="chuzu"){
			$scope.queryData.infoType=1;
		}else if($scope.selectSearchName=="qiuzu"){
			$scope.queryData.infoType=3;
		}else if($scope.selectSearchName=="sale"){
			$scope.queryData.infoType=2;
		}else if($scope.selectSearchName=="qiugou"){
			$scope.queryData.infoType=4;
		}else{
			$scope.queryData.infoType=1;
		}
		function success(rec){
			if(rec && rec.content && rec.content.length>0)
			{
				$scope.LiNumA=true;
				$('#parentOrgs1')[0].style.display = 'block'; 
				$scope.checkQueryKeyWord(rec.content);
				$scope.KeyWordList=rec.content;
				$scope.totalElement=rec.numberOfElements;
				$scope.KWList(rec.content);//字数超过9个后用...代替/
			}
			else
			{
				$scope.LiNumA=false;
			}
		}
		function error(){}
		$scope.queryData.Action="ITCount";
		if(parm){
			$scope.queryData.infoTitle=parm;
			published.unifydo($scope.queryData,success,error);
			$scope.LiNumB=false;
			//缓存的最近查询事件
			$scope.sercheVal = "";
			if(showWord()){
				$scope.sercheVal = showWord();
				$scope.cookiesshow=false;
			}else{
				$scope.cookiesshow=true;
			}
		}else{
			$scope.LiNumA=false;
		}
	};
	
	$scope.checkQueryKeyWord = function(varl){
	};
	 
	/*
	*多余字体用...代替
	*/
	$scope.KWList = function(val){
		for(var i=0;i<val.length;i++){
			if(val[i].infoTitle.length > 15){
				$scope.KeyWordList[i].infoTitleA = val[i].infoTitle.substring(0,15)+"...";
        	}else{
        		$scope.KeyWordList[i].infoTitleA = val[i].infoTitle;
        	}
		}
	};
	
	
	/*
	*点击搜索下拉框定位显示在input
	*/
	$scope.InputShow = function(parm1,parm){
		//将搜索的关键字放入缓存
		$scope.insertCache(parm);
		//更新热门搜索词
		if(parm){
			$scope.searBean.infoTitleBean = parm;
		 	var searchType=$("#searchType").val();
			if($scope.selectSearchName){
				setTimeout(function(){
				//document.getElementById("keyWords"+parm1).href=searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm;
					window.location.href =searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm;
				}/* ,500 */,0);
			}else{
				setTimeout(function(){
				//document.getElementById("keyWords"+parm1).href =searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm+"&random="+Math.random();
				window.location.href =searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm;
				}/* ,500 */,0);
			}
		}
	};
	

	/**
	查询
	*/
						
	$scope.FormDiv = false;
	$scope.outDiv = false;
	$scope.pageParams = {};
	$scope.queryInfo = function(pageNo,parm) {
		if (pageNo) {
			$scope.paginationConf.currentPage = 1;
		}
		$scope.resultList = "";
		$scope.pageParams = {};
		$scope.pageParams.infoTitle = parm;
		$scope.pageParams.pageSize = $scope.paginationConf.pageRecord;
		$scope.pageParams.pageNo = $scope.paginationConf.currentPage - 1;
		$scope.fontColor = "<font color='blue'>"+ $scope.searBean.infoTitleBean + "</font>";
		/*查询出租信息*/

		function qSuccChuZu(rec) {
			//把结果集合放入调用截取长度的方法
			if (rec.content.length == 0) {
				$scope.showView = false;
				$scope.FormDiv = false;
				$scope.outDiv = true;
				$.messager.popup("没有符合条件的纪录");
			} else {
				$scope.outDiv = false;
				$scope.FormDiv = true;
				$scope.showView = true;
				if (parm == "" || parm == null) {
					$scope.inputVal = $scope.titleContent;
				} else {
					$scope.inputVal = parm;
				}
			}
			$scope.resultList = rec.content;
			$scope.changeListValue(rec.content);
			$scope.paginationConf.totalItems = rec.totalElements;
			$scope.changeListTitleFun($scope.resultList,
					$scope.fontColor,
					$scope.pageParams.infoTitle);/* 调用替换关键字方法 */
			//如果parm不为空，并且查询成功，则放入方法querySearchHotWords()中
			if (parm != "" || parm != null) {
				$scope.querySearchHotWords(parm);
			}
		}
		function qErrChuZu(rec) {
		}
		if ($scope.ltype == "chuzu") {
			$scope.titleContent = "出租";
			$scope.searchType=1;
		}else if($scope.ltype == "qiuzu"){
			$scope.titleContent = "求租";
			$scope.searchType=3;
		}
		else if($scope.ltype == "sale"){
			$scope.titleContent = "出售";
			$scope.searchType=2;
		}
		else if($scope.ltype == "qiugou"){
			$scope.titleContent = "求购";
			$scope.searchType=4;
		}
		$scope.queryParams.dataType=$scope.searchType;
		IssuSvc.post({Action:"GetAll"},$scope.pageParams,qSuccChuZu,qErrChuZu);
	};
	
	$scope.choiceInputChange = function(type,t){
		if(type != null && type != ""){
			var valuejson={type:t};
			var namejson={type:t};
		}
		if(namejson[type] == null || namejson[type].trim() == ""){
			$scope.deletcondition(type);
		}
	};

	/*
	 *input关键字搜索回车事件
	 */
	$scope.myKeyup = function(e) {
		if(e && e.keyCode==38){//上,左
        	  $scope.searBean.infoTitleBean=e.target.title;
        }
        else if(e && e.keyCode==40){//下,右
        	  $scope.searBean.infoTitleBean=e.target.title;
        }
	};

						/*
						 *下拉框删除事件
						 */
						$scope.DelCache = function(parm,parm1){
							$scope.newKeyWordListB=[];
							$scope.KeyWordListB.splice(parm1,1);//删除数组$scope.KeyWordListB中的值
							for(var i=0;i<$scope.KeyWordListB.length;i++){
								$scope.newKeyWordListB.push($scope.KeyWordListB[i].infoTitleB);
							}
							cf.createCookies('ashow',$scope.newKeyWordListB,30);//将$scope.KeyWordListB数组剩下的值,重新添加到Cookies中
							if($scope.KeyWordListB.length <=0){
								$scope.LiNumB=false;
							}
						};

						/*
						 *下拉框删除DelAll事件
						 */
						 $scope.DelAll = function(){
							$.messager.confirm("提示", "确认删除全部历史记录？", function() { 
								$scope.LiNumB=true;
								cf.deleteCookies('ashow');
								$scope.delCookAll=false;
								$scope.KeyWordListB.splice($scope.KeyWordListB);
							});
						}; 

						/*
						 *点击搜索下拉框定位显示在input(缓存)
						 */
						$scope.InputShowB = function(parm){
							if(parm){
								$scope.searBean.infoTitleBean = parm;
								$scope.LiNumA=false;
								$scope.LiNumB=false;
								$scope.search(1, parm);
							}
						};

						/*
						 *缓存关键字搜索回车事件
						 */
						$scope.myKeyupHC = function(e){
						      if(e && e.keyCode==38){//上,左
						      	  //$scope.searBean.infoTitleBean=e.target.innerText;
						   	 // $scope.LiNumB = false;
						      }
						      else if(e && e.keyCode==40){//下,右
						      	  //$scope.searBean.infoTitleBean=e.target.innerText;
						      //	  $scope.LiNumB = false;
						      }
						};

						/*
						 *关键字缓存<删除>鼠标经过变色
						 */
						$scope.DelColorOverShow = function(parm){
							for(var i=0;i<$scope.KeyWordListB.length;i++){
								var num = document.getElementById("delid"+i);
								if(i == parm){
									num.style.color='red';
								}
							}
						};

						/*
						 *关键字缓存<删除>鼠标经过变色
						 */
						$scope.DelColorOutShow = function(parm){
							for(var i=0;i<$scope.KeyWordListB.length;i++){
								var num = document.getElementById("delid"+i);
								if(i == parm){
									num.style.color='#a8a8a8';
								}
							}
						};

						/*
						 *关键字缓存<清空>鼠标经过变色
						 */
						$scope.DelAllOver = function(parm){
							document.getElementById("delAllAId").style.color='white';
							document.getElementById("delAllBId").style.color='white';
						};

						/*
						 *关键字缓存<清空>鼠标经过变色
						 */
						$scope.DelAllOut = function(parm){
							document.getElementById("delAllAId").style.color='#a8a8a8';
							document.getElementById("delAllBId").style.color='#a8a8a8';
						};

						//产品大类型
						$scope.queryProType = function() {
							function qSucc(rec) {
								$scope.categoryList = rec.content;
							}
							function qErr(rec) {
							}
							category.unifydo({
								Action : "EquCategory",
								pageNo : 0,
								pageSize : 20
							}, qSucc, qErr);
						};

						//所属单位：ClickDept点击查询 
						/*
						 * 初始化向下查询（当前登陆人下级企业查询）
						 * 用session中的登录人id和name当参数，查询当前登录人的信息展示本企业和下级企业
						 */
						$scope.deptList = {};
						$scope.NextProject = function(orgId) {
							if(!$scope.isLogin)return;
							function qSucc(rec) {
								for (var i = 0; i < rec.content.length; i++) {
									$scope.deptList[i] = {
										detpId : rec.content[i].currOrgId,
										deptName : rec.content[i].name,
										deptValue : rec.content[i].name
									};

								}
								if (rec.content.length > 0) {
									$scope.containNext = true;//显示“是否包含下级单位”checkBox控件
								} else {
									$scope.containNext = false;
								}
							}
							function qErr(rec) {
							}
							entSvc.queryPartyInstallList({
								currOrgId : orgId,
								pageNo : $scope.paginationConf.currentPage - 1,
								pageSize : $scope.paginationConf.itemsPerPage
							}, qSucc, qErr);
						};

						$scope.NextProject(SYS_USER_INFO.orgId);//调用初始化方法传入当前企业的id

						//区域
						$scope.areaList = [ {
							name : '华北地区',
							value : '01'
						}, {
							name : '东北地区',
							value : '02'
						}, {
							name : '华东地区',
							value : '03'
						}, {
							name : "中南地区",
							value : '04'
						} ];
						//品牌字母
						$scope.abcList = [ {
							abcName : 'A',
							abcValue : '0'
						}, {
							abcName : 'B',
							abcValue : '1'
						}, {
							abcName : 'C',
							abcValue : '2'
						}, {
							abcName : 'D',
							abcValue : '3'
						}, {
							abcName : 'E',
							abcValue : '4'
						}, {
							abcName : 'F',
							abcValue : '5'
						}, {
							abcName : 'G',
							abcValue : '6'
						}, {
							abcName : 'H',
							abcValue : '7'
						}, {
							abcName : 'I',
							abcValue : '8'
						}, {
							abcName : 'J',
							abcValue : '9'
						}, {
							abcName : 'K',
							abcValue : '10'
						}, {
							abcName : 'L',
							abcValue : '11'
						}, {
							abcName : 'M',
							abcValue : '12'
						}, {
							abcName : 'N',
							abcValue : '13'
						}, {
							abcName : 'O',
							abcValue : '14'
						}, {
							abcName : 'P',
							abcValue : '15'
						}, {
							abcName : 'Q',
							abcValue : '16'
						}, {
							abcName : 'R',
							abcValue : '17'
						}, {
							abcName : 'S',
							abcValue : '18'
						}, {
							abcName : 'T',
							abcValue : '19'
						}, {
							abcName : 'U',
							abcValue : '20'
						}, {
							abcName : 'V',
							abcValue : '21'
						}, {
							abcName : 'W',
							abcValue : '22'
						}, {
							abcName : 'X',
							abcValue : '23'
						}, {
							abcName : 'Y',
							abcValue : '24'
						}, {
							abcName : 'Z',
							abcValue : '25'
						} ];

						//型号
						$scope.modelList = [];
						//规格
						$scope.standardList = [];

						/*
						 *
						 */
						$scope.getSmalType = function(obj) {
							var name = obj.equipmentCategoryName;
							$scope.formParms = obj;
							function qSucc(rec) {
								$scope.smallTypeList = rec.content;
								$scope.smallType = true;
							}
							function qErr(rec) {
							}
							$scope.smallType = true;
							category.unifydo({
								Action : "EquName",
								equCategoryId : obj.equCategoryId,
								pageNo : 0,
								pageSize : 20
							}, qSucc, qErr);
						};
						//定义全局数组
						var arrayjson = {
							params : []
						};
						$scope.arraynameArray = [];

						/*
						 *已选条件显示方法
						 */
						$scope.brandname=[];
						$scope.modelnamearr=[];
						$scope.dwfwdxnamearr=[];
						$scope.shebeilynamearr=[];
						$scope.shebeiztnamearr=[];
						$scope.fbztnamearr=[];
						$scope.ywztnamearr=[];
						$scope.guigenamearr=[];
						/*
						*已选条件显示方法
						*/
						$scope.clearmodelalinkstyle=function(){
							var xharry=document.getElementById("gunge").getElementsByTagName('a');
							for(var i=0;i<xharry.length;i++){
								xharry[i].className="";
							}
						}
						$scope.clearworkalinkstyle=function(){
							var wkarry=document.getElementById("gungework").getElementsByTagName('a');
							for(var i=0;i<wkarry.length;i++){
								wkarry[i].className="";
							}
						}
						$scope.clearshebeialinkstyle=function(){
							var shebeiarry=document.getElementById("gungeshebei").getElementsByTagName('a');
							for(var i=0;i<shebeiarry.length;i++){
								shebeiarry[i].className="";
							}
						}
						$scope.clearshebeiztalinkstyle=function(){
							var shebeiztarry=document.getElementById("gungeshebeizt").getElementsByTagName('a');
							for(var i=0;i<shebeiztarry.length;i++){
								shebeiztarry[i].className="";
							}
						}
						$scope.clearshebeifbalinkstyle=function(){
							var shebeifbarry=document.getElementById("gungeshebeifb").getElementsByTagName('a');
							for(var i=0;i<shebeifbarry.length;i++){
								shebeifbarry[i].className="";
							}
						}
						$scope.clearshebeiywztalinkstyle=function(){
							var shebeiywztarry=document.getElementById("gungeshebeiywzt").getElementsByTagName('a');
							for(var i=0;i<shebeiywztarry.length;i++){
								shebeiywztarry[i].className="";
							}
						}
						$scope.clearggalinstyle=function(){
							var ggarry=document.getElementById("ggalink").getElementsByTagName('a');
							for(var i=0;i<ggarry.length;i++){
								ggarry[i].className="";
							}
						}
						
						$scope.selectQuery=function(type,t,param,thisid){
							//$scope.
							if(type=="model"){//型号
								if($scope.ismodelradioorcheckbox){
									var valuejson={"model":t.equParameter.id};
									var namejson={"model":t.equParameter.name};
									var xharry=document.getElementById("gunge").getElementsByTagName('a');
									$scope.clearmodelalinkstyle();
									if(xharry[thisid].className==''){xharry[thisid].className='ihhagouxuan'};
								}else{
									var xharry=document.getElementById("gunge").getElementsByTagName('a');
									if(xharry[thisid].className==''){
										xharry[thisid].className='ihhagouxuan';
										$scope.modelnamearr.push({"id":thisid,"name":param});
										}else{
											for(var i=0;i<$scope.modelnamearr.length;i++){
												if($scope.modelnamearr[i].id==thisid){
													$scope.modelnamearr.splice(i,1);
												}
											}
										xharry[thisid].className='';
									};
								}
							}
							else if(type=="standard"){//规格
								var ggarry=document.getElementById("ggalink").getElementsByTagName('a');
								if(	$scope.ggisradioorcheckbox){
								var valuejson={"standard":t.equParameter.id};
								var namejson={"standard":t.equParameter.name};
								
								$scope.clearggalinstyle();
								if(ggarry[thisid].className==''){ggarry[thisid].className='ihhagouxuan'};
								}else{
									
									if(ggarry[thisid].className==''){
										
										$scope.guigenamearr.push({"id":t.equParameter.id,"name":t.equParameter.name});
										ggarry[thisid].className='ihhagouxuan';
										
										}else{
											ggarry[thisid].className='';
											for(var i=0;i<$scope.guigenamearr.length;i++){
												if($scope.guigenamearr[i].id==t.id){
													$scope.guigenamearr.splice(i,1);
												}
											}
										}
								}
		
							}
							else if(type=="brandImg"){//品牌
								var arra=document.getElementById("radioimggroup").getElementsByTagName("a");
								if(	$scope.isradioorcheckbox){
								var valuejson={"brandImg":t.id};
								var namejson={"brandImg":t.name};

								$scope.clearbrandstyle();
								if(arra[thisid].className==''){arra[thisid].className='ihhagouxuan'}else{arra[thisid].className=''};
								/* $scope.queryModelList(t.id);
								$scope.queryStandardList(t.id); */
								}else{
									var valuejson=null;
									var namejson=null;
									if(arra[thisid].className==''){
										
										if($scope.brandname.length<5){
										$scope.brandname.push({"name":param,"id":thisid});
										arra[thisid].className='ihhagouxuan';
										}else{
											$.messager.popup("最多能选择5个品牌");
										}
										
										}else{
											arra[thisid].className='';
											for(var i=0;i<$scope.brandname.length;i++){
												if(param==$scope.brandname[i].name){
													$scope.brandname.splice(i,1);
												}
											}
											}
								}
							}
							$scope.processParam(valuejson);
							$scope.displayCondition(namejson);
						};
						$scope.clearbrandstyle=function(){
							var arra=document.getElementById("radioimggroup").getElementsByTagName("a");
							for(var i=0;i<arra.length;i++){
								arra[i].className='';
							}
						}
						/**根据品牌名称查型号列表*/
						/* $scope.queryModelList = function(parm){
							published.unifydo({Action:"queryEquModel",id:parm},function(rec){
								$scope.modelList=rec.content;
							},function(){
								
							});
						}; */
						
						/*根据品牌名称查规格*/
						/* $scope.queryStandardList = function(parm){
							published.unifydo({Action:"queryEquStandard",id:parm},function(rec){
								$scope.standardList=rec.content;
							},function(rec){
								
							});
						}; */

						/*
						 *input输入框change事件
						 */
						$scope.inputChange = function(type, t, queryTrue) {
							if (queryTrue) {
							$scope.shownextlevel=false;
								if (type == "dept") {//业务状态
									var valuejson = {
										"dept" : t
									};
									var namejson = {
										"dept" : t
									};
									$scope.displayCondition(namejson);
								}
								if (namejson.dept == null
										|| namejson.dept.trim() == "") {
									$scope.deletcondition("dept");
									//如果输入框没有值 则不显示下拉选项 list设为null
									$scope.deptList = [];
									workitem.style.display='none';
									$scope.containNext=false;
									$scope.reason2.rec=false;
								} else {
									//$scope.displayCondition(namejson);
									$scope.queryDeptList(namejson.dept);
								}
							} else {
								if(SYS_USER_INFO.level=="6"){
									$scope.shownextlevel=false;
								}else{
									$scope.shownextlevel=true;
									
								}
								if (type == "dept") {//业务状态
									var valuejson = {
										"dept" : SYS_USER_INFO.orgName
									};
									var namejson = {
										"dept" : SYS_USER_INFO.orgName
									};
								}
								$scope.displayCondition(namejson);
							}
						};

						/*
						 *input输入框change事件--根据输入信息，查询企业
						 */
						$scope.queryDeptList = function(deptName,deptNo) {

							function qSucc(rec) {
								//设置下拉选项显示为true 并且给list赋值
								//OrgNameFpy
								$scope.deptList = rec.content;
								if (eval(rec.content).length >0) {
									workitem.style.display='';
									//$scope.containNext = true;  查询是否有下级单位，如果有下级单位，则显示，否则不显示
								}else{
									workitem.style.display='none';
									$scope.xjClick('dept',deptName);
									$scope.inputDeptName.deptName =deptName;
								}
								//$scope.KWList(rec.content,2);//字数超过9个后用...代替/
							}

							function qErr() {
							}

							entSvc.queryPartyInstallList({
								Action : 'QueEnts'
							}, {
								pageNo : 0,
								pageSize : 20,
								orgName : deptName
							}, qSucc, qErr);

						};
						
						/**
						*查询当前单位是否有下级单位  $scope.containNext
						*/
						$scope.queryNextDepts = function(deptName,deptNo){
							entSvc.queryPartyInstallList({
								currOrgId:deptNo,
								name:deptName,
								pageNo:$scope.paginationConf.currentPage-1,
								pageSize:$scope.paginationConf.itemsPerPage
							},function(rec){
								if (eval(rec.content).length >0){
									 $scope.containNext = true;
									 $scope.reason2.rec=false;
								}else{
									 $scope.containNext=false;
									 $scope.reason2.rec=false;
								}
							},function(rec){
								$scope.containNext=false;
								$scope.reason2.rec=false;
							});
						};

						/*
						 *所属单位，ng-checked点击显示show
						 */
						 $scope.reason2={rec:false};
						$scope.CDClick = function() {
						};
						
						/*
						*添加所在城市到已选条件之中
						*/
						$scope.addOnCity = function()
						{
							if($scope.recCit.recModel)
							{
								var valuejson={"onCity":$scope.recCit.recModel};
								var namejson={"onCity":$scope.recCit.recModel};
								$scope.displayCondition(namejson);
							}
						};
						
						/*
						*添加所在省到已选条件之中
						*/
						$scope.addOnProvince = function()
						{
							if($scope.recPro.proModel)
							{
								var valuejson={"onProvince":$scope.recPro.proModel};
								var namejson={"onProvince":$scope.recPro.proModel};
								$scope.displayCondition(namejson);
								$scope.deletcondition("onCity");//删除所在市	
							}
						};

						/*
						*添加设备大类名称到已选条件之中
						*/
						$scope.addEquCategory=function()
						{
							if($scope.equ.equCategoryId)
							{
								$scope.equipmentCategoryName = $('#equipmentCategoryName option:selected').text();
								var valuejson={"equipmentCategoryName":$scope.equipmentCategoryName};
								var namejson={"equipmentCategoryName":$scope.equipmentCategoryName};
								$scope.displayCondition(namejson);
								$scope.deletcondition("equipmentName");//删除设备小类名称
							}
						}; 
						
						/*
						*添加设备小类名称到已选条件之中
						*/
						 $scope.addEquName=function()
						 {
							if($scope.e.equNameId)
							{
								$scope.equipmentName = $('#equipmentName option:selected').text();
								var valuejson={"equipmentName":$scope.equipmentName};
								var namejson={"equipmentName":$scope.equipmentName};
								$scope.displayCondition(namejson);
							}
						}; 

						/*
						*已选条件显示
						*/
						$scope.displayCondition=function(namejson,parm)
						{
							if(namejson!=null&&namejson.dept!="")
							{
								 if(namejson instanceof Array)
								 {
									//获取namejson
									 var tmpVal="";
									 for(var k=0;k<namejson.length;k++){
										if(k==namejson.length-1){
											tmpVal+=namejson[k];
										}else{
											tmpVal+=namejson[k]+",";
										}
									 }
									var testValue=true;
									var nameArray=[];
									var tempjson={type:"",name:""};
									for(var i=0;i<$scope.arraynameArray.length;i++){
										if($scope.arraynameArray[i].type==parm){
											$scope.arraynameArray[i]={type:parm,name:tmpVal};
											testValue=false;
										}
									}
									if(testValue == true){
										$scope.arraynameArray[$scope.arraynameArray.length]={type:parm,name:tmpVal};
									}
								 }
								 else//如果传递过来的不是一个数据对象，则做如下的处理
								 {
									//获取namejson
									var nameArray=[];
									var tempjson={type:"",name:""};
									for(var key in namejson)
									{
										nameArray[0]=key;
										nameArray[1]=namejson[key];
									}
									tempjson.type=nameArray[0];
									tempjson.name=nameArray[1];
									var flag=false;
									for(var i=0;i<$scope.arraynameArray.length;i++)
									{//如果选中的条件已经在已选条件之中了，则换一下值
										if($scope.arraynameArray[i].type==nameArray[0])
										{
											$scope.arraynameArray[i].name=nameArray[1];
											flag=true;
										}
									}
									if(!flag)
									{//往数组里新增元素，选中的条件没有在已选条件之中，则将其加入已选条件之中
										$scope.arraynameArray.splice($scope.arraynameArray.length, 0, tempjson); 
									}
								 }
							 }
						};
						

						//处理全局array的方法（包括 新增元素，修改元素）
						$scope.processParam = function(param) {
							var flag = false;
							var arrayjsonArray = arrayjson.params;
							//将parm转换成数组
							var paramArray = [];
							for ( var key in param) {
								paramArray[0] = key;
								paramArray[1] = param[key];
							}
							for (var i = 0; i < arrayjsonArray.length; i++) {
								for ( var key in arrayjsonArray[i]) {
									if (key == paramArray[0]) {
										//修改属性
										arrayjsonArray[i][key] = paramArray[1];
										flag = true;
									}
								}
							}
							if (!flag) {//增加arrayjson属性
								arrayjson.params.push(param);
							}
						};

						/*
						*删除已选条件
						*/
						$scope.deletcondition=function(type){
							var arrayjsonArray=arrayjson.params;
							for(var i=0;i<arrayjsonArray.length;i++){
								for(var key in arrayjsonArray[i]){
									if(key==type){
										arrayjson.params.splice(i,1);
									}
								}
							}
							for(var i=0;i<$scope.arraynameArray.length;i++){
								if($scope.arraynameArray[i].type==type){
									$scope.arraynameArray.splice(i,1);
								}
							}
							if(type =="dept"){//删除所属单位

								$scope.clearEquAtEmployerModel();//清空所在单位的摸态框
								
							}
							else if(type == "city"){//删除全部所在城市
								$scope.deletcondition("onProvince");//删除所在省
								$scope.onCityValue = null;
								$scope.onProvinceValue = null;
								$scope.recCit.recModel = null;
								$scope.recPro.proModel = null;
							}
							else if(type == "onProvince"){//删除所在省
								$scope.deletcondition("onCity");//删除所在市
								$scope.onProvinceValue = null;
								$scope.recCit.recModel = null;
								$scope.recPro.proModel = null;
							}
							else if(type == "onCity"){//删除所在市
								$scope.onCityValue = null;
								$scope.recCit.recModel = null;
							}
							else if(type == 'device' ){//删除全部设备类型
								$scope.deletcondition("equipmentCategoryName");//删除设备大类名称
								$scope.deviceNameInputValue = null;
								$scope.equipmentCategoryNameValue = null;
								$scope.equ.equCategoryId = null;
								$scope.e.equNameId = null;
							}
							else if(type == "equipmentCategoryName"){//删除设备大类名称
								$scope.deletcondition("equipmentName");//删除设备小类名称
								$scope.deviceNameInputValue = null;
								$scope.equipmentCategoryNameValue = null;
								$scope.equ.equCategoryId = null;
								$scope.e.equNameId = null;
							}
							else if(type == "equipmentName"){//删除设备小类名称
								$scope.deviceNameInputValue = null;
								$scope.e.equNameId = null;
							}
							else if(type == 'yeWZT'){
								$scope.clearshebeiywztalinkstyle();
								$scope.yeWZTDiv=true;
								$scope.yeWZTDivShow=true;
							}
							else if(type == 'sheBZT'){
								$scope.clearshebeiztalinkstyle();
								$scope.sheBZTDiv=true;
								$scope.sheBZTDivShow=true;
							}else if(type == 'FBZT'){
								$scope.clearshebeifbalinkstyle();
								$scope.FBZTDiv=true;
								$scope.FBZTDivShow=true;
							}
							else if(type == 'sheBLY'){
								$scope.clearshebeialinkstyle();
								$scope.sheBLYDivShow=true;
								$scope.sheBLYDiv=true;
							}
							else if(type == 'danWFW'){
								$scope.clearworkalinkstyle();
								$scope.danWFWDiv=true;
								$scope.danWFWDivShow=true;
							}
							else if(type == 'standard'){
								$scope.clearggalinstyle();
								$scope.standarDivShow=true;
								$scope.standardDiv=true;
							}
							else if(type == 'model'){
								$scope.clearmodelalinkstyle();
								$scope.modeldxcancle();
								$scope.modelDiv=true;
								$scope.modelDivShow = true;
							}
							else if(type == "brandImg"){
								$scope.clearbrandstyle();
								$scope.brandDivShow = true;
								$scope.modelDivShow=true;
								$scope.standarDivShow=true;
								//$scope.brandBtnClose();
							}else if(type == "price"){
								$scope.minPrice="";
								$scope.maxPrice="";
							}
							var varityCho =[];
							for(var i = 0; i < $scope.arraynameArray.length;i++){
								if($scope.arraynameArray[i].type == "brandImg"){
									varityCho = $scope.arraynameArray[i].name.split(",");
								}
							}
							if(($scope.modelDiv ==false||$scope.standardDiv == false)&&(varityCho.length<=1)){
								$scope.modelDiv = true;
								$scope.standardDiv = true;
							} 
						};

						/*
						 *鼠标点击展开div
						 */
						$scope.zkShow = true;
						$scope.zkClick = function() {
							$scope.zkShow = false;
							$scope.sqShow = true;
							$scope.priceDiv=true;
						};


						/*
						 *点击多选按钮事件 -- 品牌
						 */
						$scope.imgShow = true;
						$scope.imgVarity = false; //非多选状态下的图片模式
						$scope.brandDX = function() {
							$scope.clearChoice();
							$scope.brandGDDis = 'true';
							$scope.TermShow = true;
							$scope.imgShow = false;
							$scope.imgGDShow = false;
							$scope.imgDXShow = true;//多选状态下的图片模式
							$scope.brandBtn = true; //多选状态下的取消按钮
							$scope.brandABC = true; //多选状态下的a标签字母
							$scope.filterParm = true;
							//型号规格不显示
							$scope.modelDiv = false;
							$scope.standardDiv = false;
							$scope.modelClick(2);
							$scope.standardClick(2);
							$scope.uploadBrand();
						};

						/*
						 * 点击取消多选状态事件 -- 品牌
						 */
						$scope.brandBtnClose = function() {
							$scope.brandGDDis = '';
							$scope.brandBtn = false;
							$scope.brandABC = false;
							$scope.imgDXShow = false;
							$scope.imgGDShow = false;
							$scope.imgShow = true;
							$scope.TermShow = false;
							var varityCho = [];
							for (var i = 0; i < $scope.arraynameArray.length; i++) {
								if ($scope.arraynameArray[i].type == "brandImg") {
									varityCho = $scope.arraynameArray[i].name
											.split(",");
								}
							}
							if (($scope.modelDiv == false || $scope.standardDiv == false)
									&& (varityCho.length <= 1)) {
								$scope.modelDiv = true;
								$scope.standardDiv = true;
							}
							//品牌
							$scope.clearChoice();
							$scope.uploadBrand();
						};

						/**
						移除多选中的某一项
						 */
						$scope.removeChoiceItem = function(parm) {
							var newList = new window.arrayFactory($scope.NewList);
							var testList = new window.arrayFactory($scope.TestList);
							var newArraynameArray = new window.arrayFactory($scope.newArraynameArray);
							$scope.NewList=newList.remove(parm);
							$scope.TestList=testList.remove(parm);
							//var testValue = true;
							$scope.newArraynameArray=newArraynameArray.remove(parm);
						};



						/*
						*鼠标经过ABC -- 品牌
						*/
						$scope.uploadBrand = function(){
							var fpys = ['A','B','C','D','E','F','G','H','I','G','k','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
							$scope.brandList=[];
							published.unifydoHM({Action:"EquBrandFpy"},{fpy:fpys},function(rec){
								var brandIndex = 0;
								for(var i = 0; i < fpys.length;i++){
									var letterFlag = fpys[i]
									var temp = rec[letterFlag];
									for(var j = 0; j < temp.length; ++j){
										temp[j].letterFlag = letterFlag;
										$scope.brandList[brandIndex] = temp[j];
										brandIndex++;
									}
								}
								return;
							},function(rec){
								return;
							});
						}
						$scope.abcOver=function(parm){
							$scope.newABCList = [parm];
							if(parm){
								$scope.filterParm = parm;
							}else{
								$scope.filterParm = true;
							}
						};

						/*
						 *型号的显示效果
						 */
						$scope.modelDX = true;
						$scope.modelShow = true;
						$scope.modelClick = function(parm) {
							if (parm == 1) {
								$scope.modelDX = false;
								$scope.modelQX = true;
								$scope.modelShow = false;
								$scope.modelShowDX = true;
								$scope.modelChoiceShow = true;
								//
								$scope.standardClick(2);
								$scope.brandBtnClose();
							} else {
								$scope.modelChoiceShow = false;
								$scope.modelDX = true;
								$scope.modelQX = false;
								$scope.modelShow = true;
								$scope.modelShowDX = false;
							}
						};

						/*
						 *规格的显示效果
						 */
						$scope.standardDX = true;
						$scope.standardShow = true;
						$scope.standardClick = function(parm) {
							if (parm == 1) {
								$scope.standardDX = false;
								$scope.standardQX = true;
								$scope.standardShow = false;
								$scope.standardShowDX = true;
								$scope.modelStandardShow = true;
								//
								$scope.modelClick(2);
								$scope.brandBtnClose();
							} else {
								$scope.modelStandardShow = false;
								$scope.standardDX = true;
								$scope.standardQX = false;
								$scope.standardShow = true;
								$scope.standardShowDX = false;
							}
						};

						/*
						 *设备状态的显示效果
						 */
						$scope.shebieDX = true;

						/*
						 *业务状态的点击效果
						 */
						var i = 0;
						var divs = "";
						$scope.NewList = [];
						$scope.TestList = [];
						var testValue = true;
						$scope.newArraynameArray = [];
						$scope.currentParam = "";
						$scope.multipulChoice = {}
						$scope.clearChoice = function() {
							var newList = new window.arrayFactory($scope.NewList);
							var testList = new window.arrayFactory($scope.TestList);
							var newArraynameArray = new window.arrayFactory($scope.newArraynameArray);
							$scope.NewList = newList.removeAll();
							$scope.TestList = testList.removeAll();
							var testValue = true;
							$scope.newArraynameArray = newArraynameArray.removeAll();
						};
						$scope.checkClick=function(parm,parm2,parm3,parm4){
							if($scope.currentParam != parm3){
								$scope.currentParam = parm3;
								$scope.clearChoice();
							}
							
							divs=document.getElementById("divId"+parm4);
							if(parm2){
								for(var i=0;i<$scope.NewList.length;i++){
									if($scope.NewList[i]==parm){
										$.messager.popup("此条件已选，不能重复");
										return;
									}
								}
								
								//计数，大于5的依据
								$scope.TestList.push(parm);
								//点击超过$scope.NewList.length>6过后
								if($scope.TestList.length > 5 && $scope.NewList.length == 5){
									var TestList = new window.arrayFactory($scope.TestList);
									$scope.TestList=TestList.remove($scope.TestList[$scope.TestList.length-1]);
									testValue=false;
								}else{
									testValue = true;
								}
								//超过5的div都没有选中效果
								if(testValue == false){
									$.messager.popup("已选条件不能多于5");
									if(parm3 != 'brandImg'){
										divs=document.getElementById(parm3+parm4);
										divs.checked = false;
									}else{
										divs=document.getElementById(parm3+"s"+parm4);
										divs.checked = false;
									}
									return;
								}
								//checkBox
								if($scope.NewList.length <= 4){
									$scope.NewList.push(parm);
									if(parm3 == 'brandImg'){
										//点击后DIV显示效果
										divs.style.borderColor = "red";
										divs.style.backgroundImage="url(../../../media/images/white_2.png)";
									}
								}
								
								//DIV里面已选条件显示
								var namejson={"model":parm};
								var nameArray=[];
								var tempjson={type:"",name:""};
								for(var key in namejson){
									nameArray[0]=key;
									nameArray[1]=namejson[key];
								}
								tempjson.type=nameArray[0];
								tempjson.name=nameArray[1];
								tempjson.modelId = parm4;
								tempjson.isBrand = parm3;
								if($scope.newArraynameArray.length <= 4){
									$scope.newArraynameArray.push(tempjson);
								}
							}else{
								//checkBox
								for(var i=0;i<$scope.NewList.length;i++){
									if($scope.NewList[i]==parm){
										$scope.NewList.splice(i,1);
										break;
									}
								}
								if(parm3 == 'brandImg'){
									//点击后DIV显示效果
									divs.style.borderColor = "gray";
									divs.style.backgroundImage="url(../../../media/images/white.png)";
								}
								//计数，大于5的依据
								for(var i=0;i<$scope.TestList.length;i++){
									if($scope.TestList[i]==parm){
										$scope.TestList.splice(i,1);
										break;
									}
								}
								//DIV里面已选条件显示
								for(var i=0;i<$scope.newArraynameArray.length;i++){
									if($scope.newArraynameArray[i].name==parm){
										$scope.newArraynameArray.splice(i,1); 
										break;
									}
								}
							}
							
							//如果没有选择任何多选的值，则选择按钮和其他效果都不显示
							if($scope.NewList.length == 0){
								if(parm3 == 'standard'){
									$scope.standardSubShow=false;
								}
								else if(parm3 == 'model'){
									$scope.sheBZTSubShow=false;
								}
								else if(parm3 == 'brandImg'){
									$scope.brandSubShow=false;
									$scope.TermShow=false;
								}
							}
							else if($scope.NewList.length > 0 && $scope.NewList.length < 5){
								if(parm3 == 'standard'){
									$scope.standardSubShow=true;
								}else if(parm3 == 'model'){
									$scope.sheBZTSubShow=true;
								}
								else if(parm3 == 'brandImg'){
									$scope.brandSubShow=true;
									$scope.TermShow=true;
								}
							}
						};

						/*
						 *业务状态多选状态下确定提交事件
						 */
						$scope.modelDiv = true;
						$scope.standardDiv = true;
						$scope.standarDivShow=true;
						$scope.modelDivShow = true;
						$scope.brandDivShow=true;
						$scope.submitClick=function(parm){
							$scope.displayCondition($scope.NewList,parm);
							if(parm == 'yeWZT'){
								$scope.yeWZTSubShow=true;
								if($scope.NewList.length >= 1 && $scope.NewList.length <= 5){
									$scope.yeWZTDiv=true;
									$scope.yeWZTDivShow = false;
									$scope.yeWZTShow=true;
									$scope.yeWZTShowDX=false;
									$scope.yeWZTSubShow=false;
									$scope.yewuDX=true;
									$scope.yewuQX=false;
									$scope.chModel=false;
								}
							}
							else if(parm == 'standard'){
								$scope.standardSubShow=true;
								if($scope.NewList.length >= 1 && $scope.NewList.length <= 5){
									$scope.standarDivShow=false;
									$scope.standardDiv=true;
									$scope.standardShow=true;
									$scope.standardShowDX=false;
									$scope.standardSubShow=false;
									$scope.standardDX=true;
									$scope.standardQX=false;
									$scope.chModel=false;
								}
							}
							else if(parm == 'model'){
								$scope.sheBZTSubShow=true;
								if($scope.NewList.length >= 1 && $scope.NewList.length <= 5){
									$scope.modelDivShow = false;
									$scope.modelDiv=true;
									$scope.modelShow=true;
									$scope.modelShowDX=false;
									$scope.sheBZTSubShow=false;
									$scope.modelDX=true;
									$scope.modelQX=false;
									$scope.chModel=false;
								}
							}
							else if(parm == 'brandImg'){
								$scope.brandBtnClose();
								//如果为多选 则型号和规格条件去掉
								var varityCho =[];
								for(var i = 0; i < $scope.arraynameArray.length;i++){
									if($scope.arraynameArray[i].type == "brandImg"){
										varityCho = $scope.arraynameArray[i].name.split(",");
									}
								}
								if(varityCho.length >1){
									var myArray = new window.arrayFactory($scope.arraynameArray);
									$scope.arraynameArray=myArray.removeType("model");
									myArray = new window.arrayFactory($scope.arraynameArray);
									$scope.arraynameArray=myArray.removeType("standard");
								};
								$scope.brandDivShow=false;
							}
							$scope.clearChoice();
						};

						/*
						 *所属单位，input点击显示-----------------------------------------------------------------------所属单位
						 */
						$scope.xiName = "";
						$scope.inputDeptName = {deptName:SYS_USER_INFO.orgName};
						$scope.shownextlevel=true;


						/*
						 *所在城市，input点击显示-----------------------------------------------------------------------所在城市
						 */
						/* var b = 0;
						$scope.cityList = [];
						$scope.abcInputClick = function() {
							if (b == 0) {
								$scope.uiShow = true;
								b++;
							} else {
								$scope.uiShow = false;
								b = 0
							}
							$scope.cityAClick('A');
						};
 */
						/*
						 *所在城市ng-change事件（）
						 */
						/* $scope.abcInputChange = function(parm) {
							if (parm) {

							}
						}; */

						/*
						 *所在城市，城市点击事件（点击城市显示在input输入框）
						 */
						/* $scope.ValueClick = function(parm) {
							if (parm) {
								$scope.abcInputValue = parm.name;
								$scope.uiShow = false;
								b = 0
							}
						}; */
						/*
						 * 设备名称点击事件 (点击设备名称显示在input输入框)
						 */
						/*  $scope.deviceNameValueClick = function(parm) {
							var valuejson = {
								"device" : parm.equipmentName
							};
							var namejson = {
								"device" : parm.equipmentName
							};
							$scope.displayCondition(namejson);
							if (parm) {
								$scope.deviceNameInputValue = parm.equipmentName;
								 //$scope.uiShow = false;
								b = 0;
							}
							$scope.equipmentClick();
						};  */
						/*
						 *条件搜索
						 */
						$scope.searchClick = function() {
							for (var i = 0; i < $scope.arraynameArray.length; i++) {
							}

						}
						
						$scope.inputPrice = function(parm){
							if(!$scope.minPrice&&!$scope.maxPrice){
								return;
							}
							switch (parseInt($scope.priceUnit.price)) {
							case 1:
								parm ='元/月';
								
								break;

							case 2:
								parm ='元/天';
								break;
							case 3:
								parm ='元/小时';
									break;
							default:
								break;
							}
							/* if(!isNaN(parm)){
								parm = (parm == "1"?'元/月':parm == "2"?'元/天':'元/小时');
							} */
							var temp = ($scope.minPrice?$scope.minPrice:"" )+"-"+($scope.maxPrice?$scope.maxPrice:"")+" " +parm;
							var valuejson={"price":'price'};
							var namejson={"price":temp};
							$scope.processParam(valuejson);
							$scope.displayCondition(namejson);
						};
						
						$scope.checkPrice = function(plagParm,n){
							var reg="^\\d+$";
							if(n!=null&&!isNaN(n)){
								n=Number(n);
							}else{
								n=null;
							}
							if(plagParm){
								if(n == null || n ==""){
									$scope.minPrice = n;
									return;
								}
								if($scope.maxPrice == null || $scope.maxPrice == ""){
									$scope.minPrice = n;
								}else{
									if(n < $scope.maxPrice){
										$scope.minPrice = n;
										}else{
											$scope.minPrice = null;
											alert("不能大于等于上限");
										}
								}
							}else{
								if(n == null || n ==""){
									$scope.maxPrice = n;
									return;
								}
								if($scope.minPrice == null && $scope.minPrice == ""){
									$scope.maxPrice = n;
								}else{
									if(n > $scope.minPrice){
										$scope.maxPrice = n;
									}else{
										if($scope.minPrice!=null){
											$scope.maxPrice=null;
											alert("不能小于等于下限");
										}
										
										
									}
								}
							}
						}
						
						
						
						
						$scope.ggisradioorcheckbox=true;
						$scope.ggdxbtn1=function(){
							$scope.clearggalinstyle();
							$scope.ggisradioorcheckbox=false;
							ggdx1.style.display="none";
							ggdx2.style.display="block";
							ggdxdiv1.style.display="block";
							ggdxdiv2.style.display="block";
						}
						$scope.ggdxbtn2=function(){
							$scope.guigenamearr=[];
							$scope.clearggalinstyle();
							$scope.ggisradioorcheckbox=true;
							ggdx2.style.display="none";
							ggdx1.style.display="block";
							ggdxdiv1.style.display="none";
							ggdxdiv2.style.display="none";
						}
						$scope.delggseled=function(o,l){
							$scope.guigenamearr.splice(l,1);
							var ggarry=document.getElementById("ggalink").getElementsByTagName('a');
					 		for(var i=0;i<$scope.standardList.length;i++){
								if($scope.standardList[i].name==o.name){
									ggarry[i].className="";
								}
							} 
						}
						$scope.ggdxsure=function(){
							
							var ggdxnameview="";
							if($scope.guigenamearr.length>1){
								for(var i=0;i<$scope.guigenamearr.length-1;i++){
									ggdxnameview=ggdxnameview+$scope.guigenamearr[i].name+",";
								}
								ggdxnameview=ggdxnameview+$scope.guigenamearr[$scope.guigenamearr.length-1].name;
								
							}else{
								if($scope.guigenamearr[0]!=null)
									ggdxnameview=$scope.guigenamearr[0].name;
							}
							if(ggdxnameview!=""){
							$scope.displayCondition({"standard":ggdxnameview});
							}
							$scope.ggdxbtn2();
						}
						$scope.dxbtn1show=true;
						$scope.showa1=true;
						$scope.showdxbtn=function(){
							$scope.dxbtn1show=false;
							$scope.dxbtn2show=false;
							$scope.dxbtn3show=false;
							$scope.showa1=false;
							$scope.showa2=false;
							$scope.showa3=false;
						}

						$scope.gdbtnclick1=function(){
							ihhaduox.className='diood_k genduo1'; 
							$scope.showdxbtn();
							$scope.dxbtn2show=true;
							$scope.showa2=true;
						}

						$scope.gdbtnclick2=function(){
							ihhaduox.className='diood_k';
							$scope.showdxbtn();
							$scope.dxbtn1show=true;
							$scope.showa1=true;
							
						}
						
						$scope.isradioorcheckbox=true;
						$scope.dxbtnclick1=function(){
							allbrand.style.display="";
							var allbrandspan=document.getElementById("allbrand").getElementsByTagName('span');
							for(var i=0;i<allbrandspan.length;i++){
								allbrandspan[i].id="allbranditem"+i;
							} 
							ihhaduox.className='diood_k';
							dxanniu.style.display='block';
							$scope.clearbrandstyle();
							$scope.isradioorcheckbox=false;
							dxshow.style.display="block";
							ihhaduox.className='diood_k genduo1';

							$scope.showdxbtn();
							$scope.dxbtn3show=true;
							$scope.showa3=true;
						}
						$scope.dxbtnclick2=function(){
							$scope.uploadBrand();
							allbrand.style.display="none";
							ihhaduox.className='diood_k';
							dxanniu.style.display='none';
							$scope.isradioorcheckbox=true;
							ihhaduox.className='diood_k';
							dxshow.style.display="none";
							$scope.showdxbtn();
							$scope.dxbtn1show=true;
							$scope.showa1=true;
							$scope.clearbrandstyle();
							$scope.brandname=[];
						}
						
						$scope.suredx=function(){
							var brandnamecash="";
							if($scope.brandname.length>1){
								for(var i=0;i<$scope.brandname.length-1;i++){
									brandnamecash=brandnamecash+$scope.brandname[i].name+",";
								}
								brandnamecash=brandnamecash+$scope.brandname[$scope.brandname.length-1].name;
								
							}else{
								if(brandnamecash!="")
								brandnamecash=$scope.brandname[0].name;
							}
							if(brandnamecash!=""){
							$scope.displayCondition({"brandImg":brandnamecash});
							}
							$scope.dxbtnclick2();
						}
						$scope.delbrandname=function(o,l){
							var arra=document.getElementById("radioimggroup").getElementsByTagName("a");
							$scope.brandname.splice(l,1);
							
					 		for(var i=0;i<$scope.brandList.length;i++){
								if($scope.brandList[i].name==o.name){
									arra[i].className="";
								}
							} 
						}
						$scope.ismodelradioorcheckbox=true;
						$scope.modeldx=function(){
							
							document.getElementById("modeldx2").style.display='block';
							document.getElementById("modeldx1").style.display='none';
							$scope.clearmodelalinkstyle();
							$scope.ismodelradioorcheckbox=false;
							document.getElementById("gunge1").style.display='';
							document.getElementById("modelselected").style.display='';
							gunge.className='iodfpq left genduo2';
						}
						$scope.delmodelseled=function(o,l){
							var xharry=document.getElementById("gunge").getElementsByTagName('a');
							$scope.modelnamearr.splice(l,1);
					 		for(var i=0;i<$scope.modelList.length;i++){
								if($scope.modelList[i].name==o.name){
									xharry[i].className="";
								}
							} 
						}
						$scope.modeldxsure=function(){
							var modelnameview="";
							if($scope.modelnamearr.length>1){
								for(var i=0;i<$scope.modelnamearr.length-1;i++){
									modelnameview=modelnameview+$scope.modelnamearr[i].name+",";
								}
								modelnameview=modelnameview+$scope.modelnamearr[$scope.modelnamearr.length-1].name;
								
							}else{
								if($scope.modelnamearr[0]!=null)
								modelnameview=$scope.modelnamearr[0].name;
							}
							if(modelnameview!=""){
							$scope.displayCondition({"model":modelnameview});
							}
							$scope.modeldxcancle();
						}
						$scope.modeldxcancle=function(){
							$scope.clearmodelalinkstyle();
							$scope.ismodelradioorcheckbox=true;
							$scope.modelnamearr=[];
							document.getElementById("modeldx1").style.display='block';
							document.getElementById("modeldx2").style.display='none';
							document.getElementById("gunge1").style.display='none';
							document.getElementById("modelselected").style.display='none';
						}
						$scope.moreselect=function(){
							morebtn.style.display="none";
							lessbtn.style.display="block";
							morecontent.style.display="table-row-group";
						}
						$scope.lessselect=function(){
							morebtn.style.display="block";
							lessbtn.style.display="none";
							morecontent.style.display="none";
						}
						/*
						*所属单位，input点击显示-----------------------------------------------------------------------所属单位
						*/
						$scope.xiName="";
						$scope.inputDeptName=SYS_USER_INFO.orgName;
						//$scope.abcInputValue = SYS_USER_INFO.cityName;
						$scope.oreCode = SYS_USER_INFO.orgCode;
						
						
						
						$scope.xjClick = function(type, parm,parm1,parm2,parm3) {
							
							
							if(a.orgLevel==3||a.orgLevel==6){
								$scope.shownextlevel=false;
							}else{
								$scope.shownextlevel=true;
								
							}
							if (type == "dept") {//业务状态
								var valuejson = {"dept":parm};
								var namejson =  {"dept":parm};
							}
							$scope.displayCondition(namejson);
							$scope.inputDeptName = parm;
							workitem.style.display='none';
							if(parm1&&parm2){
								$scope.oreCode = parm1;
								$scope.queryNextDepts(parm,parm2);
								}else{
									$scope.containNext = false;
									$scope.reason2.rec=false;
									$scope.oreCode = null;
								}
							
							$scope.showLevel = parm3.orgLevel;
						};
						
						/*
						*所在城市，input点击显示-----------------------------------------------------------------------所在城市
						*/
						/* var b=0;
						$scope.cityList=[];
						$scope.abcInputClick=function(){
							if(b == 0){
								$scope.uiShow = true;
								b++;
							}else{
								$scope.uiShow = false;
								b=0
							}
							$scope.cityAClick('A');
						}; */
						
						/*
						*所在城市ng-change事件（）
						*/
						/* $scope.abcInputChange=function(parm){
							if(parm){
								
							}
						}; */
						
						/*
						*所在城市，城市点击事件（点击城市显示在input输入框）
						*/
						/* $scope.ValueClick=function(parm){
							if(parm){
								$scope.abcInputValue=parm.name;
								$scope.uiShow = false;
								b=0
							}
						}; */
						/* 清空城市列表样式 */
						

						
						$scope.citynoshow=function(){
							$scope.recPro.proModel = '';
							/* riqi1.style.display='';
							citya.style.display="none";
							citye.style.display="none";
							cityj.style.display="none";
							cityn.style.display="none";
							cityt.style.display="none";
							cityy.style.display="none";
							ali.className="";
							eli.className="";
							jli.className="";
							nli.className="";
							tli.className="";
							yli.className=""; */
						}

						/*
						*点击ABCD -- 所在城市
						*/	
						/* $scope.cityAClick=function(parm){
							$scope.citynoshow();
							citya.style.display="block";
							ali.className="date_xz";
							//citya.className="date_xz";
							
							if(parm == "A"){
								$scope.cityList=["A","B","C","D"];
								function qSucc(rec){
											$scope.cityValueListA=rec.A;
											$scope.cityValueListB=rec.B;
											$scope.cityValueListC=rec.C;
											$scope.cityValueListD=rec.D;
								}
								function qErr(){}
								published.unifydoHM({Action:"RegionNameFpy"},{fpy:$scope.cityList},qSucc,qErr); 
							}
							$scope.cityA=true;
							
							 if(document.activeElement.id=='city_id'){
						    	 $("#city_id").blur()
					         }
						}; */
						
						/*
						*点击EFGH -- 所在城市
						*/	
						/* $scope.cityEClick=function(parm){
							$scope.citynoshow();
							citye.style.display="block";
							eli.className="date_xz";
							if(parm == "E"){
								$scope.cityList=["E","F","G","H"];
								function qSucc(rec){
									$scope.cityValueListE=rec.E;
									$scope.cityValueListF=rec.F;
									$scope.cityValueListG=rec.G;
									$scope.cityValueListH=rec.H;
								}
								function qErr(){}
								published.unifydoHM({Action:"RegionNameFpy"},{fpy:$scope.cityList},qSucc,qErr); 
							}
							$scope.cityE=true;
						}; */
						
						/*
						*点击JKLM -- 所在城市
						*/	
						/* $scope.cityJClick=function(parm){
							$scope.citynoshow();
							cityj.style.display="block";
							jli.className="date_xz";
							if(parm == "J"){
								$scope.cityList=["J","K","L","M"];
								function qSucc(rec){
									$scope.cityValueListJ=rec.J;
									$scope.cityValueListK=rec.K;
									$scope.cityValueListL=rec.L;
									$scope.cityValueListM=rec.M;

								}
								function qErr(){}
								published.unifydoHM({Action:"RegionNameFpy"},{fpy:$scope.cityList},qSucc,qErr); 
							}
							$scope.cityJ=true;
						}; */
							
						/*
						*点击NOPQRS -- 所在城市
						*/	
						/* $scope.cityNClick=function(parm){
							$scope.citynoshow();
							cityn.style.display="block";
							nli.className="date_xz";
							if(parm == "N"){
								$scope.cityList=["N","O","P","Q","R","S"];
								function qSucc(rec){
									$scope.cityValueListN=rec.N;
									$scope.cityValueListP=rec.P;
									$scope.cityValueListQ=rec.Q;
									$scope.cityValueListR=rec.R;
									$scope.cityValueListS=rec.S;
								}
								function qErr(){}
								published.unifydoHM({Action:"RegionNameFpy"},{fpy:$scope.cityList},qSucc,qErr); 
							}
							$scope.cityN=true;
						}; */
						
						/*
						*点击TUVWX -- 所在城市
						*/	
						/* $scope.cityTClick=function(parm){
							$scope.citynoshow();
							cityt.style.display="block";
							tli.className="date_xz";
							if(parm == "T"){
								$scope.cityList=["T","U","V","W","X"];
								function qSucc(rec){
									$scope.cityValueListW=rec.W;
									$scope.cityValueListT=rec.T;
									$scope.cityValueListX=rec.X;
								}
								function qErr(){}
								published.unifydoHM({Action:"RegionNameFpy"},{fpy:$scope.cityList},qSucc,qErr); 
							}
							$scope.cityT=true;
						}; */
						
						/*
						*点击YZ -- 所在城市
						*/	
						/* $scope.cityYClick=function(parm){
							$scope.citynoshow();
							cityy.style.display="block";
							yli.className="date_xz";
							if(parm == "Y"){
								$scope.cityList=["Y","Z"];
								function qSucc(rec){
									$scope.cityValueListY=rec.Y;
									$scope.cityValueListZ=rec.Z;
								}
								function qErr(){}
								published.unifydoHM({Action:"RegionNameFpy"},{fpy:$scope.cityList},qSucc,qErr); 
							}
							$scope.cityY=true;
						}; */
						
						
						
						
						/*
						*设备名称，input点击显示-----------------------------------------------------------------------设备名称
						*/
						var c=0;
						$scope.equipmentClick=function(){
						
							$scope.deviceNameAClick('A','deviceNameAID');
						};
						
						/*
						* 设备名称点击事件 (点击设备名称显示在input输入框)
						*/
						/* $scope.deviceNameValueClick=function(parm){
							riqi2.style.display='none';
							var valuejson={"device":parm.equipmentName};
							var namejson={"device":parm.equipmentName};
							$scope.displayCondition(namejson);
							if(parm){
								$scope.deviceNameInputValue=parm.equipmentName;
								// $scope.uiShow = false; 
								 b=0; 
							}
							//$scope.equipmentClick();
						};
 						*/
						$scope.clearshebeishowbol=function(){
							riqi2.style.display='';
							devicea.style.display="none";
							devicee.style.display="none";
							devicej.style.display="none";
							devicen.style.display="none";
							devicet.style.display="none";
							devicey.style.display="none";
							ali1.className="";
							eli1.className="";
							jli1.className="";
							nli1.className="";
							tli1.className="";
							yli1.className="";
						}
						/*
						* 点击ABCD 设备名称
						*/
						$scope.deviceNameList=[];
						$scope.deviceNameAClick=function(parm,parm1){
							if(parm == "A"){
								$scope.deviceNameList=["A","B","C","D"];
								function qSucc(rec){
									$scope.deviceNameValueListA=rec.A;
									$scope.deviceNameValueListB=rec.B;
									$scope.deviceNameValueListC=rec.C;
									$scope.deviceNameValueListD=rec.D;
								}
								function qErr(){}
								published.unifydoHM({Action:"EquNameFpy"},{fpy:$scope.deviceNameList},qSucc,qErr); 
							}
							$scope.clearshebeishowbol();
							ali1.className="date_xz";
							devicea.style.display="block";
							
							 if(document.activeElement.id=='name_id'){
					              $("#name_id").blur();
					          }
						};
						
						/*
						* 点击EFGH 设备名称
						*/
						$scope.deviceNameEClick=function(parm,parm1){
							if(parm == "E"){
								$scope.deviceNameList=["E","F","G","H"];
								function qSucc(rec){
									$scope.deviceNameValueListE=rec.E;
									$scope.deviceNameValueListF=rec.F;
									$scope.deviceNameValueListG=rec.G;
									$scope.deviceNameValueListH=rec.H;
								}
								function qErr(){}
								published.unifydoHM({Action:"EquNameFpy"},{fpy:$scope.deviceNameList},qSucc,qErr); 
							}
							$scope.clearshebeishowbol();
							eli1.className="date_xz";devicee.style.display="block";
						};
						
						/*
						* 点击JKLM 设备名称
						*/
						$scope.deviceNameJClick=function(parm,parm1){
							if(parm == "J"){
								$scope.deviceNameList=["J","K","L","M"];
								function qSucc(rec){
									$scope.deviceNameValueListJ=rec.J;
									$scope.deviceNameValueListK=rec.K;
									$scope.deviceNameValueListL=rec.L;
									$scope.deviceNameValueListM=rec.M;
								}
								function qErr(){}
								published.unifydoHM({Action:"EquNameFpy"},{fpy:$scope.deviceNameList},qSucc,qErr); 
							}
							$scope.clearshebeishowbol();
							jli1.className="date_xz";devicej.style.display="block";
						};
						
						/*
						* 点击NOPQRS 设备名称
						*/
						$scope.deviceNameNClick=function(parm,parm1){
							if(parm == "N"){
								$scope.deviceNameList=["N","O","P","Q","R","S"];
								function qSucc(rec){
									$scope.deviceNameValueListN=rec.N;
									$scope.deviceNameValueListP=rec.P;
									$scope.deviceNameValueListQ=rec.Q;
									$scope.deviceNameValueListR=rec.R;
									$scope.deviceNameValueListS=rec.S;
								}
								function qErr(){}
								published.unifydoHM({Action:"EquNameFpy"},{fpy:$scope.deviceNameList},qSucc,qErr); 
							}
							$scope.clearshebeishowbol();
							nli1.className="date_xz";devicen.style.display="block";
						};
						
						/*
						* 点击TUVWX 设备名称
						*/
						$scope.deviceNameTClick=function(parm,parm1){
							if(parm == "T"){
								$scope.deviceNameList=["T","U","V","W","X"];
								function qSucc(rec){
									$scope.deviceNameValueListT=rec.T;
									$scope.deviceNameValueListW=rec.W;
									$scope.deviceNameValueListX=rec.X;
								}
								function qErr(){}
								published.unifydoHM({Action:"EquNameFpy"},{fpy:$scope.deviceNameList},qSucc,qErr); 
							}
							$scope.clearshebeishowbol();		tli1.className="date_xz";devicet.style.display="block";
						};
						
						/*
						* 点击YZ 设备名称
						*/
						$scope.deviceNameYClick=function(parm,parm1){
							if(parm == "Y"){
								$scope.deviceNameList=["Y","Z"];
								function qSucc(rec){
									$scope.deviceNameValueListY=rec.Y;
									$scope.deviceNameValueListZ=rec.Z;
								}
								function qErr(){}
								published.unifydoHM({Action:"EquNameFpy"},{fpy:$scope.deviceNameList},qSucc,qErr); 
							}
						$scope.clearshebeishowbol();		yli1.className="date_xz";devicey.style.display="block";
						};
						
						$scope.overallbrand=function(p){
							$scope.clearbrandstyle();
							$scope.clearallbrand();
							document.getElementById("allbranditem"+p).style.border="1px solid #1db100";
							for(var i=0;i<$scope.abcList.length;i++){
								if($scope.abcList[i].abcValue==p){
									var abcname=$scope.abcList[i].abcName;
									var fpys = ['A','B','C','D','E','F','G','H','I','G','k','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
									published.unifydoHM({Action:"EquBrandFpy"},{fpy:[$scope.abcList[i].abcName]},function(rec){
										$scope.brandList=rec[abcname];
									return;
									},function(rec){
										return;
									});
								}
							}
						}
						$scope.addbrandstyle=function(){

							var arra=document.getElementById("radioimggroup").getElementsByTagName("a");
							for(var i=0;i<$scope.brandList.length;i++){
								for(var j=0;j<$scope.brandname.length;j++){
									if($scope.brandList[i].name==$scope.brandname[j].name){
										arra[i].className='ihhagouxuan';
									}
								}
								
							} 
							
						}
						$scope.clearallbrand=function(p){
							var allbrandspan=document.getElementById("allbrand").getElementsByTagName('span');
							for(var i=0;i<allbrandspan.length;i++){
								allbrandspan[i].style.border="1px solid white";
							} 
						}
						$scope.leavebrand=function(){
							$scope.clearbrandstyle();
							$scope.addbrandstyle();
						}
						$scope.workblur=function(){
							workitem.style.display='none';
						}
						$scope.clearInput = function(){
							$scope.searBean.infoTitleBean=null;
							$scope.LiNumB = false;
							$scope.LiNumA = false;
							$("#clearFlag")[0].style.display = "none";
						}
						if(SYS_USER_INFO.orgId!=null&&SYS_USER_INFO.orgId!=""){
							workwhich.style.display="table-row";
						}
						$scope.priceUnit.price=null;
						$scope.iswaibuorneibu=false;
						if("${sessionScope.userInfo.partyTypeId}"==6){
							$scope.iswaibuorneibu=true;
						}
						
						
						
						$scope.cityOut = true;//所在城市标识
						$scope.nameOut = true;//设备名称标识
						$scope.compOut = true;//所属单位标识
						//鼠标移入div
						$scope.mouseOverFun = function(){
							$scope.cityOut = false;
							$scope.nameOut = false;
							$scope.compOut = false;
						};
						//鼠标移出div
						$scope.mouseLeaveFun = function(){
							$scope.cityOut = true;
							$scope.nameOut = true;
							//$scope.compOut = true;
						};
		/* 				//点击鼠标时判断满足条件就隐藏div
						document.onmousedown=function(){
							 if(riqi1.style.display!='none'&& $scope.cityOut == true){
								 setTimeout(function(){
									 riqi1.style.display = 'none';
								 },100);
							 } 
							 
							 if(riqi2.style.display!='none'&& $scope.nameOut == true){
								 setTimeout(function(){
									 riqi2.style.display = 'none';
								 },100);
							 } 
					    } */
						
						
						$scope.B = function(parm){
							if(parm){
								$scope.searchPublished(1, parm);
							}
						};
						
						/*
						 * 点击搜索事件
						*/
						$scope.searchPublished=function(val,parm){//val是1，parm是传的输入值
							$scope.insertCache(parm);
							$scope.querySearchHotWords(parm);
							var searchType=$("#searchType").val();
							var searchContent=$("#searchContent").val();
							if($scope.selectSearchName){
								$('#searchVal').attr("href",searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm);
								/* document.getElementById("searchVal").click(); */
								setTimeout(function(){
								window.open(searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm,"_self");
							},500);
							}else{
								$('#searchVal').attr("href",searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm);
								/* document.getElementById("searchVal").click(); */
								setTimeout(function(){
								window.open(searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm,"_self");
							},500);
							}
						};
						
						
						
						$scope.changeFlag = true;
						$scope.overChangeFlag = function(){
							$scope.changeFlag = false;
						};
						
						$scope.leaveChangeFlag = function(){
							$scope.changeFlag = true;
						};
						
						$scope.changeQueryFlag = true;
						$scope.overChangeQueryFlag = function(){
							$scope.changeQueryFlag = false;
						};
						
						$scope.leaveChangeQueryFlag = function(){
							$scope.changeQueryFlag = true;
						};
						
						document.onmousedown = function(){
							if($scope.changeFlag == true && $scope.LiNumB == true){
								parentOrgs2.style.display = 'none';
								a = 0;
							}
							
							if($scope.changeQueryFlag == true && $scope.LiNumA == true){
								parentOrgs1.style.display = 'none';
							}
							
						};
						
						$scope.changeEquName = function(pram){
							if(pram.equNameId)
							{
								//型号
								function succ(rec){
									$scope.modelList = rec.content;
								}
								function err(rec){}
								busEquParameterSvc.unifydo({action:"GET_BUS_EQU_NAME_PARAMETER",equNameId:pram.equNameId,type:3,status:1,},succ,err);
								
								//规格
								function Succ(rec){
									$scope.standardList = rec.content;
								}
								function Err(rec){}
								busEquParameterSvc.unifydo({action:"GET_BUS_EQU_NAME_PARAMETER",equNameId:pram.equNameId,type:4,status:1},Succ,Err);
							}
							else
							{
								$scope.modelList=[];
								$scope.standardList=[];
							}
						}
				
				
				
				$scope.equQryBean = {};
				$scope.equQryBean.isInclude = 0;
				$scope.equQryBean.isCrecOrg = 0;
				if(SYS_USER_INFO.proName){
					$scope.equQryBean.equAtOrgNameSelect = SYS_USER_INFO.proName;
				}else{
					$scope.equQryBean.equAtOrgNameSelect = SYS_USER_INFO.orgName;
				}
				
				$scope.inputDeptName = SYS_USER_INFO.orgName;
				
				/* 资源管理列表查询分页标签参数配置 */
				$scope.paginationConfOrgORProject = {
					currentPage: 1,/** 当前页数 */
					totalItems: 1,/** 数据总数 */
					itemsPerPage: 10,/** 每页显示多少 */
					pagesLength: 10,/** 分页标签数量显示 */
					perPageOptions: [10, 20, 30, 40],
					onChange: function(currentPage){
						if($scope.queryEquAtEmployer.currOrgId){
							$scope.clickEquAtProjects(currentPage);
							}
					}
				};
				
				$scope.equAtEmployers = [];
				$scope.equAtEmployer = {};
				$scope.queryEquAtEmployer = {};
				$scope.equAtCheck = true;	//	项目选项 显示标志
				$scope.queryEquAtEmployer.check = false;	//	项目选项值
				$scope.checkEquAtTrEmployer = true;	//	列名称 - 单位名称 显示标志
				$scope.checkEquAtTrProjects = false;	//	列名称 - 项目名称 显示标志
				
                /*
                   打开所在单位的模态选择框
                */
				$scope.openEquAtEmployerModel = function(){
					if($scope.equAtEmployers.length==0){//	首次打开
						$scope.queryEquAtEmployer.currOrgId =1;
						$scope.queryEquAtEmployer.currOrgName='总公司';
						/** 放入单位信息，且查询该组织下的机构/项目 */
						$scope.equAtEmployers = [{name: $scope.queryEquAtEmployer.currOrgName, currOrgId: $scope.queryEquAtEmployer.currOrgId, orgFlag: 9}];

						$scope.queryEquAtEmployer.pageNo = 0;
						$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

						$scope.checkEquAtTrProjects = false;
						$scope.checkEquAtTrEmployer = true;
						$scope.queryEquAtEmployer.check = false;
						$scope.equAtCheck = true;

						/** 根据currOrgId，查询该组织下的机构 begin */
						function qSucc2(rec){
							$scope.equAtEmployerList = rec.content;
							$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
							$('#equAtEmployerModel').modal('show');
						}
						function qErr2(){
						
						}
						entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc2, qErr2);
						/** 根据currOrgId，查询该组织下的机构 end */
					}
					else{//	非首次打开
						$('#equAtEmployerModel').modal('show');
					}
				};                
// 				$scope.openEquAtEmployerModel = function(){
// 					if($scope.equAtEmployers.length==0){//	首次打开
// 						var orgLv;
// 						if(1==$scope.userInfo.orgLevel){
// 							orgLv = 9;
// 						}
// 						else if(2==$scope.userInfo.orgLevel){
// 							orgLv = 1;
// 						}
// 						else if(3==$scope.userInfo.orgLevel){
// 							orgLv = 2;
// 						}

// 						$scope.queryEquAtEmployer.currOrgId = $scope.userInfo.orgId;

// 						/** 放入单位信息，且查询该组织下的机构/项目 */
// 						$scope.equAtEmployers = [{name: $scope.userInfo.orgName, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

// 						$scope.queryEquAtEmployer.pageNo = 0;
// 						$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

// 						if(2==orgLv){
// 							$scope.checkEquAtTrProjects = true;
// 							$scope.checkEquAtTrEmployer = false;
// 							$scope.queryEquAtEmployer.check = true;
// 							$scope.equAtCheck = false;

// 							/** 根据currOrgId，查询该组织下的项目 begin */
// 							function qSucc(rec){
// 								$scope.equAtEmployerList = rec.content;
// 								$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
// 								$('#equAtEmployerModel').modal('show');
// 							}
// 							function qErr(){
								
// 							}
// 							proSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
// 							/** 根据currOrgId，查询该组织下的项目 end */
// 							}
// 						else{
// 							$scope.checkEquAtTrProjects = false;
// 							$scope.checkEquAtTrEmployer = true;
// 							$scope.queryEquAtEmployer.check = false;
// 							$scope.equAtCheck = true;

// 							/** 根据currOrgId，查询该组织下的机构 begin */
// 							function qSucc2(rec){
// 								$scope.equAtEmployerList = rec.content;
// 								$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
// 								$('#equAtEmployerModel').modal('show');
// 							}
// 							function qErr2(){
								
// 							}
// 							entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc2, qErr2);
// 							/** 根据currOrgId，查询该组织下的机构 end */
// 						}
// 					}
// 					else{//	非首次打开
// 						$('#equAtEmployerModel').modal('show');
// 					}
// 				};
				

				/* 点击查询下级单位，且保存点击的机构信息 */
				$scope.clickEquAtEmployer = function(currentPage, orgInfo){
					if(currentPage)
					{
						$scope.paginationConfOrgORProject.currentPage = currentPage;
					}

					var orgLv;
					if(1==orgInfo.orgLevel){
						orgLv = 9;
					}
					else if(2==orgInfo.orgLevel){
						orgLv = 1;
					}
					else if(3==orgInfo.orgLevel){
						orgLv = 2;
					}

					/** 保存点击的机构信息 */
					$scope.equAtEmployer = {};

					$scope.equAtEmployer.name = orgInfo.name;
					$scope.equAtEmployer.currOrgId = orgInfo.currOrgId;
					$scope.equAtEmployer.orgFlag = orgLv;
					$scope.equAtEmployer.code = orgInfo.code;
					$scope.equAtEmployers.push($scope.equAtEmployer);

					$scope.queryEquAtEmployer.currOrgId = orgInfo.currOrgId;

					if(2==orgLv){/** 处级单位 */
						$scope.checkEquAtTrProjects = true;
						$scope.checkEquAtTrEmployer = false;
						$scope.queryEquAtEmployer.check = true;
						$scope.equAtCheck = false;

						$scope.qryEquAtProject();
					}
					else{/** 总公司/局级单位 */
						$scope.checkEquAtTrProjects = false;
						$scope.checkEquAtTrEmployer = true;
						$scope.queryEquAtEmployer.check = false;
						$scope.equAtCheck = true;

						$scope.qryEquAtEmployer();
					}
				};
				
				/* 点击项目，变更保存的项目信息 */
				$scope.clickEquAtProject = function(orgInfo){
					/** 变更保存点击的项目信息 */
					$scope.equAtEmployer = {};
					$scope.equAtEmployer.code = orgInfo.code; 
					$scope.equAtEmployer.name = orgInfo.name;
					$scope.equAtEmployer.currOrgId = orgInfo.currOrgId;
					$scope.equAtEmployer.orgFlag = 3;

					var employersLength = $scope.equAtEmployers.length;
					if(employersLength>0 && 3==$scope.equAtEmployers[employersLength - 1].orgFlag){
						$scope.equAtEmployers.splice(employersLength - 1, 1);
					}
					$scope.equAtEmployers.push($scope.equAtEmployer);
				};
				
				
				/* 点击当前位置的单位/项目，变更当前位置、单位/项目列表 */
				$scope.clickEquAtEmployers = function(currentPage, orgInfo, employersIndex){
					if(currentPage)
					{
						$scope.paginationConfOrgORProject.currentPage = currentPage;
					}

					/** 变更当前位置 */
					var employersLength = $scope.equAtEmployers.length;
					if(employersLength<=0){
						return ;
					}

					$scope.equAtEmployers.splice(employersIndex + 1, employersLength - employersIndex - 1);

					/** 保存点击的机构信息 */
					$scope.queryEquAtEmployer.currOrgId = orgInfo.currOrgId;

					var orgLv = $scope.equAtEmployers[employersIndex].orgFlag;
					if(3==orgLv){/** 项目 */
						return ;
					}
					else if(2==orgLv){/** 处级单位 */
						$scope.checkTrProjects = true;
						$scope.checkTrEmployer = false;
						$scope.queryEquAtEmployer.check = true;
						$scope.equAtCheck = false;

						$scope.qryEquAtProject();
					}
					else{/** 总公司/局级单位 */
						$scope.checkEquAtTrProjects = false;
						$scope.checkEquAtTrEmployer = true;
						$scope.queryEquAtEmployer.check = false;
						$scope.equAtCheck = true;

						$scope.qryEquAtEmployer();
					}
				};

				/* 勾选项目，根据当前位置的最下级单位id，查询单位/项目列表 */
				$scope.clickEquAtProjects = function(currentPage) {
					if(currentPage)
					{
						$scope.paginationConfOrgORProject.currentPage = currentPage;
					}

					var employersLength = $scope.equAtEmployers.length;
					if(employersLength<=0){
						return ;
					}

					if($scope.equAtEmployers[employersLength - 1].orgFlag==3){
						return ;
					}

					$scope.queryEquAtEmployer.currOrgId = $scope.equAtEmployers[employersLength - 1].currOrgId;

					if($scope.queryEquAtEmployer.check){
						$scope.checkEquAtTrProjects = true;
						$scope.checkEquAtTrEmployer = false;

						$scope.qryEquAtProject();
					}
					else{
						$scope.checkEquAtTrProjects = false;
						$scope.checkEquAtTrEmployer = true;

						$scope.qryEquAtEmployer();
					}
				};
				
				/* 根据currOrgId，查询该组织下的机构 */
				$scope.qryEquAtEmployer = function(){
					$scope.queryEquAtEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
					$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

					/** 根据currOrgId，查询该组织下的机构 begin */
					function qSucc(rec){
						$scope.equAtEmployerList = rec.content;
						$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
					}
					function qErr(){
						
					}
					entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
					/** 根据currOrgId，查询该组织下的机构 end */
				};
				
				/* 根据currOrgId，查询该组织下的项目 */
				$scope.qryEquAtProject = function(){
					$scope.queryEquAtEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
					$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

					/** 根据currOrgId，查询该组织下的项目 begin */
					function qSucc(rec){
						$scope.equAtEmployerList = rec.content;
						$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
					}
					function qErr(){
						
					}
					proSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
					/** 根据currOrgId，查询该组织下的项目 end */
				};
				
				/* 变更并关闭 选择单位/项目模态框 */
				$scope.modifyEquAtEmployerModel = function(val){
					$('#equAtEmployerModel').modal('hide');

					var employersLength = $scope.equAtEmployers.length;
					if(employersLength<=0){
						return ;
					}

					$scope.equAtEmployer = $scope.equAtEmployers[employersLength - 1];
					
					$scope.equQryBean.orgCode =  $scope.equAtEmployer.code;
					
					$scope.equQryBean.equAtOrgFlag = $scope.equAtEmployer.orgFlag;
					
					$scope.equQryBean.equAtOrgPartyId = $scope.equAtEmployer.currOrgId;
					
					$scope.equQryBean.equAtOrgNameSelect = $scope.equAtEmployer.name;
					
					if($scope.equQryBean.equAtOrgNameSelect){//业务状态
						var valuejson={"dept":$scope.equQryBean.equAtOrgNameSelect};
						var namejson={"dept":$scope.equQryBean.equAtOrgNameSelect};
					}
					$scope.displayCondition(namejson); 
					
					$scope.external = 2;
					
				};
				
				/* 取消并关闭 选择单位/项目模态框 */
				$scope.closeEquAtEmployerModel = function(){
					$('#equAtEmployerModel').modal('hide');
				} 
				
				$scope.clearEquAtEmployerModel = function(){
					$scope.equQryBean.equAtOrgFlag = null;
					$scope.equQryBean.equAtOrgPartyId = null;
					$scope.equQryBean.equAtOrgNameSelect = null;
					$scope.equQryBean.equAtOrgNameInput = null;
					$scope.external = 1;
					
					
					$scope.equAtEmployers = [];
					$scope.equAtEmployer = {};
					$scope.queryEquAtEmployer = {};
					$scope.equAtCheck = true;	//	项目选项 显示标志
					$scope.queryEquAtEmployer.check = false;	//	项目选项值
					$scope.checkEquAtTrEmployer = true;	//	列名称 - 单位名称 显示标志
					$scope.checkEquAtTrProjects = false;	//	列名称 - 项目名称 显示标志

					$('#equAtEmployerModel').modal('hide');
				};
				
				
				$scope.external = 2;
				$scope.click = function(){
					if($scope.equQryBean.isCrecOrg==1){
			    		$scope.external = 1;
			    		$scope.deletcondition("dept");
			    	}
			    	if($scope.equQryBean.isCrecOrg==0){
			    		if(!$scope.equQryBean.equAtOrgNameSelect){
							$scope.external = 1;
						}else{
							$scope.external = 2;
						}	
			    	}
			    	if($scope.equQryBean.isCrecOrg==0){
						if($scope.equQryBean.equAtOrgNameSelect){//业务状态
							var valuejson={"dept":SYS_USER_INFO.orgName};
							var namejson={"dept":SYS_USER_INFO.orgName};
						}
						$scope.displayCondition(namejson);
					}
				}
				
});
	
</script>

<style>
	.select-hover > option:hover  {
		background-color: #C0C0C0;
	}
	.div-hover:hover{/* div事件  */
		border-bottom:2px solid;
		border-bottom-color: #428BCA;
	}
	.divimgabc:hover{
		border:1px solid;
	  	border-color:#E53C36;
	}
	.divimg{
		border:1px solid;
	  	border-color:gray;
	}
	.divimg:hover{
		border:1px solid;
	  	border-color:#E53C36;
	}
	.a-bg:hover{/* a标签事件   */
		background-color:#428BCA;
		text-decoration: underline;
	}
	.a-hover:link{
		color: #000000;
		text-decoration: none;
	}	
	.a-hover:hover{
		color: #428BCA;
		text-decoration: underline;
	}
	a.styleA:hover {
		color: #E16600
	} 
	span.classSpan:hover{/* 鼠标经过下拉框   */
		color: #E16600
	}
	.classSpan{
		color:#428BCA;
	}
	.labelSearch:link {
		text-decoration: none;/* 下划线：默认。定义标准的文本。 */
	}
	.labelSearch:visited {
		text-decoration: none;
	}
	.labelSearch:hover {
		text-decoration: none;
	}
	.labelSearch:active {
		text-decoration: none;
	}
	.container {
		width: 1150px !important;
	}
	
	.form-horizontal .control-label {
		padding-top: 7px;
		margin-bottom: 0;
		text-align: right;
		min-width : 0px;
	}
	
	.Acolor{color:#333333; text-decoration:none;}/*链接设置*/
	.Acolor:hover{color:#E4393C; text-decoration:none;}/*鼠标放上的链接设置*/
	/* .Acolor:visited{color:#3399CC; text-decoration:none;font-weight:bold;}访问过的链接设置*/
	/*
	取消下划线只要把text-decoration:underline修改成text-decoration:none
	文字加粗font-weight:bold 如不需要加粗显示，那么删除font-weight:bold;就可以了
	其它更多的参数设置参考：css2.0手册 其中的"伪类"说明
	*/
	#cityulctr>li{
margin-top: 10px;
}
.diood_k{ width:998px; height:100px; float:left; overflow:hidden; position:relative;}
.diood_k a{ width:116px; height:48px; line-height:48px; display:block; float:left; border:1px solid #ededed; margin:1px; text-align:center; font-size:14px; color:#222; position:relative;text-decoration: none;}
.diood_k a:hover{ border:1px solid #1db100; color:#ff0000;text-decoration: none;}

.genduo{ overflow: auto; height:200px; overflow-y:scroll; border:1px solid #DDD;}
.genduo a{ width:116px;}
.genduo a img{ vertical-align:middle;}
.genduo a input{  display: inline; *+float:left; *+margin-top:10px;}
.genduo1{ overflow: auto; height:200px; overflow-y:scroll; border:1px solid #DDD;}
.genduo1 a{ width:116px;}
.genduo1 a img{ vertical-align:middle;}



.goux_fx{width:100%; height: auto;background-color:#fff; margin-top:10px;}
.goux_fx_span{ float:left; display:block; padding-left:2px; border:1px solid #CCC; line-height:20px; text-align:left; margin-right:5px;}
.goux_fx_span a{ height:20px; width:20px; line-height:20px; text-align:center; float:right; background-color:#ccc; color:#fff; margin-left:2px;}
.goux_fx_span:hover{ border:1px solid #6faef1;}
.goux_fx_span:hover a{background-color:#6faef1;}

.ihha_sstj li.gx_1{height:20px; float:left; line-height:20px; display:block; margin-right:5px; background-color:#fff; border:1px solid #CCC; padding-left:5px;}
.ihha_sstj li.gx_1 a{ display:block; right:5px; top:0;}
.ihha_sstj li.gx_1:hover{ border:1px solid #6faef1;}
.ihha_sstj li.gx_12{border:0;padding-left:0; margin-right:0; padding:0 5px 0 0;}

.iodfpq a{ padding: 0 7px; margin-right:10px; font-size:14px; position:relative; border:1px solid #fff; float:left; margin-bottom:5px;}
.iodfpq a:hover{border:1px solid #1db100;}

a.ihhagouxuan{border:1px solid #1db100;}
a.ihhagouxuan font{ background:url(/media/images/gouxuan.png) no-repeat; width:12px; height:11px; display:block; position:absolute; bottom:0; right:0; z-index:1;}
.moneysub { width:50px; height:25px; background-color:#09F; border:0; color:#fff; cursor:pointer;float: left;line-height: 25px;}
.moneysub:hover{ background-color:#06F;}

.dllbg{ background: url(/media/images/pol.png) no-repeat 310px 13px; cursor: pointer;}
.dllbg1{ background: url(/media/images/pol1.png) no-repeat 310px 13px; cursor: pointer;}

#workitemulli{

}
#workitemulli>li{padding: 0px 0px 0px 5px;
color: black;
cursor:pointer;font-size: 12px;
}
#workitemulli>li:hover{

background: #ebebeb;
}

.alinsytle{
margin:0 auto;width: 120px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color:#017cfe;display: block;
}
.alinsytle:hover{color:#cc0001;}
</style>
 

</head>
<body>
	<div>
		<div ng-include src="'/WebSite/Front/Main/Top1.jsp'" ></div>
	</div>
	<div class="main">
		<div class="position"><span>&gt;</span>  &nbsp;{{urlTitle}}&nbsp; <span>&gt;</span> &nbsp;筛选结果 &nbsp;<span></span> </div>
		<div class="">
	<div class="zbgg_t bgcfe">
    		<span class="left col_f dddw" style="width:70px;">已选条件：</span>
		    <ul class="ihha_sstj">
		      <li ng-repeat="a in arraynameArray"  ng-show="a.name!=null&&a.name!=''">
		      <div style="max-width: 180px;overflow: hidden; /*自动隐藏文字*/
text-overflow: ellipsis;/*文字隐藏后添加省略号*/
white-space: nowrap;/*强制不换行*/" title="{{a.name}}" ng-cloak> 
		      {{a.name}}</div>
		      <a href="#" ng-click="deletcondition(a.type)">
		      <img style="vertical-align:baseline;" src="../../../media/images/ssas.png"/></a></li>
		    </ul>
   			<a class="dosdd" href="#" ng-click="queryResourec();">搜索</a> 
   		</div>
   		<div style="height:34px;"> 
   		    <div class="zbgg_t bdfff"  ng-show="searBean.infoTitleBean != null && searBean.infoTitleBean !=''">
    <span class="left col_3 hanggao">
    您搜索的关键词是
    <a class=" col_red" href="#" ng-cloak style="text-decoration: none;">{{searBean.infoTitleBean}}</a>
    ，相关信息共 <a class=" col_red" href="#" ng-cloak style="text-decoration: none;">
    {{(totalElement=="0"&&$scope.searBean.infoTitleBean=="")?paginationConf.totalItems:totalElement}}
    </a> 条</span>
    
    </div>
    </div>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_tt">
     
       <tr class="osf" style="display:none ;" id="workwhich">
          <td valign="top" nowrap="nowrap"><div align="left" class="mar_l20">{{departments}}：</div></td>
          <td valign="top">&nbsp;</td>
          <td colspan="2" style="position: relative;z-index: 102;"> 
		        <div class="col-xs-3" ng-show="userInfo.orgLevel!=6">
					<div ng-show="equQryBean.isCrecOrg==0" class="input-group">
						<input ng-model="equQryBean.equAtOrgNameSelect" type="text" class="inpt_a inpt_o span230" style="width: 112%; margin-left: -12%; height: 34px; border-right: 0px; background-color: #fff;" readonly="readonly">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEquAtEmployerModel()">…</button>
						</span>
					</div>
					<input style="margin-left: -23px;" ng-show="equQryBean.isCrecOrg==1" ng-model="equQryBean.equAtOrgNameInput" type="text" class="inpt_a inpt_o span230" />
				</div>
				<div class="col-xs-1" ng-show="userInfo.orgLevel!=6">
					<input ng-model="equQryBean.isCrecOrg" ng-true-value="1" ng-false-value="0" ng-click="click();" type="checkbox" style="position: absolute; z-index: 3; margin-left: -22px; margin-top: 10px;">
					<label contenteditable="false" class="control-label" style="text-align: left; position: absolute; z-index: 2; margin-left: -3px;">非中铁单位</label>
				</div>
				<div class="col-xs-1" ng-show="userInfo.orgLevel!=6  && (equQryBean.orgFlag==9 || equQryBean.orgFlag==1 || equQryBean.equAtOrgFlag!=2 && equQryBean.equAtOrgFlag!=3)" style="margin-left:20px">
					<input ng-model="equQryBean.isInclude" ng-show="external==2" ng-true-value="1" ng-false-value="0"  type="checkbox" style="position: absolute; z-index: 3; margin-left: -22px; margin-top: 10px;">
					<label contenteditable="false" ng-show="external==2" class="control-label" style="text-align: left; position: absolute; z-index: 2; margin-left: -3px;">包含下级单位</label>
				</div>
				<div class="col-xs-1" ng-show="userInfo.orgLevel==6">
					<span ng-bind="userInfo.orgName"></span>
				</div>
          </td>
      </tr>
       <tr class="osf">
          <td valign="top" nowrap="nowrap"><div align="left" class="mar_l20" >所在城市：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('city')">全部</a></div></td>
          <td  colspan="2" class="jjk" style="position:relative; z-index:101;">
 		  <div class="form-group text-left" style="margin-top: -15px; margin-left:-17px;">
	 		<div class="col-xs-2" >
		   		<select id="province" name="SelectProvince" ng-model="recPro.proModel" class="sel_a sel_ay" required
		    		    ng-options="recPro.name as recPro.name for recPro in areaList" ng-change="changePro(recPro);"  ng-click="addOnProvince();"
		      	     style="position: absolute;z-index:2;margin-left: 5px;width:100%;height: 34px;margin-top: 0px;color: #555;"> 
		       		<option value="" >--请选择省份--</option>
		         </select>
	     	</div>
	     	<div class="col-xs-2">
		      	<select id="city" name="SelectCity" ng-model="recCit.recModel" class="sel_a sel_ay"
		  				ng-options="recCit.name as recCit.name for recCit in pList"   required ng-click="addOnCity();"
		  				  style="position: absolute;z-index:2;margin-left:10px;width:100%;height: 34px;margin-top: 0px;color: #555;">  
		     			<option value="">--请选择城市--</option>  
		  		</select>             
	    	 </div>
    	 </div>
          </td>

        </tr>
          <tr class="osf">
          <td width="100" valign="top"><div align="left" class="mar_l20">品牌：</div></td>
          <td width="100" valign="top"><nobr><div align="center"><a class="col_lan" href="javascript:void(0);" ng-click="deletcondition('brandImg');">全部</a></div></nobr></td>
          <td width="800" align="left">
          <div class="diood_k" id="ihhaduox" >
          	<div  id="radioimggroup">
          	<div style="text-align: left;display: none;" id="allbrand" ><font ng-mouseenter="uploadBrand()" style="cursor: pointer;" ng-mouseout="leavebrand();">所有品牌：</font>
          	<span ng-repeat="i in abcList" style="padding:2px 5px 2px 5px;margin-right: 5px;" ng-mouseout="leavebrand();"
          	 ng-Mouseenter="overallbrand($index)" id="" ng-cloak>{{i.abcName}}</span></div>
          	<a class="" ng-repeat="p in brandList track by $index"	 
            	ng-click="selectQuery('brandImg',p,p.name,$index)" href="javascript:void(0);"   title="{{p.name}}" ng-cloak>{{p.name | limitTo:5}} <font></font></a>
          	</div>

            <div class="clear"></div>
          </div>
           <div class="clear"></div>
           <div  style="display:none;" id="dxshow">
           <div class="goux_fx"> 
            <ul class="ihha_sstj">
              <li class="gx_1" ng-repeat="x in brandname track by $index">{{x.name}}<a href="javascript:void(0);" ng-click="delbrandname(x,$index)">×</a></li>
            </ul>
            <div class="clear"></div
           ></div>
           <div class="ihhaduox_fc" id="dxanniu" style="border-top: 0px;margin-top: 0px;">
            <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="suredx()"/>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" ng-click="dxbtnclick2()" name="button" id="button" value="取消" />
          </div>
           <div class="clear"></div>
           </div>
          </td>
          <td width="100" valign="top">
            <div class="fopwe">
<a class="dfsfg" href="javascript:void(0);" id="dxbtn1" ng-click="dxbtnclick1()" ng-show="dxbtn1show">+多选</a>
<a class="dfsfg" href="javascript:void(0);" id="dxbtn3" ng-click="dxbtnclick2()" ng-show="dxbtn3show">-多选</a>
<a class="dfsfg" href="javascript:void(0);" id="dxbtn2" style="background: #bebebe;" ng-show="dxbtn2show">+多选</a>
<a class="dfsfg" href="javascript:void(0);" id="a1" ng-click="gdbtnclick1()" ng-show="showa1">更多  ∨&nbsp;</a>
<a class="dfsfg" href="javascript:void(0);" id="a2" ng-click="gdbtnclick2()" ng-show="showa2">更多 ∧&nbsp; </a>
<a class="dfsfg" href="javascript:void(0);" id="a3" style="background: #bebebe;" ng-show="showa3">更多  ∨</a>
</div>
          </td>
        </tr>
          <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20">设备名称：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('device')">全部</a></div></td>
          <td colspan="2" class="jjk" style="position:relative; z-index:100;">
          <div class="form-group text-left" style="margin-top: -15px; margin-left:-17px;">
	 		<div class="col-xs-2" >
		   		<select id="equipmentCategoryName" ng-model="equ.equCategoryId" class="sel_a sel_ay" required
		    		    ng-options="equ.equCategoryId as equ.equipmentCategoryName for equ in categoryList" ng-change="changeEqu(equ);"  ng-click="addEquCategory();"
		      	     style="position: absolute;z-index:2;margin-left: 5px;width:100%;height: 34px;margin-top: 0px;color: #555;"> 
		       		<option value="" >--请选择设备大类--</option>
		         </select>
	     	</div>
	     	<div class="col-xs-2">
		      	<select id="equipmentName" ng-model="e.equNameId" class="sel_a sel_ay"
		  				ng-options="e.equNameId as e.equipmentName for e in equipmentList"   required ng-change="changeEquName(e);" ng-click="addEquName();"
		  				  style="position: absolute;z-index:2;margin-left:10px;width:100%;height: 34px;margin-top: 0px;color: #555;">  
		     			<option value="">--请选择设备名称--</option>  
		  		</select>             
	    	 </div>
    	 </div>
          </td>
    </tr>
    <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20">型号：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('model');">全部</a></div></td>
          <td  class="jjk">
          <div class="iodfpq left" id="gunge">
          <a ng-repeat="m in modelList" href="javascript:void(0)" ng-click="selectQuery('model',m,m.name,$index)" ng-cloak>{{m.name}}<font></font></a>
          
          
               <font class="qdqx" id="gunge1" style="display:none;">
               <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="modeldxsure();"/>&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" ng-click="modeldxcancle();" name="button" id="button" value="取消" />
               </font>
               </div>
          
          <div class="goux_fx" style="display:none;" id="modelselected"> 
            <ul class="ihha_sstj ">
              <li class="gx_12 col_lan">已勾选条件：</li>
              <li class="gx_1" ng-repeat="x in modelnamearr">{{x.equParameter.name}}<a href="javascript:void(0);" ng-click="delmodelseled(x,$index);">×</a></li>
            </ul>
            <div class="clear"></div>
           </div>
          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="#" ng-click="modeldx();" id="modeldx1">+多选</a>
           <a class="dfsfg" href="#" style="display: none;" ng-click="modeldxcancle();" id="modeldx2">-多选</a></td>
        </tr>
         <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20">规格：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('standard');">全部</a></div></td>
          <td  class="jjk">
          <div class="iodfpq left" id="ggalink">
          <a ng-repeat="s in standardList" href="javascript:void(0)" ng-click="selectQuery('standard',s,s.name,$index)" ng-cloak>{{s.name}}<font></font></a>
          
          
               <font class="qdqx" id="ggdxdiv1" style="display:none;float: left;">
               <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="ggdxsure()"/>&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" ng-click="ggdxbtn2()" name="button" id="button" value="取消" />
               </font>
               <div style="clear: both;"></div>
               </div>
          
          <div class="goux_fx" style="display:none;" id="ggdxdiv2"> 
            <ul class="ihha_sstj ">
              <li class="gx_12 col_lan">已勾选条件：</li>
              <li class="gx_1" ng-repeat="x in guigenamearr">{{x.equParameter.name}}<a href="javascript:void(0);" ng-click="delggseled(x,$index);">×</a></li>
            </ul>
            <div class="clear"></div>
           </div>
          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="javascript:void(0)" ng-click="ggdxbtn1()" id="ggdx1">+多选</a>
           <a class="dfsfg" href="javascript:void(0)" style="display: none;" ng-click="ggdxbtn2()" id="ggdx2">-多选</a></td>
        </tr>
                <tr class="osf">
          <td valign="top" nowrap="nowrap"><div align="left" class="mar_l20">价格：</div></td>
            <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('price')">全部</a></div></td>
          <td colspan="2"> 
          <input maxlength="10" ng-model="minPrice" id="minPrice"   type="text" class="inpt_a inpt_o span230" style="width: 120px;" ng-blur="checkPrice(true,minPrice);"/>
          <div style="float: left;margin-right: 10px;border:1px solid #bebebe;width:20px;margin-top:15px;"></div>
          <input maxlength="10" ng-model="maxPrice" id="maxPrice" type="text" class="inpt_a inpt_o span230" style="width: 120px;"  ng-blur="checkPrice(false,maxPrice)"/> 
          <div style="float: left;margin-right: 10px;"><select ng-if="CZshow || QZshow" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.UNIT_RENTMONEY" ng-model="priceUnit.price">
       	 	    <option value="">全部</option>
          </select></div>
          <div ng-if="CSshow || QGshow" style="float: left;margin-right: 10px;">       	 	   
          	元
          </div>
            <input type="submit" class="moneysub" name="button" id="button" value="确定" style="margin-top: 2px;" ng-click="inputPrice('元');"/><div class="left mar_l20"></div>
             <div style="clear: both;"></div> 
            </td>
           
      </tr>
      

     </table>
    	</div>
 <div style=" margin-top:50px;"  ng-if="CZshow" ng-init="queryResourec();">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj">
	        <tr>
		        <th>序号</th>
				<th style="width: 130px;">标题</th>
				<th style="width: 150px;" >设备名称(型号:规格)</th>
				<th style="width: 100px;">设备编号</th>
				<th style="width: 100px;">品牌</th>
				<th style="width: 80px;">价格</th>
				<th style="width: 80px;">最短租期</th>
				<th style="width: 130px;">购置日期</th>
				<th style="width: 130px;">所在城市</th>
				<th style="width: 100px;">所属单位</th>
				<th style="width: 130px;">发布时间</th>
	        </tr>
	         <tr ng-repeat="t in resultList">
	          	<td ng-cloak>{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
				<td title="{{t.infoTitle}}" style="text-align: center;">
					<a class="alinsytle" ng-if="t.dataType==1||t.dataType==2" target="_bank" href="../Publish/ViewInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}" ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==3" target="_bank" href="../Publish/ViewDemandRentInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}"  ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==4" target="_bank" href="../Publish/ViewDemandSaleInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}"  ng-bind-html = "t.infoTitle"></a>
				</td>
				<td style="text-align: center;">
				<div style="margin:0 auto; width: 150px;
				overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.equName}} {{t.frontModel}}">{{t.equName}}<span ng-show="t.frontModel!=''">（</span>{{t.frontModel}}<span ng-show="t.frontModel!=''">）</span></div>
				</td>
				<td style="text-align: center;" ng-bind="t.equNo"></td>
				<!-- <td  title="{{t.equName}} {{t.frontModel}}" ng-cloak>{{t.equName}}{{t.frontModelA}}</td> -->
				<td style="text-align: center;"  >
				
				<div style="margin:0 auto;width: 90px;overflow: hidden;
					text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.brandName}}" ng-cloak>{{t.brandName}}</div>
				
				</td>
				<td ng-cloak>{{t.price}}{{ct.codeTranslate(t.priceType,"UNIT_RENTMONEY")}}</td>
				<td ng-cloak>{{t.shortestLease =='999999'?'不限':t.shortestLease+'天'}}</td>
				<td ng-cloak>{{t.approachDate}}</td>
				<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.frontCityA}}">{{t.frontCity}}</div>
				</td>
				<td style="text-align: center;" >
					<div ng-if="t.sonOrgName" style="margin:0 auto;width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.sonOrgName}}{{t.proOrgName}}" ng-cloak>{{t.sonOrgName}}-{{t.proOrgName}}</div>
					<div ng-if="!t.sonOrgName" style="margin:0 auto;width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.bureauOrgPartyName}}{{t.proOrgName}}" ng-cloak>{{t.bureauOrgPartyName}}-{{t.proOrgName}}</div>
				</td>
				<td  ng-cloak title="{{t.releaseDate}}">{{t.releaseDate}}</td>
	        </tr>
	      </table>
	   </div>
	    <!-- 求租 -->
	   	<div style=" margin-top:50px;"  ng-if="QZshow" ng-init="queryResourec();">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj">
	        <tr>
		        <th >序号</th>
				<th style="width: 130px;">标题</th>
				<th style="width: 150px;">设备名称(型号:规格)</th>
				<th style="width: 100px;">品牌</th>
				<th >价格</th>
				<th >租期</th>
				<th >数量</th>
				<th >所在城市</th>
				<th >发布单位</th>
				<th style="width: 130px;">发布时间 </th>
	        </tr>
	         <tr ng-repeat="t in resultList|orderBy:'releaseDate':true">
	         	<td ng-cloak>{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
				<td  title="{{t.infoTitle}}">
					<a class="alinsytle" ng-if="t.dataType==1||t.dataType==2" target="_bank" href="../Publish/ViewInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}"  ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==3" target="_bank" href="../Publish/ViewDemandRentInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}" ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==4" target="_bank" href="../Publish/ViewDemandSaleInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}" ng-bind-html = "t.infoTitle"></a>
				</td>
						<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.equName}} {{t.frontModel}}">{{t.equName}}<span ng-show="t.frontModel!=''">（</span>{{t.frontModel}}<span ng-show="t.frontModel!=''">）</span></div>
				</td>
				<!-- <td  ng-cloak title="{{t.equName}} {{t.frontModel}}">{{t.equName}}{{t.frontModelA}}</td> -->
				<td style="text-align: center;"  >
				
				<div style="margin:0 auto;width: 90px;overflow: hidden;
					text-overflow: ellipsis;white-space: nowrap;color: black;"  title="{{t.brandName}}" ng-cloak>{{t.brandName}}</div>
				
				</td>
				<td ng-cloak>{{ct.formatCurrency(t.price)}}元/{{ct.codeTranslate(t.tenancyType,"UNIT_LEASETIME")}}</td>
				<td ng-cloak>{{t.tenancy}}{{ct.codeTranslate(t.tenancyType,"UNIT_LEASETIME")}}</td>
				<td ng-cloak>{{t.quantity}}{{ct.codeTranslate(t.second,"UNIT_NAME")}}</td>
				<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.frontCity}}">{{t.frontCity}}</div>
				</td>
				<!-- <td ng-cloak title="{{t.frontCityA}}">{{t.frontCity}}</td> -->
				<td style="text-align: center;">
					<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.bureauOrgPartyName}}">{{t.bureauOrgPartyName}}</div>
				</td>
				<!-- <td ng-cloak>{{t.enterpriseName}}</td> -->
				<td ng-cloak title="{{t.releaseDate}}">{{t.releaseDate}}</td>
	        </tr>
	      </table>
	   </div>
	 	<!-- 出售 -->
	    <div style=" margin-top:50px;"  ng-if="CSshow" ng-init="queryResourec();">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj">
	        <tr>
		        <th style="width: 50px;">序号</th>
				<th style="width: 130px;">标题</th>
				<th style="width: 150px;">设备名称(型号:规格)</th>
				<th>设备编号</th>
				<th style="width: 100px;">品牌</th>
				<th>价格</th>
				<th style="width: 150px;">所在城市</th>
				<th style="width: 150px;">所属单位</th>
				<th style="width: 130px;">发布时间</th>
	        </tr>
	         <tr ng-repeat="t in resultList">
	         	<td ng-cloak>{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
				<td ng-cloak title="{{t.infoTitle}}">
					<a class="alinsytle" ng-if="t.dataType==1||t.dataType==2" target="_bank" href="../Publish/ViewInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}"  ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==3" target="_bank" href="../Publish/ViewDemandRentInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}"  ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==4" target="_bank" href="../Publish/ViewDemandSaleInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}"  ng-bind-html = "t.infoTitle"></a>
				</td>
				<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.equName}} {{t.frontModel}}">{{t.equName}}<span ng-show="t.frontModel!=''">（</span>{{t.frontModel}}<span ng-show="t.frontModel!=''">）</span></div>
				</td>
				<td style="text-align: center;" ng-bind="t.equNo"></td>
				<!-- <td ng-cloak title="{{t.equName}} {{t.frontModel}}">{{t.equName}}{{t.frontModelA}}</td> -->
				<td style="text-align: center;">
				
				<div style="margin:0 auto;width: 90px;overflow: hidden;
					text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.brandName}}" ng-cloak>{{t.brandName}}</div>
				
				</td>
				<td ng-cloak>{{t.price}}元</td>
				<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.frontCity}}">{{t.frontCity}}</div>
				</td>
				<!-- <td ng-cloak title="{{t.frontCityA}}">{{t.frontCity}}</td> -->
				<td style="text-align: center;">
					<div ng-if="t.sonOrgName" style="margin:0 auto;width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.sonOrgName}}{{t.proOrgName}}" ng-cloak>{{t.sonOrgName}}-{{t.proOrgName}}</div>
					<div ng-if="!t.sonOrgName" style="margin:0 auto;width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.bureauOrgPartyName}}{{t.proOrgName}}" ng-cloak>{{t.bureauOrgPartyName}}-{{t.proOrgName}}</div>
				</td>
			<!-- 	<td ng-cloak>{{t.enterpriseName}}</td> -->
				<td ng-cloak title="{{t.releaseDate}}">{{t.releaseDate}}</td>
	        </tr>
	      </table>
	   </div>
	    <!-- 求购 -->
	    <div style=" margin-top:50px;"  ng-if="QGshow" ng-init="queryResourec();">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj">
	        <tr>
		        <th style="width: 50px;">序号</th>
				<th style="width: 130px;">标题</th>
				<th style="width: 150px;">设备名称(型号:规格)</th>
				<th style="100px;">品牌</th>
				<th>价格</th>
				<th>数量</th>
				<th style="width: 150px;">所在城市</th>
				<th style="width: 150px;">发布单位</th>
				<th style="width: 130px;">发布时间</th>
	        </tr>
	         <tr ng-repeat="t in resultList|orderBy:'releaseDate':true">
	          	<td ng-cloak>{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
				<td title="{{t.infoTitle}}">
					<a class="alinsytle" ng-if="t.dataType==1||t.dataType==2" target="_bank" href="../Publish/ViewInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}" ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==3" target="_bank" href="../Publish/ViewDemandRentInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}" ng-bind-html = "t.infoTitle"></a>
					<a class="alinsytle" ng-if="t.dataType==4" target="_bank" href="../Publish/ViewDemandSaleInfo.jsp?id={{t.dataId}}&infoType={{t.dataType}}" ng-bind-html = "t.infoTitle"></a>
				</td>
					<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.equName}} {{t.frontModel}}">{{t.equName}}<span ng-show="t.frontModel!=''">（</span>{{t.frontModel}}<span ng-show="t.frontModel!=''">）</span></div>
				</td>
				<!-- <td ng-cloak title="{{t.equName}} {{t.frontModel}}">{{t.equName}}{{t.frontModelA}}</td> -->
				<td style="text-align: center;"   >
				
				<div style="margin:0 auto;width: 90px;overflow: hidden;
					text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.brandName}}" ng-cloak>{{t.brandName}}</div>
				
				</td>
				<td ng-cloak>{{t.price}}元</td>
				<td ng-cloak>{{t.quantity}}{{ct.codeTranslate(t.second,"UNIT_NAME")}}</td>
					<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.frontCity}}">{{t.frontCity}}</div>
				</td>
			<!-- 	<td ng-cloak title="{{t.frontCityA}}">{{t.frontCity}}</td> -->
				<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" ng-cloak  title="{{t.bureauOrgPartyName}}">{{t.bureauOrgPartyName}}</div>
				</td>
				<!-- <td ng-cloak>{{t.enterpriseName}}</td> -->
				<td  ng-cloak title="{{t.releaseDate}}">{{t.releaseDate}}</td>
	        </tr>
	      </table>
	   </div>
   		<div class="clear"></div>
   		<div style="float: right;">
			<tm-pagination conf="paginationConf" style="margin-left:0px;"></tm-pagination>
			<span ng-if="outDiv">没有符合条件的记录</span>
		</div>
	</div>
	<!-- 引入底文件 -->
	<div class="opwe mar_t30">
		<a href="#"><img src="../../../media/images/iopj.png" /></a>
	</div>
	<div ng-include src="'./SearchModel.jsp'" ></div>
	<jsp:include page="../Include/Bottom.jsp" />
</body>
</html>
