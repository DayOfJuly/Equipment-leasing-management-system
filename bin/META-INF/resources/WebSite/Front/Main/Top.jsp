<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.Math" %>
<script type="text/javascript" src="../../../js/JsLib/myArray.js"></script>
<script type="text/javascript">
	$(function(){
		$("#searchType").val("chuzu");
	});
	
	function selectSearch(type){
		$("#searchType").val(type);
	}
	
	var cookiesJudge=function(jumpUrl,Flag,typeNum,alarmMsg){// 判断cookies是否存在，如已存在直接进入页面，如不存在进入登录页面 
		
		
		var isLogin = "${sessionScope.userInfo}";
	    var isId = "${sessionScope.userInfo.orgLevel}"
	    
	    
	    

	    if(!isId && typeNum =='sszy'){
			$.messager.confirm("提示", "当前功能只有中国中铁的内部企业用户可以使用", function() {});	
			return;
	    }
	    
		 if(!isId){
	 			$.messager.confirm("提示", "您没有权限发布信息，请注册为企业用户", function() {});	
	 			return;
	 	 }
	    
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
					 if(isId==1){						 
							$.messager.confirm("提示", "总公司人员不能做发布操作", function() {});	
							return;
						} 
					window.open("../../Back/Publish/Infopub.jsp","_blank");
				}
				else if(typeNum=="demandRent"){
					 /* if(isId==6){						 
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
						}  */
					 if(isId==1){						 
							$.messager.confirm("提示", "总公司人员不能做发布操作", function() {});	
							return;
						} 
					window.open("../../Back/Publish/DemandInfoPub.jsp","_blank");
			    }
			     
				else if(typeNum=="sale"){
					 if(isId==1){						 
							$.messager.confirm("提示", "总公司人员不能做发布操作", function() {});	
							return;
						} 
					window.open("../../Back/Publish/InfopubSale.jsp","_blank");
			    }
				else if(typeNum=="demandSale"){
					/*  if(isId==6){
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
					} */ 
					 if(isId==1){						 
							$.messager.confirm("提示", "总公司人员不能做发布操作", function() {});	
							return;
						} 
					window.open("../../Back/Publish/DemandInfoPubShop.jsp","_blank");
			    }
			}else{
				 if(isId==6){
						$.messager.confirm("提示", "当前功能只有中国中铁的内部企业用户可以使用", function() {});	
						return;
					} 
				 if(!isId){
						$.messager.confirm("提示", "您没有权限发布信息", function() {});	
						return;
					} 
				window.open(jumpUrl,"_blank");
			}
			
		//}
	};
	app.controller('searchIncludeController',function($scope,published,searchUrl,category){
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
		$scope.InputClick_ = function(){
			$scope.indexFlag = 0;
			if($scope.searBean.infoTitleBean == null || $scope.searBean.infoTitleBean == ""){
				$scope.LiNumA=false;
				$scope.KeyWordListB=[];
				cf.getCookies('ashow');//对Cookies进行读取
				if(cf.getCookies('ashow')){
					//windowOnload(cf.getCookies('ashow'));//向外部chinesepyi.js的方法windowOnload传递参数 这段被注释了四个租赁按钮报错下方展示发布信息也报错
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
				$scope.KeyWordListB.splice($scope.KeyWordListB);
			});
		};
		
		
		/*
		* 点击热门搜索词
		*/
		$scope.queryInfoLink=function(parm){
			$scope.insertCache(parm);
			$scope.querySearchHotWords(parm);
			var searchType=$("#searchType").val();
			setTimeout(function(){
				window.open(searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm,"_self");
			},500);
			//将被点击的热门搜索词传递到搜索页面
		};	
		
		
		/*
		*input框ng-change事件
		*/
		$scope.KeyWordQuery = function(parm){
			/* $scope.checkExplore(); */
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
					//判断查询出的数据是否存在于缓存中，如果存在，将搜索词放入首个位置
					$scope.checkQueryKeyWord(rec.content);
					$scope.KeyWordList=rec.content;
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
			
			if(parm==null || parm.trim() == ""){
				return;
			}else{
				published.unifydo({Action:"RecentSearch",hotWord:parm},qSucc,qError);
			}
	
		};
		
		/*
		*点击搜索下拉框定位显示在input
		*/
		$scope.SearchInputShow = function(parm1,parm){
			
			//将搜索的关键字放入缓存
			$scope.insertCache(parm);
			//更新热门搜索词
			if(parm){
				$scope.searBean.infoTitleBean = parm;
			 	var searchType=$("#searchType").val();
				if($scope.selectSearchName){
				/* 	setTimeout(function(){
						document.getElementById("keyWords"+parm1).href=searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm;
					},500); */
					document.getElementById("keyWords"+parm1).href=searchUrl+"Search.jsp?searchType="+$scope.selectSearchName+"&searchContent="+parm;
				}else{
					/* setTimeout(function(){
						document.getElementById("keyWords"+parm1).href =searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm;
					},500); */
					document.getElementById("keyWords"+parm1).href =searchUrl+"Search.jsp?searchType="+searchType+"&searchContent="+parm;
				}
			}
		};
		
		$scope.InputShowB = function(parm){
			if(parm){
				$scope.searchPublished(1, parm);
			   // $scope.querySearchHotWords(parm);
			}
		};
		
		
		/*
		 *文本框回车事件
		 */
		 $scope.inputKeyup = function(e){
		    if(e && e.keyCode == 13){
		    	  $scope.LiNumA=false;
		    	  $scope.LiNumB=false;
		    	  if($scope.searBean.infoTitleBean == "" || $scope.searBean.infoTitleBean == null){
		    		  $scope.searchPublished();
		       	  }else{
		       		$scope.searchPublished(1,$scope.searBean.infoTitleBean);
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
		
 		
 		$scope.mouseFlag = true;
 		$scope.mouseOverFun = function(){
 			$scope.mouseFlag = false;
 		};
 		
 		$scope.mouseLeaveFun = function(){
 			$scope.mouseFlag = true;
 		};
 		
 		$scope.mouseFlag2 = true;
 		$scope.mouseOverFun2 = function(){
 			$scope.mouseFlag2 = false;
 		};
 		
 		$scope.mouseLeaveFun2 = function(){
 			$scope.mouseFlag2 = true;
 		};
 		
 		
 		
 		document.onmousedown = function(){
 			if($scope.LiNumA == true && $scope.mouseFlag == true){
 				//$scope.LiNumA = false;
 				parentOrgs1.style.display = 'none';
 			}
 			
 			if($scope.LiNumB == true && $scope.mouseFlag2 == true){
 				//$scope.LiNumA = false;
 				parentOrgs2.style.display = 'none';
 				a = 0;
 			}
 		};
 		
	});
</script>
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge" /> -->
<div ng-controller="searchIncludeController">
	<div class="topcss">
		<div class="topcss_nr">
			<p>欢迎来到中国中铁采购电子商务平台</p>
			<p>客服热线-400-6988000</p>
			<ul>
				<li class="ihhalogin"><a href="###">登录</a></li>
				<li><a href="###">免费注册</a></li>
				<li><a href="###">会员中心</a></li>
				<li><a href="###">客户服务</a></li>
				<li><a href="###">网站导航</a></li>
			</ul>
		</div>
	</div>

	<div class="logocss">
		<p><a href="http://www.crecgec.com"><img src="../../../media/images/logo.png" width="384" height="62" /></a></p>
		<div class="mmt">
			<div class="ergkite" id="tt" style="height: 30px;">
				<ul id="searchTab" style="margin-bottom: -1px;" ng-init="judgeTab();">
					<li class="lefthui" id="lqq1"><a href="#" ng-click="selectSearch('chuzu')" ng-mouseover="selectSearch('chuzu')">出租</a></li>
					<li id="lqq2"><a href="#" ng-click="selectSearch('qiuzu')" ng-mouseover="selectSearch('qiuzu')">求租</a></li>
					<li id="lqq3"><a href="#" ng-click="selectSearch('sale')" ng-mouseover="selectSearch('sale')">出售</a></li>
					<li id="lqq4"><a href="#" ng-click="selectSearch('qiugou')" ng-mouseover="selectSearch('qiugou')">求购</a></li>
				</ul>
			</div>
			<div class="ihhass">
				<p class="logo_search logo_search_aa">
					<span class="spanA" ng-click="searchPublished(1,searBean.infoTitleBean);">搜索</span>
					<input style="height:30px;padding:3px 12px"
							data-toggle="dropdown" ng-model="searBean.infoTitleBean"
							type="text" id="searchContent" name="searchContent"
							class="form-control" select="setSelected(x)"
							list-items="suggestions" close="suggestionPicked()"
							selection-made="selectionMade" placeholder="请输入关键词检索"
							index="selected" maxlength="200"
							ng-change="KeyWordQuery(searBean.infoTitleBean);"
							ng-click="InputClick_();" ng-keyup="inputKeyup($event)" />
					<span id="clearFlag" class="glyphicon glyphicon-remove" style="position: absolute;margin-left: -30px;margin-top: 8px; display:none;" ng-click="clearInput();"></span>
					<input type="text" focus-me focus-when="{{selectionMade}}" style="display:none;"/>
					<input type="hidden" id="searchType" name="searchType" />
				</p>
				<div class="ddfsf" style="position: absolute;margin-top:30px;">热门搜索词： <a href="#" ng-repeat="linkValue in linkValueList" ng-click="queryInfoLink(linkValue.equipmentName);" ng-bind="linkValue.equipmentName"></a> </div>
				<div id="parentOrgs1"  style="display: none;">
					<div class="input_xl" ng-if="LiNumA" id="parentOrgs" ng-mouseover="mouseOverFun();" ng-mouseleave="mouseLeaveFun();">
						<ul >
							<li ng-repeat="RentInfo in KeyWordList |orderBy:'-rankLocation'" ng-click="SearchInputShow($index,RentInfo.infoTitle);" ng-keyup="myKeyup($event)">
								<a id="keyWords{{$index}}" title="{{RentInfo.infoTitle}}"  class="ss_link1" style="float:left; width:199px;" href="###">{{RentInfo.infoTitleA}}</a>
								<lable style="float:right;">
									<font ng-show="$index==0" ng-bind="RentInfo.flagMsg">&nbsp;</font>&nbsp;
									<font ng-show="RentInfo.flagMsg == null || RentInfo.flagMsg == '' || $index != 0">约{{RentInfo.itCount}}个设备</font>
								</lable>
							</li>
						</ul>
						<div class="clear"></div>
					</div>
				</div>
				
				<div id="parentOrgs2"  style="display: none;">
					<div class="input_xl" ng-if="LiNumB" id="parentOrgs" ng-mouseover="mouseOverFun2();" ng-mouseleave="mouseLeaveFun2();">
						<span class="ihha_zjss">最近搜索：</span>
						<ul >
							<li ng-repeat="RentInfoB in KeyWordListB" ng-click="InputShowB(RentInfoB.infoTitleB);" ng-keyup="myKeyupHC($event)">
								<a class="ss_link1" href="###" style="float:left; width:220px;" title="{{RentInfoB.infoTitleB}}" ng-bind="RentInfoB.infoTitleB"></a>
								<a class="ss_link1" id="delid{{$index}}" style="float:right;width:40px;" ng-mouseover="DelColorOverShow($index);" ng-mouseout="DelColorOutShow($index);" ng-click="DelCache(RentInfoB.infoTitleB,$index);" >删除</a>
							</li>
		 				</ul>
						<span class="ihha_qk">
			           		<a ng-mouseover="DelAllOver();" class="ihha_qk" ng-mouseout="DelAllOut();" ng-click="DelAll();">
			           			<span id="delAllAId"></span>
								<span id="delAllBId"  style="margin-left:3px;color:#a8a8a8;" >×清空</span>
							</a>
					  </span>
		              <div class="clear"></div>
	              </div>
	         </div>
	         
	     </div>
	</div>
	<div class="logo_rigd">
	<!-- 	<a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Front/Publish/DemandInfoPub.jsp','Flag','demandRent','您没有权限发布信息，请注册为企业用户');">发布求租信息</a>
		<a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Front/Publish/Infopub.jsp','Flag','rent','您没有权限发布信息，请注册为企业用户');">发布出租信息</a>
		<a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Front/Publish/DemandInfoPubShop.jsp','Flag','demandSale','您没有权限发布信息，请注册为企业用户');" >发布求购信息</a>
		<a style="text-decoration : none;" onClick="cookiesJudge('../../../WebSite/Front/Publish/InfopubSale.jsp','Flag','sale','您没有权限发布信息，请注册为企业用户');">发布出售信息</a> -->
		
	    <a style="text-decoration : none;" onClick="cookiesJudge('../../Back/Publish/DemandInfoPub.jsp?random=${Math.random()}','Flag','demandRent','您没有权限发布信息，请注册为企业用户');">发布求租信息</a>
		<a style="text-decoration : none;" onClick="cookiesJudge('../../Back/Publish/Infopub.jsp?random=${Math.random()}','Flag','rent','您没有权限发布信息，请注册为企业用户');">发布出租信息</a>
		<a style="text-decoration : none;" onClick="cookiesJudge('../../Back/Publish/DemandInfoPubShop.jsp?random=${Math.random()}','Flag','demandSale','您没有权限发布信息，请注册为企业用户');" >发布求购信息</a>
		<a style="text-decoration : none;" onClick="cookiesJudge('../../Back/Publish/InfopubSale.jsp?random=${Math.random()}','Flag','sale','您没有权限发布信息，请注册为企业用户');">发布出售信息</a>
		<div class="clear"></div>
	</div>
</div>

<div class="daohangcss">
	<ul id="jsddm">
		<li ><a href="../../../WebSite/Front/Main/HomePage.jsp?random=${Math.random()}">首页</a></li>
    <%--<li><a href="" onClick="cookiesJudge('../../../WebSite/Front/Main/Resource.jsp?searchType=ziyuan&random=${Math.random()}',false,'sszy','当前功能只有中国中铁的内部企业用户可以使用');">资源搜索</a></li>--%>
        <li><a href="" onClick="cookiesJudge('../../Back/Main/Resource.jsp?searchType=ziyuan&random=${Math.random()}',false,'sszy','当前功能只有中国中铁的内部企业用户可以使用');">资源搜索</a></li>
		<li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=chuzu&random=${Math.random()}" target="_blank">出租信息</a></li>
		<li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=qiuzu&random=${Math.random()}" target="_blank">求租信息</a></li>
		<li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=sale&random=${Math.random()}" target="_blank">出售信息 </a></li>
		<li><a href="../../../WebSite/Front/Main/Search.jsp?searchType=qiugou&random=${Math.random()}" target="_blank">求购信息 </a></li>
		<li><a href="###">出租人风采</a></li>
		<li><a href="###">承租人风采</a></li>
		<li style="width:146px;"><a href="###">我的鲁班</a>
			<ul style="width:146px;">
				<%-- <li><a href="../../../WebSite/Front/Main/publishBack.jsp?searchType=luban&random=${Math.random()}">已发布的信息</a></li> 2016.2.23.13:49 因需要把前台所有需要拦截的文件放到后台的main文件中所以修改路径，因而注释--%>
				<%-- <li><a href="../../../WebSite/Front/Main/publishFront.jsp?searchType=luban&random=${Math.random()}">想交易的信息</a></li> --%>
				<li><a href="../../Back/Main/publishBack.jsp?searchType=luban&random=${Math.random()}">已发布的信息</a></li>
				<li><a href="../../Back/Main/publishFront.jsp?searchType=luban&random=${Math.random()}">想交易的信息</a></li>
				<li><a href="../../Back/index.jsp">后台管理</a></li>
<%-- 				<li><a href="javascript:void(0);" onClick="cookiesJudge('../../../WebSite/Back/index.jsp?random=${Math.random()}');">后台管理</a></li> --%>
			</ul>
		</li>
	</ul>
</div>
<script type="text/javascript" src="../../../media/js/commonjs.js"></script>