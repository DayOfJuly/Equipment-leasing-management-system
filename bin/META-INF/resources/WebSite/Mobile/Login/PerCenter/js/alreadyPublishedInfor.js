app.controller('alreadyPubInforController',function($scope,$route,published,busPublishInfo){
	
	
	
	$scope.equList={};
	$scope.equList = eval("("+$route.current.params.parm+")");
	
	/*判断传递过来的知是否存在*/
	$scope.screen={};
	if($scope.equList){
		if($scope.equList.type!=""||$scope.equList.type!=null){
			$scope.screen.dataType=$scope.equList.type;
		}
	
		if($scope.equList.state!=""||$scope.equList.state!=null){
			$scope.screen.dataState=$scope.equList.state;
		}
	
		if($scope.equList.startReleaseDate!=""||$scope.equList.startReleaseDate!=null){
			
			$scope.screen.startReleaseDate=$scope.equList.startReleaseDate.substring(0, 10);
		}
	
		if($scope.equList.endReleaseDate!=""||$scope.equList.endReleaseDate!=null){
			$scope.screen.endReleaseDate=$scope.equList.endReleaseDate.substring(0, 10);
		}
	};
	$scope.screen.pageNo=0;
	$scope.screen.pageSize=10;
	
	/*我已发布的信息列表*/
//	$scope.busPublishInfo={};
	$scope.searchPublish=function(pageNo){
		function qSucc(rec){
			if(rec.content.length==0){
				$.messager.popup("没有符合条件的记录");
			}
			$scope.publishList=rec.content;
			setTimeout(function listenWord(){
				/* 滑动监听 start */
				var sf = new scrollFactory();
				sf.loadData=function(){
					$scope.screen.pageSize=$scope.screen.pageSize+10;
					$scope.searchPublish();
				};
				sf.scrollListener(document.getElementById("profitListId"));
				/* 滑动监听 end */


				/* 滑动删除监听 start */
				var sdf = new scrollEditFactory();
				sdf.clickItem=function(){
//					alert(0);
				};
				sdf.deleteData=function(){
//					$scope.delPublish_();
//					alert(1);
				};
				sdf.editData=function(){
//					alert(2);
				};
				sdf.scrollListener();
				/* 滑动删除监听 end */
			}, 500);
			
		}
		function qErr(rec){} 
		busPublishInfo.post($scope.screen,qSucc,qErr);
	};
	
	/*
	*删除
	*/
	$scope.delPublish_=function(parm){
		alert(parm);
		
//		$.messager.confirm("提示", "是否删除？", function() { 
		function qSucc(rec){
			$.messager.popup("删除成功！");
			$scope.searchPublish();
//			window.location.href="/WebSite/Mobile/Index.jsp#/alreadyPublishedInfor/";
			//			$scope.publishList=rec.content;
//			$scope.paginationConf.currentPage=1;
//			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(){
			$.messager.popup("删除失败！");
		} 
		busPublishInfo.del({
			urlPath:parm
		},qSucc,qErr); 
//		})
	};
	
	
	/*修改*/
	$scope.update = function(obj){
		if(obj.dataType==1){
			updInfoPub = {dataId:obj.dataId,infoType:1};
			window.location.href="/WebSite/Mobile/Index.jsp#/Infopub"
		}
		if(obj.dataType==2){
			updInfopubSale = {dataId:obj.dataId,infoType:2};
			window.location.href="/WebSite/Mobile/Index.jsp#/InfopubSale"
		}
		if(obj.dataType==3){
			updDemandInfoPub = {dataId:obj.dataId,infoType:3};
			window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfoPub"
		}
		if(obj.dataType==4){
			updDemandInfoPubSale = {dataId:obj.dataId,infoType:4};
			window.location.href="/WebSite/Mobile/Index.jsp#/DemandInfoPubSale"
		}
	}
	
});

