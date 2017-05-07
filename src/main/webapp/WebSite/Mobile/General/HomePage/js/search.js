$(function(){
		$("#searchType").val("chuzu");
		window.scrollTo(0,0);
	});
	
	function selectSearch(type){
		$("#searchType").val(type);
	}
	 
	var cookiesJudge=function(jumpUrl,Flag,typeNum,alarmMsg){// 判断cookies是否存在，如已存在直接进入页面，如不存在进入登录页面 
		var isLogin = "${sessionScope.userInfo}";
	    var isId = "${sessionScope.userInfo.partyTypeId}"
		//if(isLogin==null||isLogin==''){
	/* 		if(alarmMsg){
				$.messager.confirm("提示", alarmMsg, function() { 
					if(typeNum){
						window.location.href="../../../WebSite/Front/Login/Login.jsp?flag="+typeNum;
					}else{
						window.location.href="../../../WebSite/Front/Login/Login.jsp?";
					}
				});
			}else{
				// $.messager.confirm("提示", "您没有权限发布信息，请注册为企业用户", function() {  
					if(typeNum){
						window.location.href="../../../WebSite/Front/Login/Login.jsp?flag="+typeNum;
					}else{
						window.location.href="../../../WebSite/Front/Login/Login.jsp?";
					}
				// }); 
			} */
		//}else{
			if(Flag){// 如果有标志就是新打开页面的模式 
				if(typeNum=="rent"){
					window.open("../../Back/Publish/Infopub.jsp","_blank");
				}
				else if(typeNum=="demandRent"){
					/* if(isId==6){
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
					} */
					window.open("../../Back/Publish/DemandInfoPub.jsp","_blank");
			    }
			     
				else if(typeNum=="sale"){
					window.open("../../Back/Publish/InfopubSale.jsp","_blank");
			    }
				else if(typeNum=="demandSale"){
					/* if(isId==6){
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
					} */
					window.open("../../Back/Publish/DemandInfoPubShop.jsp","_blank");
			    }
			}else{
				window.open(jumpUrl,"_blank");
			}
			
		//}
	};
	app.controller('searchIncludeController',function($scope,$route,published,searchUrl,category){
		
	   if($route.current.params.gotoParm_ == 1){
		   $scope.title = false;
		   $scope.infotitle=true;
		   $scope.historical = 1;
		 
		   //var screenListAll = eval("("+$route.current.params+")");
		   
			$scope.deviceNameClick=function(){
					$scope.deviceNameList=["A","B","C","D","E","F","G","H","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
					function qSucc(rec){
						$scope.deviceNameValueListA=rec.A;
						$scope.deviceNameValueListB=rec.B;
						$scope.deviceNameValueListC=rec.C;
						$scope.deviceNameValueListD=rec.D;
						$scope.deviceNameValueListE=rec.E;
						$scope.deviceNameValueListF=rec.F;
						$scope.deviceNameValueListG=rec.G;
						$scope.deviceNameValueListH=rec.H;
						$scope.deviceNameValueListI=rec.I;
						$scope.deviceNameValueListJ=rec.J;
						$scope.deviceNameValueListK=rec.K;
						$scope.deviceNameValueListL=rec.L;
						$scope.deviceNameValueListM=rec.M;
						$scope.deviceNameValueListN=rec.N;
						$scope.deviceNameValueListO=rec.O;
						$scope.deviceNameValueListP=rec.P;
						$scope.deviceNameValueListQ=rec.Q;
						$scope.deviceNameValueListR=rec.R;
						$scope.deviceNameValueListS=rec.S;
						$scope.deviceNameValueListT=rec.T;
						$scope.deviceNameValueListU=rec.U;
						$scope.deviceNameValueListV=rec.V;
						$scope.deviceNameValueListW=rec.W;
						$scope.deviceNameValueListX=rec.X;
						$scope.deviceNameValueListY=rec.Y;
						$scope.deviceNameValueListZ=rec.Z;
					}
					function qErr(){}
					published.unifydoHM({Action:"EquNameFpy"},{fpy:$scope.deviceNameList},qSucc,qErr); 
			};
			$scope.LiNumB=2;
			$scope.deviceNameClick();
			$scope.KeyWordQuery = function(parm){
				$scope.KeyWordList=[];
				function success(rec){
					if(rec.list.length <= 0){
						$scope.LiNum=false;
						$scope.LiNumB=2;
					}else{
						$scope.LiNum=true;
						$scope.LiNumB=1;
						$('#parentOrgs1')[0].style.display = 'block'; 
						//判断查询出的数据是否存在于缓存中，如果存在，将搜索词放入首个位置
						$scope.KeyWordList=rec.list;
					}
				}
				
				function error(){}
				if(parm){//输入框有值
					$scope.equipmentName=parm;
					published.unifydoHM({Action:"EquNameLike"},{equipmentName:$scope.equipmentName},success,error);
					
					$scope.LiNum=true;
					//缓存的最近查询事件
					$scope.LiNumB=1;
				}else{
					$scope.LiNum=false;
					$scope.LiNumB=2;
				}
			};
	   }
	   
	   
	   if($route.current.params.parm_url=="homePage"|| $route.current.params.parms ||$route.current.params.parm_url=="Rent"||$route.current.params.parm_url=="Sale"
		   ||$route.current.params.parm_url=="DemandRent"||$route.current.params.parm_url=="DemandSale"){
		   $scope.infotitle=false;
		   $scope.title = true;
		   $scope.historical = 2;
		   
			$scope.KeyWordQuery = function(parm){
				
				$scope.KeyWordList=[];

				function success(rec){
					
					if(rec.content.length<=0){
						$scope.LiNumA=false;
					}else{
						$scope.LiNumA=true;
						$('#parentOrgs1')[0].style.display = 'block'; 
						//判断查询出的数据是否存在于缓存中，如果存在，将搜索词放入首个位置
						$scope.checkQueryKeyWord(rec.content);
						$scope.KeyWordList=rec.content;
						$scope.KWList(rec.content);//字数超过9个后用...代替/
					}
				}
				
				
				//【安迈】【安xxx】【xxx】电动空压机(1,1)
				
				function error(){}
				$scope.queryData.Action="ITCount";
				if(parm){//输入框有值
					$scope.queryData.infoTitle=parm;
					$scope.queryData.infoType = queryData.infoType;
					published.unifydo($scope.queryData,success,error);
					$scope.LiNumB=false;
					//缓存的最近查询事件
					windowOnload(cf.getCookies('ashow'));
					$scope.sercheVal = "";
					$scope.showMsg.msg = '';
					if(showWord()){
						$scope.sercheVal = showWord();
						$scope.cookiesshow=false;
					}else{
						$scope.cookiesshow=true;
					}
				}else{//输入框被清空
					if(cf.getCookies('ashow')){//有cookies，显示cookies值
						$scope.showMsg.msg = '';
						$scope.LiNumB=true;
					}else{//没有cookies就显示暂无搜索历史
						$scope.showMsg.msg = '暂无搜索历史';
						$scope.LiNumB = false;
					}
					$scope.LiNumA=false;
				}
			};
	   }

	  
		/**
		 * 搜索返回方法
		 * 要根据穿过来的参数去判断是哪个页面传来的，在传回去
		 */
		$scope.goBackIndexPageFun = function(){
			if($route.current.params.parm_url && $route.current.params.parm_url == 'homePage'){//如果是主页传过来的就传回主页
				window.location.href="/WebSite/Mobile/Index.jsp";
			}else if($route.current.params.parm_url && $route.current.params.parm_url == 'Screen'){
				window.location.href="/WebSite/Mobile/Index.jsp#/Screen";
			}else{
				if($route.current.params.parm_url == 'Rent'){
					window.location.href="/WebSite/Mobile/Index.jsp#/viewRentList/1";
				}
				if($route.current.params.parm_url == 'Sale'){
					window.location.href="/WebSite/Mobile/Index.jsp#/ViewSaleList/2";
				}
				if($route.current.params.parm_url == 'DemandRent'){
					window.location.href="/WebSite/Mobile/Index.jsp#/ViewDemandRentList/3";
				}
				if($route.current.params.parm_url == 'DemandSale'){
					window.location.href="/WebSite/Mobile/Index.jsp#/ViewDemandSaleList/4";
				}
			}
			if($route.current.params.parms){
				window.location.href="/WebSite/Mobile/Index.jsp#/classify";
			}
			
			if(minPrice_ || maxPrice_){
				window.location.href="/WebSite/Mobile/Index.jsp#/Screen";
			}
		};
		
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
		$scope.isSearchRequest = (theRequest.searchContent==null?false:true);//判断是否是从搜索页面过来的请求
		$scope.decodeURIVal = decodeURI(theRequest.searchContent);
		$scope.requestParms = theRequest;
		$scope.ltype = $scope.requestParms.searchType;
		$scope.actionName = "";
		$scope.searBean.infoTitleBean = (($scope.decodeURIVal!=null && !($scope.decodeURIVal === 'undefined'))?$scope.decodeURIVal:"");
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
					break;		
				}
				default:{
					$('#searchTab li').removeClass('lefthui');
					$('#searchTab li:eq(0)').addClass('lefthui');
					$scope.actionName = "Rent";
					break;
				}
			}
			$scope.showMenu();
		};
	    $scope.showMenu=function(){
		    switch($scope.ltype){
			    case 'ziyuan' :{
					/* $('#ulTopId li:eq(1) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(1)').addClass("baidi")
					break;		
				}
			    case 'chuzu' :{
			    	/* $('#ulTopId li:eq(2) a').css('background','#CBCCCD'); */
			    	$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(2)').addClass("baidi")
			    	break;	
			    }
			    case 'qiuzu' :{
			    	/* $('#ulTopId li:eq(3) a').css('background','#CBCCCD'); */
			    	$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(3)').addClass("baidi")
			    	break;	
			    }
				case 'sale' :{
					/* $('#ulTopId li:eq(4) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(4)').addClass("baidi")
					break;			    	
				}
				case 'qiugou' :{
					/* $('#ulTopId li:eq(5) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(5)').addClass("baidi")
					break;		
				}case 'luban' :{
					/* $('#ulTopId li:eq(5) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(8)').addClass("baidi")
					break;		
				}
				default:{
					/* $('#ulTopId li:eq(0) a').css('background','#CBCCCD'); */
					$('#jsddm li').removeClass("baidi");
					$('#jsddm li:eq(0)').addClass("baidi")
					break;
				}
			}
		};
		
		/*
		 * 点击搜索事件
		*/
		$scope.searchPublished=function(val,parm){
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
		* 查询热门搜索词
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
		* 更改热门搜索词的位置，搜索次数越多排位更靠前
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
			$scope.indexFlag = 0;
			if($scope.searBean.infoTitleBean == null || $scope.searBean.infoTitleBean == ""){
				$scope.LiNumA=false;
				$scope.KeyWordListB=[];
				cf.getCookies('ashow');//对Cookies进行读取
				if(cf.getCookies('ashow')){
					windowOnload(cf.getCookies('ashow'));//向外部chinesepyi.js的方法windowOnload传递参数
					for(var i=0;i<cf.getCookies('ashow').length;i++){//$scope.KeyWordListB遍历接收getCookies的值
						$scope.KeyWordListB.push({infoTitleB:cf.getCookies('ashow')[cf.getCookies('ashow').length-1-i]});
					}
					if($scope.KeyWordListB){
						for(var i=0;i<$scope.KeyWordListB.length;i++){
							$scope.KeyWordListB[i].infoTitleC =  $scope.KeyWordListB[i].infoTitleB;
							if($scope.KeyWordListB[i].infoTitleB && $scope.KeyWordListB[i].infoTitleB.length > 5){
								$scope.KeyWordListB[i].infoTitleC = $scope.KeyWordListB[i].infoTitleC.substring(0,5);
							}
						}
					}
					$scope.showMsg = {};
					$scope.showMsg.msg = '';
				}else{
					$scope.showMsg = {};
					$scope.showMsg.msg = '暂无搜索历史';
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
		*缓存关键字删除事件
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
		*缓存关键字清空事件
		*/
		$scope.DelAll = function(){
			document.getElementById("searchContent").focus();
			$.messager.confirm("提示", "确认删除全部历史记录？", function() { 
				$scope.LiNumB=false;
				cf.deleteCookies('ashow');
				setTimeout(function() {
				    $scope.$apply(function() {
				    	$scope.KeyWordListB = [];
				    });  
				}, 500);
				$scope.showMsg.msg ='暂无搜索历史';
			});
			
		};
		$scope.clickEquipment = function(bettonValue,selectValue){
			setTimeout(function(){
				if(selectValue == 1){
					var id = 1;
					var bettonValue_ = bettonValue;
					window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
				}else if(selectValue == 2){
					var id = 2;
					var bettonValue_ = bettonValue;
					window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
				}else if(selectValue == 3){
					var id = 3;
					var bettonValue_ = bettonValue;
					window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
				}else if(selectValue == 4){
					var id = 4;
					var bettonValue_ = bettonValue;
					window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
				}
			},500);
		}
		
		
		
		
		/*
		* 点击热门搜索词
		*/
		$scope.queryInfoLink=function(bettonValue,selectValue){
			$scope.insertCache(bettonValue);//保存设备名到cookies
			$scope.querySearchHotWords(bettonValue);//热词前挪
			//var searchType=$("#searchType").val();
			if($route.current.params.parm_url && $route.current.params.parm_url == "Screen"){
				setTimeout(function(){
					if(selectValue == 1){
						var id = 1;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
					}else if(selectValue == 2){
						var id = 2;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
					}else if(selectValue == 3){
						var id = 3;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
					}else if(selectValue == 4){
						var id = 4;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/Screen"+'/'+id+'/'+bettonValue_;
					}
					
				},500);
			}else if($route.current.params.parm_url && $route.current.params.parm_url == "homePage" || $route.current.params.parms
					||$route.current.params.parm_url=="Rent"||$route.current.params.parm_url=="Sale"
						   ||$route.current.params.parm_url=="DemandRent"||$route.current.params.parm_url=="DemandSale"){
				setTimeout(function(){
					if(selectValue == 1){
						var id = 1;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/viewRentList"+'/'+id+'/'+bettonValue_;
					}else if(selectValue == 2){
						var id = 2;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/ViewSaleList"+'/'+id+'/'+bettonValue_;
					}else if(selectValue == 3){
						var id = 3;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/ViewDemandRentList"+'/'+id+'/'+bettonValue_;
					}else if(selectValue == 4){
						var id = 4;
						var bettonValue_ = bettonValue;
						window.location.href="/WebSite/Mobile/Index.jsp#/ViewDemandSaleList"+'/'+id+'/'+bettonValue_;
					}
					//window.open(searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm,"_self");
				},500);
			}
		
		};	
		
		
		/*
		*input框ng-change事件
		*/
		$scope.queryData = {};
		$scope.queryData.infoType = 1;
		var queryData = {};
		queryData.infoType = $scope.queryData.infoType;
		$scope.typeName_ = {};
		$scope.typeName_.name ="出租";
		
		
		$scope.checkQueryKeyWord = function(varl){
			var cookieParm = cf.getCookies('ashow');
			if(cookieParm != null){
			for(var i = 0; i < varl.length;++i){
				varl[i].rankLocation = i;
				for(var j = 0; j < cookieParm.length; ++j){
					if(varl[i].infoTitle == cookieParm[j]){
						varl[i].flagMsg = "";
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
				if(val[i].infoTitle.length > 12){
					$scope.KeyWordList[i].infoTitleA = val[i].infoTitle.substring(0,12)+"...";
	        	}else{
	        		$scope.KeyWordList[i].infoTitleA = val[i].infoTitle;
	        	}
			}
		};
		
	    /*
		*关键字搜索点击事件(出租-求租-出售-求购)
		*/
		$scope.selectSearchName="";
	/*	$scope.selectSearch = function(parm){
		};*/
/*		$scope.selectSearch=function(parm){
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
		};*/
		
		$scope.insertCache = function(parm){
			if(parm==null || parm.trim() == ""){
				return;
			}else{
				published.unifydo({Action:"RecentSearch",hotWord:parm},qSucc,qError);
			}
			function qSucc(rec){
				/*if(rec.msg == "TRUE"){*/ //经由上面的接口返回值来判断所输值是否为333个小类之中，如是也就是TRUE那么存在cookies中
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
				/*}*/
			}
			function qError(){}
		};
		
		/*
		*点击搜索下拉框定位显示在input
		*/
		$scope.SearchInputShow = function(buttonValue,selectValue){
			
			
			//将搜索的关键字放入缓存
		/*	$scope.insertCache(parm);
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
			}*/
		};
		
		$scope.InputShowB = function(parm){
			
			return;
			
			/*if(parm){
				$scope.searchPublished(1, parm);
			   // $scope.querySearchHotWords(parm);
			}*/
		};
		
		
		/*
		 *文本框回车事件
		 */
		 $scope.inputKeyupTemp = function(e){
		    if(e && e.keyCode == 13){
		    	  $scope.LiNumA=false;
		    	  $scope.LiNumB=false;
		    	  if($scope.searBean.infoTitleBean == "" || $scope.searBean.infoTitleBean == null){
		    		  //$scope.searchPublished();
		    		$scope.queryInfoLink();
		       	  }else{  
		       		$scope.queryInfoLink($scope.searBean.infoTitleBean,$scope.queryData.infoType);
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
		        	 
		          }
		     } 
		};
		
		
		/*
		*关键字搜索回车事件
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
	 	*缓存关键字搜索回车事件
	 	*/
	 	$scope.myKeyupHC = function(e){
	           if(e && e.keyCode==38){//上,左
	           	  //$scope.searBean.infoTitleBean=e.target.innerText;
	        	//  $scope.LiNumB = false;
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
		
		$scope.clearInput = function(){
			$scope.searBean.infoTitleBean=null;
			$scope.LiNumB = false;
			$scope.LiNumA = false;
			$("#clearFlag")[0].style.display = "none";
		}

		
 		setTimeout(function() {
		    $scope.$apply(function() {
		    	var inputs = document.getElementsByTagName("input");
		    	var pf=new window.placeholderFactory(); 
		    	pf.createPlaceholder(inputs);
		    	//document.getElementById("eeeee").value="asd";
		    });  
		}, 500); 
		
 		$scope.changeSelectValueFun = function(parm){
 			$scope.queryData.infoType = parm;
 			queryData.infoType = $scope.queryData.infoType;
 			if($scope.queryData.infoType == 1){
 				    	$scope.typeName_.name = '出租'; 
 				    	$scope.num_ = $scope.queryData.infoType;
 				    	$scope.revel_ = !$scope.revel_;
 			 			$scope.myVar_ = !$scope.myVar_;
 			}else if($scope.queryData.infoType == 2){
 				    	$scope.typeName_.name = '出售';
 				    	$scope.num_ = $scope.queryData.infoType;
 				    	$scope.revel_ = !$scope.revel_;
 			 			$scope.myVar_ = !$scope.myVar_;
 			}else if($scope.queryData.infoType == 3){
 				    	$scope.typeName_.name = '求租';
 				    	$scope.num_ = $scope.queryData.infoType;
 				    	$scope.revel_ = !$scope.revel_;
 			 			$scope.myVar_ = !$scope.myVar_;
 			}else if($scope.queryData.infoType == 4){
 				    	$scope.typeName_.name = '求购';
 				    	$scope.num_ = $scope.queryData.infoType;
 				    	$scope.revel_ = !$scope.revel_;
 			 			$scope.myVar_ = !$scope.myVar_;
 			}
 			
 			
  			
 		};
 		
 		/**
 		 * 如果是国才的页面传值过来那么就根据传过来的种类改变查询的种类
 		 */
 		if($route.current.params.parm_url && $route.current.params.parm_url == 'Screen'){
			if($route.current.params.gotoParm_ && $route.current.params.gotoParm_ == 1){
				setTimeout(function() {
				    $scope.$apply(function() {
				    	$scope.queryData.infoType = $route.current.params.gotoParm_;
				    });  
				}, 500);
			}else if($route.current.params.gotoParm_ && $route.current.params.gotoParm_ == 2){
				setTimeout(function() {
				    $scope.$apply(function() {
				    	$scope.queryData.infoType = $route.current.params.gotoParm_;
				    });  
				}, 500);
			}else if($route.current.params.gotoParm_ && $route.current.params.gotoParm_ == 3){
				setTimeout(function() {
				    $scope.$apply(function() {
				    	$scope.queryData.infoType = $route.current.params.gotoParm_;
				    });  
				}, 500);
			}else if($route.current.params.gotoParm_ && $route.current.params.gotoParm_ == 4){
				setTimeout(function() {
				    $scope.$apply(function() {
				    	$scope.queryData.infoType = $route.current.params.gotoParm_;
				    });  
				}, 500);
			}
		};
		
		
		$scope.myVar_ = true;
		$scope.revel_ = false;
		$scope.num_ = 1;
		$scope.typeName_.name = '出租';
		if(!$route.current.params.gotoParm_){
			$scope.num_ = 1;
			$scope.typeName_.name = '出租';
		}
		if(!$route.current.params.parms){
			$scope.num_ = 1;
			$scope.typeName_.name = '出租';
		}else{
			if($route.current.params.gotoParm_){
				$scope.num_ = $route.current.params.gotoParm_;
			}else if($route.current.params.parms){
				$scope.num_ = $route.current.params.parms;
			}
			if($scope.num_ == 1){
				$scope.typeName_.name = '出租';
			}else if($scope.num_ == 2){
				$scope.typeName_.name = '出售';
			}else if($scope.num_ == 3){
				$scope.typeName_.name = '求租';
			}else if($scope.num_ == 4){
				$scope.typeName_.name = '求购';
			}
		}
	
		$scope.toggle = function(parm) {
			$scope.num_ = parm;
         	$scope.myVar_=!$scope.myVar_;
         	$scope.revel_ = !$scope.revel_;
	   };
	   
	   
	   
	   
	   
	   
	});