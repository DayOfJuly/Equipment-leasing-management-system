app.controller('auditQueryListController', function($scope,published,busAuditSvc,SYS_CODE_CON,sysCodeTranslateFactory,PicUrl) {
	
    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    
    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
    
    //ie9下titile正确显示使用
	document.title="审核查询"
   
	var orgId=$("#USER_INFO_ORG_ID").val();
	var code=$("#USER_INFO_PARENT_CODE").val();
	var Name=$("#USER_INFO_ORG_NAME").val();
	$scope.userInfo={};
	$scope.userInfo.orgId=orgId;
	$scope.userInfo.code=code;
	$scope.userInfo.Name=Name;

	$scope.showTable = false;//控制开始不显示列表，根据所选择的去显示列表
	$scope.queryData = null;
	
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
			$scope.testFun();
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){}
		published.unifydo({
			Action:"All",
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.itemsPerPage},
			qSucc,qErr);
	};
	/*
	查询求租求购的信息(表格展示的信息查询）
	*/
	$scope.queryData={};
	//$scope.queryData.infoType=3;
	$scope.queryDemandExamineData=function(pageNo)
	{
		$scope.radioTrIndex = null;
		$scope.radioCheckValue = null;
		
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function success(rec)
		{
			
			if(rec.content==""||rec.content==null){
				$.messager.popup("无相应记录");
				$scope.auditButton=false;//审核按钮隐藏
			}else{
				$scope.showTable = true;
				$scope.auditButton=true;//审核按钮显示
			}
			$scope.demandExamineList=rec.content;
			$scope.testFun();
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function error(rec){}
		$scope.queryData.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryData.pageSize=$scope.paginationConf.itemsPerPage;
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
					objList[i][obj+'Temp']=objList[i][obj].substr(0,18)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
					
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
					objList[i][obj+'Temp']=objList[i][obj].substr(0,8)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
					
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
	
	$scope.selectRow=function(obj){
		$scope.formParms=obj;
	};
	
	/*开启幻灯片效果*/
	$scope.createLightBox3=function(){
		$('#Pic3 a').lightBox();
	}
	
	$scope.createLightBox4=function(){
		$('#Pic4 a').lightBox();
	}
	
	
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
	
	$scope.openDetailModal=function(){

		if(!$scope.radioCheckValue){
			$.messager.popup("请您选择一条信息");
			return;
		}
		$scope.titleMsg="详细信息";
		
		
	    if($scope.num_=='1'){
 			function qSucc3(rec){
 				$scope.formParms=rec.auditInfo;
 				$scope.queryAudit = rec.refuseReasons;
 				$("#auditQueryRentId").modal({backdrop:'static',keyboard:false});
 				$scope.getFirstPic($scope.formParms);
 				$scope.combinationPicName(rec.auditInfo.equipmentPic);/*将名称分解为 名字和尾缀分开的对象*/
 				document.getElementById("detailedDescriptionHtml1").innerHTML=$scope.formParms.detailedDescription;/*详细说明 显示html代码*/
 		        if($scope.formParms.detailedDescription==null){
 		        	$scope.formParms.detailedDescription="";
 		        }
 			}
 			function qErr3(rec){}
 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc3,qErr3);
 			
				
 		}
	    
	    if($scope.num_=='2'){
 			function qSucc4(rec){
 				$scope.formParms=rec.auditInfo;
 				$scope.queryAudit = rec.refuseReasons;
 				$("#auditQuerySaleId").modal({backdrop:'static',keyboard:false});
 				$scope.getFirstPic($scope.formParms);
 				$scope.combinationPicName(rec.auditInfo.equipmentPic);/*将名称分解为 名字和尾缀分开的对象*/
 				document.getElementById("detailedDescriptionHtml2").innerHTML=$scope.formParms.detailedDescription;/*详细说明 显示html代码*/
 				 if($scope.formParms.detailedDescription==null){
  		        	$scope.formParms.detailedDescription="";
  		        }
 			}
 			function qErr4(rec){}
 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc4,qErr4);
 			
 					
 	 	}
	    
		if($scope.num_=='3'){
			function qSucc(rec){
				$scope.formParms=rec.auditInfo;
				$scope.queryAudit = rec.refuseReasons;
				if(!rec.auditInfo.useProvince){
 					$scope.formParms.atCity = '全国';
 				}
				$("#auditQueryDemRenBtnId").modal({backdrop:'static',keyboard:false});
				$scope.getFirstPic($scope.formParms);
				document.getElementById("detailedDescriptionHtml3").innerHTML=$scope.formParms.detailedDescription;/*详细说明 显示html代码*/
				 if($scope.formParms.detailedDescription==null){
	 		        	$scope.formParms.detailedDescription="";
	 		        }
			}
			function qErr(rec){}
			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc,qErr);
			
			
 		}
		
		if($scope.num_=='4'){
 			function qSucc2(rec){
 				$scope.formParms=rec.auditInfo;
 				$scope.queryAudit = rec.refuseReasons;
 				if(!rec.auditInfo.useProvince){
 					$scope.formParms.atCity = '全国';
 				}
 				$('#auditQueryDemSalBtnId').modal({backdrop:'static',keyboard:false});
 				$scope.getFirstPic($scope.formParms);
 				document.getElementById("detailedDescriptionHtml4").innerHTML=$scope.formParms.detailedDescription;/*详细说明 显示html代码*/
 				 if($scope.formParms.detailedDescription==null){
  		        	$scope.formParms.detailedDescription="";
  		        }
 			}
 			function qErr2(rec){}
 			busAuditSvc.unifydo({urlPath:$scope.radioCheckValue.dataId},qSucc2,qErr2);
 			
			
 		}
	
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
		$('#endDateId').datetimepicker('setStartDate', $scope.queryData.startReleaseDate);
		return;
		
	};
	//当点击第二个日期控件给第一个日期控件赋结束值
	$scope.complienEnd = function (){
		/*if($scope.queryData.endReleaseDate.length == 16){
			$scope.queryData.endReleaseDate=$scope.queryData.endReleaseDate.substring(0, 10);
			$('#beginDateId').datetimepicker('setEndDate', $scope.queryData.endReleaseDate);
		}*/
		$('#beginDateId').datetimepicker('setEndDate', $scope.queryData.endReleaseDate);
		return;

	};
	
	
	$scope.radioList={};
	//选中订单ID
	$scope.check = function(obj,index_){
		$scope.radioTrIndex = index_;
		$scope.radioCheckValue = obj;
		if(obj.dataType == 1){
			$scope.num_ = 1;	
		}
		if(obj.dataType == 2){
			$scope.num_ = 2;	
		}
		if(obj.dataType == 3){
			$scope.num_ = 3;	
		}
		if(obj.dataType == 4){
			$scope.num_ = 4;	
		}
		//$scope.queryData.dataType=obj.dataType;
	};

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
	 // 失去焦点 
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
         	$scope.queryData.endReleaseDate = $scope.initDate;
         }
			   
	}; 
	
	/*
	* 清空结束日期
	*/
	$scope.removeEndDate = function(){
		$scope.queryData.endReleaseDate=null;
	};
	
	/*
	 * 组合图片名称，将名称分解为 名字和尾缀分开的对象
	 */
	$scope.combinationPicName=function(picName){
		var arrayAll=[];
		$scope.formParms.equipmentPicList=[];
		if(picName.indexOf(",")>=0){
			arrayAll=picName.split(",");
		}
		for(var i=0;i<arrayAll.length;i++){
			var arrs = arrayAll[i].split(".");
			$scope.formParms.equipmentPicList.push({pic:arrs[0],suffix:arrs[1]});
		}
	};
	
});