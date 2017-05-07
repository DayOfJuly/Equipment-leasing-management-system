app.controller('DeviceHaveListController', function($scope,$timeout,SYS_CODE_CON,proSvc,sysCodeTranslateFactory,RentHistOwnerSvc,entSvc) {
	
	//ie9下titile正确显示使用
	document.title="租赁费登记-设备拥有者"
	
    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    
    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
    
    $scope.userInfo = {};
    $scope.userInfo.orgCode=SYS_USER_INFO.orgCode;
    $scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
    $scope.userInfo.orgLevel_show=SYS_USER_INFO.orgLevel;
    $scope.userInfo.orgId = SYS_USER_INFO.orgId;
    $scope.userInfo.orgName = SYS_USER_INFO.orgName;
    $scope.userInfo.proId = SYS_USER_INFO.proId;
    $scope.userInfo.proName = SYS_USER_INFO.proName;
    $scope.userInfo.orgPartyId = SYS_USER_INFO.perPartyId;

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
	
	$scope.formParms={};
	$scope.employeeEntity = {};
	$scope.employeeEntity.isInclude = 0;
	
	
	$scope.showLevel = null;
	$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
	$scope.employeeEntity.orgName_ = SYS_USER_INFO.orgName;//因为没有排除orgName在哪里使用，所以创建了orgName_用于点击时传当前单位属性
	$scope.employeeEntity.orgId_ = SYS_USER_INFO.orgId;
	$scope.employeeEntity.orgCode = SYS_USER_INFO.orgCode;
	$scope.employeeEntity.orgNameInput=SYS_USER_INFO.proName;
	if(SYS_USER_INFO.proId){
		$scope.employeeEntity.currentOrgId=SYS_USER_INFO.proId;
	}else{
		$scope.employeeEntity.currentOrgId=SYS_USER_INFO.orgId;
	}
	
	if(1==SYS_USER_INFO.orgLevel){
		$scope.employeeEntity.orgFlag = 9;
	}else if(2==SYS_USER_INFO.orgLevel){
		$scope.employeeEntity.orgFlag = 1;
	}
	else if(3==SYS_USER_INFO.orgLevel){
		$scope.employeeEntity.orgFlag = 2;
	}
	
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
         itemsPerPage: 10,	/*每页显示多少*/
         pagesLength: 10,		/*分页标签数量显示*/
         perPageOptions: [10, 20, 30, 40, 50],
        
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        onChange:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	$scope.queryAllMess();
        }
    };
	
	$scope.queryData={};

	
	/**
	 * 查看
	 */
	
	$scope.openQuery = function(){
		if(!$scope.trBean){
			$.messager.popup("请选择一条记录");
			return;
		}
		$scope.showArrayList = [];
		$scope.messList = [];
		function qSucc(rec){
			//$scope.showArrayList = rec.ownerRentInfos;
			$scope.messList = rec.ownerRentInfos;
			$scope.userRentInfos = rec.userRentInfos;
			
			for( var r=0;r<rec.userRentInfos.length;r++){
				 if(rec.userRentInfos[r].equAtOrgName){
		               if(rec.userRentInfos[r].equAtOrgName.length > 7){
							$scope.userRentInfos[r].equAtOrgNameA = rec.userRentInfos[r].equAtOrgName.substring(0,7)+"...";
						}else{
							$scope.userRentInfos[r].equAtOrgNameA =  rec.userRentInfos[r].equAtOrgName;
						}
		           }
				 if(rec.userRentInfos[r].startEndDate){
		               if(rec.userRentInfos[r].startEndDate.length > 15){
							$scope.userRentInfos[r].startEndDateA = rec.userRentInfos[r].startEndDate.substring(0,15)+"...";
						}else{
							$scope.userRentInfos[r].startEndDateA =  rec.userRentInfos[r].startEndDate;
						}
		           }
				 if(rec.userRentInfos[r].note){
		               if(rec.userRentInfos[r].note.length >7){
							$scope.userRentInfos[r].noteA = rec.userRentInfos[r].note.substring(0,7)+"...";
						}else{
							$scope.userRentInfos[r].noteA =  rec.userRentInfos[r].note;
						}
		           }
			}
			
			for(var i=0;i<$scope.messList.length;i++){
				$scope.formatMoney('messList','rent',2,i);
				$scope.formatMoney('messList','amount',2,i);
				$scope.formatMoney('messList','cost',2,i);
				$scope.formatMoney('messList','deductCost',2,i);
				
			}
			$scope.showArrayList = $scope.messList;
			
			
			for( var r=0;r<$scope.messList.length;r++){
				 if($scope.messList[r].depName){
		               if($scope.messList[r].depName.length > 7){
		            	   $scope.showArrayList[r].depNameA = $scope.messList[r].depName.substring(0,7)+"...";
						}else{
							$scope.showArrayList[r].depNameA =  $scope.messList[r].depName;
						}
		           }
				 if($scope.messList[r].startEndDate){
		               if($scope.messList[r].startEndDate.length > 15){
		            	   $scope.showArrayList[r].startEndDateA = $scope.messList[r].startEndDate.substring(0,15)+"...";
						}else{
							$scope.showArrayList[r].startEndDateA =  $scope.messList[r].startEndDate;
						}
		           }
				 if($scope.messList[r].note){
		               if($scope.messList[r].note.length >7){
		            	   $scope.showArrayList[r].noteA = $scope.messList[r].note.substring(0,7)+"...";
						}else{
							$scope.showArrayList[r].noteA =  $scope.messList[r].note;
						}
		           }
			}
			$("#DeviceQueryId").modal({backdrop: 'static', keyboard: false});
		};
		
		function qErr(){};
		RentHistOwnerSvc.unifydo({equipmentId:$scope.trValues.equipmentId,month:$scope.queryData.endDate,pageNo:$scope.paginationConf.currentPage - 1,pageSize:$scope.paginationConf.itemsPerPage},qSucc,qErr);
	};
	
	
	/**
	 * 查询所有信息(查询按钮)
	 */
	$scope.queryAllList = {};//定义一个空对象
	$scope.queryAllMess = function(PageNo){
		if(PageNo){
			$scope.paginationConf.currentPage = 1;
		}
/*		$scope.cutDate();//分割时间为年-月
*/		function qSucc(rec){
			if(rec){
				if(rec.content.length > 0){
					$scope.queryAllList = rec.content;
				}else if(rec.content.length == 0){
					$scope.queryAllList = [];
					$.messager.popup("没有符合条件的记录");
					return;
				}
				$scope.paginationConf.totalItems=rec.totalElements;
				
				for( var j=0;j<$scope.queryAllList.length;j++)
				{
					$scope.queryAllList[j].amountTemp=$scope.formatNumber($scope.queryAllList[j].amount);
					$scope.queryAllList[j].costTemp=$scope.formatNumber($scope.queryAllList[j].cost);
					$scope.queryAllList[j].deductCostTemp=$scope.formatNumber($scope.queryAllList[j].deductCost);

					 if($scope.queryAllList[j].equNo){
			               if($scope.queryAllList[j].equNo.length > 7){
								$scope.queryAllList[j].equNoA = $scope.queryAllList[j].equNo.substring(0,7)+"...";
							}else{
								$scope.queryAllList[j].equNoA =  $scope.queryAllList[j].equNo;
							}
			           }
					  
					 if($scope.queryAllList[j].equipmentName){
			               if($scope.queryAllList[j].equipmentName.length > 7){
								$scope.queryAllList[j].equipmentNameA = $scope.queryAllList[j].equipmentName.substring(0,7)+"...";
							}else{
								$scope.queryAllList[j].equipmentNameA =  $scope.queryAllList[j].equipmentName;
							}
			           }
					   if($scope.queryAllList[j].brandName){
			               if($scope.queryAllList[j].brandName.length > 5){
								$scope.queryAllList[j].brandNameA = $scope.queryAllList[j].brandName.substring(0,5)+"...";
							}else{
								$scope.queryAllList[j].brandNameA =  $scope.queryAllList[j].brandName;
							}
			           }
					   if($scope.queryAllList[j].asset){
			               if($scope.queryAllList[j].asset.length > 5){
								$scope.queryAllList[j].assetA = $scope.queryAllList[j].asset.substring(0,5)+"...";
							}else{
								$scope.queryAllList[j].assetA =  $scope.queryAllList[j].asset;
							}
			           }
					   if($scope.queryAllList[j].licenseNo){
			               if($scope.queryAllList[j].licenseNo.length > 10){
								$scope.queryAllList[j].licenseNoA = $scope.queryAllList[j].licenseNo.substring(0,10)+"...";
							}else{
								$scope.queryAllList[j].licenseNoA =  $scope.queryAllList[j].licenseNo;
							}
			           }
					
				}
			}
			
			if(rec.content==""){
    			$scope.reveal = false;
			}else{
				$scope.reveal = true;
			}
		};
	
		function qErr(){};
		
	
		if(!$scope.employeeEntity.changOrgName){
			$scope.employeeEntity.changOrgName = $scope.employeeEntity.orgName_;
		}
		
/*		if($scope.changeOrgCode_){
			$scope.employeeEntity.orgCode = $scope.changeOrgCode_;
		}
*/		
		if($scope.employeeEntity.code){
			$scope.employeeEntity.orgCode = $scope.employeeEntity.code;
		}
		
		if($scope.employeeEntity.orgPartyId){
			if($scope.employeeEntity.orgFlag==2){
				$scope.employeeEntity.isInclude = 0;
			}
			if($scope.employeeEntity.orgFlag==3){
				$scope.employeeEntity.isInclude = 0;
			}
			RentHistOwnerSvc.post({
				//orgCode:$scope.employeeEntity.orgCode,
				pageNo:$scope.paginationConf.currentPage - 1,
				pageSize:$scope.paginationConf.itemsPerPage,
				isInclude:$scope.employeeEntity.isInclude,
				orgFlag:$scope.employeeEntity.orgFlag,
				orgPartyId:$scope.employeeEntity.orgPartyId,
				//orgName:$scope.employeeEntity.changOrgName,
				month:$scope.queryData.endDate
			},qSucc,qErr);
		}else{
			
			if($scope.userInfo.proId){
				$scope.employeeEntity.orgFlag = 3;
			}
			else if(1==$scope.userInfo.orgLevel){
				$scope.employeeEntity.orgFlag = 9;
			}
			else if(2==$scope.userInfo.orgLevel){
				$scope.employeeEntity.orgFlag = 1;
			}
			else if(3==$scope.userInfo.orgLevel){
				$scope.employeeEntity.orgFlag = 2;
			}
			
			if($scope.employeeEntity.orgFlag==2){
				$scope.employeeEntity.isInclude = 0;
			}
			if($scope.employeeEntity.orgFlag==3){
				$scope.employeeEntity.isInclude = 0;
			}
			RentHistOwnerSvc.post({
				//orgCode:$scope.employeeEntity.orgCode,
				pageNo:$scope.paginationConf.currentPage - 1,
				pageSize:$scope.paginationConf.itemsPerPage,
				isInclude:$scope.employeeEntity.isInclude,
				orgFlag:$scope.employeeEntity.orgFlag,
				orgPartyId:$scope.employeeEntity.currentOrgId,
				//orgName:$scope.employeeEntity.changOrgName,
				month:$scope.queryData.endDate
			},qSucc,qErr);
		}
	};
	
	
	/**
	 * 登记打开模态框
	 */
	$scope.formParms = [];
	$scope.openAdd = function(){
		   
			$scope.showFlag = {};
			$scope.num = 0;
			
			$scope.messList = [];
			
			
			if(!$scope.trBean){
				$.messager.popup("请选择一条数据");
				return;
			}
			
			function qSucc(rec){
				
				$scope.userRentInfos = rec.userRentInfos;
				for(var j=0;j< rec.userRentInfos.length;j++){
					 if(rec.userRentInfos[j].equAtOrgName){
			               if(rec.userRentInfos[j].equAtOrgName.length > 7){
								$scope.userRentInfos[j].equAtOrgNameA = rec.userRentInfos[j].equAtOrgName.substring(0,7)+"...";
							}else{
								$scope.userRentInfos[j].equAtOrgNameA =  rec.userRentInfos[j].equAtOrgName;
							}
			           }
					 if(rec.userRentInfos[j].startEndDate){
			               if(rec.userRentInfos[j].startEndDate.length > 15){
								$scope.userRentInfos[j].startEndDateA = rec.userRentInfos[j].startEndDate.substring(0,15)+"...";
							}else{
								$scope.userRentInfos[j].startEndDateA =  rec.userRentInfos[j].startEndDate;
							}
			           }
					 if(rec.userRentInfos[j].note){
			               if(rec.userRentInfos[j].note.length >7){
								$scope.userRentInfos[j].noteA = rec.userRentInfos[j].note.substring(0,7)+"...";
							}else{
								$scope.userRentInfos[j].noteA =  rec.userRentInfos[j].note;
							}
			           }
				}
				
				$scope.messList = rec.ownerRentInfos;//拿到模态框需要的信息
				$scope.equAtOrgCode = rec.viewEquInfo.orgCode;
				$scope.equAtOrgId  = rec.viewEquInfo.orgPartyId;
				$scope.equAtOrgName = rec.viewEquInfo.orgName;
				
				
				for(var i =0;i<$scope.messList.length;i++){
					$scope.formatMoney('messList','rent',2,i);
					$scope.formatMoney('messList','amount',2,i);
					$scope.formatMoney('messList','cost',2,i);
					$scope.formatMoney('messList','deductCost',2,i);
					$scope.messList[i].equAtOrgName  =$scope.equAtOrgName;
					$scope.messList[i].equAtOrgId  = $scope.equAtOrgId;
					$scope.messList[i].equAtOrgCode  = $scope.equAtOrgCode;
					
					if($scope.messList[i].rentType == null){
						$scope.messList[i].rentType = '1';
					}
				}
				$scope.num = $scope.messList.length;
				$scope.copyView = rec.viewEquInfo;//这是其他查询出的数据暂时可能用不到
				
				$("#DeviceAddId").modal({backdrop: 'static', keyboard: false});
				
				if(rec.ownerRentInfos==""){
					$scope.add = 'true';
				}else{
					$scope.add ='';
				}
			}
			function qErr(){};
			RentHistOwnerSvc.unifydo({
				equipmentId:$scope.trValues.equipmentId,
				month:$scope.queryData.endDate,
				pageNo:$scope.paginationConf.currentPage - 1,
				pageSize:$scope.paginationConf.itemsPerPage
			},qSucc,qErr);
	};
	
	/**
	 * 登记（保存）
	 */
	$scope.saveMess = function(obj){
		if(obj.$valid){
			function qSucc(rec){
				$.messager.popup(rec.msg);
				$scope.queryAllMess(1);
				$("#DeviceAddId").modal('hide');
			};
			
			function qErr(){};
			
			for(var i=0;i<$scope.messList.length;i++){
				if($scope.messList[i].rent && $scope.messList[i].rent.indexOf(",") && $scope.messList[i].rent.indexOf(",") > 0){
					$scope.messList[i].rent=$scope.messList[i].rent.toString().replace(/\,/g,'');
				}
			}
			for(var i=0;i<$scope.messList.length;i++){
				if($scope.messList[i].amount && $scope.messList[i].amount.indexOf(",") && $scope.messList[i].amount.indexOf(",") > 0){
					$scope.messList[i].amount=$scope.messList[i].amount.toString().replace(/\,/g,'');
				}
			}
			for(var i=0;i<$scope.messList.length;i++){
				if($scope.messList[i].cost&& $scope.messList[i].cost.indexOf(",") && $scope.messList[i].cost.indexOf(",") > 0){
					$scope.messList[i].cost=$scope.messList[i].cost.toString().replace(/\,/g,'');
				}
			}
			for(var i=0;i<$scope.messList.length;i++){
				if($scope.messList[i].deductCost&& $scope.messList[i].deductCost.indexOf(",") && $scope.messList[i].deductCost.indexOf(",") > 0){
					$scope.messList[i].deductCost=$scope.messList[i].deductCost.toString().replace(/\,/g,'');
				}
			}	
			for(var j=0;j<$scope.messList.length;j++){
				$scope.messList[j].equAtOrgName  =$scope.equAtOrgName;
				$scope.messList[j].equAtOrgId  = $scope.equAtOrgId;
				$scope.messList[j].equAtOrgCode  = $scope.equAtOrgCode;
			}
			
			
			RentHistOwnerSvc.post(
					{Action:'AddOrUpd'},
					{
						month_:$scope.trValues.dates,
						equipmentId:$scope.trValues.equipmentId,
						brhtList:$scope.messList
					},qSucc,qErr
			);
		}else{
			$scope.showFlag="";
			if($scope.messList){
				$scope.showFlag='';
				for(var i=0;i<$scope.messList.length;i++){
					if(obj['rentCount'+i].$invalid){
						$scope.showFlag = 'rentCount'+i;
						return;
					}
				}
			}	
		}
	
	};
	
	$scope.openAdd_delShow = function(copy){
		$scope.messList = [];
		$scope.num = 0;
		
		function qSucc(){
			$scope.messList = copy;//拿到模态框需要的信息
			for(var i =0;i<$scope.messList.length;i++){
				$scope.formatMoney('messList','rent',2,i);
				$scope.formatMoney('messList','amount',2,i);
				$scope.formatMoney('messList','cost',2,i);
				$scope.formatMoney('messList','deductCost',2,i);
			}
			$scope.num = $scope.messList.length;
		}
		function qErr(){};
		RentHistOwnerSvc.unifydo({equipmentId:$scope.trValues.equipmentId,month:$scope.queryData.endDate},qSucc,qErr);
	};
	
	/**
	 * 删除
	 */
	$scope.del = function(){
		if(!$scope.checkIndex || $scope.checkIndex == null ||  $scope.checkIndex==""){
			$.messager.popup("请选择一条记录");
			return;
		}
		$.messager.confirm("提示", "是否删除？", function() { 
			$scope.showFlag="";
			$scope.messListCopy = [];
			$scope.messList.splice($scope.checkIndex.place,1);
			$scope.messListCopy = $scope.messList;
			$scope.openAdd_delShow($scope.messListCopy);
			$scope.checkIndex = null;
		});
	};
	
	
	
	
	
	// 添加一行
	$scope.addRow = function() {
		$scope.messList.push({});
		$scope.num = $scope.messList.length;
		$scope.add='';
		for(var i=0;i<$scope.messList.length;i++){
			if($scope.messList[i].rentType){
			}else{
				$scope.messList[i].rentType="1";
			}
		}
		
	};
	
	//点行选取单选框并赋值
	$scope.radio_flag={};
	$scope.trBean=null;
	$scope.trValues = {};
	
	$scope.selectRow=function(obj,num){

		if(num && num==1){
			$scope.trBean=obj.q;
			$scope.trValues = 
			{
			   equipmentName:obj.q.equipmentName,
	           brandName:obj.q.brandName,
	           amount:obj.q.equNo,
	           equipmentId:obj.q.equId,
	           dates:$scope.queryData.endDate
		    };
			if(obj.q.equipmentName.length>20){
				$scope.trValues.equipmentNameA  = obj.q.equipmentName.substring(0,20)+"...";
			}else{
				$scope.trValues.equipmentNameA  = obj.q.equipmentName;
			}
			if(obj.q.equNo.length>20){
				$scope.trValues.amountA = obj.q.equNo.substring(0,20)+"...";
			}else{
				$scope.trValues.amountA  = obj.q.equNo;
			}
			if(obj.q.brandName.length>20){
				$scope.trValues.brandNameA  = obj.q.brandName.substring(0,20)+"...";
			}else{
				$scope.trValues.brandNameA  = obj.q.brandName;
			}
			
			
			
			
			$scope.radio_flag=obj.$index;
		}
		if(num && num==2){
		}

	};

	
/*	$scope.queryAllMess();*/
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
		//day=nowDate.getDate();
		if(month<10){
			month="0"+month;
		}
		/*if(day<10){
			day="0"+day;
		}*/
	    var strDate=year+"-"+month1;//+"-"+day
	    var endDate=year+"-"+month
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
	    /* $scope.flagEnd = false; */ /* 清空叉号 */
	    $scope.queryData.endDate = null; /* 清空日期控件值 */
	    document.getElementById("endDateId").focus(); /* 光标定位回日期控件 */
	};

	
	/**
	 * 每三位数字添加一个逗号分隔符号
	 */

	$scope.centsCopyFive1 = '';
	$scope.formatMoney=function(list_,obj_,counts,this_){//参数分别是：list_=输入值，obj_=属性,counts=小数点最多几位
			
			$scope.numsArray_ = [];
			var judge = "";
		
		    $scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
		
			if($scope[list_][this_][obj_]==null||$scope[list_][this_][obj_]==""){//首先确定输入的有值
				return;
			}else{
				$scope[list_][this_][obj_]=$scope[list_][this_][obj_].toString();//把原值字符串话，因为数据库存的是大类型，只有字符串话才能切割（用于登记的时候重新加上逗号）
				$scope.numsArray_=$scope[list_][this_][obj_].split("");//把输入的字符变成数组用于判断其中点的数目
			}
			
			for(var i=0;i<$scope[list_][this_].length;i++){//数值第一位不能是0，是0就返回0
				if($scope[list_][this_][0] == 0){
					$scope[list_][this_][obj_]=0;
					return;
				}
				
			}
			
			for(var i=0;i<$scope.numsArray_.length;i++){//不能有2个以上的小数点否则为0
				if($scope.numsArray_[i] == '.'){
					$scope.test_.push($scope.numsArray_[i]);
					if($scope.test_.length>1){
						$scope[list_][this_][obj_] = 0;
						return;
					}
				}
			}
			
			//检索点号的位置或者说是否有点号
			   judge = $scope[list_][this_][obj_].indexOf(".");
			var cents='';//包括小数点之后
			var centsCopy =0;//不包括小数点之后
			
			//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
			if(judge>0){
				cents = $scope[list_][this_][obj_].substring(judge, $scope[list_][this_][obj_].length);//包括点开始截取到完结
				centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
				$scope[list_][this_][obj_] = $scope[list_][this_][obj_].substring(0,judge);//截取（不包括点）点之前的数字
				
				if(centsCopy.length==counts){//当小数点后面的位数达到软需要求时记录数值,counts是方法传入的参数也就是要求小数点最多几位
					$scope.centsCopyFive1 = centsCopy;//$scope.centsCopyFive为一个记录对象，记录当满足小数点要求时，这个时候小数点后的数字是什么，用于下面的赋值
				}
				
				if(centsCopy.length>counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
					cents = '.'+$scope.centsCopyFive1;
				}
			}
			
			$scope[list_][this_][obj_] = $scope[list_][this_][obj_].toString().replace(/\,/g,'');//全局匹配有没有逗号，有就清除，用于清除上次的逗号在进行排版
			//如果num不是数字就赋值为0   这个不完美如果小数点后有字母不为0
			if(isNaN($scope[list_][this_][obj_])){
				$scope[list_][this_][obj_] = "0";
			}
			
					
			
			if(isNaN(centsCopy)){//如果小数点后面的值有不为数字的字符就把小数点之前的置为0，包括小数点之后的字符为空，这样起到如果有不为数字的字符就为0
				$scope[list_][this_][obj_] = "0";
				cents = "";
			}
			for (var i = 0; i < Math.floor(($scope[list_][this_][obj_].length-(1+i))/3); i++){
				$scope[list_][this_][obj_] = $scope[list_][this_][obj_].substring(0,$scope[list_][this_][obj_].length-(4*i+3))+','+$scope[list_][this_][obj_].substring($scope[list_][this_][obj_].length-(4*i+3));
			}
			//如果有小数点算上小数点赋值
			if(cents.length!=0){
				$scope[list_][this_][obj_] = $scope[list_][this_][obj_]+cents;
				if($scope[list_][this_][obj_].length > 18){
					$scope[list_][this_][obj_] = 0;
				}
			}else{
				$scope[list_][this_][obj_] = $scope[list_][this_][obj_];
				if($scope[list_][this_][obj_].length > 18){
					$scope[list_][this_][obj_] = 0;
				}
			}
		
	};
	
	
	$scope.centsCopyFive = '';
	$scope.formatMoneyNum=function(list_,obj_,counts,this_){//参数分别是：list_=输入值，obj_=属性，counts=小数点最多几位
		
		$scope.numsArray_ = [];
		var judge = "";
	
	    $scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
	
		if($scope[list_][this_][obj_]==null||$scope[list_][this_][obj_]==""){//首先确定输入的有值
			return;
		}else{
			$scope[list_][this_][obj_]=$scope[list_][this_][obj_].toString();//把原值字符串话，因为数据库存的是大类型，只有字符串话才能切割（用于登记的时候重新加上逗号）
			$scope.numsArray_=$scope[list_][this_][obj_].split("");//把输入的字符变成数组用于判断其中点的数目
		}
		
		for(var i=0;i<$scope[list_][this_].length;i++){//数值第一位不能是0，是0就返回0
			if($scope[list_][this_][0] == 0){
				$scope[list_][this_][obj_]=0;
				return;
			}
			
		}
		
		for(var i=0;i<$scope.numsArray_.length;i++){//不能有2个以上的小数点否则为0
			if($scope.numsArray_[i] == '.'){
				$scope.test_.push($scope.numsArray_[i]);
				if($scope.test_.length>1){
					$scope[list_][this_][obj_] = 0;
					return;
				}
			}
		}
		
		//检索点号的位置或者说是否有点号
		   judge = $scope[list_][this_][obj_].indexOf(".");
		var cents='';//包括小数点之后
		var centsCopy =0;//不包括小数点之后
		
		//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
		if(judge>0){
			cents = $scope[list_][this_][obj_].substring(judge, $scope[list_][this_][obj_].length);//包括点开始截取到完结
			centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
			$scope[list_][this_][obj_] = $scope[list_][this_][obj_].substring(0,judge);//截取（不包括点）点之前的数字
			
			if(centsCopy.length==counts){//当小数点后面的位数达到软需要求时记录数值,counts是方法传入的参数也就是要求小数点最多几位
				$scope.centsCopyFive = centsCopy;//$scope.centsCopyFive为一个记录对象，记录当满足小数点要求时，这个时候小数点后的数字是什么，用于下面的赋值
			}
			
			if(centsCopy.length > 5){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
				cents = '.'+$scope.centsCopyFive;
			}
		}
		
		$scope[list_][this_][obj_] = $scope[list_][this_][obj_].toString().replace(/\,/g,'');//全局匹配有没有逗号，有就清除，用于清除上次的逗号在进行排版
		//如果num不是数字就赋值为0   这个不完美如果小数点后有字母不为0
		if(isNaN($scope[list_][this_][obj_])){
			$scope[list_][this_][obj_] = "0";
		}
		
				
		
		if(isNaN(centsCopy)){//如果小数点后面的值有不为数字的字符就把小数点之前的置为0，包括小数点之后的字符为空，这样起到如果有不为数字的字符就为0
			$scope[list_][this_][obj_] = "0";
			cents = "";
		}

		//如果有小数点算上小数点赋值
		if(cents.length!=0){
			$scope[list_][this_][obj_] = $scope[list_][this_][obj_]+cents;
		}else{
			$scope[list_][this_][obj_] = $scope[list_][this_][obj_];
		}
	
};
	$scope.cancel = function(){
		if($scope.checkIndex){
			$scope.checkIndex.place=null;
		}
	}

	
	/**
	 * 模态框里面的点击一行方法
	 */
	$scope.checkLine = function(this_){
		
		$scope.checkIndex = {};
		if(this_){
			$scope.checkIndex.place = this_.$index;//位置
			$scope.checkIndex.value_ = this_.mess;//值
			
		}
		$scope.add='';
	};
	
	$scope.checkLine2 = function(this_){
			
			$scope.checkIndex2 = {};
			if(this_){
				$scope.checkIndex2.place = this_.$index;//位置
			}
			$scope.add='true';
		};
		
		
		
		

		/*
		*input框ng-change事件
		*/
		$scope.KeyWordQuery = function(inputValue,showFlag){/* 需要 */
			$scope.KeyWordListFlag = false;//如果改变输入框的值就把flag变成false，用于时时监控不管是改变的值是有查询结果还是没有都先为false这样可以把青花瓷的例子筛选出来，也可以把没改变的时候筛选出来
			if(inputValue.length == 0){//如果输入框没有值了，就隐藏下面的展示结果域
				$scope[showFlag] = false;
				$scope.flagShow = false;
			}else{
				$scope.flagShow = true;
			}
			$scope.KeyWordList=[];/* 需要 */

			if($scope.employeeEntity.orgName.length < 1){
				$scope.showLevel = false;
				//$scope.employeeEntity.isInclude = false;//复选框控制
			}
			
			function qSucc(rec){/* 需要 */
				if(rec.content.length<=0){/* 需要 */
					$scope[showFlag]=false;/* 需要 */
					$scope.flagAdd_show = true;//添加按钮不能点
				}else{
					$scope[showFlag]=true;/* 需要 */
					$scope.KeyWordList=rec.content;/* 需要 */
					$scope.KeyWordListFlag = true;//如果有查询的值flag就为true
					
					
					for(var i=0;i<$scope.KeyWordList.length;i++){//这里的遍历主要用于在改变输入值的时候如果有查询出对应的名字就赋值对应的code（解决在不展示查询信息的时候也可以根据查到的code去查询（如中铁二局查到后失去焦点在点查询的时候）
						if($scope.employeeEntity.orgName == $scope.KeyWordList[i].name){//如果输入的name等于展示集合的name那就赋值给对应的code
							$scope.employeeEntity.code = $scope.KeyWordList[i].code;//此地赋值code
							$scope.employeeEntity.deptId = $scope.KeyWordList[i].currOrgId;//id是用来赋值给当前单位下的人的
							$scope.saveDeptId = $scope.KeyWordList[i].currOrgId;
							$scope.flagAdd_show = false;//添加按钮不能点
							if($scope.KeyWordList[i].orgLevel == 2){
								$scope.userInfo.orgLevel_show = 2;
							}
							if($scope.KeyWordList[i].orgLevel == 3){
								$scope.userInfo.orgLevel_show = 3;
							}
							if($scope.KeyWordList[i].orgLevel == 1){
								$scope.userInfo.orgLevel_show = 1;
							}
							break;
						}else{
							$scope.employeeEntity.code = $scope.employeeEntity.orgName;//没有就赋值名字为code相当于去查空（如中次）
							$scope.userInfo.orgLevel_show = 3;//2016.1.12 如果在修改输入文字的时候不等于局级的名字那一律按不显示复选框处理
							$scope.flagAdd_show = true;//添加按钮不能点
						}
					}
					
					$scope.KWList(rec.content);//字数超过9个后用...代替/
				}
			}
			function qErr(){}
			if(inputValue){
				entSvc.queryPartyInstallList({Action:'QueryEnts'},{
					orgCode:SYS_USER_INFO.orgCode,
					orgName:$scope.employeeEntity.orgName,
					pageNo:$scope.paginationConf.currentPage-1,
					pageSize:$scope.paginationConf.itemsPerPage
				},qSucc,qErr);
			}
		};
		
		
		/*
		*点击搜索下拉框定位显示在input
		*/
		$scope.searBean = {};
		$scope.InputShow = function(parm,searBean,infoTitleBean,LiNumA,level,id,changeOrgId,code,codeName){//点击的值，scope后的属性名，属性名后的属性名，LiNumA为显示下方的flag，level为组织级别，
		
			if(parm){
				$scope[searBean][infoTitleBean] = parm;/* 需要 */
				$scope[searBean][changeOrgId] = id;//保存被点选的单位的id备用
				$scope[searBean][codeName] = code;//$scope.employeeEntity.code
				if(level > 2){//如果选择的当前单位的级别高于2也就是是处级
					$scope.showLevel = false;//根据组织级别控制是否有显示下级的复选框，2以上为处级也就是没有下级不显示复选框
					//$scope.employeeEntity.isInclude = false;//复选框控制
				} 
				if(level < 3){//如果不是处级，也就是有下级企业
					$scope.showLevel = true;//显示包含下级单位复选框
				}
				$scope[LiNumA] = false;//隐藏点选后的下拉框
				$scope.userInfo.orgLevel_show=level;
				//$scope.queryPersonCopy(1,id); //根据目前选择的单位id查询对应的项目
				return;
			}
		};
		
		

	/*
	*多余字体用...代替
	*/
	$scope.KWList = function(val){
		for(var i=0;i<val.length;i++){
			if(val[i].name.length > 9){
				$scope.KeyWordList[i].infoTitleA = val[i].name.substring(0,9)+"...";
        	}else{
        		$scope.KeyWordList[i].infoTitleA = val[i].name;
        	}
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
			$scope.flagAdd_show = false;//当为空的时候离可点添加
			$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
			
			$scope.employeeEntity.code=SYS_USER_INFO.orgCode;
			$scope.employeeEntity.changeOrgId = SYS_USER_INFO.orgId;
			if(SYS_USER_INFO.orgLevel == 2){
				$scope.userInfo.orgLevel_show = 2;
			}          
			
			if(SYS_USER_INFO.orgLevel == 1){
				$scope.userInfo.orgLevel_show = 1;
			}
			
			if(SYS_USER_INFO.orgLevel == 3){
				$scope.userInfo.orgLevel_show = 3;
			}
			
		}
	};
	
	
	/**
	 * 将一个数字的整数部分加千分位符
	 */
	$scope.formatNumber=function(num)
	{
		if(num)
		{
			num=num+"";
			var hasPoint = num.indexOf(".");
			if(hasPoint>0)
			{
				var cents = num.substring(hasPoint, num.length);
				num = num.substring(0,hasPoint);
				num=$scope.addThousands(num);
				num=num+cents;
			}
			else
			{
				num=$scope.addThousands(num);
			}
		}
		return num;
	}

	/**
	 * 为一个整数添加千分位符
	 */
	$scope.addThousands=function(num)
	{
		if(num)
		{
			for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
			{
				num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3));
			}	
		}
		return num;
	}
	
	$scope.employers = [];
	$scope.employer = {};
	$scope.queryEmployer = {};
	$scope.check = true;	//	项目选项 显示标志
	$scope.queryEmployer.check = false;	//	项目选项值
	$scope.checkTrEmployer = true;	//	列名称 - 单位名称 显示标志
	$scope.checkTrProjects = false;	//	列名称 - 项目名称 显示标志

	/* 打开 选择所在单位/项目模态框 */
	$scope.openEmployerModel = function(){
		if($scope.employers.length==0){//	首次打开
			var orgLv;
			if(1==$scope.userInfo.orgLevel){
				orgLv = 9;
			}
			else if(2==$scope.userInfo.orgLevel){
				orgLv = 1;
			}
			else if(3==$scope.userInfo.orgLevel){
				orgLv = 2;
			}
			
			$scope.queryEmployer.currOrgId = $scope.userInfo.orgId;

			/** 放入单位信息，且查询该组织下的机构/项目 */
			$scope.employers = [{name: $scope.userInfo.orgName, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

			$scope.queryEmployer.pageNo = 0;
			$scope.queryEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;
			if(2==orgLv){
				$scope.checkTrProjects = true;
				$scope.checkTrEmployer = false;
				$scope.queryEmployer.check = true;
				$scope.check = false;

				/** 根据currOrgId，查询该组织下的项目 begin */
				function qSucc(rec){
					$scope.employerList = rec.content;
					$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
					$('#employerModel').modal('show');
				}
				function qErr(){
					
				}
				proSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
				/** 根据currOrgId，查询该组织下的项目 end */
				}
			else{
				$scope.checkTrProjects = false;
				$scope.checkTrEmployer = true;
				$scope.queryEmployer.check = false;
				$scope.check = true;

				/** 根据currOrgId，查询该组织下的机构 begin */
				function qSucc2(rec){
					$scope.employerList = rec.content;
					$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
					$('#employerModel').modal('show');
				}
				function qErr2(){
					
				}
				entSvc.queryPartyInstallList($scope.queryEmployer, qSucc2, qErr2);
				/** 根据currOrgId，查询该组织下的机构 end */
			}
		}
		else{//	非首次打开
			$('#employerModel').modal('show');
		}
	};

	/* 点击查询下级单位，且保存点击的机构信息 */
	$scope.clickEmployer = function(currentPage, orgInfo){
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
		$scope.employer = {};

		$scope.employer.name = orgInfo.name;
		$scope.employer.currOrgId = orgInfo.currOrgId;
		$scope.employer.orgFlag = orgLv;

		$scope.employers.push($scope.employer);

		$scope.queryEmployer.currOrgId = orgInfo.currOrgId;

		if(2==orgLv){/** 处级单位 */
			$scope.checkTrProjects = true;
			$scope.checkTrEmployer = false;
			$scope.queryEmployer.check = true;
			$scope.check = false;

			$scope.qryProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkTrProjects = false;
			$scope.checkTrEmployer = true;
			$scope.queryEmployer.check = false;
			$scope.check = true;

			$scope.qryEmployer();
		}
	};

	/* 点击项目，变更保存的项目信息 */
	$scope.clickProject = function(orgInfo){
		/** 变更保存点击的项目信息 */
		$scope.employer = {};

		$scope.employer.name = orgInfo.name;
		$scope.employer.currOrgId = orgInfo.currOrgId;
		$scope.employer.orgFlag = 3;

		var employersLength = $scope.employers.length;
		if(employersLength>0 && 3==$scope.employers[employersLength - 1].orgFlag){
			$scope.employers.splice(employersLength - 1, 1);
		}
		$scope.employers.push($scope.employer);
	};

	/* 点击当前位置的单位/项目，变更当前位置、单位/项目列表 */
	$scope.clickEmployers = function(currentPage, orgInfo, employersIndex){
		if(currentPage)
		{
			$scope.paginationConfOrgORProject.currentPage = currentPage;
		}

		/** 变更当前位置 */
		var employersLength = $scope.employers.length;
		if(employersLength<=0){
			return ;
		}

		$scope.employers.splice(employersIndex + 1, employersLength - employersIndex - 1);

		/** 保存点击的机构信息 */
		$scope.queryEmployer.currOrgId = orgInfo.currOrgId;

		var orgLv = $scope.employers[employersIndex].orgFlag;
		if(3==orgLv){/** 项目 */
			return ;
		}
		else if(2==orgLv){/** 处级单位 */
			$scope.checkTrProjects = true;
			$scope.checkTrEmployer = false;
			$scope.queryEmployer.check = true;
			$scope.check = false;

			$scope.qryProject();
		}
		else{/** 总公司/局级单位 */
			$scope.checkTrProjects = false;
			$scope.checkTrEmployer = true;
			$scope.queryEmployer.check = false;
			$scope.check = true;

			$scope.qryEmployer();
		}
	};

	/* 勾选项目，根据当前位置的最下级单位id，查询单位/项目列表 */
	$scope.clickProjects = function(currentPage) {
		if(currentPage)
		{
			$scope.paginationConfOrgORProject.currentPage = currentPage;
		}

		var employersLength = $scope.employers.length;
		if(employersLength<=0){
			return ;
		}

		if($scope.employers[employersLength - 1].orgFlag==3){
			return ;
		}

		$scope.queryEmployer.currOrgId = $scope.employers[employersLength - 1].currOrgId;

		if($scope.queryEmployer.check){
			$scope.checkTrProjects = true;
			$scope.checkTrEmployer = false;

			$scope.qryProject();
		}
		else{
			$scope.checkTrProjects = false;
			$scope.checkTrEmployer = true;

			$scope.qryEmployer();
		}
	};

	/* 根据currOrgId，查询该组织下的机构 */
	$scope.qryEmployer = function(){
		$scope.queryEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
		$scope.queryEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的机构 begin */
		function qSucc(rec){
			$scope.employerList = rec.content;
			$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
		}
		function qErr(){
			
		}
		entSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的机构 end */
	};

	/* 根据currOrgId，查询该组织下的项目 */
	$scope.qryProject = function(){
		$scope.queryEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
		$scope.queryEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

		/** 根据currOrgId，查询该组织下的项目 begin */
		function qSucc(rec){
			$scope.employerList = rec.content;
			$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
		}
		function qErr(){
			
		}
		proSvc.queryPartyInstallList($scope.queryEmployer, qSucc, qErr);
		/** 根据currOrgId，查询该组织下的项目 end */
	};

	/* 变更并关闭 选择单位/项目模态框 */
	$scope.modifyEmployerModel = function(val){
		$('#employerModel').modal('hide');

		var employersLength = $scope.employers.length;
		if(employersLength<=0){
			return ;
		}

		$scope.employer = $scope.employers[employersLength - 1];

		$scope.employeeEntity.orgFlag = $scope.employer.orgFlag;
		$scope.employeeEntity.orgPartyId = $scope.employer.currOrgId;
		$scope.employeeEntity.orgName = $scope.employer.name;
	};

	/* 取消并关闭 选择单位/项目模态框 */
	$scope.closeEmployerModel = function(){
		$('#employerModel').modal('hide');
	} 

	/* 资源管理列表查询分页标签参数配置 */
	$scope.paginationConfOrgORProject = {
		currentPage: 1,/** 当前页数 */
		totalItems: 1,/** 数据总数 */
		itemsPerPage: 10,/** 每页显示多少 */
		pagesLength: 10,/** 分页标签数量显示 */
		perPageOptions: [10, 20, 30, 40],
		onChange: function(currentPage){
			if($scope.queryEmployer.currOrgId){
				$scope.clickProjects(currentPage);
				}
		}
	};
});
