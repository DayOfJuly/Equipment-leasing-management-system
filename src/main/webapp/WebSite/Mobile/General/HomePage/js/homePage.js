app.controller('homePageController',function($scope,published){

	//资源统计
	$scope.resourceCount=function(){
		function qSucc(rec){
			$scope.resourceMsg = rec;
		}
		function qErr(){}
		published.getResources({Action:"ResourceCount"},{pageNo:0,pageSize:10},qSucc,qErr);
	};
	
//	//最新出租-列表查询
//	$scope.resourceRentList=function(){
//		function qSucc(rec){
//			$scope.resourceRentLists = rec;
//			
//		}
//		function qErr(){}
//		published.unifydoHM({Action:"Rent"},{pageNo:0,pageSize:10},qSucc,qErr);
//	};
	
	//页面初始化最新出租列表
	$(function(){
		function qSucc(rec){
			$scope.resourceRentList=rec.content;
			$scope.getFirstPic($scope.resourceRentList);
			$scope.titleList=[];
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>8){
					$scope.resourceRentList[i].infoTitleTemp = $scope.titleList[i].substring(0,8)+"...";
				}else{
					$scope.resourceRentList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
		}
		function qErr(rec){}
		//初始化最新出租信息
		published.unifydoHM({Action:"Rent"},{pageNo:0,pageSize:10},qSucc,qErr);
		//$scope.queryUpdHotWordCount();
	});
	
	//处理获取的list得到图片
	$scope.getFirstPic=function(list){
		if(list)/* 防止图片没刷出来的时候报length错误，当有list值的时候在执行下面的代码 */
		{
			for(var i=0;i<list.length;i++){
				if(list[i].equipmentPic!=null && list[i].equipmentPic!=""){
					var pic=list[i].equipmentPic.split(',');
					var fullname = pic[0].split('.');
					var PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};
					list[i].PicName=fullname[0];
					list[i].PicType=fullname[1];
				}else{
					list[i].PicName="18c07505-700d-4667-83df-cdf1465188ce";
					list[i].PicType="png";
				}
			}
		}
	};
	
	/*最新出售列表*/	
	$scope.saleListQury=function (){
		function qSucc(rec){
			$scope.resourceSaleList=rec.content;
			$scope.getFirstPic($scope.resourceSaleList);
			$scope.titleList=[];
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>5){
					$scope.resourceSaleList[i].infoTitleTemp = $scope.titleList[i].substring(0,5)+"...";
				}else{
					$scope.resourceSaleList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
		}
		function qErr(rec){}
		//初始化最新出售信息
		published.unifydoHM({Action:"Sale"},{pageNo:0,pageSize:10},qSucc,qErr);
		
	}
	
	/*最新求租列表*/	
	$scope.demandRentListQury=function (){
		function qSucc(rec){
			$scope.resourceDemandRentList=rec.content;
			$scope.getFirstPic($scope.resourceDemandRentList);
			$scope.titleList=[];
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>5){
					$scope.resourceDemandRentList[i].infoTitleTemp = $scope.titleList[i].substring(0,4)+"...";
				}else{
					$scope.resourceDemandRentList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
			$scope.releaseDateList=[];//截取发布日期
			for(var i=0;i<rec.content.length;i++){
				$scope.releaseDateList.push(rec.content[i].releaseDate);
			}
			for(var i=0;i<$scope.releaseDateList.length;i++){
				if($scope.releaseDateList[i].length>10){
					$scope.resourceDemandRentList[i].releaseDateTemp = $scope.releaseDateList[i].substring(0,10);
				}
			} 
		}
		function qErr(rec){}
		//初始化最新求租信息
		published.unifydoHM({Action:"DemandRent"},{pageNo:0,pageSize:10},qSucc,qErr);
		
	}
	
	/*最新求购列表*/	
	$scope.demandSaleListQury=function (){
		function qSucc(rec){
			$scope.resourceDemandSaleList=rec.content;
			$scope.getFirstPic($scope.resourceDemandSaleList);
			$scope.titleList=[];
			for(var i=0;i<rec.content.length;i++){
				$scope.titleList.push(rec.content[i].infoTitle);
			}
			for(var i=0;i<$scope.titleList.length;i++){
				if($scope.titleList[i].length>5){
					$scope.resourceDemandSaleList[i].infoTitleTemp = $scope.titleList[i].substring(0,5)+"...";
				}else{
					$scope.resourceDemandSaleList[i].infoTitleTemp = rec.content[i].infoTitle;
				}
			} 
			$scope.releaseDateList=[];//截取发布日期
			for(var i=0;i<rec.content.length;i++){
				$scope.releaseDateList.push(rec.content[i].releaseDate);
			}
			for(var i=0;i<$scope.releaseDateList.length;i++){
				if($scope.releaseDateList[i].length>10){
					$scope.resourceDemandSaleList[i].releaseDateTemp = $scope.releaseDateList[i].substring(0,10);
				}
			} 
		}
		function qErr(rec){}
		//初始化最新求购信息
		published.unifydoHM({Action:"DemandSale"},{pageNo:0,pageSize:10},qSucc,qErr);
		
	}
	
	$scope.jump = function(parm){
		if(!SYS_USER_INFO.orgId){
			//未登录
			if(parm.r.dataType==2){
				var urlStr = "#/ViewInfoSale/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr; 
			}
			if(parm.r.dataType==1){
				var urlStr = "#/ViewInfoRent/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr; 
			}
			if(parm.r.dataType==4){
				var urlStr = "#/ViewDemandSale/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr; 
			}
			if(parm.r.dataType==3){
				var urlStr = "#/ViewDemandRent/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr; 
			}
			
		}else{
			//已登录
			if(parm.r.dataType==2){
				var urlStr = "#/ViewSale/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr; 
			}
			if(parm.r.dataType==1){
				var urlStr = "#/ViewRent/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr; 
			}
			if(parm.r.dataType==4){
				var urlStr = "#/ViewDemandSaleInfo/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr; 
			}
			if(parm.r.dataType==3){
				var urlStr = "#/ViewDemandRentInfo/" + parm.r.dataId + "/" + parm.r.dataType+"/"+1;
				window.location.href = urlStr;	
			}
			 
		}
	}
	
		
	/**
	 * (yy)因需要传递一个路由所用路径参数用于区分与国才所用页面的不同
	 */
	$scope.goToSearch = function(){
		
		var parm_url = 'homePage';
		window.location.href="/WebSite/Mobile/Index.jsp#/search/"+parm_url;
	};
	
	/*
	 * 改变字体颜色
	 */
//	$scope.changeColor=function(event){
//		if(event==1){
//			var color = document.getElementById('homepage');  
//			color.style.color="red";  
//		}
//		
//	}
	
	
});