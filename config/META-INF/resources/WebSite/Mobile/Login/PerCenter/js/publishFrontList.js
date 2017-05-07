app.controller('pubFrontListController',function($scope,$route,published,busDealInfo,busPublishInfo){
	
	$scope.equList={};
	$scope.equList = eval("("+$route.current.params.parm+")");
	
	/*判断传递过来的知是否存在*/
	$scope.screen={};
	if($scope.equList){
		if($scope.equList.type!=""||$scope.equList.type!=null){
			$scope.screen.dataType=$scope.equList.type;
		}
	
		if($scope.equList.state!=""||$scope.equList.state!=null){
			$scope.screen.equState=$scope.equList.state;
		}
	
		if($scope.equList.startReleaseDate!=""||$scope.equList.startReleaseDate!=null){
			$scope.screen.startReleaseDate=$scope.equList.startReleaseDate;
		}
	
		if($scope.equList.endReleaseDate!=""||$scope.equList.endReleaseDate!=null){
			$scope.screen.endReleaseDate=$scope.equList.endReleaseDate;
		}
	};
	$scope.screen.pageNo=0;
	$scope.screen.pageSize=10;
	
	$scope.searchPublish=function(){
		function qSucc(rec){
			$scope.KeyWordList=rec.content;
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
				var sdf = new scrollDeleteFactory();
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
			if(rec.content==""){
				$.messager.popup("没有符合条件的记录！");
			}
			
		}
		function qErr(rec){} 
		
		busDealInfo.post($scope.screen,qSucc,qErr);
	};

	/*
	*删除
	*/
	$scope.delPublish_=function(parm){
//		$.messager.confirm("提示", "是否删除？",function (){
			function qSucc(rec){
				$.messager.popup("删除成功！");
				window.location.href="/WebSite/Mobile/Index.jsp#/publishFrontList/";
			}
			function qErr(){
				$.messager.popup("删除失败！");
			} 
			busDealInfo.del({ urlPath:parm },qSucc,qErr);
//		});
	};
	
});