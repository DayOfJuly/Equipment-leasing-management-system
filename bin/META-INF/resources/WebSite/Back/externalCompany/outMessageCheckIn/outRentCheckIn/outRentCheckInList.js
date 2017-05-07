app.controller('outRentCheckInListController', function($scope,$timeout,SYS_CODE_CON,sysCodeTranslateFactory,RentHistOwnerSvc,entSvc) {
		
	    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
	    
	    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	    
	   
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
		$scope.employeeEntity.isInclude = false;
		
		
		$scope.showLevel = null;
		$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
		$scope.employeeEntity.orgName_ = SYS_USER_INFO.orgName;//因为没有排除orgName在哪里使用，所以创建了orgName_用于点击时传当前单位属性
		if($scope.employeeEntity.orgName.length > 20){
			$scope.employeeEntity.orgNameA  = $scope.employeeEntity.orgName.substring(0,20)+"...";
		}else{
			$scope.employeeEntity.orgNameA  = $scope.employeeEntity.orgName
		}
		$scope.employeeEntity.orgId_ = SYS_USER_INFO.orgId;
		$scope.employeeEntity.orgCode = SYS_USER_INFO.orgCode;
		
		if($scope.employeeEntity.orgName && SYS_USER_INFO.orgId < 3){//控制包含下级的显示，当有当前单位和组织级别小于3的时候展示包含下级单位
			$scope.showLevel = true;
		}else if(!$scope.employeeEntity.orgName || SYS_USER_INFO.orgId > 2){
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
				$scope.messList = rec.ownerRentInfos;
				for(var i=0;i<$scope.messList.length;i++){
					$scope.formatMoney('messList','rent',2,i);
					$scope.formatMoney('messList','amount',2,i);
					$scope.formatMoney('messList','cost',2,i);
					$scope.formatMoney('messList','deductCost',2,i);
				}
				$scope.showArrayList = $scope.messList;
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
			               if(rec.userRentInfos[r].note.length >10){
								$scope.userRentInfos[r].noteA = rec.userRentInfos[r].note.substring(0,10)+"...";
							}else{
								$scope.userRentInfos[r].noteA =  rec.userRentInfos[r].note;
							}
			           }
				}
				
				
				for(var i=0;i<$scope.showArrayList.length;i++){
					if($scope.showArrayList[i].depName!==null){
						if($scope.showArrayList[i].depName.length>5){
							$scope.showArrayList[i].depNameA = $scope.showArrayList[i].depName.substring(0,5)+"...";
						}else{
							$scope.showArrayList[i].depNameA = $scope.showArrayList[i].depName;
						}
					}
				}
				for(var i=0;i<$scope.showArrayList.length;i++){
					if($scope.showArrayList[i].startEndDate){
						if($scope.showArrayList[i].startEndDate.length>10){
							$scope.showArrayList[i].startEndDateA = $scope.showArrayList[i].startEndDate.substring(0,10)+"...";
						}else{
							$scope.showArrayList[i].startEndDateA = $scope.showArrayList[i].startEndDate;
						}
					}
				}
				for(var i=0;i<$scope.showArrayList.length;i++){
					if($scope.showArrayList[i].note){
						if($scope.showArrayList[i].note.length>10){
							$scope.showArrayList[i].noteA = $scope.showArrayList[i].note.substring(0,10)+"...";
						}else{
							$scope.showArrayList[i].noteA = $scope.showArrayList[i].note;
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
			function qSucc(rec){
				if(rec){
					$scope.queryAllList = rec.content;
					$scope.paginationConf.totalItems=rec.totalElements;
					for( var j=0;j<$scope.queryAllList.length;j++)
					{
						$scope.queryAllList[j].amountTemp=$scope.formatNumber($scope.queryAllList[j].amount);
						$scope.queryAllList[j].costTemp=$scope.formatNumber($scope.queryAllList[j].cost);
						$scope.queryAllList[j].deductCostTemp=$scope.formatNumber($scope.queryAllList[j].deductCost);
						if($scope.queryAllList[j].equNo){
							if($scope.queryAllList[j].equNo.length > 10){
								$scope.queryAllList[j].equNoA = $scope.queryAllList[j].equNo.substring(0,10)+"...";
							}else{
								$scope.queryAllList[j].equNoA = $scope.queryAllList[j].equNo;
							}
						}
						if($scope.queryAllList[j].asset){
							if($scope.queryAllList[j].asset.length > 10){
								$scope.queryAllList[j].assetA = $scope.queryAllList[j].asset.substring(0,10)+"...";
							}else{
								$scope.queryAllList[j].assetA = $scope.queryAllList[j].asset;
							}
						}
						if($scope.queryAllList[j].equipmentName){
							if($scope.queryAllList[j].equipmentName.length > 5){
								$scope.queryAllList[j].equipmentNameA = $scope.queryAllList[j].equipmentName.substring(0,5)+"...";
							}else{
								$scope.queryAllList[j].equipmentNameA = $scope.queryAllList[j].equipmentName;
							}
						}
						if($scope.queryAllList[j].brandName){
							if($scope.queryAllList[j].brandName.length > 5){
								$scope.queryAllList[j].brandNameA = $scope.queryAllList[j].brandName.substring(0,5)+"...";
							}else{
								$scope.queryAllList[j].brandNameA = $scope.queryAllList[j].brandName;
							}
						}
						
					}
				}
				
				if(rec.content==null){
					$.messager.popup("没有符合条件的记录");
	    			$scope.reveal = false;
				}else{
					$scope.reveal = true;
				}
				
			};
		
			function qErr(){};
			
			if(!$scope.queryData.endDate){
				var nowDate=new Date();
				year=nowDate.getFullYear();
				month=nowDate.getMonth()+1;
				month1=nowDate.getMonth()+3;
				if(month<10){
					month="0"+month;
				}
			    var strDate=year+"-"+month1;//+"-"+day
			    var endDate=year+"-"+month;
			    $scope.queryData.endDate = endDate;
			    $('#endDateId').datetimepicker('setEndDate', strDate);
			}
			RentHistOwnerSvc.post({
				pageNo:$scope.paginationConf.currentPage - 1,
				pageSize:$scope.paginationConf.itemsPerPage,
				isProvider:1,
				month:$scope.queryData.endDate
			},qSucc,qErr);
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
					}
					$scope.num = $scope.messList.length;
					$scope.copyView = rec.viewEquInfo;//这是其他查询出的数据暂时可能用不到
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
				               if(rec.userRentInfos[j].note.length >10){
									$scope.userRentInfos[j].noteA = rec.userRentInfos[j].note.substring(0,10)+"...";
								}else{
									$scope.userRentInfos[j].noteA =  rec.userRentInfos[j].note;
								}
				           }
					}
					
					$("#DeviceAddId").modal({backdrop: 'static', keyboard: false});
					if(rec.ownerRentInfos==""){
						$scope.add = 'true';
					}
				}
				
				function qErr(){};
				
				
				RentHistOwnerSvc.unifydo({
					equipmentId:$scope.trValues.equipmentId,
					month:$scope.queryData.endDate,
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
					if($scope.messList[i].cost && $scope.messList[i].cost.indexOf(",") && $scope.messList[i].cost.indexOf(",") > 0){
						$scope.messList[i].cost=$scope.messList[i].cost.toString().replace(/\,/g,'');
					}
				}
				for(var i=0;i<$scope.messList.length;i++){
					if($scope.messList[i].deductCost && $scope.messList[i].deductCost.indexOf(",") && $scope.messList[i].deductCost.indexOf(",") > 0){
						$scope.messList[i].deductCost=$scope.messList[i].deductCost.toString().replace(/\,/g,'');
					}
				}
					
				for(var j=0;j<$scope.messList.length;j++){
					
					$scope.messList[j].equAtOrgName  = $scope.equAtOrgName;
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
			if(!$scope.checkIndex || $scope.checkIndex == null){
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
			if($scope.num==1){
				$scope.messList[0].rentType = "1";
			}
			
			for(var i=1;i<$scope.messList.length;i++){
				if($scope.num=i){
					$scope.messList[i].rentType = "1";
				}
				
			}
			$scope.add = '';
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
		$scope.queryAllMess();
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
		    /* $scope.flagEnd = false; */ /* 清空叉号 */
		    $scope.queryData.endDate = null; /* 清空日期控件值 */
		    document.getElementById("endDateId").focus(); /* 光标定位回日期控件 */
		};

		
		$scope.cleanRadio = function(){
			if($scope.checkIndex){
			$scope.checkIndex.place = null;
			}
		}
		
		/**
		 * 每三位数字添加一个逗号分隔符号
		 */

		$scope.centsCopyFive = '';
		$scope.formatMoney=function(list_,obj_,counts,this_){//参数分别是：num=输入值，parm=属性,flag=区分添加和修改的符号，counts=小数点最多几位
			
				
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
					
					if(centsCopy.length>counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
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
		$scope.formatMoneyNum=function(list_,obj_,counts,this_){		
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
				
				if(centsCopy.length>counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
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
			/*for (var i = 0; i < Math.floor(($scope[list_][this_][obj_].length-(1+i))/3); i++){
				$scope[list_][this_][obj_] = $scope[list_][this_][obj_].substring(0,$scope[list_][this_][obj_].length-(4*i+3))+','+$scope[list_][this_][obj_].substring($scope[list_][this_][obj_].length-(4*i+3));
			}*/
			//如果有小数点算上小数点赋值
			if(cents.length!=0){
				$scope[list_][this_][obj_] = $scope[list_][this_][obj_]+cents;
			}else{
				$scope[list_][this_][obj_] = $scope[list_][this_][obj_];
			}
		
	};
		
		
		/**
		 * 模态框里面的点击一行方法
		 */
		$scope.checkLine = function(this_){
			
			$scope.checkIndex = {};
			if(this_){
				$scope.checkIndex.place = this_.$index;//位置
				$scope.checkIndex.value_ = this_.mess;//值
			}
			$scope.add = '';
			
		};
		$scope.checkLine2 = function(this_){
				
				$scope.checkIndex2 = {};
				if(this_){
					$scope.checkIndex2.place2 = this_.$index;//位置
					$scope.checkIndex2.value_ = this_.mess;//值
				}
				
				$scope.add = 'true';
			};
		
		/*
		*多余字体用...代替
		*/
		$scope.KWList = function(val){
			for(var i=0;i<val.length;i++){
				if(val[i].name.length > 9){
					$scope.KeyWordList[i].infoTitleA = val[i].name.substring(0,7)+"...";
	        	}else{
	        		$scope.KeyWordList[i].infoTitleA = val[i].name;
	        	}
			}
		};
		
		/**
		 * 将一个数字的整数部分加千分位符
		 */
		$scope.formatNumber=function(num){
			if(num){
				num=num+"";
				var hasPoint = num.indexOf(".");
				if(hasPoint>0){
					var cents = num.substring(hasPoint, num.length);
					num = num.substring(0,hasPoint);
					num=$scope.addThousands(num);
					num=num+cents;
				}else{
					num=$scope.addThousands(num);
				}
			}
			return num;
		}

		/**
		 * 为一个整数添加千分位符
		 */
		$scope.addThousands=function(num){
			if(num){
				for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++){
					num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3));
				}	
			}
			return num;
		};
		
	});
