app.controller('DemandInfoPubController', function ($scope,$timeout,$route,DemandRentSvc, regionSvc, category, published) {
    
	var areaArr=[];
	
	
	$scope.formPar = {};
	if(area_){
		$scope.formPar.areaDemand_ = area_;//所在城市
	}
	var tmpVal = publicParms.saveParm;
	$scope.formParm={description:tmpVal};
	/*publicParms={};*/  
	$scope.formParms = selectListParms.saveParm;
	var formParms_ = {};
	if(area_Demand.length!=0){
		$scope.formPar.areaObjDemand = area_Demand;//这个是用来判断选择完成后赋值给主页面显示的
		formParms_ = area_Demand;//这个是用来往省传参用的，当你选择完一回后第二次进入省页面需要用这个参数判断显示那种省的方式（一种是全国勾选一种是没有勾选）
		//formParms_.areaObjDemand = area_Demand;
	}else{
		$scope.formPar.areaObjDemand = {saveParm:'全国'};//初始情况如果没有结果值也就是最开始的时候值要为全国显示，之所以用json的形式是为了配合主页面显示的方式
		formParms_= '全国';//初始化传参用的，这个是用来往省传参用的，当你选择完一回后第二次进入省页面需要用这个参数判断显示那种省的方式（一种是全国勾选一种是没有勾选）
		//formParms_.areaObjDemand = {saveParm:'全国'};
	}
	
	if($route.current.params.goBakeParm && $route.current.params.goBakeParm == '全国'){//如果用户勾选了复选框在点返回主页面的话主页面的值就为全国，这里的goBakeParm就是省带回来的参数，这里做一个标识
		$scope.formPar.areaObjDemand = {saveParm:'全国'};//主页面为全国显示
	}
	//$scope.areaObj = area_;
	
		
		if(area_){
			
			var areaStr = $scope.formPar.areaDemand_.saveParm;
			areaArr = areaStr.split("-");
			}	
		if(area_Demand){
			var DemandareaStr = $scope.formPar.areaObjDemand.saveParm;
			var DemandareaArr = DemandareaStr.split("-");
			}	
		
	
	
	
		$scope.goToAreaPage = function(obj,url_,parm){//这是往省跳转用的方法，obj为类型1、2、3其实没用到因为之前写了就写吧，要不还得改，其实没用但是值要传传几随意，url是跳转的主路径
			var obj_ = obj;
			var parm_ = 'DemandInfoPub';//这个是附带的参数在路由中证明跳转到哪个页面之所以说obj没用了就是因为这个参数可以替代obj的用途，但是obj不能省因为路由配了，并且我没改
			
			if($route.current.params.goBakeParm && $route.current.params.goBakeParm == '全国'){//这个主要的作用就是如果选择完一个省市区比如北京-北京市-丰台区，然后用户又选择省这个时候他点了全国在返回主页面，这个时候主页面要根据传过来的参数为全国把穿回去的参数改成全国，这样才会在点省的时候能呈现全国应有的状态
				formParms_ = '全国';
			}
			
			
			window.location = url_+"/"+obj_+'/'+parm_+'/'+formParms_;
			selectListParms = {saveParm:parm};
		};	
		
		//所在城市跳转
		$scope.goToAreaPage_AreaFun = function(url_,parm){//这里就传一个路径参数不传种类用于区别
			var parm_ = 'DemandInfoPub';
			
			window.location = url_+'/'+parm_;
			selectListParms = {saveParm:parm};
		};
		$scope.openDemandescription = function(obj){
			if($scope.formParm.description){
				publicParms.saveParm=$scope.formParm.description;				
			}
			selectListParms = {saveParm:obj};
			window.location.href="/WebSite/Mobile/Index.jsp#/Infopubdescription/3";		    
		};
		/*
         * 验证码
         */
        $scope.GetVercode = function createCode() {
            var code = "";
            var codeLength = 4; //验证码的长度
            var checkCode = document.getElementById("checkCode");
            var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                    /** 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',**/
                    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，可以用中文
            for (var i = 0; i < codeLength; i++) {
                var charNum = Math.floor(Math.random() * 26);
                code += codeChars[charNum];

            }
            if (checkCode) {
                checkCode.className = "code";
                checkCode.innerHTML = code;
            }
        }
        
        
        $scope.add = function(obj) {
        	if($scope.selectList.equipmentName==null){
      	    	 $.messager.popup("请选择设备");
      	    	 return;
               } 
    		
    	/*	$scope.formParms.detailedDescription=$scope.ue.getContent();
    		if(!$scope.formParms.detailedDescription){
    		   $scope.showFlag = 'detailedDescription';
    		   $.messager.popup("请输入详细说明,内容越详细，用户越容易找到此类信息！");
    		   return;
    		}
    	
    		
     		if (!obj.$valid) {
     			if (!$scope.selectList.equipmentName) {
                    $scope.showFlag = 'equipmentName';
               		$.messager.popup("请选择设备");
               		return;
                }
    			 else if(!$scope.province){
    				$scope.showFlag = 'province';
    				$.messager.popup("请选择所在省份");
    				return;
    			} 
    			 else if(!$scope.city){
    					$scope.showFlag = 'city';
    					$.messager.popup("请选择所在城市");
    					return;
    				} 
    			 else if(!$scope.district){
    					$scope.showFlag = 'district';
    					$.messager.popup("请选择所在区县");
    					return;
    				} 
    			else if (!obj.price.$valid) {
    				$scope.showFlag = 'price';
    				if(obj.quantity.$error.required==true){
           				$.messager.popup("请您填写正确的价格");
               	 	}
    			}
    			else if (!obj.quantity.$valid) {
    				$scope.showFlag = 'quantity';
    				if(obj.quantity.$error.required==true){
           				$.messager.popup("请您填写数量");
               	 	}
    				else if(obj.quantity.$error.pattern==true){
           				$.messager.popup("请您填写正确的数量");
               	 	}
    			}
    			else if (!obj.infoTitle.$valid) {
                   	if(obj.infoTitle.$viewValue){
                   		$scope.showFlag = 'infoTitle2';
                   		if(obj.infoTitle.$error.minlength==true){
               				$.messager.popup("信息标题不可少于2个汉字请补充");
               		 	}
                   	}else{
                        $scope.showFlag = 'infoTitle';
                        if(obj.infoTitle.$error.required==true){
               				$.messager.popup("请输入信息标题");
               		 	}
                   	}
                   	return;
                }
    			else if (!$scope.formParms.detailedDescription) {
    				$scope.showFlag = 'detailedDescription';
       				$.messager.popup("请输入详细说明，内容越详细，用户越容易找到此类信息！");
       			
    			}
    			else if (!obj.enterpriseName.$valid) {
    				$scope.showFlag = 'enterpriseName';
    				if(obj.enterpriseName.$error.required==true){
           				$.messager.popup("请输入单位名称");
               	 	}
    			}
    			else if (!obj.proA.$valid) {
    				$scope.showFlag = 'proA';
    				if(obj.proA.$error.required==true){
           				$.messager.popup("请选择所在省份");
               	 	}
    			}
    			else if (!obj.citA.$valid) {
    				$scope.showFlag = 'citA';
    				if(obj.citA.$error.required==true){
           				$.messager.popup("请选择所在城市");
               	 	}
    			}
    			else if (!obj.disA.$valid) {
    				$scope.showFlag = 'disA';
    				if(obj.disA.$error.required==true){
           				$.messager.popup("请选择所在区县");
               	 	}
    			}
    			else if (!obj.contactPerson.$valid) {
    				$scope.showFlag = 'contactPerson';
    				if(obj.contactPerson.$error.required==true){
           				$.messager.popup("请输入联系人姓名");
               	 	}
    			}
    			else if (!obj.contactPhone.$valid) {
    				$scope.showFlag = 'contactPhone';
    				if(obj.contactPhone.$error.required==true){
           				$.messager.popup("请输入联系电话");
               	 	}
    				else if(obj.contactPhone.$error.pattern==true){
           				$.messager.popup("请输入正确的联系电话");
               	 	}
    				else if(obj.contactPhone.$error.minlength==true){
           				$.messager.popup("请输入正确的联系电话");
               	 	}
    			}
    			else if (!obj.qqNo.$valid) {
    				$scope.showFlag = 'qqNo';
    				if(obj.qqNo.$error.pattern==true){
           				$.messager.popup("请输入正确的QQ号码");
               	 	}
    			}
    			else if (!obj.inputCode.$valid) {
    				$scope.showFlag = 'inputCode';
    				if(obj.inputCode.$error.required==true){
           				$.messager.popup("请您填写验证码");
               	 	}
    			}
    			//$scope.formParms.electronicMail=$("#electronicMail").val();强制赋值 电子邮箱
    			return;
    		}else{ */
    			//判断验证码是否正确
    			if ($scope.formParms.inputCode.toLowerCase() != document.getElementById("checkCode").innerHTML.toLowerCase()) {
    					$scope.showFlag = 'inputCodeErr';
    					$.messager.popup("请您填写正确的验证码");
    					return;
    			}
    			
    			
    			/*if($scope.Parm && $scope.Parm.second)
    			{
    				if($scope.Parm.second==2){
    					$scope.formParms.second = "辆";
    				}else if($scope.Parm.second==3){
    					$scope.formParms.second = "套";
    				}else{
    					$scope.formParms.second = "台";
    				}
    			}*/
    			$scope.formParms.second = "台";
    			$scope.formParms.detailedDescription = tmpVal;
    			$scope.formParms.equName=$scope.selectList.equipmentName;/*设备名称*/
    			
    			$scope.formParms.brandName=$scope.selectList.manufacturer;/*品牌*/
    			
    			$scope.formParms.modelName=$scope.selectList.modelNumber;/*型号*/
    			
    			$scope.formParms.standardName=$scope.selectList.specifications;/*规格*/
    			
    			$scope.formParms.price=$scope.formParms.price.toString().replace(/\,/g,'');/*期望金额分隔符去掉处理*/
    			
    			$scope.formParms.onProvince = areaArr[0];
    		    
    			$scope.formParms.onCity = areaArr[1];
    		    
    			$scope.formParms.onDistrict = areaArr[2];
    			
    			if(area_Demand){
    			$scope.formParms.useProvince = DemandareaArr[0];
    		    
    			$scope.formParms.useCity = DemandareaArr[1];
    		    
    			$scope.formParms.useDistrict = DemandareaArr[2];
    			}
    			
    			//判断是否为购买添加，4位求购，3位求租
    			$scope.formParms.infoRadio = 4;
    			if($scope.formParms.priceType==null){
    				$scope.formParms.priceType=1;
    			}
    			if($scope.formParms.tenancyType==null){
    				$scope.formParms.tenancyType=1;
    			}
    			function aSucc(rec) {
    				$.messager.popup("发布成功");
    				$scope.formPar = {};
    				$scope.selectList={};
    				$scope.formParms={};
    				selectListParms="";
    				publicParms="";
    				updDemandInfoPub="";
    				 setTimeout(function(){
    		        	 window.location.reload(true);
    		 		},500)
    			}
    			function aErr(rec) {
    				$.messager.popup("发布失败");
    			}
    			if(updDemandInfoPub.dataId){
             	   DemandRentSvc.post({urlPath:updDemandInfoPub.dataId},$scope.formParms, aSucc, aErr);
                }else{
                	
             	   DemandRentSvc.put($scope.formParms, aSucc, aErr);
                }
    			/*}*/ 
    	};
    	
    
     		if(updDemandInfoPub.infoType == 3){
     			qSucc=function(rec){
     				updDemandInfoPub.infoType=null;
     				
     				$scope.selectList = {};
     				$scope.formPar.areaDemand_={};
     				$scope.formPar.areaDemand={};
     				$scope.formParms=rec;			 	
        	  		$scope.selectList.equipmentName = rec.equName;        	  		
        	  		$scope.selectList.manufacturer = rec.brandName;
        	  		$scope.selectList.modelNumber = rec.modelName;
        	  		$scope.selectList.specifications = rec.standardName;  	
        	  		$scope.formPar.areaDemand_.saveParm = rec.onProvince+"-"+rec.onCity+"-"+rec.onDistrict;
        	  		area_ = $scope.formPar.areaDemand_.saveParm;	
        	  		if(area_){
        				var areaStr = $scope.formPar.areaDemand_.saveParm;
        				areaArr = areaStr.split("-");
        				}	
        			if(area_Demand){
        				var DemandareaStr = $scope.formPar.areaObjDemand.saveParm;
        				var DemandareaArr = DemandareaStr.split("-");
        				}	
        	  		$scope.formParm.description = rec.detailedDescription;
        	  		tmpVal = $scope.formParm.description;
        	  		publicParms = {saveParm:$scope.formParm.description};
    			}
    			qErr=function(rec){}
     			DemandRentSvc.unifydo({parm:updDemandInfoPub.dataId},qSucc,qErr);
     		}
    	
});
		