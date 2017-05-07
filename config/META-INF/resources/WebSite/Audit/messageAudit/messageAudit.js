app.controller('messageAuditListController', function($scope,published,SYS_CODE_CON,sysCodeTranslateFactory,busAuditSvc,PicUrl ) {
	
    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    
    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
    
    //ie9下titile正确显示使用
	document.title="信息审核"
   
	var orgId=$("#USER_INFO_ORG_ID").val();
	var code=$("#USER_INFO_PARENT_CODE").val();
	var Name=$("#USER_INFO_ORG_NAME").val();
	$scope.userInfo={};
	$scope.userInfo.orgId=orgId;
	$scope.userInfo.code=code;
	$scope.userInfo.Name=Name;
	
	/*
	 *分页标签参数配置
	*/
	$scope.paginationConf = {
	
        currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 20,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [20, 30, 40, 50],
        
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        onChange:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	$scope.queryDemandExamineData();
        	$scope.radioTrIndex=null;
        }
    };
	
	
	
	/*
	 * 查询已发布的求租/求购信息
	*/
	$scope.queryDemandExamineData_copy=function(pageNo){
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function qSucc(rec){
			$scope.demandExamineList=rec.content;
			
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){}
		published.unifydo({
			Action:"DemandRentSale",
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage},
			qSucc,qErr);
	};
	/*
	查询求租求购的信息
	*/
	$scope.queryData={};
	//$scope.queryData.infoType=3;
	$scope.queryDemandExamineData=function(pageNo)
	{
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function success(rec)
		{
			if(rec.content==""||rec.content==null){
				$.messager.popup("无相应记录");
				$scope.auditButton=false;//审核按钮隐藏
			}else{
				$scope.auditButton=true;//审核按钮显示
			}
			$scope.demandExamineList=rec.content;
			$scope.testFun();
			$scope.demandExamineListCopy = $scope.demandExamineList;
			
			for(var i=0;i<$scope.demandExamineListCopy.length;i++){
				$scope.demandExamineListCopy[i].check_ = false;
			}
			$scope.paginationConf.totalItems=rec.totalElements;
			$scope.checkObj.isAllCheck = false;
		}
		function error(rec){}
		$scope.queryData.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryData.pageSize=$scope.paginationConf.itemsPerPage;
		$scope.queryData.dataState = 1;
		busAuditSvc.unifydoAll($scope.queryData,success,error);

	};
	 $scope.testFun = function(){
		 $scope.changeListValue($scope.demandExamineList,'infoTitle');
			$scope.changeListValueB($scope.demandExamineList,'enterpriseName');
			$scope.changeListValueA($scope.demandExamineList,'contactPerson');
			$scope.changeListValueC($scope.demandExamineList,'equName');
		};
		$scope.changeListValue = function(objList,obj){
			for(var i=0;i<objList.length;i++)
			{
				if(objList[i][obj]&&objList[i][obj].length>10)
				{
					objList[i][obj+'Temp']=objList[i][obj].substr(0,20)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
					
				}
				else
				{
					
					objList[i][obj+'Temp']=objList[i][obj];
					
				}
				
			}

		};	
		$scope.changeListValueA = function(objList,obj){
			for(var i=0;i<objList.length;i++)
			{
				if(objList[i][obj]&&objList[i][obj].length>5)
				{
					objList[i][obj+'Temp']=objList[i][obj].substr(0,10)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
					
				}
				else
				{
					
					objList[i][obj+'Temp']=objList[i][obj];
					
				}
				
			}

		};	
		$scope.changeListValueB = function(objList,obj){
			for(var i=0;i<objList.length;i++)
			{
				if(objList[i][obj]&&objList[i][obj].length>10)
				{
					objList[i][obj+'Temp']=objList[i][obj].substr(0,10)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
					
				}
				else
				{
					
					objList[i][obj+'Temp']=objList[i][obj];
					
				}
				
			}

		};	
		$scope.changeListValueC = function(objList,obj){
			for(var i=0;i<objList.length;i++)
			{
				if(objList[i][obj]&&objList[i][obj].length>6)
				{
					objList[i][obj+'Temp']=objList[i][obj].substr(0,6)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
					
				}
				else
				{
					
					objList[i][obj+'Temp']=objList[i][obj];
					
				}
				
			}

		};	
	

	//展示图片
	$scope.getFirstPic=function(list){
		
		 if(list.equipmentPic)
        {
        	
            $scope.pic = list.equipmentPic.split(',');//分割逗号，因本没逗号所以把整个值放入数组pic
            
            
            $scope.PicList = [];
            for ( var i = 0; i < $scope.pic.length; i++) {
                var fullname = $scope.pic[i].split('.');//截去点号，为前半段图片名和后半段类型名
                $scope.PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};//把两个值分别和一个key匹配放入一个对象内
                $scope.PicList.push($scope.PicOne);
                $scope.PicUrl = PicUrl;
            };
            $scope.PicSrc=$scope.PicUrl+"/"+$scope.PicList[0].PicName+"/"+$scope.PicList[0].PicType; //拼出一个链接
        }
	};
	/*开启幻灯片效果*/
	$scope.createLightBox=function(){
		$('#Pic a').lightBox();
	}
	
	$scope.createLightBox2=function(){
		$('#Pic2 a').lightBox();
	}
	
	/**
	 * 打开单体审核模态框
	 */
	$scope.openDetailModal=function(obj,pram){
		
		console.info(obj,pram);
		
		
		$scope.checkSelect = true;
		$scope.getCheckedFun();
		
		if(obj.length == 0){
			$.messager.popup("请您选择一条信息");
			return;
		}
		
		if(obj.length>1){
			$.messager.popup("请选择一条信息进行审核操作");
			return;
		}
		for(var i=0;i<pram.length;i++){
			if(obj==pram[i].dataId){
				$scope.dataType = pram[i].dataType;
			}
		}
		
		
/*		if($scope.queryData.dataIds.length==0){
			$.messager.popup("请您选择一条信息");
			return;
		}
		
		if($scope.queryData.dataIds.length>1){
			$.messager.popup("请选择一条信息进行审核操作");
			return;
		}*/
		
		$scope.titleMsg1="详细信息";
		
		
	    if($scope.dataType=='1'){
 			function qSucc3(rec){
 				$scope.formParms=rec.auditInfo;
 				$scope.getFirstPic($scope.formParms);
 				$("#rePayM").get(0).innerHTML = $scope.formParms.detailedDescription;
 				$("#rentDetailModalId").modal({backdrop:'static',keyboard:false});
 				return;
 			}
 			function qErr3(rec){}
// 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc3,qErr3);
 			busAuditSvc.unifydo({urlPath:obj[0]},qSucc3,qErr3);
 			
				
 		}
	    if($scope.dataType=='2'){
 			function qSucc4(rec){
 				$scope.formParms=rec.auditInfo;
 				$scope.getFirstPic($scope.formParms);
 				$("#rePay").get(0).innerHTML = $scope.formParms.detailedDescription;
 				$("#saleDetailModalId").modal({backdrop:'static',keyboard:false});
 				return;
 			}
 			function qErr4(rec){}
// 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc4,qErr4);
 			busAuditSvc.unifydo({urlPath:obj[0]},qSucc4,qErr4);

 			
 					
 	 	}
		if($scope.dataType=='3'){
			function qSucc(rec){
				$scope.formParms=rec.auditInfo;
				if($scope.formParms.dataType){
 					if($scope.formParms.dataType == 1){
 						$scope.formParms.dataTypeName = '出租';
 					}else if($scope.formParms.dataType == 2){
 						$scope.formParms.dataTypeName = '出售';
 					}else if($scope.formParms.dataType == 3){
 						$scope.formParms.dataTypeName = '求租';
 					}else if($scope.formParms.dataType == 4){
 						$scope.formParms.dataTypeName = '求购';
 					}
 				}
				$scope.getFirstPic($scope.formParms);
				$("#rePayMsg").get(0).innerHTML = $scope.formParms.detailedDescription;
				$("#demandRentDetailModalId").modal({backdrop:'static',keyboard:false});
				return;
			}
			function qErr(rec){}
//			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc,qErr);
			busAuditSvc.unifydo({urlPath:obj[0]},qSucc,qErr);
			
			
 		}
		if($scope.dataType=='4'){
 			function qSucc2(rec){
 				$scope.formParms=rec.auditInfo;
 				if($scope.formParms.dataType){
 					if($scope.formParms.dataType == 1){
 						$scope.formParms.dataTypeName = '出租';
 					}else if($scope.formParms.dataType == 2){
 						$scope.formParms.dataTypeName = '出售';
 					}else if($scope.formParms.dataType == 3){
 						$scope.formParms.dataTypeName = '求租';
 					}else if($scope.formParms.dataType == 4){
 						$scope.formParms.dataTypeName = '求购';
 					}
 				}
 				$scope.getFirstPic($scope.formParms);
 				$("#rePayMs").get(0).innerHTML = $scope.formParms.detailedDescription;
 				$('#demandSaleDetailModalId').modal({backdrop:'static',keyboard:false});
 				return;
 			}
 			function qErr2(rec){}
// 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc2,qErr2);
 			busAuditSvc.unifydo({urlPath:obj[0]},qSucc2,qErr2);
 			
			
 		}
	
	};
	
	$scope.openDetailModal1=function(obj){
		$scope.radioCheckValue.dataId = obj.dataId;
		$scope.checkSelect = true;
		$scope.getCheckedFun();	
		$scope.titleMsg1="详细信息";		
	    if($scope.queryData.dataTypeFlag=='1'){
 			function qSucc3(rec){
 				$scope.formParms=rec.auditInfo;
 				$("#rePayM").get(0).innerHTML = $scope.formParms.detailedDescription;
 				$("#rentDetailModalId").modal({backdrop:'static',keyboard:false});
 				return;
 			}
 			function qErr3(rec){}
 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc3,qErr3);
 			
				
 		}
	    if($scope.dataType=='2'){
 			function qSucc4(rec){
 				$scope.formParms=rec.auditInfo;
 				$("#rePay").get(0).innerHTML = $scope.formParms.detailedDescription;
 				$("#saleDetailModalId").modal({backdrop:'static',keyboard:false});
 				return;
 			}
 			function qErr4(rec){}
 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc4,qErr4);
 			
 					
 	 	}
		if($scope.dataType=='3'){
			function qSucc(rec){
				$scope.formParms=rec.auditInfo;
				$("#rePayMsg").get(0).innerHTML = $scope.formParms.detailedDescription;
				$("#demandRentDetailModalId").modal({backdrop:'static',keyboard:false});
				return;
			}
			function qErr(rec){}
			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc,qErr);
			
			
 		}
		if($scope.dataType=='4'){
 			function qSucc2(rec){
 				$scope.formParms=rec.auditInfo;
 				$("#rePayMs").get(0).innerHTML = $scope.formParms.detailedDescription;
 				$('#demandSaleDetailModalId').modal({backdrop:'static',keyboard:false});
 				return;
 			}
 			function qErr2(rec){}
 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc2,qErr2);
 			
			
 		}
	
	};
	$scope.selectRow=function(obj){
		$scope.formParms=obj;
	};
	
	$scope.modalBackdropId=false;
	
	$scope.openOpinionModal=function(){
		$scope.titleMsg="请选择或手动填写不通过原因(可多选)";
		$scope.modalBackdropId=true;
		$('#OpinionModalId_').modal({backdrop:'static',keyboard:false});
		setTimeout(function() {
		    $scope.$apply(function() {
		    	var inputs = document.getElementsByTagName("input");
		    	var pf=new window.placeholderFactory(); 
		    	pf.createPlaceholder(inputs);
		    });  
		}, 100);
	};
	
	$scope.resolvePicture=function(){
		$scope.formParms.equipmentPicList=[];
		if($scope.formParms.equipmentPic!=null){
			var picList=$scope.formParms.equipmentPic.split(",");
			for(var i=0,m=picList.length;i<m;i++){
				var picName=picList[i].split(".");
				$scope.formParms.equipmentPicList.push({"pic":picName[0],"suffix":picName[1]});
			}
		}
	};
	
	
	$scope.tmpCheck=[];
	$scope.changeNote = true;
	$scope.changeCheck=function(parm){
		if(parm == false){
			$scope.changeNote = true;
			
		}
		else{
			$scope.changeNote = '';
			$scope.checkSelect = false;
		}
	};
	//单体审核
	$scope.submit=function(id){
		$scope.queryData.dataIds = [$scope.radioCheckValue.dataId];
		if($scope.queryData.dataIds.length>1){
			$.messager.popup("只能审核一条数据");
			$('#'+id).modal('hide');
			return;
		}
		function aSucc(rec){
			$scope.checkValueList = [];
			$('#'+id).modal('hide');
			$.messager.popup(rec.msg);
			$scope.queryData.dataType = '';
			$scope.dataType = '';
			$scope.queryDemandExamineData();
		}
		function aErr(){}
		busAuditSvc.post({Action:"Audits"},{dataIds:$scope.queryData.dataIds},aSucc,aErr);
	};
	
	//批量审核
	$scope.batchAudit=function(){
		
		$scope.getCheckedFun();
		
		if($scope.queryData.dataIds.length==0){
			$.messager.popup("请选择多条记录");
			return;
		}
		if($scope.queryData.dataIds.length==1){
			$.messager.popup("单条数据不可进行批量审核,请选择多条记录。");
			return;
		}
		$.messager.confirm("提示", "是否确认批量审核当前所有数据？", function() {
		function aSucc(rec){
			$scope.checkValueList = [];
			$.messager.popup(rec.msg);
			$scope.queryData.dataType = '';
			$scope.dataType = '';
			$scope.queryDemandExamineData();
			window.location.reload();
		}
		function aErr(){}
		busAuditSvc.post({Action:"Audits"},{dataIds:$scope.queryData.dataIds},aSucc,aErr);
		})
	};
	
	
	$scope.checkValueFun = function(){
		$scope.reasonIds = [];
		$scope.reasonNotes = [];
		
		if($scope.formParms.typeNo1 == true){
			$scope.reasonIds.push(1);
			$scope.reasonNotes.push('信息标题不合格');
		}
		if($scope.formParms.typeNo2 == true){
			$scope.reasonIds.push(2);
			$scope.reasonNotes.push('详细说明不合格');
		}
		if($scope.formParms.typeNo3 == true){
			$scope.reasonIds.push(3);
			$scope.reasonNotes.push('设备图片不合格');
		}
		if($scope.formParms.typeNo4 == true){
			$scope.reasonIds.push(4);
			$scope.reasonNotes.push('联系方式不合格');
		}
		if($scope.formParms.typeNo5 == true){
			$scope.reasonIds.push(5);
			$scope.reasonNotes.push($scope.formParms.checkNote);
		}
		
	};
	
	
	
	
	//审核不通过
	$scope.Refuse=function(){
		if(!$("input[type='checkbox']").is(':checked')){
			$.messager.popup("请选择拒绝原因！");
			return;
		}else if($scope.formParms.typeNo5){
			if($scope.formParms.checkNote == "" || $scope.formParms.checkNote == null){
				$.messager.popup("请填写退回原因");
				return;
			}	
		}
		
		$scope.checkValueFun();
		
		$scope.queryData.dataIds = [$scope.radioCheckValue.dataId];
		
		if($scope.dataType == 1){
			function aSucc1(rec){
				$scope.checkValueList = [];
				$('#rentDetailModalId').modal('hide');
				$('#OpinionModalId_').modal('hide');
				$.messager.popup(rec.msg);
				$scope.queryData.dataType = '';
				$scope.dataType = '';
				$scope.queryDemandExamineData();
			}
			function aErr1(rec){}
			busAuditSvc.post({Action:"AuditRefuse"},{dataIds:$scope.queryData.dataIds,reasonIds:$scope.reasonIds,reasonNotes:$scope.reasonNotes},aSucc1,aErr1);
		}
		if($scope.dataType == 2){
			function aSucc2(rec){
				$scope.checkValueList = [];
				$('#saleDetailModalId').modal('hide');
				$('#OpinionModalId_').modal('hide');
				$.messager.popup(rec.msg);
				$scope.queryData.dataType = '';
				$scope.dataType = '';
				$scope.queryDemandExamineData();
			}
			function aErr2(rec){}
			busAuditSvc.post({Action:"AuditRefuse"},{dataIds:$scope.queryData.dataIds,reasonIds:$scope.reasonIds,reasonNotes:$scope.reasonNotes},aSucc2,aErr2);
		}
		if($scope.dataType == 3){
			function aSucc3(rec){
				$scope.checkValueList = [];
				$('#demandRentDetailModalId').modal('hide');
				$('#OpinionModalId_').modal('hide');
				$.messager.popup(rec.msg);
				$scope.queryData.dataType = '';
				$scope.dataType = '';
				$scope.queryDemandExamineData();
			}
			function aErr3(rec){}
			busAuditSvc.post({Action:"AuditRefuse"},{dataIds:$scope.queryData.dataIds,reasonIds:$scope.reasonIds,reasonNotes:$scope.reasonNotes},aSucc3,aErr3);
		}
		if($scope.dataType == 4){
			function aSucc4(rec){
				$('#demandSaleDetailModalId').modal('hide');
				$('#OpinionModalId_').modal('hide');
				$scope.checkValueList = [];
				$.messager.popup(rec.msg);
				$scope.queryData.dataType = '';
				$scope.dataType = '';
				$scope.queryDemandExamineData();
			}
			function aErr4(rec){}
			busAuditSvc.post({Action:"AuditRefuse"},{dataIds:$scope.queryData.dataIds,reasonIds:$scope.reasonIds,reasonNotes:$scope.reasonNotes},aSucc4,aErr4);
		}
	};
	
	/**
	 * 删除
	 */
	$scope.delectAudit = function(id){
		$.messager.confirm("提示", "是否确认删除当前数据？", function() {
		function qSucc(rec){
			$scope.checkValueList = [];
			$('#'+id).modal('hide');
			$.messager.popup(rec.msg);
			$scope.queryData.dataType = '';
			$scope.queryDemandExamineData();
		}
		
		function qErr(){};
		
		busAuditSvc.del({urlPath:$scope.checkValueList[0]},qSucc,qErr);
		})
	};
	
	
	
	//日期控件
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
	    
	    $scope.queryData.endReleaseDate = strDate;
	    $scope.initDate = strDate;
	};
	
	
	
	/**
	 * 获取当前日期三十天之前的时间
	 */
	$scope.getBeforeDate=function(){
		$scope.queryData.startReleaseDate = getLastMonthYestdy(new Date());
	    $scope.limitEndDate("beginDateId");
	    $scope.limitEndDate("endDateId");
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
/*var i = '';
i = new Date();
var year_=i.getFullYear();
var month_=i.getMonth()-1;
var day_ =i.getDay();*/

	//$('#beginDateId').datetimepicker('setEndDate', datastr);
	/**
	 * 限制日期空间的可选日期不能大于今天
	 */
	$scope.limitEndDate=function(dateId)
	{
	    $('#beginDateId').datetimepicker({
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
			initialDate:$scope.queryData.startReleaseDate
		});
	    
	    $('#endDateId').datetimepicker({
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
			initialDate:$scope.queryData.endReleaseDate
			
		});
	    
	};



	//当点击第一个日期控件给第二个日期控件赋开始值
	$scope.complienStart = function (){
	/*	if($scope.queryData.startReleaseDate.length == 16){
			$scope.queryData.startReleaseDate=$scope.queryData.startReleaseDate.substring(0, 10);
			$('#endDateId').datetimepicker('setStartDate', $scope.queryData.startReleaseDate);
		}*/
		$('#endDateId').datetimepicker('setEndDate', $scope.queryData.endReleaseDate);
		return;
		
	};
	//当点击第二个日期控件给第一个日期控件赋结束值
	$scope.complienEnd = function (){
		/*if($scope.queryData.endReleaseDate.length == 16){
			$scope.queryData.endReleaseDate=$scope.queryData.endReleaseDate.substring(0, 10);
			$('#beginDateId').datetimepicker('setEndDate', $scope.queryData.endReleaseDate);
		}*/
		$('#beginDateId').datetimepicker('setStartDate', $scope.queryData.startReleaseDate);
		return;

	};
	
	
	
	//---------------------------------------------------------------------------------------复选框
	$scope.radioList={};
	$scope.checkValueList = [];
	//选中订单ID
	$scope.check = function(obj){
		$scope.radioTrIndex = obj.$index;
		$scope.radioCheckValue = obj.t;
		$scope.queryData.dataTypeFlag=$scope.radioCheckValue.dataType;
		
		//遍历展示的集合，如果发现展示的信息中的位置和点选的位置一样就改变该值的check_属性，也就是被选中或者被取消。
	    for(var i=0;i<$scope.demandExamineListCopy.length;i++)
	    {
	    	if(i == obj.$index){
	    		$scope.demandExamineListCopy[i].check_ = !$scope.demandExamineListCopy[i].check_;
	    		if($scope.checkValueList && $scope.checkValueList.length > 0){
	    			for(var j=0;j<$scope.checkValueList.length;j++){
	    				
		    			if($scope.radioCheckValue.dataId && $scope.demandExamineListCopy[i].check_ == true){
		    				$scope.checkValueList.push($scope.demandExamineListCopy[i].dataId);
		    				
		    			    //根据选中的数据的长度和遍历数组的长度的对比来判断是否通过点击单选的方式，促成了全选
		    			    if($scope.demandExamineListCopy.length==$scope.checkValueList.length)
		    			    {
		    			    	$scope.checkObj.isAllCheck = true;
		    			    }
		    			    else
		    			    {
		    			    	$scope.checkObj.isAllCheck = false;
		    			    }
		    				return;
		    			}
		    			
		    			if($scope.radioCheckValue.dataId && $scope.demandExamineListCopy[i].check_ == false && $scope.checkValueList[j]==$scope.demandExamineListCopy[i].dataId){
			    			$scope.checkValueList.splice(j,1);
			    			$scope.checkObj.isAllCheck = false;
			    			return;
			    			
			    		}
		    			
		    		}
	    		}else{
	    			if($scope.checkValueList && $scope.checkValueList.length == 0){
	    				$scope.checkValueList.push($scope.demandExamineListCopy[i].dataId);
	    			    //根据选中的数据的长度和遍历数组的长度的对比来判断是否通过点击单选的方式，促成了全选
	    			    if($scope.demandExamineListCopy.length==$scope.checkValueList.length)
	    			    {
	    			    	$scope.checkObj.isAllCheck = true;
	    			    }
	    			    else
	    			    {
	    			    	$scope.checkObj.isAllCheck = false;
	    			    }
	    			}
	    		}
	        }
	    }
	};
	
	/**
	 * 全选或者全不选
	 */
	//allCheck这个变量也进行了双向数据绑定，她的值会根据选中全选与否来变化的
	$scope.checkObj = {};
	$scope.checkObj.isAllCheck =false;
	$scope.changAllCheck = function(){
		if($scope.checkObj.isAllCheck && $scope.checkObj.isAllCheck==true)
		{
			 for(var i=0;i<$scope.demandExamineListCopy.length;i++)
		     {
				$scope.demandExamineListCopy[i].check_ = true;
				$scope.checkValueList.push($scope.demandExamineListCopy[i].dataId);
		     }
		}
		else
		{
			 for(var i=0;i<$scope.demandExamineListCopy.length;i++)
		     {
				$scope.demandExamineListCopy[i].check_ = false;
		     }
			 $scope.checkValueList = [];
		}
	};
	
	
	/**
	 * 遍历展示的数组如果有勾选的信息就放入准备好的数组内之后用于接口传参用
	 */
	$scope.getCheckedFun = function()
	{
		$scope.queryData.dataIds = [];
		
		for(var i=0;i<$scope.demandExamineListCopy.length;i++)
		{
			if($scope.demandExamineListCopy[i].check_ == true)
			{
				$scope.queryData.dataIds.push($scope.demandExamineListCopy[i].dataId);
			}
		}
	};
	
	
	
	
	//---------------------------------------------------------------------------------------复选框
	

	/*
	* 清空开始日期
	*/
	$scope.removeBeginDate = function(){
		$scope.queryData.startReleaseDate=null;
	};
	
	$scope.Dateout = function(){
		if($scope.queryData.beginDate == null){
		}
		
	};
	
	////
	$scope.cleanFlagFunStart = function(parm)
	{
            if(parm==""){           	
            	$scope.queryData.startReleaseDate = datastr;
            }
	};
	
	// 失去焦点
	$scope.cleanFlagFunEnd = function(parm) // 同上 
	{
		 if(parm==""){           	
         	$scope.queryData.endReleaseDate = strDate;
         }
			   
	}; 
	
	/*
	* 清空结束日期
	*/
	$scope.removeEndDate = function(){
		$scope.queryData.endReleaseDate=null;
	};
	
	
	$("button").focus(function(){this.blur()});
	
	$scope.a = function(){
	};
	
	//X号
	
	$scope.deleteText=function(){
		$scope.formParms.checkNote = "";	
	}
	
	$scope.inputFocus=function(){
		$scope.checkNote = true;
	}
	
	$scope.FormBlur=function(){
		var event = event ? event : window.event;
		var tag = event.srcElement ? event.srcElement : event.target;
		if(tag && tag.tagName.toLowerCase()=="div"){
			$scope.checkNote=false;
		}
	};
	
	setTimeout(function() {
	    $scope.$apply(function() {
	    	var inputs = document.getElementsByTagName("input");
	    	var pf=new window.placeholderFactory(); 
	    	pf.createPlaceholder(inputs);
	    	//document.getElementById("eeeee").value="asd";
	    });  
	}, 500);
	
	$scope.closeModal = function(){
		$scope.modalBackdropId = false;
		$('#OpinionModalId_').modal('hide');
	};
});