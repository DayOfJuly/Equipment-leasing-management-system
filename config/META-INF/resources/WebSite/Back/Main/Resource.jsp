<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>资源搜索页</title>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../Front/Include/Head.jsp" />
<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
<script src="../../../media/js/lrtk.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../../../media/js/ss.js"></script><!--左右GUNDONG-->
<jsp:include page="../../Front/conmmon/publicSession.jsp" />
<!-- <link rel="stylesheet"  type="text/css" href="../../../media/css/home.css"> -->
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
</style>
<script type="text/javascript" src="../../../media/js/tm.pagination.js"></script>

<script type="text/javascript">
var app = angular.module('searchApp',['ngResource','unifyModule','tm.pagination','ngSanitize','Config','sysCodeConfigModule','sysCodeTranslateModule']);
app.controller('searchController',function($scope,$sanitize,unifyTestSvc1,category,proSvc,rentSvc,SaleSvc,busEquParameterSvc,DemandRentSvc,DemandSaleSvc,regionSvc,published,entSvc,equipment,searchUrl,SYS_CODE_CON,sysCodeTranslateFactory){
	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
	    
	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	 SYS_USER_INFO.orgCode="${sessionScope.userInfo.orgCode}";
	 SYS_USER_INFO.cityName="${sessionScope.userInfo.cityName}";
	 SYS_USER_INFO.level="${sessionScope.userInfo.orgLevel}";
	 $scope.userInfo = {};

		$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
		$scope.userInfo.orgId = SYS_USER_INFO.orgId;
		$scope.userInfo.orgCode = SYS_USER_INFO.orgCode;
		$scope.userInfo.orgName = SYS_USER_INFO.orgName;
		$scope.userInfo.proId = SYS_USER_INFO.proId;
		$scope.userInfo.proName = SYS_USER_INFO.proName;
		$scope.userInfo.partyId = SYS_USER_INFO.partyId;
		
	 $scope.levelShow = SYS_USER_INFO.level==2?false:true;
	 $scope.showLevel = SYS_USER_INFO.orgLevel;
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
	//定义一个搜索内容显示
	$scope.daohang={};
	$scope.titleContent="";
	$scope.decodeURIVal="";
	$scope.decodeURIVal = decodeURI(theRequest.searchContent);
	$scope.requestParms = theRequest;
	$scope.ltype = $scope.requestParms.searchType;
	/*
	  判断导航栏到达的位置
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
				break;		
			}
			default:{
				$('#searchTab li').removeClass('lefthui');
				$('#searchTab li:eq(0)').addClass('lefthui');
				break;
			}
		}
		$scope.showMenu();
	};
	 /*
	   控制菜单的显示
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
				$('#ulTopId li:eq(1) a').css('background','#CBCCCD');
				break;
			}
		}
	    initShow=$('#jsddm >li.baidi:eq(0)');
	};
	
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
		}else if($scope.ltype == "qiuzu"){
			$scope.titleContent = "求租";
		}
		else if($scope.ltype == "sale"){
			$scope.titleContent = "出售";
		}
		else if($scope.ltype == "qiugou"){
			$scope.titleContent = "求购";
		}
		IssuSvc.post({Action:$scope.actionName},$scope.pageParams,qSuccChuZu,qErrChuZu);
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
        perPageOptions: [ 20, 30, 40, 50],
        onChange : function(parm1){
        	$scope.paginationConf.currentPage = parm1;
			/* if($scope.searBean.infoTitleBean == "" || $scope.searBean.infoTitleBean == null){ */
				// $scope.queryUpdHotWordCount();   //自动查询热门搜索词
	             $scope.uploadBrand();   	  //品牌查询
				 $scope.queryResourec();
			/* } */
        }
	};

	
	//搜索
	$scope.queryResourec=function(callType){
		
		function qSuccChuZu(rec){
			if (rec.content.length == 0) {
				$scope.showView = false;
				$scope.FormDiv = false;
				$scope.outDiv = true;
				$.messager.popup("没有符合条件的纪录");
			} else {
				$scope.outDiv = false;
				$scope.FormDiv = true;
				$scope.showView = true;
			}
			$scope.resultList=rec.content;
			$scope.changeListValue(rec.content);
			$scope.paginationConf.totalItems=rec.totalElements;
			for(var i = 0; i < rec.content.length; ++i){
				var frontModel = "";
				if(rec.content[i].models != null){
					frontModel +=rec.content[i].models;
				}
				if(rec.content[i].specifications != null){
					frontModel = frontModel+":"+rec.content[i].specifications;
				}
				rec.content[i].frontModel=frontModel;
				if(frontModel.length > 6){
					rec.content[i].frontModelA = frontModel.substring(0,4)+"..."
				}else{
					rec.content[i].frontModelA = frontModel;
				}
				var frontRange = "";
				if(rec.content[i].orgCode != null){
					frontRange +=rec.content[i].orgCode;
				}
				if(rec.content[i].equNo != null){
					frontRange = frontRange+"-"+rec.content[i].equNo;
				}
				rec.content[i].frontRange=frontRange;
				if(frontModel.length > 9){
					rec.content[i].frontRangeA = frontRange.substring(0,7)+"..."
				}else{
					rec.content[i].frontRangeA = frontRange;
				}
			}
	    }
		function qErrChuZu(rec){}

		$scope.initSearchParms();//调用初始化页面查询参数的方法
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
		
		if(callType && 'init'==callType)
		{
		
           if(SYS_USER_INFO.proId){//当当前登录人有所属项目时，使用项目的ID作为默认的查询条件
				$scope.queryParams.orgPartyId = SYS_USER_INFO.proId;
			}
			else if(SYS_USER_INFO.orgId){
				$scope.queryParams.orgPartyId = SYS_USER_INFO.orgId;
			}
           //当当前登录人有所属项目时，查询其项目下的资源，否则查询其企业下的资源
			if($scope.userInfo.proId){
				$scope.queryParams.orgFlag = 3;
			}
			else if(1==$scope.userInfo.orgLevel){
				$scope.queryParams.orgFlag = 9;
			}
			else if(2==$scope.userInfo.orgLevel){
				$scope.queryParams.orgFlag = 1;
			}
			else if(3==$scope.userInfo.orgLevel){
				$scope.queryParams.orgFlag = 2;
			}
			$scope.equQryBean.equAtOrgPartyId=$scope.queryParams.orgPartyId;
			$scope.equQryBean.equAtOrgFlag = $scope.queryParams.orgFlag;
		}
		else
		{
			$scope.queryParams.orgPartyId = $scope.equQryBean.equAtOrgPartyId;
			$scope.queryParams.orgFlag = $scope.equQryBean.equAtOrgFlag;
		}
		

		
		if($scope.equQryBean.isCrecOrg){
			$scope.queryParams.isProvider = $scope.equQryBean.isCrecOrg;
		}else{
			$scope.queryParams.isProvider = 0;
		}
		$scope.queryParams.isInclude = $scope.equQryBean.isInclude;
		
		if($scope.equQryBean.isCrecOrg==1){
			
			if($scope.equQryBean.equAtOrgNameSelect){
				$scope.equQryBean.equAtOrgNameSelect = '';
			}
			$scope.queryParams.orgName = $scope.equQryBean.equAtOrgNameInput;
			$scope.queryParams.pageNo=$scope.paginationConf.currentPage-1;
			$scope.queryParams.pageSize=$scope.paginationConf.itemsPerPage;
			
			$scope.queryParams.isInclude = $scope.queryParams.isInclude;
			
			$scope.queryParams.isProvider = 1;
				var valuejson={"dept":$scope.equQryBean.equAtOrgNameInput};
				var namejson={"dept":$scope.equQryBean.equAtOrgNameInput};
			$scope.displayCondition(namejson); 
			equipment.post({Action:"Equipment"},$scope.queryParams,qSuccChuZu,qErrChuZu);
			
		}else{
			$scope.queryParams.orgName = $scope.equQryBean.equAtOrgNameSelect;
				var valuejson={"dept":$scope.queryParams.orgName};
				var namejson={"dept":$scope.queryParams.orgName};
			$scope.displayCondition(namejson);
			equipment.post({Action:"Equipment"},$scope.queryParams,qSuccChuZu,qErrChuZu);
		}
	}
	
	
	$scope.queryParams = {};
	$scope.initSearchParms = function(){
		
		$scope.queryParams.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryParams.pageSize=$scope.paginationConf.itemsPerPage;
		for(var i = 0; i < $scope.arraynameArray.length;i++){
			if($scope.arraynameArray[i].type == "dept"){
				$scope.queryParams.orgName = $scope.arraynameArray[i].name;
				//$scope.queryParams.orgCode=$scope.oreCode;
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
			}else if($scope.arraynameArray[i].type == "danWFW"){
				//单位范围 
				var orgScope = $scope.arraynameArray[i].name.split(",");
				$scope.queryParams.orgScope = [];
				for(var k = 0 ; k < orgScope.length; ++k){
					for(var j = 0; j < $scope.danWFWList.length; ++j){
						if(orgScope[k] == $scope.danWFWList[j].danWFWName){
							$scope.queryParams.orgScope.push(Number($scope.danWFWList[j].danWFWValue));
						}
					}
				}
			}else if($scope.arraynameArray[i].type == "sheBLY"){
				//设备来源 $scope.sheBLYList
				var equipmentSourceNos = $scope.arraynameArray[i].name.split(",");
				$scope.queryParams.equipmentSourceNos = [];
				for(var k = 0 ; k < equipmentSourceNos.length; ++k){
					for(var j = 0; j < $scope.sheBLYList.length; ++j){
						if(equipmentSourceNos[k] == $scope.sheBLYList[j].sheBLYName){
							$scope.queryParams.equipmentSourceNos.push(Number($scope.sheBLYList[j].sheBLYValue));
						}
					}
				}
			}else if($scope.arraynameArray[i].type == "sheBZT"){
				//设备状态
				$scope.queryParams.equStates = [];
				var equStates = $scope.arraynameArray[i].name.split(",");
				for(var k = 0 ; k < equStates.length; ++k){
					for(var j = 0; j < $scope.sheBZTList.length; ++j){
						if(equStates[k] == $scope.sheBZTList[j].sheBZTName){
							$scope.queryParams.equStates.push(Number($scope.sheBZTList[j].sheBZTValue));
						}
					}
				}
			}else if($scope.arraynameArray[i].type == "FBZT"){
				//设备状态
				$scope.queryParams.pubStates = [];
				var pubStates = $scope.arraynameArray[i].name.split(",");
				for(var k = 0 ; k < pubStates.length; ++k){
					for(var j = 0; j < $scope.FBZTList.length; ++j){
						if(pubStates[k] == $scope.FBZTList[j].FBZTName){
							$scope.queryParams.pubStates.push(Number($scope.FBZTList[j].FBZTValue));
						}
					}
				}
			}else if($scope.arraynameArray[i].type == "yeWZT"){
				//业务状态 
				$scope.queryParams.busStates = [];
				var busStates = $scope.arraynameArray[i].name.split(",");
				for(var k = 0 ; k < busStates.length; ++k){
					for(var j = 0; j < $scope.yeWZTList.length; ++j){
						if(busStates[k] == $scope.yeWZTList[j].yeWZTName){
							$scope.queryParams.busStates.push(Number($scope.yeWZTList[j].yeWZTValue));
						}
					}
				}
			}else if($scope.arraynameArray[i].type == "price"){
				var tempPrice = $scope.arraynameArray[i].name;
				tempPrice = tempPrice.split('-');
				$scope.queryParams.minPrice = Number(tempPrice[0]);
				tempPrice = tempPrice[1].split(' ');
				$scope.queryParams.maxPrice = Number(tempPrice[0]);
				if($scope.queryParams.maxPrice==0){
					$scope.queryParams.maxPrice=null;
				}
			}
		}
		
	/* 	if($scope.minPrice != null && $scope.minPrice != ""){
			$scope.queryParams.minPrice = Number($scope.minPrice);
		}
		if($scope.maxPrice != null && $scope.maxPrice != ""){
			$scope.queryParams.maxPrice = Number($scope.maxPrice);
		} */
		/* if($scope.priceUnit != null && $scope.priceUnit != "" &&(($scope.minPrice != null && $scope.minPrice != "")||($scope.maxPrice != null && $scope.maxPrice != ""))){
			$scope.queryParams.priceType = Number($scope.priceUnit);
		} */
		
		
		$scope.queryParams.isInclude=($scope.reason2.rec?1:2);	
			
	};
		
	/*
	 * 搜索
	*/
	$scope.showView=false;//你搜索的关键字是:的ng-show
	$scope.search=function(varl,parm){
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
	$scope.queryUpdHotWordCount();   	  //品牌查询
	
	
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
	$scope.InputClick = function(){
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
	* 点击热门搜索词搜索查询的方法
	*/
	$scope.queryInfoLink=function(parm){
		$scope.insertCache(parm);
		$scope.querySearchHotWords(parm);
		var searchType=$("#searchType").val();
		setTimeout(function(){
		window.open(searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm,"_self");
		},500);
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
	     } else{
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
			if(objList[i].infoTitle&&objList[i].infoTitle.length>8)
			{
				objList[i].infoTitleTemp=objList[i].infoTitle.substr(0,8)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
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
				var cookieParm = cf.getCookies('ashow');
				if(cookieParm == null){
					cookieParm = [];
				}
				for(var k=0;k<cookieParm.length;k++){
					if(parm == cookieParm[k]){
						var myArray = new window.arrayFactory(cookieParm);
						cookieParm=myArray.removeIndex(k);//判断是否重复的值,如果是重复的值，则去掉原来的值，重新加入
					}
				}
				cookieParm.push(parm);
				if(cookieParm && cookieParm.length > 10){
					for(var n=0;n <= cookieParm.length-10;++n){
						var myArray = new window.arrayFactory(cookieParm);
						cookieParm=myArray.removeIndex(0);
					}
				}
				cf.createCookies('ashow',cookieParm,30);
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
			if(rec.content.length<=0){
				$scope.LiNumA=false;
			}else{
				$scope.LiNumA=true;
				$('#parentOrgs1')[0].style.display = 'block'; 
				$scope.checkQueryKeyWord(rec.content);
				$scope.KeyWordList=rec.content;
				$scope.totalElement=rec.numberOfElements;
				$scope.KWList(rec.content);//字数超过9个后用...代替/
			}
		}
		function error(){}
		$scope.queryData.Action="ITCount";
		if(parm){
			$scope.queryData.infoTitle=parm;
			published.unifydo($scope.queryData,success,error);
			$scope.LiNumB=false;
			//缓存的最近查询事件
			windowOnload(cf.getCookies('ashow'));
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
		var cookieParm = cf.getCookies('ashow');
		if(cookieParm != null){
			for(var i = 0; i < varl.length;++i){
				varl[i].rankLocation = i;
				for(var j = 0; j < cookieParm.length; ++j){
					if(varl[i].infoTitle == cookieParm[j]){
						varl[i].flagMsg = "最近搜索过";
						varl[i].rankLocation = (100+j+1);
						break;
					}
				}
			}
			}
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
				document.getElementById("keyWords"+parm1).href=searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm;
				},500);
			}else{
				setTimeout(function(){
				document.getElementById("keyWords"+parm1).href =searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm;
				},500);
			}
		}
	};
	
	
	
	/*
	*input关键字搜索回车事件
	*/
	$scope.myKeyup = function(e){
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
			$scope.search(1, parm);
		   // $scope.querySearchHotWords(parm);
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
          	//  $scope.LiNumB = false;
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
	$scope.queryProType=function(){
		function qSucc(rec){
			$scope.categoryList=rec.content;
		}
		function qErr(rec){}
		category.unifydo({Action:"EquCategory",pageNo:0,pageSize:20},qSucc,qErr);
	};
	
	//所属单位：ClickDept点击查询 
	/*
    * 初始化向下查询（当前登陆人下级企业查询）
    * 用session中的登录人id和name当参数，查询当前登录人的信息展示本企业和下级企业
    */
    $scope.deptList={};
	$scope.NextProject = function(orgId){
 	   function qSucc(rec)
 	   {
 		   for(var i=0;i<rec.content.length;i++){
 			  $scope.deptList[i]={
 				  detpId:rec.content[i].currOrgId,
 				  deptName:rec.content[i].name,
 				  deptValue:rec.content[i].name
 			  };
 			 
 		   }
 		  if (rec.content.length > 0) {
				$scope.containNext = true;//显示“是否包含下级单位”checkBox控件
			} else {
				$scope.containNext = false;
			}
 		}
 		function qErr(rec){}
 		entSvc.queryPartyInstallList({
			currOrgId:orgId,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage
		},qSucc,qErr);
	};

	$scope.NextProject(SYS_USER_INFO.orgId);//调用初始化方法传入当前企业的id
	
	
	//区域
	$scope.areaList=[{name:'华北地区',value:'01'},
		             {name:'东北地区',value:'02'},
		             {name:'华东地区',value:'03'},
		             {name:"中南地区",value:'04'}];
	//品牌字母
	$scope.abcList=[
	              {abcName:'A',abcValue:'0'},
                  {abcName:'B',abcValue:'1'},
                  {abcName:'C',abcValue:'2'},
                  {abcName:'D',abcValue:'3'},
                  {abcName:'E',abcValue:'4'},
                  {abcName:'F',abcValue:'5'},
                  {abcName:'G',abcValue:'6'},
                  {abcName:'H',abcValue:'7'},
                  {abcName:'I',abcValue:'8'},
                  {abcName:'J',abcValue:'9'},
                  {abcName:'K',abcValue:'10'},
                  {abcName:'L',abcValue:'11'},
                  {abcName:'M',abcValue:'12'},
                  {abcName:'N',abcValue:'13'},
                  {abcName:'O',abcValue:'14'},
                  {abcName:'P',abcValue:'15'},
                  {abcName:'Q',abcValue:'16'},
                  {abcName:'R',abcValue:'17'},
                  {abcName:'S',abcValue:'18'},
                  {abcName:'T',abcValue:'19'},
                  {abcName:'U',abcValue:'20'},
                  {abcName:'V',abcValue:'21'},
                  {abcName:'W',abcValue:'22'},
                  {abcName:'X',abcValue:'23'},
                  {abcName:'Y',abcValue:'24'},
                  {abcName:'Z',abcValue:'25'}];
	
	//型号
	$scope.modelList=[];
	//规格
	$scope.standardList=[];
	
	//单位范围
	if(SYS_USER_INFO.level==2){
		$scope.danWFWList=[
						   {danWFWName:'局内',danWFWValue:'2'},
		                   {danWFWName:'外局',danWFWValue:'3'},
						   {danWFWName:'外单位',danWFWValue:'4'}];
	}else{
		$scope.danWFWList=[{danWFWName:'处内',danWFWValue:'1'},
						   {danWFWName:'局内',danWFWValue:'2'},
		                   {danWFWName:'外局',danWFWValue:'3'},
						   {danWFWName:'外单位',danWFWValue:'4'}];
	}
	//设备来源  
	$scope.sheBLYList=[{sheBLYName:'自有',sheBLYValue:'1'},
					   {sheBLYName:'外租',sheBLYValue:'2'},
	                   {sheBLYName:'外协',sheBLYValue:'3'}];
	
	//设备状态：全部   闲置、使用中、可出租、可出售、出租发布中、出售发布中
	$scope.sheBZTList=[{sheBZTName:'闲置',sheBZTValue:'1'},
	                   {sheBZTName:'使用中',sheBZTValue:'2'},
	                   {sheBZTName:'可出租',sheBZTValue:'4'},
	                   {sheBZTName:'可出售',sheBZTValue:'5'}];
	
	$scope.FBZTList = [{FBZTName:'出租发布中',FBZTValue:'2'},{FBZTName:'出售发布中',FBZTValue:'3'}];
	
	//业务状态：全部   自用、调拨、局内租、外局租、外租
	$scope.yeWZTList=[{yeWZTName:'自用',yeWZTValue:'1'},
	                  {yeWZTName:'调拨',yeWZTValue:'2'},
	                  {yeWZTName:'局内租',yeWZTValue:'3'},
	                  {yeWZTName:'外局租',yeWZTValue:'4'},
	                  {yeWZTName:'外租',yeWZTValue:'5'}];
	
	
	
	/*
	*
	*/
	$scope.getSmalType=function(obj){
		var name=obj.equipmentCategoryName;
		$scope.formParms=obj;
		function qSucc(rec){
			$scope.smallTypeList=rec.content;
			$scope.smallType=true;
		}
		function qErr(rec){}
		$scope.smallType=true;
		category.unifydo({
			Action:"EquName",equCategoryId:obj.equCategoryId,
			pageNo:0,
			pageSize:20},qSucc,qErr
		);
	};
	if(!$scope.priceUnit){
		$scope.priceUnit={};
	}
	$scope.priceUnit.price = null;
	//定义全局数组
	var arrayjson={params:[]};
	$scope.arraynameArray=[];
	
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
		var temp = ($scope.minPrice?$scope.minPrice:"" )+"-"+($scope.maxPrice?$scope.maxPrice:"")+" "+parm;
		var valuejson={"price":'price'};
		var namejson={"price":temp};
		$scope.processParam(valuejson);
		$scope.displayCondition(namejson);
	};
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
				var valuejson={"model":t.id};
				var namejson={"model":t.name};
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

/* 			var tabs=document.getElementById("modelId").getElementsByTagName('m');
			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
					
	 				tab.style.color='#000000';
			}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
		}
		else if(type=="standard"){//规格
			var ggarry=document.getElementById("ggalink").getElementsByTagName('a');
			if(	$scope.ggisradioorcheckbox){
			var valuejson={"standard":t.id};
			var namejson={"standard":t.name};
			
			$scope.clearggalinstyle();
			if(ggarry[thisid].className==''){ggarry[thisid].className='ihhagouxuan'};
			}else{
				
				if(ggarry[thisid].className==''){
					
					$scope.guigenamearr.push({"id":t.id,"name":t.name});
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
/* 			var tabs=document.getElementById("standardId").getElementsByTagName('s');
			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
					
	 				tab.style.color='#000000';
				}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
		}
		else if(type=="danWFW"){//单位范围
			var wkarry=document.getElementById("gungework").getElementsByTagName('a');
			if(	$scope.dwfwisradioorcheckbox){
			var valuejson={"danWFW":t.danWFWValue};
			var namejson={"danWFW":t.danWFWName};
			$scope.clearworkalinkstyle();
			if(wkarry[thisid].className==''){wkarry[thisid].className='ihhagouxuan'};
			
			}else{
			
				
				if(wkarry[thisid].className==''){
					$scope.dwfwdxnamearr.push({"id":t.danWFWValue,"name":t.danWFWName});
					wkarry[thisid].className='ihhagouxuan';
					}else{
						wkarry[thisid].className='';
						for(var i=0;i<$scope.dwfwdxnamearr.length;i++){
							if($scope.dwfwdxnamearr[i].name==t.danWFWName){
								$scope.dwfwdxnamearr.splice(i,1);
							}
						}
						
					};
				
				
				
			}
/* 			var tabs=document.getElementById("danWFWId").getElementsByTagName('d');
			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
				
	 				tab.style.color='#000000';
				}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
		}
		else if(type=="sheBLY"){//设备来源
			var shebeiarry=document.getElementById("gungeshebei").getElementsByTagName('a');
			if($scope.shebeilyisradioorcheckbox){
			var valuejson={"sheBLY":t.sheBLYValue};
			var namejson={"sheBLY":t.sheBLYName};
			$scope.clearshebeialinkstyle();
			if(shebeiarry[thisid].className==''){shebeiarry[thisid].className='ihhagouxuan'};
			}else{
				if(shebeiarry[thisid].className==''){
					shebeiarry[thisid].className='ihhagouxuan';
					$scope.shebeilynamearr.push({"id":t.sheBLYValue,"name":t.sheBLYName});
					}else{
						shebeiarry[thisid].className='';
						for(var i=0;i<$scope.shebeilynamearr.length;i++){
							if($scope.shebeilynamearr[i].name==t.sheBLYName){
								$scope.shebeilynamearr.splice(i,1);
							}
						}
					};
				
			}
		//	var tabs=document.getElementById("sheBLYId").getElementsByTagName('s');
/* 			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
	 				tab.style.color='#000000';
				}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
		}
		else if(type=="sheBZT"){//设备状态
			
			var shebeiztarry=document.getElementById("gungeshebeizt").getElementsByTagName('a');
			if(	$scope.shebeiztisradioorcheckbox){
			var valuejson={"sheBZT":t.sheBZTValue};
			var namejson={"sheBZT":t.sheBZTName};
			$scope.clearshebeiztalinkstyle();
			if(shebeiztarry[thisid].className==''){shebeiztarry[thisid].className='ihhagouxuan'};
			}else{
				if(shebeiztarry[thisid].className==''){
					$scope.shebeiztnamearr.push({"id":t.sheBZTValue,"name":t.sheBZTName});
					shebeiztarry[thisid].className='ihhagouxuan'
					}else{
						shebeiztarry[thisid].className=''
							for(var i=0;i<$scope.shebeiztnamearr.length;i++){
								if($scope.shebeiztnamearr[i].name==t.sheBZTName){
									$scope.shebeiztnamearr.splice(i,1);
								}
							}
					}
				
				
			}

/* 			var tabs=document.getElementById("sheBZTId").getElementsByTagName('s');
			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
	 				tab.style.color='#000000';
				}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
		}
		else if(type=="FBZT"){//设备状态
			var shebeifbarry=document.getElementById("gungeshebeifb").getElementsByTagName('a');
			if(	$scope.fbztisradioorcheckbox){
				var valuejson={"FBZT":t.FBZTValue};
				var namejson={"FBZT":t.FBZTName};
				$scope.clearshebeifbalinkstyle();
				if(shebeifbarry[thisid].className==''){shebeifbarry[thisid].className='ihhagouxuan'};
			}else{
				if(shebeifbarry[thisid].className==''){
					$scope.fbztnamearr.push({"id":t.FBZTValue,"name":t.FBZTName});
					shebeifbarry[thisid].className='ihhagouxuan';
					}else{
						for(var i=0;i<$scope.fbztnamearr.length;i++){
							if($scope.fbztnamearr[i].name==t.FBZTName){
								$scope.fbztnamearr.splice(i,1);
							}
						}
						shebeifbarry[thisid].className='';
					}
				
			}


/* 			var tabs=document.getElementById("FBZTId").getElementsByTagName('s');
			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
	 				tab.style.color='#000000';
				}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
		}
		else if(type=="yeWZT"){//业务状态
			var shebeiywztarry=document.getElementById("gungeshebeiywzt").getElementsByTagName('a');
			if(	$scope.ywztisradioorcheckbox){
			var valuejson={"yeWZT":t.yeWZTValue};
			var namejson={"yeWZT":t.yeWZTName};
			$scope.clearshebeiywztalinkstyle();
			if(shebeiywztarry[thisid].className==''){shebeiywztarry[thisid].className='ihhagouxuan'};
			
			}else{
				
				if(shebeiywztarry[thisid].className==''){
					shebeiywztarry[thisid].className='ihhagouxuan';
					$scope.ywztnamearr.push({"id":t.yeWZTValue,"name":t.yeWZTName});
					}else{
						for(var i=0;i<$scope.ywztnamearr.length;i++){
							if($scope.ywztnamearr[i].name==t.yeWZTName){
								$scope.ywztnamearr.splice(i,1);
							}
						}
						shebeiywztarry[thisid].className='';
					}
			}

/* 			var tabs=document.getElementById("yeWZTLId").getElementsByTagName('y');
			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
	 				tab.style.color='#000000';
				}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
		}
		else if(type=="brandImg"){//品牌
			var arra=document.getElementById("radioimggroup").getElementsByTagName("a");
			if(	$scope.isradioorcheckbox){
			var valuejson={"brandImg":t.id};
			var namejson={"brandImg":t.name};
/* 			var tabs=document.getElementById("brandImg").getElementsByTagName('p');
			for(var i=0;i<tabs.length;i++){
	 			var tab = tabs[i];
	 			if(i==param){
					
	 				tab.style.color='#000000';
				}else{
	 				tab.style.backgroundColor='';
					tab.style.color='#428bca';
	 			}
			} */
			$scope.clearbrandstyle();
			if(arra[thisid].className==''){arra[thisid].className='ihhagouxuan'}else{arra[thisid].className=''};
			//$scope.queryModelList(t.id);
			//$scope.queryStandardList(t.id);
			}else{
				var valuejson=null;
				var namejson=null;
				if(arra[thisid].className==''){
					if($scope.brandname.length<5){
					var havesame=false;
					for(var i=0;i<$scope.brandname.length;i++){
						if(param==$scope.brandname[i].name){
							havesame=true;
						}
					}
					if(!havesame){
						$scope.brandname.push({"name":param,"id":thisid});
					}
					
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


$scope.worklostblur=function(){
	
}
	/*
	*input输入框change事件
	*/
	$scope.inputChange=function(type,t,queryTrue){
		if(queryTrue){
		$scope.shownextlevel=false;
			if(type=="dept"){//业务状态
				var valuejson={"dept":t};
				var namejson={"dept":t};
				$scope.displayCondition(namejson);
			}
			if(namejson.dept == null || namejson.dept.trim() == ""){
				$scope.deletcondition("dept");
				//如果输入框没有值 则不显示下拉选项 list设为null
				$scope.deptList = [];
				workitem.style.display='none';
				$scope.containNext=false;
				$scope.reason2.rec=false;
			}else{
				//$scope.displayCondition(namejson);
				$scope.queryDeptList(namejson.dept);
			}
		}else{
			if(SYS_USER_INFO.level=="6"){
				$scope.shownextlevel=false;
			}else{
				$scope.shownextlevel=true;
				
			}
			if(type=="dept"){//业务状态
				var valuejson={"dept":SYS_USER_INFO.orgName};
				var namejson={"dept":SYS_USER_INFO.orgName};
			}
			$scope.displayCondition(namejson);
		}
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
	*input输入框change事件--根据输入信息，查询企业
	*/
	$scope.queryDeptList = function(deptName){
		
		function qSucc(rec){
			//设置下拉选项显示为true 并且给list赋值
			//OrgNameFpy
			$scope.deptList = rec.content;
			if(eval(rec.content).length){
				workitem.style.display='';
			}
			//$scope.KWList(rec.content,2);//字数超过9个后用...代替/
		}
		
		function qErr(){}
	
		entSvc.queryPartyInstallList(
			{Action:'QueEnts'},{
				pageNo:0,
				pageSize:20,
				orgName:deptName
			},qSucc,qErr);
		

	};
	
	/*
	*所属单位，ng-checked点击显示show
	*/
	$scope.CDClick=function(){
	};
	
	/*
	*所在城市   city
	*/
	$scope.valuClick = function(){
		if($scope.recCit.recModel)
		{
			var valuejson={"onCity":$scope.recCit.recModel};
			var namejson={"onCity":$scope.recCit.recModel};
			$scope.displayCondition(namejson);
			$scope.onCityValue = $scope.recCit.recModel;
			//$scope.abcInputClick();
			//riqi1.style.display='none';
		}
	};
	
	/*
	*所在城市   city
	*/
	$scope.onProvinceClick = function(){
		if($scope.recPro.proModel)
		{
			var valuejson={"onProvince":$scope.recPro.proModel};
			var namejson={"onProvince":$scope.recPro.proModel};
			$scope.displayCondition(namejson);
			$scope.onProvinceValue = $scope.recPro.proModel;
			$scope.deletcondition("onCity");//删除所在市
			//$scope.abcInputClick();
			//riqi1.style.display='none';
		}
	};
	/*
	*已选条件显示
	*/
	$scope.displayCondition=function(namejson,parm){
		if(namejson!=null){
		 if(namejson instanceof Array){
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
		 }else{
			//获取namejson
			var nameArray=[];
			var tempjson={type:"",name:""};
			for(var key in namejson){
				nameArray[0]=key;
				nameArray[1]=namejson[key];
			}
			tempjson.type=nameArray[0];
			tempjson.name=nameArray[1];
			var flag=false;
			for(var i=0;i<$scope.arraynameArray.length;i++){
				if($scope.arraynameArray[i].type==nameArray[0]){
					$scope.arraynameArray[i].name=nameArray[1];
					flag=true;
				}
			}
			if(!flag){//往数组里新增元素
				$scope.arraynameArray.splice($scope.arraynameArray.length, 0, tempjson); 
			}
		 }}
	};
	
	//处理全局array的方法（包括 新增元素，修改元素）
	$scope.processParam=function(param){
		var flag=false;
		var arrayjsonArray=arrayjson.params;
		//将parm转换成数组
		var paramArray=[];
		for(var key in param){
			paramArray[0]=key;
			paramArray[1]=param[key];
		}
		for(var i=0;i<arrayjsonArray.length;i++){
			for(var key in arrayjsonArray[i]){ 
					if(key==paramArray[0]){
						//修改属性
						arrayjsonArray[i][key]=paramArray[1];
						flag=true;
					}
				} 
		}
		if(!flag){//增加arrayjson属性
			arrayjson.params.push(param);
		}
	};

	/*
	*删除已选条件
	*/
	$scope.deletcondition=function(type){
		
		//return;
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
		if(type =="dept"){//删除所在单位
			$scope.inputDeptName=null;
			$scope.equQryBean.equAtOrgNameInput = null;
			$scope.equQryBean.equAtOrgNameSelect = null;
			$scope.equQryBean.equAtOrgFlag = null;
			$scope.equQryBean.equAtOrgPartyId = null;
			$scope.queryParams.orgName=null;
		}
		else if(type == "city"){//删除全部所在城市
			//$scope.abcInputValue = null;
			$scope.deletcondition("onProvince");//删除所在省
			$scope.onCityValue = null;
			$scope.onProvinceValue = null;
			$scope.recCit.recModel = null;
			$scope.recPro.proModel = null;
		}
		else if(type == "onCity"){//删除所在市
			$scope.onCityValue = null;
			$scope.recCit.recModel = null;
			$scope.queryParams.onCity =null;
		}
		else if(type == "onProvince"){//删除所在省
			$scope.deletcondition("onCity");//删除所在市
			$scope.onProvinceValue = null;		
			$scope.recCit.recModel = null;
			$scope.recPro.proModel = null;
			$scope.queryParams.onProvince =null;
		}
		else if(type == "equipmentName"){//删除设备小类名称
			$scope.deviceNameInputValue = null;
			$scope.e.equNameId = null;
			$scope.queryParams.equNameId =null;
		}
		else if(type == 'device' ){//删除全部设备类型
			$scope.deletcondition("equipmentCategoryName");//删除设备大类名称
			$scope.deviceNameInputValue = null;
			$scope.equipmentCategoryNameValue = null;
			$scope.equ.equCategoryId = null;
			$scope.e.equNameId = null;
			$scope.queryParams.equName=null;
		}
		else if(type == "equipmentCategoryName"){//删除设备大类名称
			$scope.deletcondition("equipmentName");//删除设备小类名称
			$scope.deviceNameInputValue = null;
			$scope.equipmentCategoryNameValue = null;
			$scope.equ.equCategoryId = null;
			$scope.e.equNameId = null;
			$scope.queryParams.equCategoryId =null;
		}
		else if(type == 'yeWZT'){//删除业务状态
			$scope.clearshebeiywztalinkstyle();
			$scope.yeWZTDiv=true;
			$scope.yeWZTDivShow=true;

			$scope.queryParams.busStates=null;
		}
		else if(type == 'sheBZT'){//删除设备状态
			$scope.clearshebeiztalinkstyle();
			$scope.sheBZTDiv=true;
			$scope.sheBZTDivShow=true;
			$scope.queryParams.equStates=null;
		}else if(type == 'FBZT'){//删除发布状态
			$scope.clearshebeifbalinkstyle();
			$scope.FBZTDiv=true;
			$scope.FBZTDivShow=true;
			$scope.queryParams.pubStates=null;
		}
		else if(type == 'sheBLY'){//删除设备来源
			$scope.clearshebeialinkstyle();
			$scope.sheBLYDivShow=true;
			$scope.sheBLYDiv=true;
			$scope.queryParams.equipmentSourceNos=null;
		}
		else if(type == 'danWFW'){//删除单位范围
			$scope.clearworkalinkstyle();
			$scope.danWFWDiv=true;
			$scope.danWFWDivShow=true;
			$scope.queryParams.orgScope=null;
		}
		else if(type == 'standard'){//删除规格
			$scope.clearggalinstyle();
			$scope.standarDivShow=true;
			$scope.standardDiv=true;
			$scope.queryParams.standardNames=null;
		}
		else if(type == 'model'){//删除型号
			$scope.clearmodelalinkstyle();
			$scope.modeldxcancle();
			$scope.modelDiv=true;
			$scope.modelDivShow = true;
			$scope.queryParams.modelNames=null;
		}
		else if(type == "brandImg"){//删除品牌
			$scope.clearbrandstyle();
			$scope.brandDivShow = true;
			$scope.modelDivShow=true;
			$scope.standarDivShow=true;
			$scope.queryParams.brandNames=null;
			//$scope.brandBtnClose();
		}else if(type == "price"){//删除设备原值
			$scope.minPrice="";
			$scope.maxPrice="";
			$scope.queryParams.minPrice=null;

			$scope.queryParams.maxPrice=null;
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
	*鼠标经过展开div
	*/
	$scope.zhanKaiOut=function(){
		document.getElementById("zkShowId").style.color='#333333';
		document.getElementById("sqShowId").style.color='#333333';
	};
	
	/*
	*鼠标离开展开div
	*/
	$scope.zhanKaiOver=function(){
		document.getElementById("zkShowId").style.color='#E4393C';
		document.getElementById("sqShowId").style.color='#E4393C';
	};
	
	/*
	*鼠标点击展开div
	*/
	$scope.zkShow=true;
	$scope.zkClick=function(){
		$scope.zkShow=false;
		$scope.sqShow=true;
		$scope.danWFWDiv=true;
		$scope.sheBLYDiv=true;
		$scope.sheBZTDiv=true;
		$scope.FBZTDiv=true;
		$scope.yeWZTDiv=true;
		$scope.priceDiv=true;
	};
	
	/*
	*鼠标点击收起div
	*/
	$scope.sqClick=function(){
		$scope.zkShow=true;
		$scope.sqShow=false;
		$scope.danWFWDiv=false;
		$scope.sheBLYDiv=false;
		$scope.sheBZTDiv=false;
		$scope.FBZTDiv=false;
		$scope.yeWZTDiv=false;
		$scope.priceDiv=false;
	};
	
	/*
	* 查询列表 -- 品牌
	*/
	$scope.queryBrandList=function(){};
	
	
	/*
	*点击多选按钮事件 -- 品牌
	*/
/* 	$scope.brandDivShow = true;
	$scope.imgShow=true;       
	$scope.imgVarity=false;
	$scope.brandDX=function(){
		$scope.clearChoice();
		$scope.brandGDDis='true';
		$scope.TermShow = true;
		$scope.imgShow=false;
		$scope.imgGDShow=false;
		$scope.imgDXShow=true;
		$scope.brandBtn=true; 
		$scope.brandABC=true; 
		$scope.filterParm = true;
		
		$scope.modelDiv = false;
		$scope.standardDiv = false;
		$scope.modelClick(2);
		$scope.standardClick(2);
		$scope.danWFWClick(2);
		$scope.sheBLYClick(2);
		$scope.sheBZTClick(2);
		$scope.FBZTClick(2);
		$scope.yeWZTClick(2);
		$scope.uploadBrand();
	}; */
	
	/*
	* 点击取消多选状态事件 -- 品牌
	*/
/* 	$scope.brandBtnClose=function(){
		$scope.brandGDDis='';
		$scope.brandBtn=false;
		$scope.brandABC=false;
		$scope.imgDXShow=false;
		$scope.imgGDShow=false;
		$scope.imgShow=true;
		$scope.TermShow = false;
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
		$scope.clearChoice();
		$scope.uploadBrand();
	}; */
	
	/**
	移除多选中的某一项
	*/
	$scope.removeChoiceItem = function(parm){
		var newList = new window.arrayFactory($scope.NewList);
		var testList = new window.arrayFactory($scope.TestList);
		var newArraynameArray = new window.arrayFactory($scope.newArraynameArray);
		$scope.NewList=newList.remove(parm);
		$scope.TestList=testList.remove(parm);
		//var testValue = true;
		$scope.newArraynameArray=newArraynameArray.remove(parm);
	};
	
	/*
	*点击更多事件 -- 品牌
	*/
/* 	$scope.brandGDShow=true;
	$scope.brandGD=function(){
		$scope.imgShow=false;
		$scope.imgDXShow=false;
		$scope.imgGDShow=true;
		$scope.brandABC=true;
		$scope.brandSQShow=true;
		$scope.brandGDShow=false;
		$scope.brandDXDis='true';
		$scope.uploadBrand();		
	}; */
	
	/*
	*点击收起更多状态 -- 品牌
	*/
/* 	$scope.brandSQ=function(){
		$scope.brandDXDis='';
		$scope.brandSQShow=false;
		$scope.brandGDShow=true;
		$scope.imgDXShow=false;
		$scope.imgGDShow=false
		$scope.brandABC=false;
		$scope.imgShow=true;

		$scope.uploadBrand();
	}; */
	
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
	$scope.modelDX=true;
	$scope.modelShow=true;
	$scope.modelClick=function(parm){
		if(parm == 1){
			$scope.modelDX=false;
			$scope.modelQX=true;
			$scope.modelShow=false;
			$scope.modelShowDX=true; 
			$scope.modelChoiceShow = true;
			//
			$scope.standardClick(2);
			$scope.danWFWClick(2);
			$scope.sheBLYClick(2);
			$scope.sheBZTClick(2);
			$scope.FBZTClick(2);
			$scope.yeWZTClick(2);
			$scope.brandBtnClose();
		}else{
			$scope.modelChoiceShow = false;
			$scope.modelDX=true;
			$scope.modelQX=false;
			$scope.modelShow=true;
			$scope.modelShowDX=false;
		}	
	};
	
	
	/*
	*规格的显示效果
	*/
	$scope.standardDX=true;
	$scope.standardShow=true;
	$scope.standardClick=function(parm){
		if(parm == 1){
			$scope.standardDX=false;
			$scope.standardQX=true;
			$scope.standardShow=false;
			$scope.standardShowDX=true; 
			$scope.modelStandardShow = true;
			//
			$scope.modelClick(2);
			$scope.danWFWClick(2);
			$scope.sheBLYClick(2);
			$scope.sheBZTClick(2);
			$scope.FBZTClick(2);
			$scope.yeWZTClick(2);
			$scope.brandBtnClose();
		}else{
			$scope.modelStandardShow = false;
			$scope.standardDX=true;
			$scope.standardQX=false;
			$scope.standardShow=true;
			$scope.standardShowDX=false;
		}	
	};
	
	
	/*
	*单位范围的显示效果
	*/
	$scope.danWFWDX=true;
	$scope.danWFWShow=true;
	$scope.danWFWClick=function(parm){
		if(parm == 1){
			$scope.danWFWDX=false;
			$scope.danWFWQX=true;
			$scope.danWFWShow=false;
			$scope.danWFWShowDX=true;
			$scope.modelDanWFWShow = true;
			//
			$scope.standardClick(2);
			$scope.sheBLYClick(2);
			$scope.sheBZTClick(2);
			$scope.FBZTClick(2);
			$scope.modelClick(2);
			$scope.yeWZTClick(2);
			$scope.brandBtnClose();
		}else{
			$scope.modelDanWFWShow = false;
			$scope.danWFWDX=true;
			$scope.danWFWQX=false;
			$scope.danWFWShow=true;
			$scope.danWFWShowDX=false;
		}	
	}; 
	
	
	/*
	*设备来源的显示效果
	*/
	$scope.sheBLYDX=true;
	$scope.sheBLYShow=true;
	$scope.sheBLYClick=function(parm){
		if(parm == 1){
			$scope.sheBLYDX=false;
			$scope.sheBLYQX=true;
			$scope.sheBLYShow=false;
			$scope.sheBLYShowDX=true;
			$scope.modelSheBLYSShow = true;
			//
			$scope.standardClick(2);
			$scope.danWFWClick(2);
			$scope.sheBZTClick(2);
			$scope.FBZTClick(2);
			$scope.yeWZTClick(2);
			$scope.brandBtnClose();
		}else{
			$scope.modelSheBLYSShow = false;
			$scope.sheBLYDX=true;
			$scope.sheBLYQX=false;
			$scope.sheBLYShow=true;
			$scope.sheBLYShowDX=false;
		}	
	};
	
	
	/*
	*设备状态的显示效果
	*/
	$scope.shebieDX=true;
	$scope.sheBZTShow=true;
	$scope.sheBZTClick=function(parm){
		if(parm == 1){
			$scope.shebieDX=false;
			$scope.shebieQX=true;
			$scope.sheBZTShow=false;
			$scope.sheBZTShowDX=true;
			$scope.modelSheBZTShow = true;
			//
			$scope.standardClick(2);
			$scope.danWFWClick(2);
			$scope.sheBLYClick(2);
			$scope.modelClick(2);
			$scope.yeWZTClick(2);
			$scope.FBZTClick(2);
			$scope.brandBtnClose();
		}else{
			$scope.modelSheBZTShow = false;
			$scope.shebieDX=true;
			$scope.shebieQX=false;
			$scope.sheBZTShow=true;
			$scope.sheBZTShowDX=false;
		}
	};
	
	/*
	*发布状态的显示效果
	*/
	$scope.fbDX=true;
	$scope.FBZTShow=true;
	$scope.FBZTClick=function(parm){
		if(parm == 1){
			$scope.fbDX=false;
			$scope.fbQX=true;
			$scope.FBZTShow=false;
			$scope.FBZTShowDX=true;
			$scope.modelFBZTShow = true;
			//
			$scope.standardClick(2);
			$scope.danWFWClick(2);
			$scope.sheBLYClick(2);
			$scope.modelClick(2);
			$scope.yeWZTClick(2);
			$scope.sheBZTClick(2);
			$scope.brandBtnClose();
		}else{
			$scope.modelFBZTShow = false;
			$scope.fbDX=true;
			$scope.fbQX=false;
			$scope.FBZTShow=true;
			$scope.FBZTShowDX=false;
		}
	};
	
	/*
	*业务状态的显示效果
	*/
	$scope.yewuDX=true;
	$scope.yeWZTShow=true;
	$scope.yeWZTClick=function(parm){
		if(parm == 1){
			$scope.yewuDX=false;
			$scope.yewuQX=true;
			$scope.yeWZTShow=false;
			$scope.yeWZTShowDX=true;
			$scope.modelYeWZTShow = true;
			//点击业务状态显示时，关闭其他多选
			$scope.standardClick(2);
			$scope.danWFWClick(2);
			$scope.sheBLYClick(2);
			$scope.sheBZTClick(2);
			$scope.FBZTClick(2);
			$scope.modelClick(2);
			$scope.brandBtnClose();
		}else{
			$scope.modelYeWZTShow = false;
			$scope.yewuDX=true;
			$scope.yewuQX=false;
			$scope.yeWZTShow=true;
			$scope.yeWZTShowDX=false;
			$scope.ngCheckYWZT=false;
		}
	};
	
	/*
	*业务状态的点击效果
	*/
	var i=0;
	var divs="";
	$scope.NewList=[];
	$scope.TestList=[];
	var testValue = true;
	$scope.newArraynameArray=[];
	$scope.currentParam = "";
	$scope.multipulChoice={}
	$scope.clearChoice = function(){
		//$scope.NewList=[];
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
			if(parm3 == 'yeWZT'){
				$scope.yeWZTSubShow=false;
			}
			else if(parm3 == 'sheBZT'){
				$scope.sheBZTSubShow=false;
			}
			else if(parm3 == 'FBZT'){
				$scope.FBZTSubShow=false;
			}
			else if(parm3 == 'sheBLY'){
				$scope.sheBLYSubShow=false;
			}
			else if(parm3 == 'danWFW'){
				$scope.danWFWSubShow=false;
			}
			else if(parm3 == 'standard'){
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
			if(parm3 == 'yeWZT'){
				$scope.yeWZTSubShow=true;
			}
			else if(parm3 == 'sheBZT'){
				$scope.sheBZTSubShow=true;
			}
			else if(parm3 == 'FBZT'){
				$scope.FBZTSubShow=true;
			}
			else if(parm3 == 'sheBLY'){
				$scope.sheBLYSubShow=true;
			}
			else if(parm3 == 'danWFW'){
				$scope.danWFWSubShow=true;
			}
			else if(parm3 == 'standard'){
				$scope.standardSubShow=true;
			}
			else if(parm3 == 'model'){
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
	$scope.modelDiv=true;
	$scope.modelDivShow=true;
	$scope.yeWZTDivShow=true;
	$scope.standarDivShow=true;
	$scope.sheBZTDivShow=true;
	$scope.FBZTDivShow=true;
	$scope.sheBLYDivShow=true;
	$scope.danWFWDivShow=true;
	$scope.standardDiv=true;
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
		else if(parm == 'sheBZT'){
			$scope.sheBZTSubShow=true;
			if($scope.NewList.length >= 1 && $scope.NewList.length <= 5){
				$scope.sheBZTDivShow=false;
				$scope.sheBZTDiv=true;
				$scope.sheBZTShow=true;
				$scope.sheBZTShowDX=false;
				$scope.sheBZTSubShow=false;
				$scope.shebieDX=true;
				$scope.shebieQX=false;
				$scope.chModel=false;
			}
		}else if(parm == 'FBZT'){
			$scope.FBZTSubShow=true;
			if($scope.NewList.length >= 1 && $scope.NewList.length <= 5){
				$scope.FBZTDivShow=false;
				$scope.FBZTDiv=true;
				$scope.FBZTShow=true;
				$scope.FBZTShowDX=false;
				$scope.FBZTSubShow=false;
				$scope.fbDX=true;
				$scope.fbQX=false;
				$scope.chModel=false;
			}
		}
		else if(parm == 'sheBLY'){
			$scope.sheBLYSubShow=true;
			if($scope.NewList.length >= 1 && $scope.NewList.length <= 5){
				$scope.sheBLYDivShow=false;
				$scope.sheBLYDiv=true;
				$scope.sheBLYShow=true;
				$scope.sheBLYShowDX=false;
				$scope.sheBLYSubShow=false;
				$scope.sheBLYDX=true;
				$scope.sheBLYQX=false;
				$scope.chModel=false;
			}
		}
		else if(parm == 'danWFW'){
			$scope.danWFWSubShow=true;
			if($scope.NewList.length >= 1 && $scope.NewList.length <= 5){
				$scope.danWFWDivShow=false;
				$scope.danWFWDiv=true;
				$scope.danWFWShow=true;
				$scope.danWFWShowDX=false;
				$scope.danWFWSubShow=false;
				$scope.danWFWDX=true;
				$scope.danWFWQX=false;
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
	$scope.xiName="";
	$scope.inputDeptName=SYS_USER_INFO.orgName;
	$scope.abcInputValue = SYS_USER_INFO.cityName;
	$scope.oreCode = SYS_USER_INFO.orgCode;
	$scope.shownextlevel=true;
	$scope.xjClick = function(type, parm,parm1,parm2,a) {
		if(a.orgLevel==3||a.orgLevel==6){
			$scope.shownextlevel=false;
		}else{
			$scope.shownextlevel=true;
			
		}
		if (type == "dept") {//业务状态
			var valuejson = {
				"dept" : parm
			};
			var namejson = {
				"dept" : parm
			};
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
		$scope.showLevel = a.orgLevel;
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
		//riqi1.style.display='';
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
		yli.className=""; 
	}

	
	
	
	/*
	*设备名称，input点击显示-----------------------------------------------------------------------设备名称
	*/
	/* var c=0;
	$scope.equipmentClick=function(){
	
		$scope.deviceNameAClick('A','deviceNameAID');
	}; */
	
	/*
	* 设备名称点击事件 (点击设备名称显示在input输入框)
	*/
	//选择小类 显示到已选条件
	 $scope.deviceNameValueClick=function(){
		if($scope.e.equNameId)
		{
			//riqi2.style.display='none';
			$scope.equipmentCategoryName = $('#equipmentCategoryName option:selected').text();
			$scope.equipmentName = $('#equipmentName option:selected').text();
			var valuejson={"equipmentCategoryName":$scope.equipmentCategoryName};
			var valuejson={"equipmentName":$scope.equipmentName};
			var namejson={"equipmentCategoryName":$scope.equipmentCategoryName};
			var namejson={"equipmentName":$scope.equipmentName};
			$scope.displayCondition(namejson);
				$scope.deviceNameInputValue=$scope.equipmentName;
				 $scope.uiShow = false; 
				 b=0; 
		}
	}; 

	
	//选择设备大类 显示到已选条件
	$scope.equipmentCategoryNameClick=function(){
		if($scope.equ.equCategoryId)
		{
			//riqi2.style.display='none';
			$scope.equipmentCategoryName = $('#equipmentCategoryName option:selected').text();
			var valuejson={"equipmentCategoryName":$scope.equipmentCategoryName};
			var namejson={"equipmentCategoryName":$scope.equipmentCategoryName};
			$scope.displayCondition(namejson);
				$scope.equipmentCategoryNameValue = $scope.equipmentCategoryName;
				 $scope.uiShow = false; 
				 b=0; 
		    $scope.deletcondition("equipmentName");//删除设备小类名称	
		}
	}; 
	$scope.clearshebeishowbol=function(){
		//riqi2.style.display='';
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
	

		 $scope.reason2={rec:false};
	
	/*
	*条件搜索
	*/
	$scope.searchClick=function(){
		//$scope.arraynameArray[$scope.arraynameArray.length] = {type:"containNext",name:$scope.containNext};
		for(var i = 0; i < $scope.arraynameArray.length;i++){
		}
	}
	
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
	$scope.dwfwisradioorcheckbox=true;
	$scope.dwfwdxbtn1=function(){
		$scope.clearworkalinkstyle();
		$scope.dwfwisradioorcheckbox=false;
		dwfwdx1.style.display="none";
		dwfwdx2.style.display="block";
		dwfwsel1.style.display="block";
		dwfwsel2.style.display="block";
		
	}
	$scope.dwfwdxbtn2=function(){
		$scope.dwfwdxnamearr=[];
		$scope.clearworkalinkstyle();
		$scope.dwfwisradioorcheckbox=true;
		dwfwdx1.style.display="block";
		dwfwdx2.style.display="none";
		dwfwsel1.style.display="none";
		dwfwsel2.style.display="none";
		
	}
	$scope.dwfwdxsure=function(){
		var dwfwnameview="";
		if($scope.dwfwdxnamearr.length>1){
			for(var i=0;i<$scope.dwfwdxnamearr.length-1;i++){
				dwfwnameview=dwfwnameview+$scope.dwfwdxnamearr[i].name+",";
			}
			dwfwnameview=dwfwnameview+$scope.dwfwdxnamearr[$scope.dwfwdxnamearr.length-1].name;
			
		}else{
			if($scope.dwfwdxnamearr[0]!=null)
				dwfwnameview=$scope.dwfwdxnamearr[0].name;
		}
		if(dwfwnameview!=""){
		$scope.displayCondition({"danWFW":dwfwnameview});
		}
		$scope.dwfwdxbtn2();
	}
	$scope.deldwfwdxnamearrelement=function(o,l){
		var wkarry=document.getElementById("gungework").getElementsByTagName('a');
		$scope.dwfwdxnamearr.splice(l,1);
 		for(var i=0;i<$scope.danWFWList.length;i++){
			if($scope.danWFWList[i].danWFWName==o.name){
				wkarry[i].className="";
			}
		} 
	}
	$scope.shebeilyisradioorcheckbox=true;
	$scope.shebeilydxbtn1=function(){
		$scope.clearshebeialinkstyle();
		$scope.shebeilyisradioorcheckbox=false;
		shebeilydx1.style.display="none";
		shebeilydx2.style.display="block";
		shebeily1.style.display="block";
		shebeily2.style.display="block";
		
	}
	$scope.shebeilydxbtn2=function(){
		$scope.shebeilynamearr=[];
		$scope.clearshebeialinkstyle();
		$scope.shebeilyisradioorcheckbox=true;
		shebeilydx2.style.display="none";
		shebeilydx1.style.display="block";
		shebeily1.style.display="none";
		shebeily2.style.display="none";
	}
	$scope.delshebeilyelement=function(o,l){
		$scope.shebeilynamearr.splice(l,1);
		var shebeiarry=document.getElementById("gungeshebei").getElementsByTagName('a');
		
 		for(var i=0;i<$scope.sheBLYList.length;i++){
			if($scope.sheBLYList[i].sheBLYName==o.name){
				shebeiarry[i].className="";
			}
		} 
	}
	$scope.shebeilyselectsure=function(){
		var shebeilynameview="";
		if($scope.shebeilynamearr.length>1){
			for(var i=0;i<$scope.shebeilynamearr.length-1;i++){
				shebeilynameview=shebeilynameview+$scope.shebeilynamearr[i].name+",";
			}
			shebeilynameview=shebeilynameview+$scope.shebeilynamearr[$scope.shebeilynamearr.length-1].name;
			
		}else{
			if($scope.shebeilynamearr[0]!=null)
				shebeilynameview=$scope.shebeilynamearr[0].name;
		}
		if(shebeilynameview!=""){
		$scope.displayCondition({"sheBLY":shebeilynameview});
		}
		$scope.shebeilydxbtn2();
	}
	$scope.shebeiztisradioorcheckbox=true;
	$scope.shebeiztdxbtn1=function(){
		$scope.clearshebeiztalinkstyle();
		$scope.shebeiztisradioorcheckbox=false;
		shebeiztdxdiv1.style.display="block";
		shebeiztdxdiv2.style.display="block";
		shebeiztdx1.style.display="none";
		shebeiztdx2.style.display="block";
		
	}
	$scope.shebeiztdxbtn2=function(){
		$scope.shebeiztnamearr=[];
		$scope.clearshebeiztalinkstyle();
		$scope.shebeiztisradioorcheckbox=true;
		shebeiztdxdiv1.style.display="none";
		shebeiztdxdiv2.style.display="none";
		shebeiztdx1.style.display="block";
		shebeiztdx2.style.display="none";
		
	}
	$scope.delshebeiztelement=function(o,l){
		$scope.shebeiztnamearr.splice(l,1);
		var shebeiztarry=document.getElementById("gungeshebeizt").getElementsByTagName('a');
 		for(var i=0;i<$scope.sheBZTList.length;i++){
			if($scope.sheBZTList[i].sheBZTName==o.name){
				shebeiztarry[i].className="";
			}
		} 
	}
	$scope.shebeiztdxsure=function(){
		var shebeiztnameview="";
		if($scope.shebeiztnamearr.length>1){
			for(var i=0;i<$scope.shebeiztnamearr.length-1;i++){
				shebeiztnameview=shebeiztnameview+$scope.shebeiztnamearr[i].name+",";
			}
			shebeiztnameview=shebeiztnameview+$scope.shebeiztnamearr[$scope.shebeiztnamearr.length-1].name;
			
		}else{
			if($scope.shebeiztnamearr[0]!=null)
				shebeiztnameview=$scope.shebeiztnamearr[0].name;
		}
		if(shebeiztnameview!=""){
		$scope.displayCondition({"sheBZT":shebeiztnameview});
		}
		$scope.shebeiztdxbtn2();
	}
	$scope.fbztisradioorcheckbox=true;
	$scope.fbztdxbtn1=function(){
		$scope.clearshebeifbalinkstyle();
		$scope.fbztisradioorcheckbox=false;
		fbztdxdiv1.style.display="block";
		fbztdxdiv2.style.display="block";
		fbztdx1.style.display="none";
		fbztdx2.style.display="block";
	}
	$scope.fbztdxbtn2=function(){
		$scope.fbztnamearr=[];
		$scope.clearshebeifbalinkstyle();
		$scope.fbztisradioorcheckbox=true;
		fbztdxdiv1.style.display="none";
		fbztdxdiv2.style.display="none";
		fbztdx1.style.display="block";
		fbztdx2.style.display="none";
	}
	$scope.fbztdxsure=function(){
		var fbztnameview="";
		if($scope.fbztnamearr.length>1){
			for(var i=0;i<$scope.fbztnamearr.length-1;i++){
				fbztnameview=fbztnameview+$scope.fbztnamearr[i].name+",";
			}
			fbztnameview=fbztnameview+$scope.fbztnamearr[$scope.fbztnamearr.length-1].name;
			
		}else{
			if($scope.fbztnamearr[0]!=null)
				fbztnameview=$scope.fbztnamearr[0].name;
		}
		if(fbztnameview!=""){
		$scope.displayCondition({"FBZT":fbztnameview});
		}
		$scope.fbztdxbtn2();
	}
	$scope.fbztseledcancle=function(o,l){
		$scope.fbztnamearr.splice(l,1);
		var shebeifbarry=document.getElementById("gungeshebeifb").getElementsByTagName('a');
 		for(var i=0;i<$scope.FBZTList.length;i++){
			if($scope.FBZTList[i].FBZTName==o.name){
				shebeifbarry[i].className="";
			}
		} 
	}
	$scope.ywztisradioorcheckbox=true;
	$scope.ywztdxbtn1=function(){
		$scope.clearshebeiywztalinkstyle();
		$scope.ywztisradioorcheckbox=false;
		ywztdx1.style.display="none";
		ywztdx2.style.display="block";
		ywztdxdiv1.style.display="block";
		ywztdxdiv2.style.display="block";
	}
	$scope.ywztdxbtn2=function(){
		$scope.ywztnamearr=[];
		$scope.clearshebeiywztalinkstyle();
		$scope.ywztisradioorcheckbox=true;
		ywztdx2.style.display="none";
		ywztdx1.style.display="block";
		ywztdxdiv1.style.display="none";
		ywztdxdiv2.style.display="none";
	}
	$scope.delywztselected=function(o,l){
		$scope.ywztnamearr.splice(l,1);
		var shebeiywztarry=document.getElementById("gungeshebeiywzt").getElementsByTagName('a');
 		for(var i=0;i<$scope.yeWZTList.length;i++){
			if($scope.yeWZTList[i].yeWZTName==o.name){
				shebeiywztarry[i].className="";
			}
		} 
		
	}
	$scope.yeztdxsure=function(){
		var ywztnameview="";
		if($scope.ywztnamearr.length>1){
			for(var i=0;i<$scope.ywztnamearr.length-1;i++){
				ywztnameview=ywztnameview+$scope.ywztnamearr[i].name+",";
			}
			ywztnameview=ywztnameview+$scope.ywztnamearr[$scope.ywztnamearr.length-1].name;
			
		}else{
			if($scope.ywztnamearr[0]!=null)
				ywztnameview=$scope.ywztnamearr[0].name;
		}
		if(ywztnameview!=""){
		$scope.displayCondition({"yeWZT":ywztnameview});
		}
		$scope.ywztdxbtn2();
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
		$scope.iswaibuorneibu=false;
		if("${sessionScope.userInfo.partyTypeId}"==6){
			$scope.iswaibuorneibu=true;
		}
		$scope.searchchangev=function(){}
		
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
			$scope.compOut = true;
		};
/* 		//点击鼠标时判断满足条件就隐藏div
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
			
			 /* if(riqi1.style.display!='none'&& $scope.cityOut == true){
				 setTimeout(function(){
					 riqi1.style.display = 'none';
				 },100);
			 }  */
			 /* if(riqi2.style.display!='none'&& $scope.nameOut == true){
				 setTimeout(function(){
					 riqi2.style.display = 'none';
				 },100);
			 } 
			  */
			 /* if(workitem.style.display!='none' && $scope.compOut == true){
				 setTimeout(function(){
					 workitem.style.display = 'none';
				 },100); 
			 } */
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
					pageSize : 9999999
				},qSucc,qErr);
			};	
			$scope.queryCategoryData();
			
			//查询设备小类 
			$scope.changeEqu = function(pram){
				if(pram.equCategoryId)
				{
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
				}
				else
				{
					$scope.equipmentList=[];//在IE10浏览器中，如果没有定义，走不通
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
		
		
		
		
		//获取设备的基本信息
		$scope.equipmentBean = {};
		$scope.queryDetail = function(equipmentId)
		{
			
			function qSucc(rec)
			{
				$scope.equipmentBean = rec;
				/** 生产厂家名称 */
				$scope.equipmentBean.manufacturerNameCopy = $scope.equipmentBean.manufacturerName;
				if($scope.equipmentBean.manufacturerName && $scope.equipmentBean.manufacturerName.length > 12)
				{
					$scope.equipmentBean.manufacturerNameCopy = $scope.equipmentBean.manufacturerNameCopy.substring(0,12) + "...";
				}
				$("#equipmentMessage").modal({backdrop: 'static', keyboard: false});
			}
			function qErr(rec){$.messager.popup(rec.data.message);}
			
			equipment.unifydo({urlPath:equipmentId}, qSucc, qErr);
		};
		
	
			
			
			$scope.equQryBean = {};
			$scope.equQryBean.isInclude = 0;//是否包含下级单位 1，包含下级单位
			$scope.equQryBean.isCrecOrg = 0;//是否是中铁单位 1非中铁
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
			
// 			$scope.openEquAtEmployerModel = function(){
// 				if($scope.equAtEmployers.length==0){//	首次打开
// 					var orgLv;
// 					if(1==$scope.userInfo.orgLevel){
// 						orgLv = 9;
// 					}
// 					else if(2==$scope.userInfo.orgLevel){
// 						orgLv = 1;
// 					}
// 					else if(3==$scope.userInfo.orgLevel){
// 						orgLv = 2;
// 					}

// 					$scope.queryEquAtEmployer.currOrgId = $scope.userInfo.orgId;

// 					/** 放入单位信息，且查询该组织下的机构/项目 */
// 					$scope.equAtEmployers = [{name: $scope.userInfo.orgName, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

// 					$scope.queryEquAtEmployer.pageNo = 0;
// 					$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

// 					if(2==orgLv){
// 						$scope.checkEquAtTrProjects = true;
// 						$scope.checkEquAtTrEmployer = false;
// 						$scope.queryEquAtEmployer.check = true;
// 						$scope.equAtCheck = false;

// 						/** 根据currOrgId，查询该组织下的项目 begin */
// 						function qSucc(rec){
// 							$scope.equAtEmployerList = rec.content;
// 							$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
// 							$('#equAtEmployerModel').modal('show');
// 						}
// 						function qErr(){
							
// 						}
// 						proSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
// 						/** 根据currOrgId，查询该组织下的项目 end */
// 						}
// 					else{
// 						$scope.checkEquAtTrProjects = false;
// 						$scope.checkEquAtTrEmployer = true;
// 						$scope.queryEquAtEmployer.check = false;
// 						$scope.equAtCheck = true;

// 						/** 根据currOrgId，查询该组织下的机构 begin */
// 						function qSucc2(rec){
// 							$scope.equAtEmployerList = rec.content;
// 							$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
// 							$('#equAtEmployerModel').modal('show');
// 						}
// 						function qErr2(){
							
// 						}
// 						entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc2, qErr2);
// 						/** 根据currOrgId，查询该组织下的机构 end */
// 					}
// 				}
// 				else{//	非首次打开
// 					$('#equAtEmployerModel').modal('show');
// 				}
// 			};
			
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

				$scope.equQryBean.equAtOrgFlag = $scope.equAtEmployer.orgFlag;
				$scope.equQryBean.equAtOrgPartyId = $scope.equAtEmployer.currOrgId;
				$scope.equQryBean.equAtOrgNameSelect = $scope.equAtEmployer.name;
				
				if($scope.equQryBean.isCrecOrg==1){
					$scope.equQryBean.equAtOrgNameInput = $scope.queryEquAtEmployer.orgName;
					$scope.equQryBean.equAtOrgNameSelect = null;
					if($scope.equQryBean.equAtOrgNameInput){//业务状态
						var valuejson={"dept":$scope.equQryBean.equAtOrgNameInput};
						var namejson={"dept":$scope.equQryBean.equAtOrgNameInput};
					}
					$scope.displayCondition(namejson);
				}
				
				if($scope.equQryBean.equAtOrgNameSelect){//业务状态
					var valuejson={"dept":$scope.equQryBean.equAtOrgNameSelect};
					var namejson={"dept":$scope.equQryBean.equAtOrgNameSelect};
				}
				$scope.displayCondition(namejson); 
			};
			
			/* 取消并关闭 选择单位/项目模态框 */
			$scope.closeEquAtEmployerModel = function(){
				$('#equAtEmployerModel').modal('hide');
			} 

			/*
			 清空单位所在单位的相关参数
			*/
			$scope.clearEquAtEmployerModel = function(){
				$scope.equQryBean.equAtOrgFlag = null;
				$scope.equQryBean.equAtOrgPartyId = null;
				$scope.equQryBean.equAtOrgNameSelect = null;
				$scope.equQryBean.equAtOrgNameInput = null;
				
				$scope.equAtEmployers = [];
				$scope.equAtEmployer = {};
				$scope.queryEquAtEmployer = {};
				$scope.equAtCheck = true;	//	项目选项 显示标志
				$scope.queryEquAtEmployer.check = false;	//	项目选项值
				$scope.checkEquAtTrEmployer = true;	//	列名称 - 单位名称 显示标志
				$scope.checkEquAtTrProjects = false;	//	列名称 - 项目名称 显示标志

				$('#equAtEmployerModel').modal('hide');
			};
			
			/* 选择单选框 */
			$scope.selectFlag = "";	/** 记录第几个单选框标记 */
			$scope.qryEquDetail = {};

			$scope.equipSelect = function(equipmentId, index_){
				$scope.selectFlag = index_;
				$scope.qryEquDetail.equipmentId = equipmentId;
			};
			
			$scope.equQryBean.displayIsCrecFlag = true;
			/* 变更使用单位 中铁/非中铁 */
			$scope.external = 2;
			$scope.click = function(){
				if(0==$scope.equQryBean.isCrecOrg){
					$scope.external = 2;
					$scope.equQryBean.displayIsCrecFlag = true;/** 非中铁单位选项 显示标志 */
					$scope.equQryBean.orgName = "";
					 if($scope.equQryBean.equAtOrgNameSelect){//业务状态
						var valuejson={"dept":SYS_USER_INFO.orgName};
						var namejson={"dept":SYS_USER_INFO.orgName};
						}
					$scope.displayCondition(namejson);
				}
				else{
					$scope.equQryBean.displayIsCrecFlag = false;/** 非中铁单位选项 显示标志 */
					$scope.external = 1;
					$scope.deletcondition("dept");
					
					
				}
				
			}
});
</script>
<style>
	.select-hover > option:hover  {
		background-color: #C0C0C0;
	}
	.div-hover:hover{/* div事件  */
		border-bottom:2px solid #428BCA;
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
	#firstupcaseul{
	margin-left:15px;
	list-style: none;
		
	}
		#firstupcaseul>li{
		height:25px;
		cursor:pointer;
		padding:0px 10px 0px 10px;
	float: left;
	}
			#firstupcaseul>li:hover{
	border-bottom:2px solid #428BCA;
	}
	.citylistcss{
	width:450px;
		float: left;
	list-style: none;
	
	}
	.citylistcss>li{
	cursor:pointer;
	height:17px;
	line-height:17px;
	float: left;
	width:90px ;
	color: black;
	font-size: 12px;
	
	}
		.citylistcss>li:hover{
	
			background-color:#428BCA;
	
	}
#cityulctr>li{
margin-top: 10px;
}
.diood_k{ width:998px; height:100px; float:left; overflow:hidden; position:relative;}
.diood_k a{ width:116px; height:48px; line-height:48px; display:block; float:left; border:1px solid #ededed;
 margin:1px; text-align:center; font-size:14px; color:#222; position:relative;text-decoration: none;}
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

#allbrand>span:hover{border:1px solid #1db100; }
#allbrand>span{cursor: pointer;width: 20px;border:1px solid white;}

#workitemulli{

}
#workitemulli>li{
padding: 0px 0px 0px 5px;
color: black;
cursor:pointer;font-size: 12px;
}
#workitemulli>li:hover{

background: #ebebeb;
}
.tab_hj tr:hover{
background: #f3f3f3;
}
</style>

</head>
<body ng-app="searchApp" ng-controller="searchController" >
    <div ng-include src="'./EquipmentMessage.jsp'" ></div>
	<div>
        <div ng-include src="'/WebSite/Front/Main/Top1.jsp'" ></div>
 	</div>
	<div class="main">
	<div class="position"><span>&gt;</span>  &nbsp;资源搜索页&nbsp; <span>&gt;</span> &nbsp;筛选结果 &nbsp;<span></span> </div>
	<div class="zbgg_t bgcfe">
    		<span class="left col_f dddw" style="width:70px;">已选条件：</span>
		    <ul class="ihha_sstj">
		      <li ng-repeat="a in arraynameArray" ng-show="a.name!=null&&a.name!=''">
			      <div style="max-width: 180px;overflow: hidden; /*自动隐藏文字*/text-overflow: ellipsis;/*文字隐藏后添加省略号*/white-space: nowrap;/*强制不换行*/" title="{{a.name}}" ng-cloak>{{a.name}}</div>
			      <a href="#" ng-click="deletcondition(a.type)"><img style="vertical-align:baseline;" src="../../../media/images/ssas.png"/></a>
		      </li>
		    </ul>
   			<a class="dosdd" href="#" ng-click="queryResourec();">搜索</a> 
   		</div>
   		<!-- 已选条件  -->
		<!-- 你搜索的关键字是 -->
   		<div style="height:34px;"> 
   		<div class="zbgg_t bdfff"  ng-show="searBean.infoTitleBean != null && searBean.infoTitleBean !=''">
    	<span class="left col_3 hanggao">您搜索的关键词是
   			<a class=" col_red" href="#" ng-cloak style="text-decoration: none;">{{searBean.infoTitleBean}}</a>
   			 ，相关信息共
   			<a class=" col_red" href="#" ng-cloak style="text-decoration: none;">
    		 {{(totalElement=="0" && $scope.searBean.infoTitleBean=="") ? paginationConf.totalItems:totalElement}}
    		</a> 条
        </span>
    </div>
    </div>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_tt">
        <tr class="osf">
          <td valign="top" nowrap="nowrap"><div align="left" class="mar_l20">所属单位：</div></td>
          <td valign="top">&nbsp;</td>
	      <td colspan="2" style="position: relative;z-index: 102;"> 
	          <!-- <input type="hidden" id="dept" name="dept">
	          <input onclick="if(workitem.style.display==''){workitem.style.display=='none'}else{workitem.style.display==''}"
	          ng-change="inputChange('dept',inputDeptName,true)" ng-init="inputChange('dept')"  type="text" class="inpt_a inpt_o span230"
	          ng-model="inputDeptName" data-toggle="dropdown" list-items="suggestions" index="selected" />
	          <div class="left mar_l20" ng-show="shownextlevel"> 
	          		<input type="checkbox" ng-show="showLevel &lt; 3" ng-model="reason2.rec" ng-click="CDClick();" /><font ng-show="showLevel &lt; 3">是否包含下级</font>
	          </div>
	          <div ng-mouseover="mouseOverFun();" ng-mouseleave="mouseLeaveFun();" style="position: absolute;top:40px;left: 0px;display: none;width:230px;border: 1px solid #bebebe;background: white;text-align: left;" id="workitem">
	          <ul id="workitemulli">
		          <li ng-repeat="d in deptList" ng-keyup="myKeyupHC($event)" ng-click="xjClick('dept',d.name,d.code,d.currOrgId,d);" >
			          <div style="width: 180px;overflow: hidden; /*自动隐藏文字*/
			               text-overflow: ellipsis;/*文字隐藏后添加省略号*/
			               white-space: nowrap;/*强制不换行*/" title="{{d.name}}">{{d.name}}</div>
		          </li>
	          </ul>
			  <div style="clear: both;"></div>
	          </div> -->
	          <div class="col-xs-3" >
					<div ng-show="equQryBean.isCrecOrg==0" class="input-group">
						<input ng-model="equQryBean.equAtOrgNameSelect" type="text" class="inpt_a inpt_o span230" style="margin-top: 6px; width: 112%; margin-left: -12%; height: 34px; border-right: 0px; background-color: #fff;" readonly="readonly">
						<span class="input-group-btn" style="padding-top: 6px;">
							<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEquAtEmployerModel()">…</button>
						</span>
					</div>
					<div ng-show="equQryBean.isCrecOrg==1"class="input-group">
						<input style="margin-left: -23px;height: 34px;"  ng-model="equQryBean.equAtOrgNameInput" type="text" class="inpt_a inpt_o span230" />
						<span class="input-group-btn" style="padding-top: 6px;">
							<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; margin-left: -29px;margin-top: -8px; background-color: #fff;" ng-click="openEquAtEmployerModel()">…</button>
						</span>
					</div>
					
				</div>
				<!-- <div class="col-xs-1">
					<input ng-model="equQryBean.isCrecOrg" ng-true-value="1" ng-false-value="0" ng-click="click();" type="checkbox" style="position: absolute; z-index: 3; margin-left: -22px; margin-top: 10px;">
					<label contenteditable="false" class="control-label" style="text-align: left; position: absolute; z-index: 2; margin-left: -3px;">非中铁单位</label>
				</div> -->
				<div class="col-xs-1" ng-show="external==2 && (equQryBean.orgFlag==9 || equQryBean.orgFlag==1 || equQryBean.equAtOrgFlag!=2 && equQryBean.equAtOrgFlag!=3)">
					<input ng-model="equQryBean.isInclude" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: -22px; margin-top: 10px;">
					<label contenteditable="false" class="control-label" style="text-align: left; position: absolute; z-index: 2; margin-left: -3px;">包含下级单位</label>
				</div>
	      </td>
      	</tr>
        
        <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20" >所在城市：</div></td>
          <td valign="top">
	          <div align="center">
	          	  <a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('city')">全部</a>
	          </div>
	      </td>
 		  <td  colspan="2" class="jjk" style="position:relative; z-index:101;">
 		  	<div class="form-group text-left" style="margin-top: -15px;margin:-17px;">
		 		<div class="col-xs-2" >
			   		<select id="province" name="SelectProvince" ng-model="recPro.proModel" class="sel_a sel_ay" required
			    		    ng-options="recPro.name as recPro.name for recPro in areaList" ng-change="changePro(recPro);"  ng-click="onProvinceClick();"
			      	     style="position: absolute;z-index:2;margin-left: 5px;width:100%;height: 34px;margin-top: 0px;color: #555;"> 
			       		<option value="" >--请选择省份--</option>
			         </select>
		     	</div>
		     	<div class="col-xs-2">
			      	<select id="city" name="SelectCity" ng-model="recCit.recModel" class="sel_a sel_ay"
			  				ng-options="recCit.name as recCit.name for recCit in pList"   required  ng-click="valuClick();"
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
			   		<select id="equipmentCategoryName" name="" ng-model="equ.equCategoryId" class="sel_a sel_ay" required
			    		    ng-options="equ.equCategoryId as equ.equipmentCategoryName for equ in categoryList" ng-change="changeEqu(equ);" ng-click="equipmentCategoryNameClick();"
			      	     style="position: absolute;z-index:2;margin-left: 5px;width:100%;height: 34px;margin-top: 0px;color: #555;"> 
			       		<option value="" >--请选择设备大类--</option>
			         </select>
		     	</div>
		     	<div class="col-xs-2">
			      	<select id="equipmentName" name="" ng-model="e.equNameId" class="sel_a sel_ay"
			  				ng-options="e.equNameId as e.equipmentName for e in equipmentList"   required ng-change="changeEquName(e);" ng-click="deviceNameValueClick();"
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
		              <li class="gx_1" ng-repeat="x in modelnamearr">{{x.name}}<a href="javascript:void(0);" ng-click="delmodelseled(x,$index);">×</a></li>
		            </ul>
		            <div class="clear"></div>
	          </div>
	          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="#" ng-click="modeldx();" id="modeldx1">+多选</a>
           		<a class="dfsfg" href="#" style="display: none;" ng-click="modeldxcancle();" id="modeldx2">-多选</a>
           </td>
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
	              <li class="gx_1" ng-repeat="x in guigenamearr">{{x.name}}<a href="javascript:void(0);" ng-click="delggseled(x,$index);">×</a></li>
	            </ul>
	            <div class="clear"></div>
	          </div>
	          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="javascript:void(0)" ng-click="ggdxbtn1()" id="ggdx1">+多选</a>
           <a class="dfsfg" href="javascript:void(0)" style="display: none;" ng-click="ggdxbtn2()" id="ggdx2">-多选</a></td>
        </tr>
            <tbody style="display: none;" id="morecontent">
        
        <tr class="osf" ng-show="inputDeptName==null||inputDeptName==''">
          <td valign="top"><div align="left" class="mar_l20">单位范围：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('danWFW');">全部</a></div></td>
          <td  class="jjk">
          <div class="iodfpq left" id="gungework">
          <a ng-repeat="d in danWFWList" href="javascript:void(0)" ng-click="selectQuery('danWFW',d,d.danWFWName,$index)"  >{{d.danWFWName}}<font></font></a>
          
         
               <font class="qdqx" id="dwfwsel1" style="display:none;float: left;">
               <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="dwfwdxsure()"/>&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" ng-click="dwfwdxbtn2()" name="button" id="button" value="取消" />
               </font>
               <div style="clear: both;"></div>
               </div>
          
          <div class="goux_fx" style="display:none;" id="dwfwsel2"> 
            <ul class="ihha_sstj ">
              <li class="gx_12 col_lan">已勾选条件：</li>
              <li class="gx_1" ng-repeat="x in dwfwdxnamearr">{{x.name}}<a href="javascript:void(0);" ng-click="deldwfwdxnamearrelement(x,$index)">×</a></li>
            </ul>
            <div class="clear"></div>
           </div>
          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="#" ng-click="dwfwdxbtn1()" id="dwfwdx1">+多选</a>
           <a class="dfsfg" href="#" style="display: none;" ng-click="dwfwdxbtn2()" id="dwfwdx2">-多选</a></td>
        </tr>
        
        
        
         <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20">设备来源：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"   ng-click="deletcondition('sheBLY');">全部</a></div></td>
          <td  class="jjk">
          <div class="iodfpq left" id="gungeshebei">
          <a  ng-repeat="s in sheBLYList" href="javascript:void(0)" ng-click="selectQuery('sheBLY',s,s.sheBLYValue,$index)"   >{{s.sheBLYName}}<font></font></a>
               <font class="qdqx" id="shebeily1" style="display:none;float: left;">
               <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="shebeilyselectsure()"/>&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" ng-click="shebeilydxbtn2()" name="button" id="button" value="取消" />
               </font>
                         <div class="clear"></div> 
               </div>
          
          <div class="goux_fx" style="display:none;" id="shebeily2"> 
            <ul class="ihha_sstj ">
              <li class="gx_12 col_lan">已勾选条件：</li>
              <li class="gx_1" ng-repeat="x in shebeilynamearr">{{x.name}}<a href="javascript:void(0);" ng-click="delshebeilyelement(x,$index)">×</a></li>
            </ul>
            <div class="clear"></div>
           </div>
          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="#" ng-click="shebeilydxbtn1()" id="shebeilydx1">+多选</a>
           <a class="dfsfg" href="#" style="display: none;" ng-click="shebeilydxbtn2()" id="shebeilydx2">-多选</a></td>
        </tr>
        
        
        
        
                 <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20">设备状态：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('sheBZT');">全部</a></div></td>
          <td  class="jjk">
          <div class="iodfpq left" id="gungeshebeizt">
          <a href="javascript:void(0)" ng-repeat="s in sheBZTList" ng-click="selectQuery('sheBZT',s,s.sheBZTName,$index)"   >{{s.sheBZTName}}<font></font></a>
          
          
               <font class="qdqx" id="shebeiztdxdiv1" style="display:none;float: left;">
               <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="shebeiztdxsure()"/>&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" ng-click="shebeiztdxbtn2()" name="button" id="button" value="取消" />
               </font>
               </div>
          
          <div class="goux_fx" style="display:none;" id="shebeiztdxdiv2"> 
            <ul class="ihha_sstj ">
              <li class="gx_12 col_lan">已勾选条件：</li>
              <li class="gx_1" ng-repeat="x in shebeiztnamearr">{{x.name}}<a href="javascript:void(0);" ng-click="delshebeiztelement(x,$index)">×</a></li>
            </ul>
            <div class="clear"></div>
           </div>
          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="#" ng-click="shebeiztdxbtn1()" id="shebeiztdx1">+多选</a>
           <a class="dfsfg" href="#" style="display: none;" ng-click="shebeiztdxbtn2()" id="shebeiztdx2">-多选</a></td>
        </tr>
        
        
        
        
        
                
                 <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20">发布状态：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('FBZT');">全部</a></div></td>
          <td  class="jjk">
          <div class="iodfpq left" id="gungeshebeifb">
          <a href="javascript:void(0)" ng-repeat="s in FBZTList"  ng-click="selectQuery('FBZT',s,s.FBZTName,$index)"    >{{s.FBZTName}}<font></font></a>
          
          
               <font class="qdqx" id="fbztdxdiv1" style="display:none;float: left;">
               <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="fbztdxsure()"/>&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" ng-click="fbztdxbtn2()" name="button" id="button" value="取消" />
               </font>
               </div>
          <div style="clear: both;"> </div>
          <div class="goux_fx" style="display:none;" id="fbztdxdiv2"> 
            <ul class="ihha_sstj ">
              <li class="gx_12 col_lan">已勾选条件：</li>
              <li class="gx_1" ng-repeat="x in fbztnamearr">{{x.name}}<a href="javascript:void(0);" ng-click="fbztseledcancle(x,$index)">×</a></li>
            </ul>
            <div class="clear"></div>
           </div>
          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="#" ng-click="fbztdxbtn1()" id="fbztdx1">+多选</a>
           <a class="dfsfg" href="#" style="display: none;" ng-click="fbztdxbtn2()" id="fbztdx2">-多选</a></td>
        </tr>
        
        
        
        
                        <tr class="osf">
          <td valign="top"><div align="left" class="mar_l20">业务状态：</div></td>
          <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('yeWZT');">全部</a></div></td>
          <td  class="jjk">
          <div class="iodfpq left" id="gungeshebeiywzt">
          <a href="javascript:void(0)" ng-repeat="y in yeWZTList"  ng-click="selectQuery('yeWZT',y,y.yeWZTName,$index)"   >{{y.yeWZTName}}<font></font></a>
          
          
               <font class="qdqx" id="ywztdxdiv1" style="display:none;float: left;">
               <input type="submit" class="ihhaannou" name="button" id="button" value="确定" ng-click="yeztdxsure()"/>&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="submit" ng-click="ywztdxbtn2()" name="button" id="button" value="取消" />
               </font>
               <div style="clear: both;"></div>
               </div>
          
          <div class="goux_fx" style="display:none;" id="ywztdxdiv2"> 
            <ul class="ihha_sstj ">
              <li class="gx_12 col_lan">已勾选条件：</li>
              <li class="gx_1" ng-repeat="x in ywztnamearr">{{x.name}}<a href="javascript:void(0);" ng-click="delywztselected(x,$index)">×</a></li>
            </ul>
            <div class="clear"></div>
           </div>
          <div class="clear"></div> 
          </td>
           <td valign="top"><a class="dfsfg" href="#" ng-click="ywztdxbtn1()" id="ywztdx1">+多选</a>
           <a class="dfsfg" href="#" style="display: none;" ng-click="ywztdxbtn2()" id="ywztdx2">-多选</a></td>
        </tr>
        
        
        <tr class="osf">
          <td valign="top" nowrap="nowrap"><div align="left" class="mar_l20">设备原值：</div></td>
            <td valign="top"><div align="center"><a class=" col_lan" href="javascript:void(0)"  ng-click="deletcondition('price')">全部</a></div></td>
          <td colspan="2"> 
          <input ng-model="minPrice" id="minPrice"   type="text" class="inpt_a inpt_o span230" style="width: 120px;" ng-blur="checkPrice(true,minPrice);" maxlength="10"/>
          <div style="float: left;margin-right: 10px;border:1px solid #bebebe;width:20px;margin-top:15px;"></div>
          <input  ng-model="maxPrice" id="maxPrice" maxlength="10" type="text" class="inpt_a inpt_o span230" style="width: 120px;"  ng-blur="checkPrice(false,maxPrice)"/>
            <!-- <div style="float: left;margin-right: 10px;"><select ng-if="CZshow || QZshow" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.UNIT_RENTMONEY" ng-model="priceUnit.price">
       	 	    <option value="">全部</option>
          </select></div> -->
           	<span style="float: left;margin-right: 10px;">万元</span> <input  type="submit" class="moneysub" name="button" id="button" value="确定" style="margin-top: 2px;" ng-click="inputPrice('万元');"/>
           	
           	<div class="left mar_l20"></div>
             <div style="clear: both;"></div> 
            </td>
           
      </tr>
  </tbody>
</table>
    <div class="fopwqr" id="morebtn"><p class="hha dllbg" ng-click="moreselect()">更多选项：（单位范围，设备来源，设备状态等）</p></div>
    <div class="fopwqr" id="lessbtn" style="display: none;" ><p ng-click="lessselect()" class="hha dllbg1">收起</p></div>
    
    	


   <div style=" margin-top:50px;"  ng-init="queryResourec('init');">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj">
	        <tr>
		       	<th>序号</th>
				<th  style="width:130px;">设备编号</th>
				<th  style="width: 150px;">设备名称(型号:规格)</th>
				<th style="width:100px;">品牌</th>
				<th>设备来源</th>
				<th>设备原值(万元)</th>
				<th>购置日期</th>
				<th style="width: 150px;">所属单位</th>
				<th>设备状态</th>
				<th>业务状态</th>
				<th style="width: 150px;">使用单位</th>
				<th>租售状态</th>
	        </tr>
	        <!-- |orderBy:'releaseDate':true -->
	         <tr ng-repeat="t in resultList">
	          	<td>
					<span ng-cloak>{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</span>
				</td>
				<td style="text-align: center;" >
					<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.equNo}}" ng-cloak><a ng-click="queryDetail(t.equipmentId);">{{t.equNo}}</a></div>
				</td>
					<td style="text-align: center;">
				<div style="margin:0 auto;width: 130px;overflow: hidden;
				text-overflow: ellipsis;white-space: nowrap;color: black;"
				 ng-cloak  title="{{t.equName}} {{t.frontModel}}">{{t.equName}}<span ng-show="t.frontModel!=''">（</span>{{t.frontModel}}<span ng-show="t.frontModel!=''">）</span></div>
				</td>
				<td  style="text-align: center;">
					<div style="margin:0 auto;width: 90px;overflow: hidden;
					text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.brandName}}" ng-cloak>{{t.brandName}}</div>
				</td>
				<td ng-cloak>{{ct.codeTranslate(t.equipmentSourceNo,"SOURCE_TYPE")}}</td>
				<td ng-cloak>{{t.equipmentCost}}</td>
				<td ng-cloak title="{{t.purchaseDate | limitTo:10}}">{{t.purchaseDate | limitTo:10}}</td>
				<td style="text-align: center;" >
					<div style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.proOrgName}}" ng-cloak>{{t.proOrgName}}</div>
					<div ng-if="!t.proOrgName" style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.sonOrgName}}" ng-cloak>{{t.sonOrgName}}</div>
					<div ng-if="!t.sonOrgName && !t.proOrgName" style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.bureauOrgPartyName}}" ng-cloak>{{t.bureauOrgPartyName}}</div>
				</td>
				<td ng-cloak >{{ct.codeTranslate(t.equState,"EQU_STATE")}}</td>
				<td ng-cloak>{{ct.codeTranslate(t.busState,"WORK_STATE")}}</td>
				
				<td style="text-align: center;" >
					<div  style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.equAtProjectName}}" ng-cloak>{{t.equAtProjectName}}</div>
					<div ng-if="!t.equAtProjectName" style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.equAtSubOrgName}}" ng-cloak>{{t.equAtSubOrgName}}</div>
					<div ng-if="!t.equAtSubOrgName && !t.equAtProjectName" style="margin:0 auto;width: 130px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color: black;" title="{{t.equAtOrgName}}" ng-cloak>{{t.equAtOrgName}}</div>
				</td>
				<td ng-cloak>{{ct.codeTranslate(t.pubState,"RELEASE_STATE")}}</td>
	        </tr>

      </table>

   </div>

	   <div style="float: right;">
				<!-- <pagination-tag conf="paginationConf"></pagination-tag> -->
				<tm-pagination conf="paginationConf" style="margin-left:0px;"></tm-pagination>
				<span ng-if="outDiv">没有符合条件的记录</span>
			</div>
			<div style="clear: both;"></div>
</div>
<div ng-include src="'./ResourceModel.jsp'" ></div>
	<!-- 引入底文件 -->
	<jsp:include page="../../Front/Include/Bottom.jsp" />
</body>

</html>
