app.controller('outDepreciationCostListController', function($scope,$timeout,published,depreciationHist,entSvc) {
			
				/**
			     *cookies
			     */
			    $scope.userInfo = {};
			    $scope.userInfo.orgCode=SYS_USER_INFO.orgCode;
			    $scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
			    $scope.userInfo.orgId=SYS_USER_INFO.orgId;
			    $scope.userInfo.orgName = SYS_USER_INFO.orgName;
			    
			    $scope.orgId = $scope.userInfo.orgId;
				$scope.orgCode = $scope.userInfo.orgCode;
				$scope.orgName = $scope.userInfo.orgName;
				$scope.orgLevel = $scope.userInfo.orgLevel;

				$scope.employeeEntity= {};
				
				$scope.employeeEntity = {'equipmentPic': ''};//声明图片初始路径
				$scope.employeeEntity.isInclude = false;
				$scope.showLevel = null;
				$scope.employeeEntity.orgName = SYS_USER_INFO.orgName;
				if($scope.employeeEntity.orgName.length>20){
					$scope.employeeEntity.orgNameA  = $scope.employeeEntity.orgName.substring(0,20)+"...";
				}else{
					$scope.employeeEntity.orgNameA  = $scope.employeeEntity.orgName
				}
				$scope.employeeEntity.orgName_ = SYS_USER_INFO.orgName;//因为没有排除orgName在哪里使用，所以创建了orgName_用于点击时传当前单位属性
				$scope.employeeEntity.orgId_ = SYS_USER_INFO.orgId;
				$scope.employeeEntity.orgCode = SYS_USER_INFO.orgCode;
				if($scope.employeeEntity.orgName && $scope.orgLevel < 3){//控制包含下级的显示，当有当前单位和组织级别小于3的时候展示包含下级单位
					$scope.showLevel = true;
				}else if(!$scope.employeeEntity.orgName || $scope.orgLevel > 2){
					$scope.showLevel = false;
				}
				
			
			/**
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
		        onChange:function(parm1){
		        	$scope.paginationConf.currentPage=parm1;
		        	if($scope.criteriaVal == 1){
		        		$scope.criteriaQueryDepreciationHist();
		        		//alert(1);
		        	}else{
		        		$scope.queryDepreciationHist();
		        		//alert(2);
		        	}
		        	$scope.radioTrIndex=null;
		        	 $scope.save = false;
		        }
			      
		    };
			
			$scope.check = function(params,varl){
				$scope.radioTrIndex=varl;
			};
			
			/**
			 *查询折旧费登记列表信息
			 */
			$scope.depreactionList=[];
		    $scope.queryDepreciationHist = function(){
		    	if($scope.queryData.endDate){
					var str=$scope.queryData.endDate.toString().substring(0, 7);
				}
		    	function qSucc(rec){
		    		$scope.depreactionList=rec.content;
		    		
		    		if(rec.content==null){
		    			$scope.reveal = false;
		    		}else{
		    			$scope.reveal = true;
		    		}
		    		$scope.paginationConf.totalItems=rec.totalElements;
		    		if(rec.content!=null){
		    		$scope.num=$scope.depreactionList.length;
		    		
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].asset!==null){
							if($scope.depreactionList[i].asset.length>10){
								$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset.substring(0,10)+"...";
							}else{
								$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset;
							}
						}
					}
		    		
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].equNo!==null){
							if($scope.depreactionList[i].equNo.length>10){
								$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo.substring(0,10)+"...";
							}else{
								$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo;
							}
						}
					}
		    		
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].equipmentName!==null){
							if($scope.depreactionList[i].equipmentName.length>7){
								$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName.substring(0,7)+"...";
							}else{
								$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName;
							}
						}
					}
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].brandName!==null){
							if($scope.depreactionList[i].brandName.length>5){
								$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName.substring(0,5)+"...";
							}else{
								$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName;
							}
						}
					}
		    		
		    		
					for(var i=0;i<$scope.depreactionList.length;i++){
						$scope.formatMoney('depreactionList','depreciation',2,i);
						$scope.depreactionList[i].depreciation = $scope.depreactionList[i].depreciation;
					}
		    		}
		    	}
		    	function qErr(){}
		    	depreciationHist.post({Action:"Provider"},{
		    		pageNo:$scope.paginationConf.currentPage-1,
					pageSize:$scope.paginationConf.itemsPerPage,
					month:str,
		    	},qSucc,qErr);
		    };
			
			/**
			 * 条件查询折旧费登记列表信息
			 */
		    $scope.criteriaList={};
		    $scope.criteriaVal=0;
		    $scope. criteriaQueryDepreciationHist = function(pageNo){
		    	$scope.criteriaVal=1;
		    	if($scope.queryData.endDate){
					var str=$scope.queryData.endDate.toString().substring(0, 7);
				}
		    	function qSucc(rec){
		    		if(pageNo == 1){
		    			$scope.paginationConf.currentPage=1;
		    		}
		    		$scope.depreactionList=rec.content;
		    		
		    		if(rec.content==null){
		    			$scope.reveal = false;
		    		}else{
		    			$scope.reveal = true;
		    		}
		    		
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].asset!==null){
							if($scope.depreactionList[i].asset.length>10){
								$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset.substring(0,10)+"...";
							}else{
								$scope.depreactionList[i].assetA = $scope.depreactionList[i].asset;
							}
						}
					}
		    		
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].equNo!==null){
							if($scope.depreactionList[i].equNo.length>10){
								$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo.substring(0,10)+"...";
							}else{
								$scope.depreactionList[i].equNoA = $scope.depreactionList[i].equNo;
							}
						}
					}
		    		
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].equipmentName!==null){
							if($scope.depreactionList[i].equipmentName.length>7){
								$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName.substring(0,7)+"...";
							}else{
								$scope.depreactionList[i].equipmentNameA = $scope.depreactionList[i].equipmentName;
							}
						}
					}
		    		for(var i=0;i<$scope.depreactionList.length;i++){
						if($scope.depreactionList[i].brandName!==null){
							if($scope.depreactionList[i].brandName.length>7){
								$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName.substring(0,7)+"...";
							}else{
								$scope.depreactionList[i].brandNameA = $scope.depreactionList[i].brandName;
							}
						}
					}
		    		
		    		
		    		for(var i=0;i<$scope.depreactionList.length;i++){
	    				$scope.formatMoney('depreactionList','depreciation',2,i);
	    				$scope.depreactionList[i].depreciation = $scope.depreactionList[i].depreciation;
	    			}
		    		
		    		$scope.paginationConf.totalItems=rec.totalElements;
		    	}
		    	function qErr(){}
		    	
		    	depreciationHist.post({Action:"Provider"},{
		    		pageNo:$scope.paginationConf.currentPage-1,
					pageSize:$scope.paginationConf.itemsPerPage,
					month:str,
		    	},qSucc,qErr);
		    };
		    
		    
		    /**
		     * 保存按钮事件
		     */
			$scope.saveClick=function(save){
				$scope.save = true;
				if($scope.queryData.endDate){
					var str=$scope.queryData.endDate.toString().substring(0, 7);
				}

				function qSucc(rec){
					$scope.save = false;
					$.messager.popup(rec.msg);
					str="";					//登记月份
					$scope.queryDepreciationHist();
			}
				function qErr(){
					
					$scope.save = false;
				};
				
				for(var i=0;i<$scope.depreactionList.length;i++){
					if($scope.depreactionList[i].depreciation && $scope.depreactionList[i].depreciation.indexOf(",") && $scope.depreactionList[i].depreciation.indexOf(",") > 0){
						$scope.depreactionList[i].depreciation=$scope.depreactionList[i].depreciation.toString().replace(/\,/g,'');
					}
				}
				depreciationHist.post({Action:"AddOrUpd"},{
					bdhbtList:$scope.depreactionList,
					month_:str
				},qSucc,qErr);
				
			};
			$scope.param={};	
			/**
			 * 获取当前日期的字符串表示形式
			 */
			$scope.queryData={};
			$scope.getNowDateStr=function()
			{
				var nowDate=new Date();
				year=nowDate.getFullYear();
				month = nowDate.getMonth()+1;
				month1=nowDate.getMonth()+3;
				//day=nowDate.getDate();
				if(month<10){
					month="0"+month;
				}
				/*if(day<10){
					day="0"+day;
				}*/
			    var strDate=year+"-"+month1;//+"-"+day
			    var endDate = year+"-"+month;
			    $scope.queryData.endDate = endDate;
			    $('#endDateId').datetimepicker('setEndDate', strDate);
			    //$scope.param = {date:strDate};
			}
			$("button").focus(function(){this.blur()});	
			
			
			$scope.flagEnd = true; /* 叉号显示初始值赋值 */
			
			
			$scope.openAdd = function(){
				$("#depreciationAddId").modal({backdrop: 'static', keyboard: false});
			};
			
			
			$scope.openUpd = function(){
				$("#depreciationUpdId").modal({backdrop: 'static', keyboard: false});
			};
			
			$scope.openQuery = function(){
				$("#depreciationQueryId").modal({backdrop: 'static', keyboard: false});
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
			 * 每三位数字添加一个逗号分隔符号
			 */

			$scope.centsCopyFive = '';
			$scope.formatMoney=function(list_,obj2_,counts,this_){//参数分别是：num=输入值，parm=属性,flag=区分添加和修改的符号，counts=小数点最多几位
					$scope.numsArray_ = [];
				
				
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
					var judge = $scope[list_][this_][obj2_].indexOf(".");
					var cents='';//包括小数点之后
					var centsCopy =0;//不包括小数点之后
					
					//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
					if(judge>0){
						cents = $scope[list_][this_][obj2_].substring(judge, $scope[list_][this_][obj2_].length);//包括点开始截取到完结
						centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
						$scope[list_][this_][obj2_] = $scope[list_][this_][obj2_].substring(0,judge);//截取（不包括点）点之前的数字
						
						if(centsCopy.length == counts){//当小数点后面的位数达到软需要求时记录数值,counts是方法传入的参数也就是要求小数点最多几位
							$scope.centsCopyFive = centsCopy;//$scope.centsCopyFive为一个记录对象，记录当满足小数点要求时，这个时候小数点后的数字是什么，用于下面的赋值
						}
						
						if(centsCopy.length> counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
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
		});
