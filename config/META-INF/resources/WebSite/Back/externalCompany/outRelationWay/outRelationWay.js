  app.controller('outRelationWayController', function ($scope,SYS_CODE_CON,sysCodeTranslateFactory,regionSvc,partyConTactSvc,personOutSvc) {
	  
	    $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
	    
	    $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
	   
	    $scope.sysUserInfo = {};
	    $scope.sysUserInfo = SYS_USER_INFO;
	    
	    
	    $scope.userInfo = {};
	    $scope.userInfo.orgId=SYS_USER_INFO.orgId;
	    $scope.userInfo.orgCode=SYS_USER_INFO.orgCode;
	    $scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
	    $scope.userInfo.orgName=SYS_USER_INFO.orgName;
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
	        	$scope.formParms = {};
	        	$scope.queryAll();
	        	
	        	function aSucc(rec){
	    			$scope.areaList=[];
	    			$scope.areaList=rec;
	    		}
	    		function aErr(rec){}
	    		regionSvc.queryRegionArea({}, aSucc,aErr);
	        }
	    };
        
		/**
		 * 查询所有信息
		 */
		$scope.queryAllList = {};
		$scope.queryAll = function(pageNo){
			if(pageNo)
			{
				$scope.paginationConf.currentPage=1;
			} 
			
			function qSucc(rec){
				$scope.queryAllList = rec.content;
				for(var i = 0;i<$scope.queryAllList.length;i++){
					$scope.queryAllList[i].partyName_Copy = $scope.queryAllList[i].partyName;
					if($scope.queryAllList[i].partyName.length > 12){
						$scope.queryAllList[i].partyName_Copy = $scope.queryAllList[i].partyName_Copy.substring(0,12)+'...';
					}
					
					$scope.queryAllList[i].onProvince_Copy = $scope.queryAllList[i].onProvince;
					if($scope.queryAllList[i].onProvince.length > 4){
						$scope.queryAllList[i].onProvince_Copy = $scope.queryAllList[i].onProvince_Copy.substring(0,4)+'...';
					}
					
					$scope.queryAllList[i].onCity_Copy = $scope.queryAllList[i].onCity;
					if($scope.queryAllList[i].onCity.length > 4){
						$scope.queryAllList[i].onCity_Copy = $scope.queryAllList[i].onCity_Copy.substring(0,4)+'...';
					}
					
					$scope.queryAllList[i].onDistrict_Copy = $scope.queryAllList[i].onDistrict;
					if($scope.queryAllList[i].onDistrict.length > 4){
						$scope.queryAllList[i].onDistrict_Copy = $scope.queryAllList[i].onDistrict_Copy.substring(0,4)+'...';
					}
					
					$scope.queryAllList[i].address_Copy = $scope.queryAllList[i].address;
					if($scope.queryAllList[i].address && $scope.queryAllList[i].address.length > 12){
						$scope.queryAllList[i].address_Copy = $scope.queryAllList[i].address_Copy.substring(0,12)+'...';
					}
					
					$scope.queryAllList[i].name_Copy = $scope.queryAllList[i].name;
					if($scope.queryAllList[i].name.length > 4){
						$scope.queryAllList[i].name_Copy = $scope.queryAllList[i].name_Copy.substring(0,4)+'...';
					}
					
					$scope.queryAllList[i].tel_Copy = $scope.queryAllList[i].tel;
					if($scope.queryAllList[i].tel.length > 4){
						$scope.queryAllList[i].tel_Copy = $scope.queryAllList[i].tel_Copy.substring(0,4)+'...';
					}
					
					$scope.queryAllList[i].qq_Copy = $scope.queryAllList[i].qq;
					if($scope.queryAllList[i].qq && $scope.queryAllList[i].qq.length > 4){
						$scope.queryAllList[i].qq_Copy = $scope.queryAllList[i].qq_Copy.substring(0,4)+'...';
					}
				}
				$scope.paginationConf.totalItems = rec.totalElements;
			};
			
			function qErr(){};
			
			partyConTactSvc.post({currOrgId:SYS_USER_INFO.orgId,pageNo:$scope.paginationConf.currentPage-1,pageSize:$scope.paginationConf.itemsPerPage},qSucc,qErr);
		};
		
		/**
		 * 回显外部员工信息
		 */
		$scope.returnPeoMsg = function(){
		
				function qSucc(rec){
					
					$scope.formParms = {};
					$scope.formParms.tel=rec.mobile;
					$scope.formParms.qq=rec.qq;
					$scope.formParms.name=rec.name;
				};
			
				function qErr(){};
			
				personOutSvc.queryPerson({id:SYS_USER_INFO.perPartyId},qSucc,qErr);
			
		};
		
		
		/**
		 * 打开添加模态框
		 */
		$scope.openAddModal = function(){
			$scope.showFlag = {};
			
			
			$scope.recPro={};
			$scope.recCit={};
			$scope.recDis={};
			
			$scope.cList=[];//省市区初始化
			$scope.pList=[];
			$scope.district="";
			setTimeout(function(){
				$('#city')[0].selectedIndex = $('#city option').length-1;
				$('#district')[0].selectedIndex = $('#district option').length-1;
			},500);
			
			
			$scope.btnValue = {};
			$scope.btnValue.name = "保存";
			$scope.titleMsg = "联系方式维护";
			$scope.returnPeoMsg();//回显外部员工信息用
			
	        
			
			$("#outRelationWayAdd").modal({backdrop: 'static', keyboard: false});
		};
		
		/**
		 * 保存方法
		 */
		$scope.add = function(obj){
			if(!obj.$valid){
				if(!obj.unitName.$valid){
					$scope.showFlag = 'unitName';//联系单位
					return;
				}
				if(!obj.SelectProvince.$valid){
					$scope.showFlag = 'SelectProvince';//设备所在省份
					return;
				}
				if(!obj.SelectCity.$valid){
					$scope.showFlag = 'SelectCity';//设备所在城市
					return;
				}
				if(!obj.SelectCounty.$valid){
					$scope.showFlag = 'SelectCounty';//设备所在区县
					return;
				}
		/*		if(!obj.SelectProvince.$valid){
					$scope.showFlag = 'SelectProvince';//设备所在省份
					return;
				}
				if(!obj.SelectCity.$valid){
					$scope.showFlag = 'SelectCity';//设备所在城市
					return;
				}
				if(!obj.SelectCounty.$valid){
					$scope.showFlag = 'SelectCounty';//设备所在区县
					return;
				}*/
				if(!obj.contactPerson.$valid){
					$scope.showFlag = 'contactPerson';//联系人
					return;
				}
				if(!obj.tel.$valid){
					$scope.showFlag = 'tel';//联系电话
					return;
				}
				if(!obj.qqNo.$valid){
					$scope.showFlag = 'qqNo';//qq
					return;
			    }
			}else{
				if($scope.formParms.flag_ == true){
					$scope.formParms.defConFlag = 1;//勾了就是传1
				}else{
					$scope.formParms.defConFlag = 0;
				}
				
				//$scope.formParms.atCity=$scope.formParms.disName_;
				$scope.formParms.onProvince = $scope.recPro.proModel;
				if($scope.formParms.onProvince){
					for(var i=0;i<$scope.areaList.length;i++){
						var tmpProvince = $scope.areaList[i];
						if(tmpProvince.name==$scope.formParms.onProvince){
							$scope.formParms.onProvinceId = tmpProvince.regionId;
							break;
						}
					}
				}
				$scope.formParms.onCity = $scope.recCit.recModel;
				if($scope.formParms.onCity){
					for(var i=0;i<$scope.pList.length;i++){
						var tmpProvince = $scope.pList[i];
						if(tmpProvince.name==$scope.formParms.onCity){
							$scope.formParms.onCityId = tmpProvince.regionId;
							break;
						}
					}
				}
				$scope.formParms.onDistrict = $scope.recDis.disModel;
				if($scope.formParms.onDistrict){
					for(var i=0;i<$scope.cList.length;i++){
						var tmpProvince = $scope.cList[i];
						if(tmpProvince.name==$scope.formParms.onDistrict){
							$scope.formParms.onDistrictId = tmpProvince.regionId;
							break;
						}
					}
				}

				$scope.formParms.partyId = SYS_USER_INFO.orgId;
				function qSucc(rec){
					$.messager.popup(rec.msg);
					$("#outRelationWayAdd").modal('hide');
					$scope.queryAll(1);
				};
				
				function qErr(){};
				partyConTactSvc.put($scope.formParms,qSucc,qErr);
			}
		};
		
		/**
		 * 打开修改模态框
		 */
		 $scope.openUpdModal = function(){
			 
			if(!$scope.selectequip){
				 $.messager.popup("请选择一条信息");
				 return;
			}
			
			$scope.recPro={};
			$scope.recCit={};
			$scope.recDis={};
			
			$scope.titleMsg = "联系方式维护";
			$scope.showFlag = "";
			$scope.btnValue = {};
			$scope.btnValue.name = "修改";
			
			function qSucc(rec){
				$scope.formParms = {};
				$scope.formParms = rec.contactInfo; 
				if(rec.contactInfo.defConFlag == 1){
					$scope.formParms.flag_ = true;
				}else{
					$scope.formParms.flag_ = false;
				}
				//$scope.requesRegionAt($scope.formParms.atCity);
				//$scope.queryCityFun(rec);
				
				/*弹出修改模态框 根据省中文查出省id，然后依次查询出市数据源和区数据源*/
				/*查询省市区数据源 start*/
				var provinceId="";
				var cityId="";
				var cityNum=0;
				var districtNum=0;
				
				//拿省的数组遍历
				for(var i=0;i<$scope.areaList.length;i++){
					var tmpProvince=$scope.areaList[i];
					if(tmpProvince.name==rec.contactInfo.onProvince){//如果省数组中有查询回的省
						provinceId=tmpProvince.regionId;//这里拿到对应的省的id
						provinceNum=i;//这个不知道后面干嘛用的，猜测是记录第几条用的
						break;
					}
					
				}
				//调用查询行政地区的方法，把刚才拿到的省的id传进去
				regionSvc.queryRegionArea(
					{regionId:provinceId},
					function qCitySucc(recProvince){
						$scope.pList=[];
						$scope.pList=recProvince;
						for(var i=0;i<$scope.pList.length;i++){//拿查出的市的集合遍历
							var tmpCity=$scope.pList[i];
							if(tmpCity.name==rec.contactInfo.onCity){//如果有对应的市
								cityId=tmpCity.regionId;//拿到对应市的id
								cityNum=i;
								break;
							}
						}
						regionSvc.queryRegionArea(//同上
							{regionId:cityId},
							function qSucc(recCity){
								$scope.cList=[];
								$scope.cList=recCity;
								for(var i=0;i<$scope.cList.length;i++){
									var tmpDistrict=$scope.cList[i];
									if(tmpDistrict.name==rec.contactInfo.onDistrict){
										districtNum=i;
										break;
									}
								}
								/*$scope.pList=[{name:rec.onCity}];
								$scope.cList=[{name:rec.onDistrict}];*/
								
								//对应的省市区赋值给修改页面对应的model用于下拉框回显对应的值
								$scope.recPro.proModel=$scope.formParms.onProvince;
								$scope.recCit.recModel=$scope.formParms.onCity;
								$scope.recDis.disModel=$scope.formParms.onDistrict;
								
								setTimeout(function(){
									cityNum=Math.abs($('#city option').length*1-$scope.pList.length*1)+cityNum*1;//得到城市数组中对应的城市位置
									districtNum=Math.abs($('#district option').length*1-$scope.cList.length*1)+districtNum*1;
									$('#city')[0].selectedIndex = cityNum;
									$('#district')[0].selectedIndex = districtNum;
								},500);
								$("#outRelationWayAdd").modal({backdrop: 'static', keyboard: false});
							},
							function(recCity){}
						);
					},
					function(recProvince){}
				);
				/*查询省市区数据源 end*/
				
				
	/*			var pId = '';
				var cId = '';
				var cityNum = 0;
				var districtNum = 0;
				
				for(var i=0;i<$scope.areaList.length;i++){
					if($scope.areaList[i].name == rec.contactInfo.onProvince){
						pId = $scope.areaList[i].regionId;
						break;
					}
				}
				
				regionSvc.queryRegionArea({regionId:pId},function qSuccy(recProvince){
					$scope.pList=[];
					$scope.pList=recProvince;
					for(var i =0;i<$scope.pList.length;i++){
						if($scope.pList[i].name == rec.contactInfo.onCity){
							cId = $scope.pList[i].regionId;
							cityNum = i;
							break;
						}
					}
					regionSvc.queryRegionArea({regionId:cId},function qSuccs(recCity){
						$scope.cList=[];
						$scope.cList=recCity;
						
						for(var i =0;i<$scope.cList.length;i++){
							if($scope.cList[i].name == rec.contactInfo.onCity){
								districtNum = i;
								break;
							}
						}
						
						$scope.formParms.proName_=rec.contactInfo.onProvince;
						$scope.formParms.citName_=rec.contactInfo.onCity;
						$scope.formParms.disName_=rec.contactInfo.onDistrict;
						
						$scope.recPro.proModel=$scope.formParms.onProvince;
						$scope.recCit.recModel=$scope.formParms.onCity;
						$scope.recDis.disModel=$scope.formParms.onDistrict;
						
						setTimeout(function(){
							cityNum=Math.abs($('#city option').length*1-$scope.pList.length*1)+cityNum*1;//得到城市数组中对应的城市位置
							districtNum=Math.abs($('#district option').length*1-$scope.cList.length*1)+districtNum*1;
							$('#city')[0].selectedIndex = cityNum;
							$('#district')[0].selectedIndex = districtNum;
						},500);
						
						$("#outRelationWayAdd").modal({backdrop: 'static', keyboard: false});
					},function qErrs(){});
				},function qErry(){});*/
			};
			
			function qErr(){};
			
			partyConTactSvc.unifydo({urlPath:$scope.selectId_},qSucc,qErr);
		
			
			
		};
			/**
			 * 查询省市区回显
			 */
			$scope.queryCityFun = function(rec){
			
			
				
			var pId = '';
			var cId = '';
			
			for(var i=0;i<$scope.areaList.length;i++){
				if($scope.areaList[i].name == rec.onProvince){
					pId = $scope.areaList[i].regionId;
					break;
				}
			}
			
			regionSvc.queryRegionArea({regionId:pId},function qSuccy(recProvince){
				$scope.pList=[];
				$scope.pList=recProvince;
				for(var i =0;i<$scope.pList.length;i++){
					if($scope.pList[i].name == rec.onCity){
						cId = $scope.pList[i].regionId;
						break;
					}
				}
			
			},function qErry(){});
			
			
			regionSvc.queryRegionArea({regionId:cId},function qSuccs(recCity){
				$scope.cList=[];
				$scope.cList=recCity;
				for(var i =0;i<$scope.cList.length;i++){
					if($scope.cList[i].name == rec.onDistrict){
						break;
					}
				}
				$scope.formParms.proName_=rec.onProvince;
				$scope.formParms.citName_=rec.onCity;
				$scope.formParms.disName_=rec.onDistrict;
			},function qErrs(){});
			
		};
		
		
		
		/**
		 * 修改
		 */
		$scope.upd = function(obj){
			if(!obj.$valid){
				if(!obj.unitName.$valid){
					$scope.showFlag = 'unitName';//联系单位
					return;
				}
				if(!obj.SelectProvince.$valid){
					$scope.showFlag = 'SelectProvince';//设备所在省份
					return;
				}
				if(!obj.SelectCity.$valid){
					$scope.showFlag = 'SelectCity';//设备所在城市
					return;
				}
				if(!obj.SelectCounty.$valid){
					$scope.showFlag = 'SelectCounty';//设备所在区县
					return;
				}
				if(!obj.contactPerson.$valid){
					$scope.showFlag = 'contactPerson';//联系人
					return;
				}
				if(!obj.tel.$valid){
					$scope.showFlag = 'tel';//联系电话
					return;
				}
				if(!obj.qqNo.$valid){
					$scope.showFlag = 'qqNo';//qq
					return;
			    }
			}else{
				if($scope.formParms.flag_ == true){
					$scope.formParms.defConFlag = 1;//勾了就是传1
				}else{
					$scope.formParms.defConFlag = 0;
				}
				
				//$scope.formParms.atCity=$scope.formParms.disName_;
				$scope.formParms.onProvince = $scope.recPro.proModel;
				if($scope.formParms.onProvince){
					for(var i=0;i<$scope.areaList.length;i++){
						var tmpProvince = $scope.areaList[i];
						if(tmpProvince.name==$scope.formParms.onProvince){
							$scope.formParms.onProvinceId = tmpProvince.regionId;
							break;
						}
					}
				}
				$scope.formParms.onCity = $scope.recCit.recModel;
				if($scope.formParms.onCity){
					for(var i=0;i<$scope.pList.length;i++){
						var tmpProvince = $scope.pList[i];
						if(tmpProvince.name==$scope.formParms.onCity){
							$scope.formParms.onCityId = tmpProvince.regionId;
							break;
						}
					}
				}
				$scope.formParms.onDistrict = $scope.recDis.disModel;
				if($scope.formParms.onDistrict){
					for(var i=0;i<$scope.cList.length;i++){
						var tmpProvince = $scope.cList[i];
						if(tmpProvince.name==$scope.formParms.onDistrict){
							$scope.formParms.onDistrictId = tmpProvince.regionId;
							break;
						}
					}
				}

				$scope.formParms.partyId = SYS_USER_INFO.orgId;
				function qSucc(rec){
					$.messager.popup(rec.msg);
					$("#outRelationWayAdd").modal('hide');
					$scope.queryAll(1);
					//window.location.reload();
				};
				
				function qErr(){};
				
				partyConTactSvc.post({urlPath:$scope.selectId_},$scope.formParms,qSucc,qErr);
			}
		
			
		};
		
		/**
		 * 删除
		 */
		
		$scope.openDelModal = function(){
			
			if(!$scope.selectId_){
				$.messager.popup('请选择一条数据');
				return;
			}
			
			$.messager.confirm("提示", "是否删除？", function() { 	
			function qSucc(rec){
				$.messager.popup(rec.msg);
				$scope.queryAll(1);
				$scope.selectequip = '';
				$scope.selectFlag = null;
				$scope.selectId_='';
			};
			
			function qErr(){};
			
			partyConTactSvc.del({urlPath:$scope.selectId_},qSucc,qErr);
			});
		};
		
		
		/*
		 *省份
		
		$scope.province="";//省份标识名
		$scope.changePro=function(obj){
			$scope.province = obj.formParms.proName_;
			if(obj.formParms.proName_){
				$scope.formParms.onProvince=$('#province').find("option:selected").text();
			}else{
				$scope.formParms.onProvince="";
			}
			$scope.formParms.onCity="";
			$scope.formParms.onDistrict="";
			function qSucc(rec){
				$scope.pList=[];
				$scope.pList=rec;
				$scope.cList={};
			}
			function qErr(rec){}
			regionSvc.queryRegionArea({regionId:$scope.province},qSucc,qErr);
		};
		
		
		 *城市
		
		$scope.city="";	//市区标识名
		$scope.changeCity=function(obj){
			$scope.city = obj.formParms.citName_;
			if(obj.formParms.citName_){
				$scope.formParms.onCity=$('#city').find("option:selected").text();
			}else{
				$scope.formParms.onCity="";
			}
			$scope.formParms.onDistrict="";
			regionSvc.queryRegionArea({regionId:$scope.city},qSucc,qErr);
			function qSucc(rec){
				$scope.cList=[];
				$scope.cList=rec;
			}
			function qErr(rec){}
		};
		
		
		 *区县
		
		$scope.district="";//区县标识名
		$scope.changeDis=function(obj){
			$scope.district = obj.formParms.disName_;
			if(obj.formParms.disName_){
				$scope.formParms.onDistrict=$('#district').find("option:selected").text();
			}else{
				$scope.formParms.onDistrict="";
			}
		};*/
		
		
		/*
		 *省份
		*/
		$scope.changePro=function(parm){
			
			/*选择空*/
			if(!parm.proModel){
				$scope.pList=[];
				$scope.cList={};
				setTimeout(function(){
					$("#city").val("");
					$("#district").val("");
				},500);
				return;
			}
			
			var regionId = "";
			for(var i=0;i<$scope.areaList.length;i++){
				if($scope.areaList[i].name==parm.proModel){
					regionId=$scope.areaList[i].regionId;
					break;
				}
			}
			
			$scope.formParms.onProvince=parm.proModel;
			function qSucc(rec){
				
				$scope.pList=[];
				$scope.pList=rec;
				$scope.cList={};
				setTimeout(function(){
					$("#city").val("");
					$("#district").val("");
				},500);
				
			}
			function qErr(rec){}
			regionSvc.queryRegionArea({regionId:regionId},qSucc,qErr);
		};
		
		/*
		 *城市
		*/
		$scope.changeCity=function(parm){
			/*选择空*/
			if(!parm.recModel){
				$scope.cList=[];
				setTimeout(function(){
					$("#district").val("");
				},500);
				return;
			}
			
			var regionId = "";
			for(var i=0;i<$scope.pList.length;i++){
				if($scope.pList[i].name==parm.recModel){
					regionId=$scope.pList[i].regionId;
					break;
				}
			}
			
			$scope.formParms.onCity=parm.recModel;
			function qSucc(rec){
				$scope.cList=[];
				$scope.cList=rec;
				setTimeout(function(){
					$("#district").val("");
				},500);
			}
			function qErr(rec){}
			
			if(regionId){
				regionSvc.queryRegionArea({regionId:regionId},qSucc,qErr);
			}else{
				$scope.cList=[];
				setTimeout(function(){
					$("#district").val("");
				},500);
			}
		};
		
		
		/*
		 *区县
		*/
		$scope.changeDis=function(parm){
			$scope.formParms.onDistrict=parm.disModel;
		};
		
		/* 选择单选框 */
		$scope.equipSelect = function(obj){
			$scope.selectequip = obj.q;
			$scope.selectFlag = obj.$index;
			$scope.selectId_=obj.q.contactId;
		};
		
		
		
		
		
		
		
		  /*
         * 地址查询--所在城市
         */
         $scope.temporary={};
         $scope.AtDisName = null;
         $scope.requesRegionAt = function(parm){
         	function qSucc(rec){
     			//$scope.AtDisName=rec.name;
     			//$scope.AtCitName=rec.parentName;
         		$scope.formParms.disName_ = $scope.formParms.atCity;
     			$scope.formParms.citName_ = rec.parentRegionId;
     			$scope.temporary=rec;
     			$scope.queryCities($scope.temporary);
     			$scope.pList=[];
     			$scope.pList.push({regionId:rec.parentRegionId,name:rec.parentName});
     			$scope.cList=[];
     			$scope.cList.push({regionId:rec.regionId,name:rec.name});
     			$scope.formParms.onCity=rec.parentName;
     			$scope.formParms.onDistrict=rec.name;
     			
			}
			function qErr(){}
			regionSvc.queryRegionByRegionId2({id:parm},qSucc,qErr);
         };
         
         
          $scope.queryCities = function(){
        	  function qSucc(rec){
       			//$scope.AtProName=rec.parentName;
       			$scope.formParms.proName_ = rec.parentRegionId;
       			$scope.formParms.onProvince=rec.parentName;
   				//$scope.viewList.AtRegionName=$scope.AtProName+'-'+$scope.AtCitName+'-'+$scope.AtDisName;
       		 }
				 function qErr(){}
   			 regionSvc.queryRegionByRegionId2({id:$scope.temporary.parentRegionId},qSucc,qErr);
          };            
         
         
  });