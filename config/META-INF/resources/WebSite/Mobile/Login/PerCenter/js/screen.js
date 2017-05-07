app.controller('perScreenController',function($scope,$route,published){
	
	$scope.redirect = eval("("+$route.current.params.parm+")");
	
	$scope.screen={};
	$scope.typeVar = 0;
	$scope.stateVar = 0;
	$scope.typeName="全部";
	
	/*
	 * 类型-控制上下箭头
	 */
	$scope.toggleType = function(parm) {
		$scope.id = parm;
		if($scope.id==0){
			$scope.typeVar=1;
		}else{
			$scope.typeVar=0;
		};
	};
	
	/*
	 * 类型名称
	 */
	$scope.changeType = function(parm) {
		$scope.id = parm;
		if($scope.id==1){
			$scope.typeName="出租";
			$scope.typeVar=0;
		}else if($scope.id==2){
			$scope.typeName="出售";
			$scope.typeVar=0;
		}else if($scope.id==3){
			$scope.typeName="求租";
			$scope.typeVar=0;
		}else if($scope.id==4){
			$scope.typeName="求购";
			$scope.typeVar=0;
		};
		$scope.screen.type=$scope.id;
	};
	
	$scope.stateName="全部";
	/*
	 * 类型-控制上下箭头
	 */
	$scope.toggleState = function(parm) {
		$scope.id = parm;
		if($scope.id==0){
			$scope.stateVar=1;
		}else{
			$scope.stateVar=0;
		};
	};
	
	/*
	 * 类型名称
	 */
	$scope.changeState = function(parm) {
		$scope.id = parm;
		if($scope.id==1){
			$scope.stateName="待审核";
			$scope.stateVar=0;
		}else if($scope.id==2){
			$scope.stateName="审核通过";
			$scope.stateVar=0;
		}else if($scope.id==3){
			$scope.stateName="审核不通过";
			$scope.stateVar=0;
		};
		$scope.screen.state=$scope.id;
	};
	
	/*清空*/
	$scope.clear=function(){
		$scope.typeVar = 0;
		$scope.stateVar = 0;
		$scope.typeName="全部";
		$scope.stateName="全部";
		$scope.screen.startReleaseDate="";
		$scope.screen.endReleaseDate="";
	};
	
	/*确认*/
	$scope.confirm=function(parm){
		$scope.screenCondition=parm;
	};
	
	/*------------------------------------------------------------------------------------*/
	$scope.limitEndDate=function(dateId)
	{/*
		 $('#startReleaseDate').datetimepicker({
				format: 'yyyy-mm-dd',
				language : 'zh-CN',
				weekStart : 1,
				todayBtn : 1,
				autoclose : 1,
				endDate:new Date(),
				todayHighlight : 1,
				startView : 2,
				minView : 2,
				forceParse : 0,
				initialDate:$scope.screen.startReleaseDate
			});
		    
		    $('#endReleaseDate').datetimepicker({
				format: 'yyyy-mm-dd',
				language : 'zh-CN',
				weekStart : 1,
				todayBtn : 1,
				autoclose : 1,
				endDate:new Date(),
				todayHighlight : 1,
				startView : 2,
				minView : 2,
				forceParse : 0,
				initialDate:$scope.screen.endReleaseDate
			});*/
		    
	};
	/**
	 * 获取当前日期的字符串表示形式
	 */
	$scope.getNowDateStr=function()
	{
		var nowDate=new Date(),
		year=nowDate.getFullYear(),
		month=nowDate.getMonth()+1,
		day=nowDate.getDate();
		
		if(month<10){
			month="0"+month;
		}
		if(day<10){
			day="0"+day;
		}
	    var strDate=year+"-"+month+"-"+day;
	    
	    $scope.screen.endReleaseDate = strDate;
	    $scope.screen.endReleaseDate = new Date($scope.screen.endReleaseDate);
	    $scope.initDate = strDate;
	};
	
	/**
	 * 获取当前日期三十天之前的时间
	 */
	$scope.getBeforeDate=function(){
		$scope.screen.startReleaseDate = getLastMonthYestdy(new Date());
		$scope.screen.startReleaseDate = new Date($scope.screen.startReleaseDate);
	    $scope.limitEndDate("startReleaseDate");
	    $scope.limitEndDate("endReleaseDate");
	};
	/**
	 * 获得上个月在昨天这一天的日期   
	 */
	function getLastMonthYestdy(date){   
		var daysInMonth = new Array([0],[31],[28],[31],[30],[31],[30],[31],[31],[30],[31],[30],[31]);   
		var strYear = date.getFullYear();     
		var strDay = date.getDate();     
		var strMonth = date.getMonth()+1;   
		//判断是否是闰年
		if(strYear%4 == 0 && strYear%100 != 0)
		{   
		        daysInMonth[2] = 29;   
		}   
		//判断当前月是否本年的一月份
	     if(strMonth - 1 == 0)   
	     {   
	        strYear -= 1;   
	        strMonth = 12;   
	     }   
	     else  
	     {   
	        strMonth -= 1;   
	     }   
	     strDay = daysInMonth[strMonth] >= strDay ? strDay : daysInMonth[strMonth];   
	     if(strMonth<10)     
	     {     
	        strMonth="0"+strMonth;     
	     }   
	     if(strDay<10)     
	     {     
	        strDay="0"+strDay;     
	     }   
	     datastr = strYear+"-"+strMonth+"-"+strDay; 
	     
	     return datastr;  
	  }  
	//当点击第一个日期控件给第二个日期控件赋开始值
	$scope.complienStart = function (){
	/*	if($scope.queryData.startReleaseDate.length == 16){
			$scope.queryData.startReleaseDate=$scope.queryData.startReleaseDate.substring(0, 10);
			$('#endDateId').datetimepicker('setStartDate', $scope.queryData.startReleaseDate);
		}*/
		$('#endReleaseDate').datetimepicker('setStartDate', $scope.screen.startReleaseDate);
		return;
		
	};
	//当点击第二个日期控件给第一个日期控件赋结束值
	$scope.complienEnd = function (){
		/*if($scope.queryData.endReleaseDate.length == 16){
			$scope.queryData.endReleaseDate=$scope.queryData.endReleaseDate.substring(0, 10);
			$('#beginDateId').datetimepicker('setEndDate', $scope.queryData.endReleaseDate);
		}*/
		$('#startReleaseDate').datetimepicker('setEndDate', $scope.screen.endReleaseDate);
		return;

	};
});