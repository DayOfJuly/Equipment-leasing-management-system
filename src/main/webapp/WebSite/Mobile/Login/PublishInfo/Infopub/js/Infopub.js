app.controller('infoPubController', function ($scope,$timeout,proSvc,rentSvc, SaleSvc,partyConTactSvc , equipment, PicSvc, regionSvc, entSvc, category,PicUrl) {

	var areaArr = [];
	$scope.formPar = {};
	$scope.formPar.areaObj = area_;
	if(area_){
	var areaStr = $scope.formPar.areaObj.saveParm;
		areaArr = areaStr.split("-");
	}
	var tmpVal = publicParms.saveParm;
	$scope.formParm={description:tmpVal};
	/*publicParms={};*/   
	$scope.formParms = InfopubParms.saveParm;
	$scope.add = function (obj,tmp) {
		if($scope.InfopubList.equipmentId==null){
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
    	 $.messager.popup("成功");
         $scope.formParms={};
         $scope.formPar = {};
         InfoPubParms = "";
         publicParms="";
         updInfoPub = "";
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
     $scope.formParms.equipmentId = $scope.InfopubList.equipmentId;
     $scope.formParms.equNo = $scope.InfopubList.equNo;
     $scope.formParms.power = $scope.InfopubList.power;
     if($scope.InfopubList.technicalStatus==1){
         $scope.formParms.technicalStatus = "一类";
         }else if($scope.InfopubList.technicalStatus==2){
         	$scope.formParms.technicalStatus = "二类";
         }else{
         	$scope.formParms.technicalStatus = "三类";
         }
     $scope.formParms.detailedDescription = tmpVal;
     $scope.formParms.manufacturer = $scope.InfopubList.manufacturerName;
     $scope.formParms.productionDate = $scope.InfopubList.productionDate;
     $scope.formParms.equName = $scope.InfopubList.equName;
     $scope.formParms.brandName = $scope.InfopubList.brandName;
     $scope.formParms.modelName = $scope.InfopubList.models;
     $scope.formParms.standardName = $scope.InfopubList.specifications;
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
    if(updInfoPub.dataId){
 	   //$scope.formParms.dataId=$scope.id;
 	   rentSvc.post({urlPath:updInfoPub.dataId},$scope.formParms, aSucc, aErr);
     }else{
 	   rentSvc.put($scope.formParms, aSucc, aErr);
 	   
    }
 };
	
		$scope.openInfopubdescription = function(obj){
			if($scope.formParm.description){
				publicParms.saveParm=$scope.formParm.description;				
			}
			InfopubParms = {saveParm:obj};
			window.location.href="/WebSite/Mobile/Index.jsp#/Infopubdescription/1";		    
		};
		
	
		$scope.InfopubPublishFun = function(obj){
			window.location.href="/WebSite/Mobile/Index.jsp#/Infopubpublish";		
		};

			
		$scope.GetPic = function(){
			$('#getPic').modal('show');
			
		}	
			
	    $scope.Init = function(){
	    	window.location.href="m://my.com/";
	    } 
		
		
		$scope.goToAreaPage = function(obj,url_,parm){
			InfopubParms = {saveParm:parm};
			/*var obj_ = obj;*/
			var parm_ = 'Infopub';
			window.location = url_+'/'+parm_;
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
        
        
        if(updInfoPub.infoType == 1){
 			qSucc=function(rec){
 				updInfoPub.infoType=null;
 				$scope.selectList = {};
 				$scope.formPar.areaObj={};
 				$scope.formParms=rec;			 	
 				$scope.InfopubList.manufacturerName = rec.manufacturer;        	  		
    	  		$scope.InfopubList.productionDate = rec.productionDate;
    	  		$scope.InfopubList.equName = rec.equName;
    	  		$scope.InfopubList.brandName = rec.brandName;  	
    	  		$scope.InfopubList.models = rec.modelName;
   	  	        $scope.InfopubList.specifications = rec.standardName;   
   	  	        $scope.InfopubList.equipmentId = rec.equipmentTable.equipmentId;
   	  	        $scope.InfopubList.technicalStatus = rec.technicalStatus;
   	  	        $scope.InfopubList.equNo = rec.equNo ;
   	     	    $scope.InfopubList.power = rec.power;
   	  	        $scope.formPar.areaObj.saveParm = rec.onProvince+"-"+rec.onCity+"-"+rec.onDistrict;
    	  		area_s = $scope.formPar.areaObj.saveParm;	
    	  		if(area_s){
    				var areaStr = $scope.formPar.areaObj.saveParm;
    				areaArr = areaStr.split("-");
    				}	
    	  		$scope.formParm.description = rec.detailedDescription;
    	  		tmpVal = $scope.formParm.description;
    	  		publicParms = {saveParm:$scope.formParm.description};
			}
			qErr=function(rec){}
			rentSvc.unifydo({parm:updInfoPub.dataId},qSucc,qErr);
 		}
        $scope.zuQi=false;
        $scope.zuQiClick=function(parm){
 			if(parm == true){
 				$scope.zuQi=true;
 				$scope.showFlag="";
 			  $scope.shortestLease=$scope.formParms.shortestLease; 
 			}else{
 				$scope.zuQi=false;
 			}
 		};
});
		