app.controller('infoPubSaleController', function($scope, $timeout, proSvc,rentSvc, SaleSvc, partyConTactSvc, equipment, PicSvc, regionSvc,entSvc, category, PicUrl) {
    
	
	var areaArr =[];
	$scope.SaleformPar = {};
	$scope.SaleformPar.areaObj = area_;
	//$scope.areaObj = area_;
	if(area_){
		var areaStr = $scope.SaleformPar.areaObj.saveParm;
			areaArr = areaStr.split("-");
		}
	var tmpVal = publicParms.saveParm;
	$scope.formParms = InfopubSaleParms.saveParm;
	$scope.formParm = {
		description : tmpVal
	};
	/*publicParms = {};*/

	$scope.add = function (obj,tmp) {
		if($scope.InfopubSaleList.equipmentId==null){
	    	 $.messager.popup("请选择设备");
	    	 return;
         } 
	 	/*//验证码判断是否正确
	     if (!obj.$valid) {
	          if (!obj.equipmentId.$valid) {
	             $scope.showFlag = 'equipmentId';
	             if(obj.equipmentId.$error.required==true){
	             	$.messager.popup("请选择设备");
	             }
	             return;
	          }
	          if (!obj.price.$valid) {
	             $scope.showFlag = 'price';
	             if(obj.price.$error.required==true){
	             	$.messager.popup("请您填写正确的价格");
	             }
	             return;
	          } 
	          if (!obj.shortestLease.$valid&&$scope.zuQi==false) {
	         	 $scope.showFlag = 'shortestLease';//验证最短租期
	            if(obj.shortestLease.$error.required==true){	                	   
	             	if($scope.formParms.shortestLease==7){
	             	     $.messager.popup("请输入正确天数");
	             	}else{
	             		 $.messager.popup("请输入正确天数");
	             	}
	             }
	             return; 
	           
	         }
	         if (!obj.infoTitle.$valid) {
	         	if(obj.infoTitle.$viewValue){
	         		
	         		 $scope.showFlag = 'infoTitle2';
	         		 if(obj.infoTitle.$error.minlength==true){
	         			 $.messager.popup("信息标题不能少于2个汉字请补充");
	         		 }
	         	}else{
	         		 
	              	 $scope.showFlag = 'infoTitle';
	         		 if(obj.infoTitle.$error.required==true){
	         			 $.messager.popup("请输入信息标题");
	         		 }
	         	}
	             return;
	         }
	         if (!$scope.formParms.detailedDescription) {
	             $scope.showFlag = 'detailedDescription';
	             	$.messager.popup("请输入详细说明,内容越详细，用户越容易找到此类信息！");
	             return;
	         }
	         if (!obj.equipmentPic.$valid) {
	             $scope.showFlag = 'equipmentPic';
	             if(obj.equipmentPic.$error.required==true){
	             	$.messager.popup("请上传设备图片");
	             }
	             return;
	         }
	         if(!obj.SelectProvince.$valid){
	         	$scope.showFlag='SelectProvince';
	         	if(obj.SelectProvince.$error.required==true){
	          	$.messager.popup("请选择所在省份");
	         	}
	         	return;
	         }
	         if(!obj.SelectCity.$valid){
	         	$scope.showFlag='SelectCity';
	         	if(obj.SelectCity.$error.required==true){
	         		$.messager.popup("请选择所在城市");
	         	}
	         	return;
	         }
	         if(!obj.SelectCounty.$valid){
	         	$scope.showFlag='SelectCounty';
	         	if(obj.SelectCounty.$error.required==true){
	         		$.messager.popup("请选择所在区县");
	         	}
	         	return;
	         }
	         if (!obj.contactPerson.$valid) {
	             $scope.showFlag = 'contactPerson';
	             if(obj.contactPerson.$error.required==true){
	             	$.messager.popup("请输入联系人姓名");
	             }
	             return;
	         }
	         if (!obj.contactPhone.$valid) {
	             $scope.showFlag = 'contactPhone';
	             if(obj.contactPhone.$error.required==true){
	             	$.messager.popup("请输入正确的联系电话");
	             }
	             if(obj.contactPhone.$error.pattern==true){
	             	$.messager.popup("请输入正确的联系电话");
	             }
	             if(obj.contactPhone.$error.minlength==true){
	             	$.messager.popup("请输入正确的联系电话");
	             }
	             return;
	         }
	         if(!obj.qqNo.$valid){
	         	$scope.showFlag = 'qqNo';
	         	if(obj.qqNo.$error.pattern==true){
	             	$.messager.popup("请输入正确的QQ号码");
	             }
	             return;
	         }
	         if (!obj.inputCode.$valid) {
	         	if(obj.inputCode.$error.required==true){
	         		$.messager.popup("请您填写验证码");
	         	}
	             $scope.showFlag = 'inputCode';
	             return;
	         } 
	 	}*/
	     //验证码输入正确校验
		 /*if($scope.formParms.inputCode==null||$scope.formParms.inputCode ==""){
			 $.messager.popup("请输入验证码");
		 }*/
	     if( $scope.formParms.inputCode && ($scope.formParms.inputCode.toUpperCase()!=document.getElementById("checkCode").innerHTML.toUpperCase())) {
	         $scope.showFlag = 'inputCodeErr';
	         $.messager.popup("请输入正确的验证码");
	         return;
	     }  
	     $scope.formParms.priceType=$("#priceTypeId").val();
	   /*  
	     var tmpLastIndex = $scope.formParms.equipmentPic.lastIndexOf(",");
	     if(tmpLastIndex==$scope.formParms.equipmentPic.length-1){
	         $scope.formParms.equipmentPic = $scope.formParms.equipmentPic.substring(0, $scope.formParms.equipmentPic.length - 1);
	     }*/
	     
	 	if($scope.formParms.priceType==null){
				$scope.formParms.priceType=1;
			}
	     
	     function aSucc(rec) {
	    	 $.messager.popup("发布成功");
	         $scope.formParms={};
	         $scope.formPar = {};
	         InfopubSaleParms = {};
	         publicParms={};
	         area_="";	
	         updInfopubSale="";
	         setTimeout(function(){
	        	 window.location.reload(true);
	 		},1000)
	        
	         
	     }
	     function aErr() {
	         $.messager.popup("发布失败,请检查录入的数据是否填写完善");
	     }
	     
	     //去掉逗号
	     $scope.formParms.price = $scope.formParms.price.toString().replace(/\,/g,'');
	     $scope.formParms.enterpriseName = $scope.userInfo.orgName;
	     $scope.formParms.infoRadio = 1;
	     $scope.formParms.equipmentId = $scope.InfopubSaleList.equipmentId;
	     $scope.formParms.equNo = $scope.InfopubSaleList.equNo;
	     $scope.formParms.power = $scope.InfopubSaleList.power;
	     if($scope.InfopubSaleList.technicalStatus==1){
	         $scope.formParms.technicalStatus = "一类";
	         }else if($scope.InfopubSaleList.technicalStatus==2){
	         	$scope.formParms.technicalStatus = "二类";
	         }else{
	         	$scope.formParms.technicalStatus = "三类";
	         }
	     $scope.formParms.detailedDescription = tmpVal;
	     $scope.formParms.manufacturer = $scope.InfopubSaleList.manufacturerName;
	     $scope.formParms.productionDate = $scope.InfopubSaleList.productionDate;
	     $scope.formParms.equName = $scope.InfopubSaleList.equName;
	     $scope.formParms.brandName = $scope.InfopubSaleList.brandName;
	     $scope.formParms.modelName = $scope.InfopubSaleList.models;
	     $scope.formParms.standardName = $scope.InfopubSaleList.specifications;
	     $scope.formParms.onProvince = areaArr[0];
	     $scope.formParms.onCity = areaArr[1];
	     $scope.formParms.onDistrict = areaArr[2];
	   /*  if($scope.zuQi==true){
	 		$scope.formParms.shortestLease='999';
	 	}
	 */
	     if($scope.formParms.priceType==null){
	     	$scope.formParms.priceType = 1;
	     }
	     if(updInfopubSale.dataId){
	 	   //$scope.formParms.dataId=$scope.id;
	    	 SaleSvc.post({urlPath:updInfopubSale.dataId},$scope.formParms, aSucc, aErr);
	     }else{
	     
	    
	     SaleSvc.put($scope.formParms, aSucc, aErr);
	 	   
	     }
	 };
		
			$scope.openInfopubSaledescription = function(obj){
				
				if($scope.formParm.description){
					publicParms.saveParm=$scope.formParm.description;				
				}
				InfopubSaleParms = {saveParm:obj};
				
				window.location.href="/WebSite/Mobile/Index.jsp#/Infopubdescription/2";		    
			};
			
		
			$scope.InfopubPublishFun = function(obj){
				window.location.href="/WebSite/Mobile/Index.jsp#/Infopubpublish";		
				
			};
			$scope.SalegoToAreaPage = function(obj,url_,parm){
				InfopubSaleParms = {saveParm:parm};
				//var obj_ = obj;
				var parm_ = 'InfopubSale';
				window.location = url_+'/'+parm_;
			};
	$scope.InfopubPublishFun = function(obj) {
		window.location.href = "/WebSite/Mobile/Index.jsp#/InfopubSalepublish";

	};
	$scope.openInfopubdescription = function(obj){
		if($scope.formParm.description){
			publicParms.saveParm=$scope.formParm.description;
		}
		window.location.href="/WebSite/Mobile/Index.jsp#/Infopubdescription/2";		    
	};
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
	 

     if(updInfopubSale.infoType == 2){
			qSucc=function(rec){
				updInfopubSale.infoType=null;
				
				$scope.InfopubSaleList = {};
				$scope.SaleformPar.areaObj ={};
				$scope.formParms=rec;			 	
				$scope.InfopubSaleList.manufacturerName = rec.manufacturer;        	  		
	 	  		$scope.InfopubSaleList.productionDate = rec.productionDate;
	 	  		$scope.InfopubSaleList.equName = rec.equName;
	 	  		$scope.InfopubSaleList.brandName = rec.brandName;  	
	 	  		$scope.InfopubSaleList.models = rec.modelName;
	  	        $scope.InfopubSaleList.specifications = rec.standardName;   
	  	        $scope.InfopubSaleList.equipmentId = rec.equipmentTable.equipmentId;
	  	        $scope.InfopubSaleList.technicalStatus = rec.technicalStatus;
	  	        $scope.InfopubSaleList.equNo = rec.equNo;
	     	    $scope.InfopubSaleList.power = rec.power;
	     	    $scope.SaleformPar.areaObj.saveParm = rec.onProvince+"-"+rec.onCity+"-"+rec.onDistrict;
	 	  		area_s = $scope.SaleformPar.areaObj;	
	 	  		if(area_s){
	 				var areaStr = $scope.SaleformPar.areaObj.saveParm;
	 				areaArr = areaStr.split("-");
	 				}	
	 	  		$scope.formParm.description = rec.detailedDescription;
	 	  		tmpVal = $scope.formParm.description;
	 	  		publicParms = {saveParm:$scope.formParm.description};
				}
				qErr=function(rec){}
				SaleSvc.unifydo({parm:updInfopubSale.dataId},qSucc,qErr);
		}
});
