app.controller('outUserRentCheckInListController', function($scope,$timeout,SYS_CODE_CON,sysCodeTranslateFactory,RentHistUserSvc,entSvc) {
		
	    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
	    
	    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	    
	    $scope.userInfo = {};
	    $scope.userInfo.orgCode=SYS_USER_INFO.orgCode;
	    $scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
	    $scope.userInfo.orgLevel_show=SYS_USER_INFO.orgLevel;
	   
	    /*修改z-index 的层级*/
	    $scope.changeZIndex=function(num,len){
	    	for(var i=0;i<len;i++){
	    		if(i==num){
	    			$("#state"+num).css("z-index","999");
	    		}else{
	    			$("#state"+i).css("z-index","99");
	    		}
	    	}
	    };
	    
	    
	    
		$scope.employeeEntity = {};
		$scope.employeeEntity.isInclude = false;
		
		
		$scope.showLevel = null;
		$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
		$scope.employeeEntity.orgName_ = SYS_USER_INFO.orgName;//因为没有排除orgName在哪里使用，所以创建了orgName_用于点击时传当前单位属性
		if($scope.employeeEntity.orgName.length>20){
			$scope.employeeEntity.orgNameA = $scope.employeeEntity.orgName.substring(0,20)+"...";
		}else{
			$scope.employeeEntity.orgNameA = $scope.employeeEntity.orgName
		}
		$scope.employeeEntity.orgId_ = SYS_USER_INFO.orgId;
		$scope.employeeEntity.orgCode = SYS_USER_INFO.orgCode;
		if($scope.employeeEntity.orgName && SYS_USER_INFO.orgLevel < 3){//控制包含下级的显示，当有当前单位和组织级别小于3的时候展示包含下级单位
			$scope.showLevel = true;
		}else if(!$scope.employeeEntity.orgName || SYS_USER_INFO.orgLevel > 2){
			$scope.showLevel = false;
		}
		
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
	        	//$scope.paginationConf.currentPage=parm1;
	        	$scope.queryAllMess();
	        }
	    };
				
		
		$scope.queryData={};
		$scope.copyFormParmsList = [];
		/**
		 * 查询
		 */
		$scope.formParmsList = [];
		$scope.queryAllMess = function(pageNo){
			if(pageNo){
				$scope.paginationConf.currentPage = 1;
			}
			$scope.num = 0;
			function qSucc(rec){
				if(rec.content==""){
					$scope.reveal = false;
					$.messager.popup("没有符合条件的记录");
	    		}else{
	    			$scope.reveal = true;
	    		}
				
				if($scope.employeeEntity.isInclude == 1){
					$scope.employeeEntity.isInclude = true;
				}
				
				if($scope.employeeEntity.isInclude == 0){
					$scope.employeeEntity.isInclude = false;
				}
				$scope.paginationConf.totalItems = rec.totalElements;
				$scope.formParmsList = rec.content;
				for(var i=0;i<$scope.formParmsList.length;i++){
					if($scope.formParmsList[i].models!==null){
						if($scope.formParmsList[i].models.length>3){
							$scope.formParmsList[i].modelsA = $scope.formParmsList[i].models.substring(0,3)+"...";
						}else{
							$scope.formParmsList[i].modelsA = $scope.formParmsList[i].models;
						}
					}
					if($scope.formParmsList[i].licenseNo!==null){
						if($scope.formParmsList[i].licenseNo.length>5){
							$scope.formParmsList[i].licenseNoA = $scope.formParmsList[i].licenseNo.substring(0,5)+"...";
						}else{
							$scope.formParmsList[i].licenseNoA = $scope.formParmsList[i].licenseNo;
						}
					}
					
					if($scope.formParmsList[i].equNo!==null){
						if($scope.formParmsList[i].equNo.length>7){
							$scope.formParmsList[i].equNoA = $scope.formParmsList[i].equNo.substring(0,7)+"...";
						}else{
							$scope.formParmsList[i].equNoA = $scope.formParmsList[i].equNo;
						}
					}
					if($scope.formParmsList[i].equName!==null){
						if($scope.formParmsList[i].equName.length>5){
							$scope.formParmsList[i].equNameA = $scope.formParmsList[i].equName.substring(0,5)+"...";
						}else{
							$scope.formParmsList[i].equNameA = $scope.formParmsList[i].equName;
						}
					}
					if($scope.formParmsList[i].brandName!==null){
						if($scope.formParmsList[i].brandName.length>3){
							$scope.formParmsList[i].brandNameA = $scope.formParmsList[i].brandName.substring(0,3)+"...";
						}else{
							$scope.formParmsList[i].brandNameA = $scope.formParmsList[i].brandName;
						}
					}
				}
				
				$scope.num=$scope.formParmsList.length;
				for(var i=0;i<$scope.formParmsList.length;i++){
					
					
					$scope.formatMoney('formParmsList','rent',2,i);
					$scope.formatMoney('formParmsList','amount',2,i);
					$scope.formatMoney('formParmsList','cost',2,i);
					$scope.formatMoney('formParmsList','deductCost',2,i);
					
					$scope.formParmsList[i].equAtOrgCode=$scope.formParmsList[i].orgCode;
					$scope.formParmsList[i].equipmentId=$scope.formParmsList[i].equipmentId;
					$scope.formParmsList[i].equAtOrgId=$scope.formParmsList[i].equAtOrgId;
					$scope.formParmsList[i].equAtOrgName=$scope.formParmsList[i].orgName;
					
					$scope.copyFormParmsList[i] = $scope.formParmsList[i];
					if($scope.formParmsList[i].rentType==null){
						$scope.formParmsList[i].rentType = "1";
					}
				}
			};
			
			function qErr(){};
			
			
			if($scope.employeeEntity.isInclude == true){
				$scope.employeeEntity.isInclude = 1;
			}
			
			if($scope.employeeEntity.isInclude == false){
				$scope.employeeEntity.isInclude = 0;
			}
			if(!$scope.employeeEntity.changOrgName){
				$scope.employeeEntity.changOrgName = $scope.employeeEntity.orgName_;
			}
			if($scope.changeOrgCode_){
				$scope.employeeEntity.orgCode = $scope.changeOrgCode_;
			}
			
			
			RentHistUserSvc.post({
				orgCode:$scope.employeeEntity.orgCode,
				pageNo:$scope.paginationConf.currentPage - 1,
				pageSize:$scope.paginationConf.itemsPerPage,
				isProvider:1,
				//orgName:$scope.employeeEntity.changOrgName,
				month:$scope.queryData.endDate
			},qSucc,qErr);
		};
		
		
		/**
		 * 保存
		 */
		$scope.saveMess = function(obj){
			if(obj.$invalid){
				if($scope.formParmsList){
					$scope.showFlag="";
					for(var i =0;i<$scope.formParmsList.length;i++){
						if(obj['rentCount'+i].$invalid){
							$scope.showFlag = 'rentCount'+i;
							return;
						}
					}
				}	
			}else{
				function qSucc(rec){
					$.messager.popup(rec.msg);
					$scope.queryAllMess(1);
				};
				
				function qErr(){};
				
				for(var i=0;i<$scope.formParmsList.length;i++){
					if($scope.formParmsList[i].rent && $scope.formParmsList[i].rent.indexOf(",") && $scope.formParmsList[i].rent.indexOf(",") > 0){
						$scope.formParmsList[i].rent=$scope.formParmsList[i].rent.toString().replace(/\,/g,'');
					}
				}
				
				for(var i=0;i<$scope.formParmsList.length;i++){
					if($scope.formParmsList[i].amount && $scope.formParmsList[i].amount.indexOf(",") && $scope.formParmsList[i].amount.indexOf(",") > 0){
						$scope.formParmsList[i].amount=$scope.formParmsList[i].amount.toString().replace(/\,/g,'');
					}
				}
				for(var i=0;i<$scope.formParmsList.length;i++){
					if($scope.formParmsList[i].cost && $scope.formParmsList[i].cost.indexOf(",") && $scope.formParmsList[i].cost.indexOf(",") > 0){
						$scope.formParmsList[i].cost=$scope.formParmsList[i].cost.toString().replace(/\,/g,'');
					}
				}
				for(var i=0;i<$scope.formParmsList.length;i++){
					if($scope.formParmsList[i].deductCost && $scope.formParmsList[i].deductCost.indexOf(",") && $scope.formParmsList[i].deductCost.indexOf(",") > 0){
						$scope.formParmsList[i].deductCost=$scope.formParmsList[i].deductCost.toString().replace(/\,/g,'');
					}
				}
				RentHistUserSvc.post(
						{Action:"AddOrUpd"},
						{
							brhtList:$scope.copyFormParmsList,
							month_:$scope.queryData.endDate
						},
				qSucc,qErr);
			}
		
		};
		
		/**
		 * 已退场
		 */
	    $scope.walkOff = function(){
	    	if(!$scope.trBean){
	    		$.messager.popup("请选择一条记录");
	    		return;
	    	}
	    	$.messager.confirm("提示","请您在确认租赁费已结清，如已结清，当前设备信息不会在下个月的列表中展现",function(){
	    		
	    		function qSucc(rec){
	    			$.messager.popup(rec.msg);
	    			$scope.queryAllMess(1);
	    		};
	    		function qErr(){};
	    		RentHistUserSvc.post({Action:"Exit"},{equipmentId:$scope.trBean.equipmentId,month_:$scope.queryData.endDate,equAtOrgId:$scope.trBean.equAtOrgId},qSucc,qErr);
	    	});
	    };
		
		
		//点行选取单选框并赋值
		$scope.radio_flag={};
		$scope.trBean=null;
		$scope.selectRow=function(obj){
			$scope.trBean=obj.f;
			$scope.radio_flag=obj.$index;
		};
		//日期控件
		/**
		 * 获取当前日期的字符串表示形式
		 */
		 
		$scope.getNowDateStr=function()
		{
			var nowDate=new Date();
			year=nowDate.getFullYear();
			month=nowDate.getMonth()+1;
			month1=nowDate.getMonth()+3;
			//month1=nowDate.getMonth()+9;
			//day=nowDate.getDate();
			if(month<10){
				month="0"+month;
			}
			/*if(day<10){
				day="0"+day;
			}*/
		    var strDate=year+"-"+month1;//+"-"+day
		    var endDate=year+"-"+month;
		    $scope.queryData.endDate = endDate;
		    $('#endDateId').datetimepicker('setEndDate', strDate);
		}

		$("button").focus(function(){this.blur()});	
		
		$scope.flagEnd = true; /* 叉号显示初始值赋值 */
		
		/* 清除结束日期 */
		$scope.saveEndBean = null;/* 用于保存结束日期初始值 */
		$scope.cleanDateFunEnd = function()
		{
		    $scope.saveEndBean = $scope.queryData.endDate; /* 保存初始值  */
		    $scope.queryData.endDate = null; /* 清空日期控件值 */
		    document.getElementById("endDateId").focus(); /* 光标定位回日期控件 */
		};


		/**
		 * 每三位数字添加一个逗号分隔符号
		 */
		$scope.centsCopyFive = '';
	 	
		$scope.formatMoney=function(list_,obj2_,counts,this_){//参数分别是：num=输入值，parm=属性,flag=区分添加和修改的符号，counts=小数点最多几位
				
				$scope.numsArray_ = [];
				var judge = "";
			
			    $scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
			
				if($scope[list_][this_][obj2_]==null||$scope[list_][this_][obj2_]==""){//首先确定输入的有值
					return;
				}else{
					$scope[list_][this_][obj2_]=$scope[list_][this_][obj2_].toString();//把原值字符串话，因为数据库存的是大类型，只有字符串话才能切割（用于登记的时候重新加上逗号）
					$scope.numsArray_=$scope[list_][this_][obj2_].split("");//把输入的字符变成数组用于判断其中点的数目
				}
				
				for(var i=0;i<$scope[list_][this_].length;i++){//数值第一位不能是0，是0就返回0
					if($scope[list_][this_][0] == 0){
						//$scope.mess[parm] = 0;
						$scope[list_][this_][obj2_]=0;
						return ;
					}
				}
				
				for(var i=0;i<$scope.numsArray_.length;i++){//不能有2个以上的小数点否则为0
					if($scope.numsArray_[i] == '.'){
						$scope.test_.push($scope.numsArray_[i]);
						if($scope.test_.length>1){
							$scope[list_][this_][obj2_] = 0;
							return;
						}
					}
				}
				
				//检索点号的位置或者说是否有点号
				   judge = $scope[list_][this_][obj2_].indexOf(".");
				var cents='';//包括小数点之后
				var centsCopy =0;//不包括小数点之后
				
				//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
				if(judge>0){
					cents = $scope[list_][this_][obj2_].substring(judge, $scope[list_][this_][obj2_].length);//包括点开始截取到完结
					centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
					$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].substring(0,judge);//截取（不包括点）点之前的数字
					
					if(centsCopy.length==counts){//当小数点后面的位数达到软需要求时记录数值,counts是方法传入的参数也就是要求小数点最多几位
						$scope.centsCopyFive = centsCopy;//$scope.centsCopyFive为一个记录对象，记录当满足小数点要求时，这个时候小数点后的数字是什么，用于下面的赋值
					}
					
					if(centsCopy.length>counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
						cents = '.'+$scope.centsCopyFive;
					}
				}
				
				$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].toString().replace(/\,/g,'');//全局匹配有没有逗号，有就清除，用于清除上次的逗号在进行排版
				//如果num不是数字就赋值为0   这个不完美如果小数点后有字母不为0
				if(isNaN($scope[list_][this_][obj2_])){
					$scope[list_][this_][obj2_] = "0";
				}
				
					if(isNaN(centsCopy)){//如果小数点后面的值有不为数字的字符就把小数点之前的置为0，包括小数点之后的字符为空，这样起到如果有不为数字的字符就为0
						$scope[list_][this_][obj2_] = "0";
						cents = "";
					}	
				
					for (var i = 0; i < Math.floor(($scope[list_][this_][obj2_].length-(1+i))/3); i++){
						$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].substring(0,$scope[list_][this_][obj2_].length-(4*i+3))+','+$scope[list_][this_][obj2_].substring($scope[list_][this_][obj2_].length-(4*i+3));
					}
				//如果有小数点算上小数点赋值
				if(cents.length!=0){
					$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_]+cents;
					if($scope[list_][this_][obj2_].length > 18){
						$scope[list_][this_][obj2_] = 0;
					}
				}else{
					$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_];
					if($scope[list_][this_][obj2_].length > 18){
						$scope[list_][this_][obj2_] = 0;
					}
				}
		};
		$scope.centsCopyFive = '';
	 	
		$scope.formatMoneyNum=function(list_,obj2_,counts,this_){//参数分别是：num=输入值，parm=属性,flag=区分添加和修改的符号，counts=小数点最多几位
				
				$scope.numsArray_ = [];
				var judge = "";
			
			    $scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
			
				if($scope[list_][this_][obj2_]==null||$scope[list_][this_][obj2_]==""){//首先确定输入的有值
					return;
				}else{
					$scope[list_][this_][obj2_]=$scope[list_][this_][obj2_].toString();//把原值字符串话，因为数据库存的是大类型，只有字符串话才能切割（用于登记的时候重新加上逗号）
					$scope.numsArray_=$scope[list_][this_][obj2_].split("");//把输入的字符变成数组用于判断其中点的数目
				}
				
				for(var i=0;i<$scope[list_][this_].length;i++){//数值第一位不能是0，是0就返回0
					if($scope[list_][this_][0] == 0){
						//$scope.mess[parm] = 0;
						$scope[list_][this_][obj2_]=0;
						return ;
					}
				}
				
				for(var i=0;i<$scope.numsArray_.length;i++){//不能有2个以上的小数点否则为0
					if($scope.numsArray_[i] == '.'){
						$scope.test_.push($scope.numsArray_[i]);
						if($scope.test_.length>1){
							$scope[list_][this_][obj2_] = 0;
							return;
						}
					}
				}
				
				//检索点号的位置或者说是否有点号
				   judge = $scope[list_][this_][obj2_].indexOf(".");
				var cents='';//包括小数点之后
				var centsCopy =0;//不包括小数点之后
				
				//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
				if(judge>0){
					cents = $scope[list_][this_][obj2_].substring(judge, $scope[list_][this_][obj2_].length);//包括点开始截取到完结
					centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
					$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].substring(0,judge);//截取（不包括点）点之前的数字
					
					if(centsCopy.length==counts){//当小数点后面的位数达到软需要求时记录数值,counts是方法传入的参数也就是要求小数点最多几位
						$scope.centsCopyFive = centsCopy;//$scope.centsCopyFive为一个记录对象，记录当满足小数点要求时，这个时候小数点后的数字是什么，用于下面的赋值
					}
					
					if(centsCopy.length>counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
						cents = '.'+$scope.centsCopyFive;
					}
				}
				
				$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].toString().replace(/\,/g,'');//全局匹配有没有逗号，有就清除，用于清除上次的逗号在进行排版
				//如果num不是数字就赋值为0   这个不完美如果小数点后有字母不为0
				if(isNaN($scope[list_][this_][obj2_])){
					$scope[list_][this_][obj2_] = "0";
				}
				
					if(isNaN(centsCopy)){//如果小数点后面的值有不为数字的字符就把小数点之前的置为0，包括小数点之后的字符为空，这样起到如果有不为数字的字符就为0
						$scope[list_][this_][obj2_] = "0";
						cents = "";
					}	
				
					/*for (var i = 0; i < Math.floor(($scope[list_][this_][obj2_].length-(1+i))/3); i++){
						$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].substring(0,$scope[list_][this_][obj2_].length-(4*i+3))+','+$scope[list_][this_][obj2_].substring($scope[list_][this_][obj2_].length-(4*i+3));
					}*/
				//如果有小数点算上小数点赋值
				if(cents.length!=0){
					$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_]+cents;
					/*if($scope[list_][this_][obj2_].length > 18){
						$scope[list_][this_][obj2_] = 0;
					}*/
				}else{
					$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_];
					/*if($scope[list_][this_][obj2_].length > 18){
						$scope[list_][this_][obj2_] = 0;
					}*/
				}
				
		};

		
		/**
		 * 以下为12.29日编写的有关输入框叉号的一系列方法，其中包括：点击叉号清除输入框值焦点定位到输入框、点击输入框判断如果输入框有值就显示叉号，没有就清空、失去焦点推迟0.15秒失去叉号这样可以保证失去焦点的时候不会叉号直接就被清空了来不及点
		 * 顺序按照上面的描述排序
		 */
		$scope.flagShow = false;
		
		$scope.cleanDateFunEnd = function(){
			$scope.employeeEntity.orgName = '';
			$("#searchContent").focus();
			$scope.flagShow = false;
			if($scope.LiNumA == true){
				$scope.LiNumA = false;
			}
		};
		
		$scope.clickInput = function(obj){
			if(obj.length > 0){
				$scope.flagShow = true;
			}else{
				$scope.flagShow = false;
			}
		};
		
		$scope.blurInput = function(){
			$timeout(function() { // 延迟0.15秒这样能优先执行清除日期的方法达到赋值，要不点击会直接清除叉号不会执行清除日期的方法不能赋值 
				$scope.flagShow = false;
				$scope.LiNumA = false;
				$scope.KeyWordList = [];
		     },150);
			
			if($scope.employeeEntity.orgName == ''){//失去焦点时如果当前单位是空的默认查询当前登录人信息
				$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
				
				$scope.employeeEntity.code=SYS_USER_INFO.orgCode;
				$scope.employeeEntity.OrgId = SYS_USER_INFO.orgId;
			}
		};
		
		
		
		
	});
