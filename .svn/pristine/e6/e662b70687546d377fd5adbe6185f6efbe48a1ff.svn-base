<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>发布求租信息</title>
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../Include/Head.jsp" />
<jsp:include page="../conmmon/publicSession.jsp" />
<link href="../../../css/heightLight.css" rel="stylesheet">
<link href="../../../media/css/emailstyle.css" rel="stylesheet">
<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/SysCodeConfig.js"></script>
<script type="text/javascript" src="../../../js/JsSvc/SysCodeTranslate.js"></script>
<script type="text/javascript" src="../../../media/js/pagination.js"></script>
<script type="text/javascript" src="../../../media/js/tm.paginationss.js"></script>
<script type="text/javascript" src="../../../media/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="../../../media/ueditor/ueditor.all.js"></script>
<script src="../../../js/JsLib/angular.min.js"></script>
<script type="text/javascript" src="../../../media/js/common.js"></script>
<script type="text/javascript">
var app = angular.module('infoPubApp', [ 'ngResource', 'unifyModule','tm.paginationss', 'angularFileUpload', 'ngMessages']);
	app.controller('infoPubController',function($scope, $upload, DemandRentSvc, regionSvc, category, published) {
	
	/*
	* 富文本编辑器
	*/
	$scope.ue=UE.getEditor('myEditor');
  	$scope.getEditContent=function(){
  		$scope.ue.getContent();
  		$scope.ue.setContent($scope.formParms.detailedDescription);
  	};
	
	var url = location.search;
	var theRequest = new Object();
	if (url.indexOf("?") != -1) {
		var str = url.substr(1);
		strs = str.split("&");
		for (var i = 0; i < strs.length; i++) {
			theRequest[strs[i].split("=")[0]] = (strs[i]
					.split("=")[1]);
		}
	}

	
    //接收其他页面传递过来的id和infoType
	$scope.id=theRequest.id;
	$scope.infoType=theRequest.infoType;
	/*
	*如果有已发布页面传过来的值，则进行查询，回显到页面
	*/
	$scope.queryPublish=function(){
		$scope.selectList={};
 		if($scope.infoType == 3){
 			qSucc=function(rec){
 				
 				$scope.formParms=rec;			 	
    	  		$scope.selectList.equipmentName = rec.equName;
    	  		
    	  		$scope.selectList.manufacturer = rec.brandName;
    	  		$scope.selectList.modelNumber = rec.modelName;
    	  		$scope.selectList.specifications = rec.standardName;
             
     			/*弹出修改模态框 根据省中文查出省id，然后依次查询出市数据源和区数据源*/
				/*查询省市区数据源 start*/
				$scope.recPro={};
				$scope.recCit={};
				$scope.recDis={};
				var provinceId="";
				var cityId="";
				var cityNum=0;
				var districtNum=0;
				
				for(var i=0;i<$scope.areaListA.length;i++){
					var tmpProvince=$scope.areaListA[i];
					
					if(tmpProvince.name==rec.onProvince){
						provinceId=tmpProvince.regionId;
						provinceNum=i;
						break;
					}
					
				}
				regionSvc.queryRegionArea(
					{regionId:provinceId},
					function qCitySucc(recProvince){
						$scope.pListA=[];
						$scope.pListA=recProvince;
						for(var i=0;i<$scope.pListA.length;i++){
							var tmpCity=$scope.pListA[i];
							if(tmpCity.name==rec.onCity){
								cityId=tmpCity.regionId;
								cityNum=i;
								break;
							}
						}
						regionSvc.queryRegionArea(
							{regionId:cityId},
							function qSucc(recCity){
								$scope.cListA=[];
								$scope.cListA=recCity;
								for(var i=0;i<$scope.cListA.length;i++){
									var tmpDistrict=$scope.cListA[i];
									if(tmpDistrict.name==rec.onDistrict){
										districtNum=i;
										break;
									}
								}
								/*$scope.pList=[{name:rec.onCity}];
								$scope.cList=[{name:rec.onDistrict}];*/
								$scope.recPro.proAModel=rec.onProvince;
				     			$scope.recCit.cityAModel=rec.onCity;
				     			$scope.recDis.disAModel=rec.onDistrict;  
								setTimeout(function(){
									cityNum=Math.abs($('#city option').length*1-$scope.pListA.length*1)+cityNum*1;
									districtNum=Math.abs($('#district option').length*1-$scope.cListA.length*1)+districtNum*1;
									$('#cityA')[0].selectedIndex = cityNum;
									$('#districtA')[0].selectedIndex = districtNum;
								},500);
							},
							function(recCity){}
						);
					},
					function(recProvince){}
				);
				/*查询省市区数据源 end*/
     			setTimeout(function(){
	         		$scope.ue.setContent(rec.detailedDescription);
     			},1000)
    	  		
			}
			qErr=function(rec){}
 			DemandRentSvc.unifydo({parm:$scope.id},qSucc,qErr);
 		}
	};
	
	
	$scope.requestParms = theRequest;
	$scope.titleMsg = "免费发布信息步骤：";
	$scope.titleMsg2 = "填写详细内容";
	$scope.titleMsg3 = "> 审核详细内容 > 发布成功";
	/*
	提交表单后刷新页面
	*/
	$scope.closeAndGoBack=function ()
	{
		window.location.reload(true);
	};
	
	/*
	 *分页标签参数配置
	 */
	$scope.paginationConf = {
		currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10, 20, 30, 40, 50],
   		//parm1:当前选择页数 parm2:每页显示多少 屏幕加载运行
   		//屏幕打开时加载多半用于打开时查询
   		onChange : function(parm1, parm2) {
   			$scope.radioTrIndex=null;
			$scope.inputModel=null;	
			$scope.paginationConf.currentPage = parm1;
			/*  $scope.queryCategory();  */
			 if($scope.queryData.searchParam=="" || $scope.queryData.searchParam==null){
        		/*   $scope.queryCategoryData(); */
        	}else{
        		$scope.queryCategoryData(1);
        	}
			if($scope.infoType == 3){
    			$scope.queryPublish();
    			$scope.udp=true;
    		}else{
    			$scope.udp=false;
    		} 
			 
            $scope.queryCity();
        	
			//地区选择默认不可编辑
			$scope.procheck = 'true';
			$scope.citcheck = 'true';
			$scope.discheck = 'true';
			$scope.infoTypeA = true;
			$scope.tmp.reason=true;
			$scope.province=true;
			$scope.city=true;
			$scope.district=true;
		}
	};
	
	$scope.queryCity=function(){
    	function aSucc(rec){
			$scope.areaListA=[];
			$scope.areaListA=rec;
		}
		function aErr(rec){}
		regionSvc.queryRegionArea({}, aSucc,aErr);//查询省级单位
    };
	
	/*
	 * 验证码
	 */
	$scope.GetVercode = function createCode() {
		var code = "";
		var codeLength = 4; //验证码的长度
		var checkCode = document
				.getElementById("checkCode");
		var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7,
				8, 9,
				/** 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',**/
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
				'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
				'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
				'Y', 'Z'); //所有候选组成验证码的字符，可以用中文
		for (var i = 0; i < codeLength; i++) {
			var charNum = Math.floor(Math.random() * 26);
			code += codeChars[charNum];

		}
		if (checkCode) {
			checkCode.className = "code";
			checkCode.innerHTML = code;
		}
	};
	
	/*
	 * 添加信息
	 */
	 $scope.tmp={};
	$scope.formParms={};
	$scope.add = function(obj) {
		
		
		$scope.formParms.detailedDescription=$scope.ue.getContent();
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
			//$scope.formParms.electronicMail=$("#electronicMail").val();/*强制赋值 电子邮箱*/
			return;
		}else{ 
			//判断验证码是否正确
			if ($scope.formParms.inputCode.toLowerCase() != document.getElementById("checkCode").innerHTML.toLowerCase()) {
					$scope.showFlag = 'inputCodeErr';
					$.messager.popup("请您填写正确的验证码");
					return;
			}
			
			
			if($scope.Parm && $scope.Parm.second)
			{
				if($scope.Parm.second==2){
					$scope.formParms.second = "辆";
				}else if($scope.Parm.second==3){
					$scope.formParms.second = "套";
				}else{
					$scope.formParms.second = "台";
				}
			}
			
			$scope.formParms.equName=$scope.selectList.equipmentName;/*设备名称*/
			
			$scope.formParms.brandName=$scope.selectList.manufacturer;/*品牌*/
			
			$scope.formParms.modelName=$scope.selectList.modelNumber;/*型号*/
			
			$scope.formParms.standardName=$scope.selectList.specifications;/*规格*/
			
			$scope.formParms.price=$scope.formParms.price.toString().replace(/\,/g,'');/*期望金额分隔符去掉处理*/
			
			//判断是否为购买添加，4位求购，3位求租
			$scope.formParms.infoRadio = 4;
			if($scope.formParms.priceType==null){
				$scope.formParms.priceType=1;
			}
			if($scope.formParms.tenancyType==null){
				$scope.formParms.tenancyType=1;
			}
			function aSucc(rec) {
				$scope.empty();
				//查询所有地区A
				function qSucc(rec){
					$scope.areaListA=[];
					$scope.areaListA=rec;
					$scope.provinceA="";
				}
				function qErr(){}
				regionSvc.queryRegionArea({}, qSucc,qErr);
				$scope.infoTypeA=true;
				$scope.showview=false;
				$scope.selectList={};
				$scope.ue.setContent(" ");
				$("#fade,#openwin5").show();
			}
			function aErr(rec) {
				$.messager.popup("发布失败");
			}
			if($scope.udp == true){
         	   
         	   DemandRentSvc.post({urlPath:$scope.id},$scope.formParms, aSucc, aErr);
            }else{
            	
         	   
         	   
         	   DemandRentSvc.put($scope.formParms, aSucc, aErr);
            }
 		} 
	};
	/* $scope.returnWindow = function(){
		window.location.reload();
	} */
	/*
	 *清空页面所有内容
	*/
	$scope.empty = function(){
		 $scope.phon1="";
		 $scope.phon2="";
		 $scope.phon3="";
		 $scope.PicList=[];
		 $scope.areaListA=[];
		 $scope.pListA=[];
		 $scope.cListA=[];
		 $scope.GetVercode();
		 $scope.showFlag='';
		 $scope.formParms={}; 
		 $scope.changeCheck(true);
		 //$scope.tmp.reason=true;
		
	};
	/*
	 *省份
	*/
	$scope.province="";//省份标识名
	$scope.changePro=function(parm){

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
		
		$scope.formParms.useProvince=parm.proModel.name;
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
		if($scope.province != null){
			$scope.province = true;
			$scope.showFlag = 'city';
		}
	};
	/*
	 *城市
	*/
	$scope.city="";	//市区标识名
	$scope.changeCity=function(parm){
	
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
		
		$scope.formParms.useCity=parm.recModel.name;
		function qSucc(rec){
			$scope.cList=[];
			$scope.cList=rec;
			setTimeout(function(){
				$("#district").val("");
			},500);
		}
		function qErr(rec){}
		regionSvc.queryRegionArea({regionId:regionId},qSucc,qErr);
		if($scope.city != null){
			$scope.city = true;
			$scope.showFlag = 'district';
		}else if($scope.province == null){
			$scope.showFlag = 'province';
		}else{
			$scope.showFlag = 'city';
		}
	};
	
	/*
	 *区县
	*/
	$scope.district="";//区县标识名
	$scope.changeDis=function(parm){
		$scope.formParms.useDistrict=parm.disModel.name;
		if(!$scope.province != null){
			$scope.showFlag = 'province';
		}else if($scope.city == null){
			$scope.showFlag = 'city';
		}else{
			$scope.showFlag = '';
		}
		if($scope.district != null){
			$scope.district=true;
			$scope.showFlag = '';
		}
	};
	/*
	 *省份A
	*/
	$scope.provinceA="";//省份标识名
	$scope.changeProA=function(parm){
		/*选择空*/
		
		
		if(!parm.proAModel){
			$scope.pListA=[];
			$scope.cListA={};
			setTimeout(function(){
				$("#cityA").val("");
				$("#districtA").val("");
			},500);
			return;
		}
		
		var regionId = "";
		for(var i=0;i<$scope.areaListA.length;i++){
			if($scope.areaListA[i].name==parm.proAModel){
				regionId=$scope.areaListA[i].regionId;
				break;
			}
		}
		
		$scope.formParms.onProvince=parm.proAModel;
		function qSucc(rec){
			
			$scope.pListA=[];
			$scope.pListA=rec;
			$scope.cListA={};
			setTimeout(function(){
				$("#cityA").val("");
				$("#districtA").val("");
			},500);
			
		}
		function qErr(rec){}
		regionSvc.queryRegionArea({regionId:regionId},qSucc,qErr);
		}
	/*
	 *城市A
	*/
	$scope.cityA="";	//市区标识名
	$scope.changeCityA=function(parm){
		
		/*选择空*/
		if(!parm.cityAModel){
			$scope.cListA=[];
			setTimeout(function(){
				$("#districtA").val("");
			},500);
			return;
		}
		
		var regionId = "";
		for(var i=0;i<$scope.pListA.length;i++){
			if($scope.pListA[i].name==parm.cityAModel){
				regionId=$scope.pListA[i].regionId;
				break;
			}
		}
		
		$scope.formParms.onCity=parm.cityAModel;
		function qSucc(rec){
			$scope.cListA=[];
			$scope.cListA=rec;
			setTimeout(function(){
				$("#districtA").val("");
			},500);
		}
		function qErr(rec){}
		regionSvc.queryRegionArea({regionId:regionId},qSucc,qErr);
	};
	
	/*
	 *区县A
	*/
	$scope.districtA="";//区县标识名
	$scope.changeDisA=function(parm){
		$scope.formParms.onDistrict=parm.disAModel;
	};
	
	
	//信息标题显示
	/*  $scope.focusJudge=function(obj){
          	 if (!obj.$valid) {
          		 if (!obj.infoTitle.$valid) {
                       $scope.showFlag = 'infoTitle';
                       return;
                   }
          	 }
          }; */
	
	$('.form_date').datetimepicker({
		language : 'zh-CN',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		minView : 2,
		forceParse : 0
	});
	
	
	//checkbox全国
	$scope.tmpCheck=[];
	$scope.changeCheck=function(parm){
		
		
		if(parm == true){
			$scope.showFlag='';			
			$scope.procheck = 'true';
			$scope.citcheck = 'true';
			$scope.discheck = 'true';
			$scope.areaList=[];
			$scope.pList=[];
			$scope.cList=[];
			$("#province").val("");
			$("#city").val("");
			$("#district").val("");
		
			
		}
		else{
			$scope.showFlag='province';
			$scope.procheck = '';
			$scope.citcheck = '';
			$scope.discheck = '';
			$scope.province=false;
			$scope.city=false;
			$scope.district=false;
			//查询所有地区
			function aSucc(rec){
				$scope.areaList=[];
				$scope.areaList=rec;
				$("#province").val("");
				$("#city").val("");
				$("#district").val("");
			}
			function aErr(){}
			regionSvc.queryRegionArea({}, aSucc,aErr);
		}
		
	};
	/*处理IE不兼容问题*/
	$scope.IEChange=function(obj,parm){
		if ((navigator.userAgent.indexOf('Firefox')<0) && (navigator.userAgent.indexOf('Chrome')<0) && (navigator.userAgent.indexOf('Safari')<0)  && (navigator.userAgent.indexOf('Opera')<0)){
			if(parm=="equCategory"){
				for(var i=0;i<obj.length;i++){
					if(obj[i].equCategoryId==$scope.equ_List.equCategoryId){
						$scope.queryClassify({equCategoryId:obj[i].equCategoryId,equipmentCategoryName:obj[i].equipmentCategoryName});
						break;
					}
				}
			}else if(parm=="equName"){
				for(var i=0;i<obj.length;i++){
					if(obj[i].equNameId==$scope.equ_List.equNameId){
						$scope.saveValueOfEquList({equCategoryId:obj[i].equCategoryId,equNameId:obj[i].equNameId});
						break;
					}
				}
			}else if(parm=="equType" && $scope.formParms.equType==""){
				$scope.changeModelNoValue('selectModelName','inputModelName','repeatModelName');
			}else if(parm=="specifications" && $scope.formParms.specifications==""){
				$scope.changeModelNoValue('selectStandardName','inputStandardName','repeatStandardName');
			}
		}
	};
	/*
   	 * 弹出选择设备信模态框
     */
    $scope.openChoEquModal = function () {
		$scope.inputModel=null;
    	$scope.equ_List = {};
    	$scope.radioTrIndex=null;
    	$scope.ChoeDemandModule = true;
    	$("#fade,#openwin3").show();
		$scope.queryCategoryData(); 
		
		
    };
    
    
	
	/**
	 * 设备名称点击的时候获取所选的值赋值给对象equ_List用于当查询按钮的查询条件
	 */
    $scope.saveValueOfEquList = function(e){
		$scope.equ_List.equNameId = e.equNameId;//赋值后用于查询的条件
		$scope.equ_List.equCategoryId = e.equCategoryId;
		
		
		$scope.equBrand_ = {};
		$scope.equBrand_.id = e.equNameId;//用于查询品牌集合传的id
	};
	//名称
	$scope.queryClassify=function(obj){
		$scope.equ_List.equNameId = "";
		$scope.equ_List.class_ = obj.equipmentCategoryName;//保存这个name值用于查询按钮的查询条件
		$scope.equ_List.equCategoryId = obj.equCategoryId;
		function qSucc(rec){
				$scope.equList=rec.content;
				//$scope.paginationConfQueryClassify.totalItems = rec.totalElements;/*查询出来的数据总数*/
			}
			function qErr(rec){}
			category.unifydo({
				Action:"EquName",
				equCategoryId:obj.equCategoryId,
				pageNo : $scope.paginationConf.currentPage - 1,// 当前页数
				pageSize : $scope.paginationConf.itemsPerPage
			},qSucc,qErr);
	};
     $scope.del=function(){
    
    	$scope.inputModel = null;
    }
  	//单选框
    $scope.selectList={};
    $scope.Select=function(params,parm){
        $scope.equipmentName=params.equName.equipmentName; 
        $scope.inputModel={parm:params.equName.equipmentName};
        $scope.queryEquNameId=params.equName.equNameId;
        $scope.radioTrIndex=parm;
        $scope.equipment_obj = params;
        $scope.showFlag='';
    }; 
    
    
  	/*
  	* 清空选择信息和单选框
  	*/
    $scope.clearMessage = function(){
    	$scope.radioTrIndex={};
    	$scope.selectList={};
    };
    
    /*
	 * 点击"选择"查询数据
	*/
	$scope.queryData={};
	$scope.queryCategoryData=function(PageNo)
	{
		function qSucc(rec)
		{
			if(rec.content.length == 0){
				$scope.queryCategoryData();
				$.messager.popup("无相应记录");
				return;
			}
			$scope.queryCategory();
			$scope.categoryList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function qErr(rec){}
	
		
		
		category.unifydo({
			Action:"All",
		    relationType:1,
			/* equState:1, */
			pageNo : $scope.paginationConf.currentPage - 1,// 当前页数
			pageSize : $scope.paginationConf.itemsPerPage
		},qSucc,qErr);
	}; 
	
	/*
	 * 查询下拉框分类信息
	*/
	$scope.queryCategory=function(){
		function qSucc(rec){
			$scope.categorySelectList=rec.content;
			$scope.categorySelectListUpd=rec.content;
		}
		function qErr(rec){}
		category.unifydo({
			Action:"EquCategory",
			pageNo:0,pageSize:99
		},qSucc,qErr);
	};
	
	/*
	 * 选择下拉框分类信息时，查询分类名称
	 */
	$scope.changeEquipmentCategoryName=function(parm){
		var o = document.getElementById("attrTypeSelect");
		$scope.formParms.equipmentCategoryName=o.options[o.selectedIndex].text;
		for(var i=0;i<$scope.categorySelectList.length;i++){
			if($scope.categorySelectList[i].equipmentCategoryNo==parm){
				parm=$scope.categorySelectList[i].equCategoryId;
				break;
			}
		}
		function qSucc(rec){
			$scope.nameSelectList=rec.content;
		}
		function qErr(rec){}
		category.unifydo({ Action:"EquName",equCategoryId:parm,pageNo:0,pageSize:99 },qSucc,qErr);
	};
	
	/*
	 * 点击搜索查询数据
	*/
 	$scope.queryData={};
	$scope.queryCategoryDataA=function(pageNo)
	{
		function success(rec)
		{
			if(pageNo){
				$scope.paginationConf.currentPage=1;
			}
			if(rec.content.length == 0){
				$.messager.popup("无相应记录");
				$scope.equ_List.equNameId="";
				$scope.categoryList.length =0;
				return;
			}
			$scope.categoryList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
        function error(rec){}
		
		$scope.equ_List.Action="ByEquCategoryName";
		$scope.equ_List.pageNo=$scope.paginationConf.currentPage-1;
		$scope.equ_List.pageSize=$scope.paginationConf.itemsPerPage;
		$scope.equ_List.relationType = 1;
		
		
		
		
		
		
		category.unifydo($scope.equ_List,success,error);
	}; 
	
	
	/*
	*新增页面确定事件-弹出新窗口
	*/
	$scope.ChoeDemandModule = true;
	$scope.selectSubmit=function(obj,param,input){
		if($scope.queryEquNameId==null&&input==null){
			$.messager.popup("请您选择一条设备信息");
			return;
		}		
		$scope.input=input.parm;
	    $scope.openEquipmentUpdModal(obj.equName); 
		$scope.equipmentName = $scope.input;
		$scope.selectList.equipmentName = $scope.equipmentName;
		if($scope.queryEquNameId||$scope.input){
			//select下拉框选择项
			$scope.brandSelectShow=true;
			$scope.modelSelectShow=true;
			$scope.standardSelectShow=true;
			//input输入框
			$scope.brandInputShow=false;
			$scope.modelInputShow=false;  
			$scope.standardInputShow=false;
			$scope.ChoeDemandModule = false;
			$scope.queryEquBrand($scope.queryEquNameId);
			$('#fade,#openwin4').show();
			$('#openwin3').hide()
		
		}else{
			
		}
		return;
		
		if($scope.selectList.equipmentName){
			//select下拉框选择项
			$scope.brandSelectShow=true;
			$scope.modelSelectShow=true;
			$scope.standardSelectShow=true;
			//input输入框
			$scope.brandInputShow=false;
			$scope.modelInputShow=false;
			$scope.standardInputShow=false;
			$('#fade,#openwin4').show();
			$scope.ChoeDemandModule = false;
			$('#openwin3').hide()
		}else{
			
		}	
		
		
	}
	/////
	$scope.openEquipmentUpdModal=function(obj){	
		function qSucc(rec){
			if(rec){
				$scope.Parm=rec;
			}
		};
		
		function qErr(){};
		
	    category.unifydo({urlPath:obj.equNameId,Action:"EquNameId"},qSucc,qErr);
	
	};
	
	/*
	*新增页面取消事件
	*/
	$scope.cancelSubmit=function(parm){
		    $scope.equ_List = null;
			$scope.radioTrIndex=null;
			$scope.inputModel=null;	
		$('#fade,#openwin3').hide();
	}
	
	
	/*
	*点击手动添加事件
	*/
	$scope.brandSelectShow=true;
	$scope.modelSelectShow=true;
	$scope.standardSelectShow=true;
	$scope.addManual=function(parm){
		if(parm == "Brand"){
			$scope.brandSelectShow=false;
			$scope.brandInputShow=true;
		}else if(parm == "Model"){
			$scope.modelSelectShow=false;
			$scope.modelInputShow=true;
		}
		else if(parm == "Standard"){
			$scope.standardSelectShow=false;
			$scope.standardInputShow=true;
		}
	};
	
	/*
	*点击重选添加事件
	*/
	$scope.addSelect=function(parm){
		if(parm == "Brand"){
			$scope.brandSelectShow=true;
			$scope.brandInputShow=false;
		}else if(parm == "Model"){
			$scope.modelSelectShow=true;
			$scope.modelInputShow=false;
		}
		else if(parm == "Standard"){
			$scope.standardSelectShow=true;
			$scope.standardInputShow=false;
		}
	}
	
	/*
	*选择确定事件
	*/
	$scope.selectList.brandS="";
	$scope.selectList.brandI="";
	$scope.selectList.modelS="";
	$scope.selectList.modelI="";
	$scope.selectList.standardS="";
	$scope.selectList.satndardI="";
	$scope.addModelSubimt=function(){
		
		if($scope.brandInputShow){
			/*赋值品牌*/
			//$scope.queryEquBrandList.newBrandName=$scope.selectList.brandI;
			$scope.queryEquBrandListCopy.newBrandName=$scope.selectList.brandI;
		}
		if($scope.modelInputShow){
			/*赋值型号*/
			$scope.queryEquModelList.newModelName=$scope.selectList.modelI;
		}
		if($scope.standardInputShow){
			/*赋值规格*/
			$scope.queryEquStandardList.newStandardName=$scope.selectList.satndardI;
		}
		if($scope.brandSelectShow){
			/*赋值品牌*/
			//$scope.queryEquBrandList.newBrandName=$scope.queryEquBrandList.newBrandName;
			$scope.queryEquBrandListCopy.newBrandName = $scope.queryEquBrandListCopy.newBrandName;
		}
		if($scope.modelSelectShow){
			/*赋值型号*/
			$scope.queryEquModelList.newModelName=$scope.queryEquModelList.newModelName;
		}
		if($scope.standardSelectShow){
			/*赋值规格*/
			$scope.queryEquStandardList.newStandardName=$scope.queryEquStandardList.newStandardName;
		
		}
			//$scope.selectList.manufacturer=$scope.queryEquBrandList.newBrandName;
			$scope.selectList.manufacturer=$scope.queryEquBrandListCopy.newBrandName;
			$scope.selectList.modelNumber=$scope.queryEquModelList.newModelName;		
			$scope.selectList.specifications=$scope.queryEquStandardList.newStandardName;
			
			$scope.formParms.infoTitle=$scope.selectList.manufacturer?"【"+$scope.selectList.manufacturer+"】":"";
			$scope.formParms.infoTitle+=$scope.selectList.equipmentName;
			
			if($scope.selectList.modelNumber)
			{
				if($scope.selectList.specifications){$scope.formParms.infoTitle+="("+$scope.selectList.modelNumber+","+$scope.selectList.specifications+")";}
				else
				{
					$scope.formParms.infoTitle+="("+$scope.selectList.modelNumber+")";
				}
			}
			else
			{
				if($scope.selectList.specifications){$scope.formParms.infoTitle+="("+$scope.selectList.specifications+")";}
			}
			
		
		$('#openwin4,#fade').hide();
		
	}
	
	/*
	*选择取消事件
	*/
	$scope.addModelCancel=function(){
		$('#openwin4,#fade').hide();
	}
	
	
	
	
	/*
	*品牌
	*/
	$scope.queryEquBrandList={};
	$scope.queryEquBrand=function(parm){
		function qSucc(rec){
			$scope.queryEquBrandList=rec.content;
		}
		function qErr(){}
		published.unifydo({Action:"queryEquBrand",id:parm,pageSize:20},qSucc,qErr);
	};
	
	/*
	*品牌点击效果
	*/
	$scope.queryEquBrandListCopy = {};
	$scope.brandChange=function(parm){
		for(var i=0;i<$scope.queryEquBrandList.length;i++){
			if(parm == $scope.queryEquBrandList[i].id){
				//$scope.queryEquBrandList.newBrandName=$scope.queryEquBrandList[i].name;
				$scope.queryEquBrandListCopy.newBrandName=$scope.queryEquBrandList[i].name;
			}
		}
		if(parm){
			$scope.queryEquModel(parm);
			$scope.queryEquStandard(parm);
		}
	};
	
	/*
	*型号
	*/
	$scope.queryEquModelList={};
	$scope.queryEquModel=function(parm){
		function qEmSucc(rec){
			$scope.queryEquModelList=rec.content;
		}
		function qEmErr(){}
		published.unifydo({Action:"queryEquModel",id:parm,pageSize:20},qEmSucc,qEmErr);
	};
	
	/*
	*型号点击效果
	*/
	$scope.modelChange=function(parm){
		for(var i=0;i<$scope.queryEquModelList.length;i++){
			if(parm == $scope.queryEquModelList[i].id){
				$scope.queryEquModelList.newModelName=$scope.queryEquModelList[i].name;
			}
		}
		
	};
	
	
	/*
	*规格
	*/
	$scope.queryEquStandardList={};
	$scope.queryEquStandard=function(parm){
		function qEsSucc(rec){
			$scope.queryEquStandardList=rec.content;
		}
		function qEsErr(){}
		published.unifydo({Action:"queryEquStandard",id:parm,pageSize:20},qEsSucc,qEsErr);
	}
	
	/*
	*规格点击效果
	*/
	$scope.standardChange=function(parm){
		for(var i=0;i<$scope.queryEquStandardList.length;i++){
			if(parm == $scope.queryEquStandardList[i].id){
				$scope.queryEquStandardList.newStandardName=$scope.queryEquStandardList[i].name;
			}
		}
	};
	
	
	/**
	 * 每三位数字添加一个逗号分隔符号
	 */
 	$scope.formData={};              //num为传入的值，parm为复用的属性 ，flag为区分的标志这里可能不需要
 	$scope.centsCopyFive = '';
	$scope.formatMoney=function(num,parm,counts){//参数分别是：num=输入值，parm=属性,flag=区分添加和修改的符号，counts=小数点最多几位
		$scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
		if(num==null||num==""){
			return;
		}else{
			$scope.numArray_=num.split("");//把输入的字符变成数组用于判断其中点的数目
		}
		for(var i=0;i<num.length;i++){//数值第一位不能是0，是0就返回0
			if(num[1] == 0){
				$scope.formParms[parm] = 0;
				return;
			}
			
		}
		/* for(var i=0;i<num.length;i++){//数值第二位不是  . ，是0就返回0
				if(num[1] !== '.'){
					$scope.formParms[parm] = 0;
					return;
				}	
			} */
		for(var i=0;i<$scope.numArray_.length;i++){//不能有2个以上的小数点否则为0
			if($scope.numArray_[i] == '.'){
				$scope.test_.push($scope.numArray_[i]);
				if($scope.test_.length>1){
					$scope.formParms[parm] = 0;
					return;
				}
			}
		}
		//检索点号的位置或者说是否有点号
		var judge = num.indexOf(".");
		var cents='';//包括小数点之后
		var centsCopy =0;//不包括小数点之后
		//如果有点号之前的值存在（间接判定了点号不是第一位，第一位的时候judge==0）
		if(judge>0){
			cents = num.substring(judge, num.length);//包括点开始截取到完结
			centsCopy = cents.substring(1,cents.length);//截取（不包括小数点）点之后的数字原意是根据这个去判断如果小数点之后的字符有不是数字的判定输出结果为0
			num = num.substring(0,judge);//截取（不包括点）点之前的数字
			
			if(centsCopy.length==counts){//当小数点后面的位数达到软需要求时记录数值
				$scope.centsCopyFive = centsCopy;
			}
			
			if(centsCopy.length>counts){//当小数点后面的位数超过软需要求时，把之前存的值赋值回cents,达到只能输入固定小数点位数
				cents = '.'+$scope.centsCopyFive;
			}
		}
		num = num.toString().replace(/\,/g,'');//全局匹配有没有逗号，有就清除，用于清除上次的逗号在进行排版
		//如果num不是数字就赋值为0   这个不完美如果小数点后有字母不为0
		if(isNaN(num)){
			num = "0";
		}
		if(isNaN(centsCopy)){//如果小数点后面的值有不为数字的字符就把小数点之前的置为0，包括小数点之后的字符为空，这样起到如果有不为数字的字符就为0
			num = "0";
			cents = "";
		}
		if(parm=='price'){
		for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++){
			num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3));
		 }
		}
		//如果有小数点算上小数点赋值
		if(cents.length!=0){
			$scope.formParms[parm] = num+cents;
			 if($scope.formParms[parm].length > 18){
             	$scope.formParms[parm] =0;
             }
		}else{
			//没有直接加小数点之前的赋值
			$scope.formParms[parm] = num;
			 if($scope.formParms[parm].length > 18){
             	$scope.formParms[parm] =0;
             }
		}
	};
	
	/* X号 */
	  $scope.inputFocus = function(parm)
            {
            	if(parm == "priceFlag"){
            		$scope.priceFlag=true;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "AddressFlag"){
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=true;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "infoTitleFlag"){
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=true;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "contactAddressFlag"){
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=true;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "contactPersonFlag"){
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=true;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "contactPhoneFlag"){
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=true;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "qqNoFlag"){
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=true;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "inputCodeFlag"){
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=true;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=false;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            	}
            	else if(parm == "tenancyFlag")
            	{
            		$scope.priceFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.AddressFlag=false;
            		$scope.tenancyFlag=true;
            		$scope.quantityFlag=false;
            		$scope.enterpriseNameFlag=false;
            }
	                 else if(parm == "quantityFlag")
	        	  {
	        		$scope.priceFlag=false;
	        		$scope.infoTitleFlag=false;
	        		$scope.contactAddressFlag=false;
	        		$scope.contactPersonFlag=false;
	        		$scope.contactPhoneFlag=false;
	        		$scope.qqNoFlag=false;
	        		$scope.inputCodeFlag=false;
	        		$scope.AddressFlag=false;
	        		$scope.tenancyFlag=false;
	        		$scope.quantityFlag=true;
	        		$scope.enterpriseNameFlag=false;
	           }
		           else if(parm == "enterpriseNameFlag")
		     	  {
		     		$scope.priceFlag=false;
		     		$scope.infoTitleFlag=false;
		     		$scope.contactAddressFlag=false;
		     		$scope.contactPersonFlag=false;
		     		$scope.contactPhoneFlag=false;
		     		$scope.qqNoFlag=false;
		     		$scope.inputCodeFlag=false;
		     		$scope.AddressFlag=false;
		     		$scope.tenancyFlag=false;
		     		$scope.quantityFlag=false;
		     		$scope.enterpriseNameFlag=true;
		        };
           }
	
	/* 点击X */
	
	  $scope.deleteText=function(parm){
      	if(parm == "priceFlag"){
      		$scope.formParms.price=" ";
      		$scope.priceFlag=false;
      	}
      	else if(parm == "enterpriseNameFlag"){
      		$scope.formParms.enterpriseName=" ";
      		$scope.enterpriseNameFlag=false;
      	}
      	else if(parm == "infoTitleFlag"){
      		$scope.formParms.infoTitle=" ";
      		$scope.infoTitleFlag=false;
      	}
      	else if(parm == "contactAddressFlag"){
      		$scope.formParms.contactAddress=" ";
      		$scope.contactAddressFlag=false;
      	}
      	else if(parm == "contactPersonFlag"){
      		$scope.formParms.contactPerson=" ";
      		$scope.contactPersonFlag=false;
      	}
      	else if(parm == "contactPhoneFlag"){
      		$scope.formParms.contactPhone=" ";
      		$scope.contactPhoneFlag=false;
      	}
      	else if(parm == "qqNoFlag"){
      		$scope.formParms.qqNo=" ";
      		$scope.qqNoFlag=false;
      	}
      	else if(parm == "inputCodeFlag"){
      		$scope.formParms.inputCode=" ";
      		$scope.inputCodeFlag=false;
      	}else if(parm == "quantityFlag"){
      		$scope.formParms.quantity=" ";
      		$scope.quantityFlag=false;
      	}else if(parm == "AddressFlag"){
      		$scope.formParms.address=" ";
      		$scope.AddressFlag=false;
      	}else if(parm == "tenancyFlag"){
      		$scope.formParms.tenancy=" ";
      		$scope.tenancyFlag=false;
      	}
      } 
	
	  $scope.FormBlur=function(){
  		var tag=window.event.target;
  		if(tag && tag.tagName.toLowerCase()=="div"){
  			$scope.priceFlag=false;
     		$scope.infoTitleFlag=false;
     		$scope.contactAddressFlag=false;
     		$scope.contactPersonFlag=false;
     		$scope.contactPhoneFlag=false;
     		$scope.qqNoFlag=false;
     		$scope.inputCodeFlag=false;
     		$scope.AddressFlag=false;
     		$scope.tenancyFlag=false;
     		$scope.quantityFlag=false;
     		$scope.enterpriseNameFlag=false;
  		}
  	};
	/*
	*返回首页
	*/
	$scope.goBack=function(){
		window.location.href = "/WebSite/Front/Main/HomePage.jsp";
	}
  
	/*
    为富文本添加监听内容变化的事件
	*/
	$scope.detailedDescriptionTemp={};
	$scope.detailedDescriptionTemp.count=0;
	$scope.ue.addListener('contentchange',function(){
		var count =$scope.ue.getContentLength(true);
		$scope.detailedDescriptionTemp.count=count;
		
		$scope.$apply(function(){});
	});
	
	setTimeout(function() {
	    $scope.$apply(function() {
	    	var inputs = document.getElementsByTagName("input");
	    	var pf=new window.placeholderFactory(); 
	    	pf.createPlaceholder(inputs);
	    	//document.getElementById("eeeee").value="asd";
	    });  
	}, 500);
	
});
</script>
<style type="text/css">
    ::-ms-clear, ::-ms-reveal{display: none;}
	.container {width: 1500px !important;}
	 a {
            text-decoration: none;
            font-size: 12px;
           /*  color: #288bc4; */
        }
        a:hover {
            text-decoration: none;
        }
	.form-horizontal .control-label {
	    font-size: 14px;
        color: #000;
		padding-top: 7px;
		margin-bottom: 0;
		text-align: right;
		min-width : 0px;
	}
	.form-control{
		        border-radius:0px;	
		 }
	.page-list .pagination {float:left;}
	.page-list .pagination span {cursor: pointer;}
	.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
	.page-list .pagination .separate span:hover {background: none;}
	.page-list .page-total {float:left; margin: 25px 20px;}
	.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
	.page-list .page-total input {width: 40px; padding-left:3px;}
	.page-list .page-total select {width: 50px;}
	.table-hover > tbody > tr:hover > td,
	.table-hover > tbody > tr:hover > th {
		  background-color: #f5f5f5;
	}
</style>

</head>
<body ng-app="infoPubApp" ng-controller="infoPubController" class="container">
<jsp:include page="../Main/Top.jsp"/>
	<form action="" style="width: 95%" novalidate name="InfoAddForm" ng-click="FormBlur();">
		<div class="form-horizontal" style="margin-top: 10px;margin-left:50px;">
			 <div class="col-xs-12" style="margin-top: -20px"><div class="position"><span>&gt;</span>  &nbsp;首页  &nbsp; <span>&gt;</span> &nbsp;发布求租信息  &nbsp;</div>  </div>
			<div class="modal-body">
				<div class="form-horizontal" style="background-color: #f7f7f7;">
					<div class="panel " style="margin-top: ">
					</div>
					<!-- 设备选择  -->
					<div class="form-group">
	                    <label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>设备选择：</label>
	                    
	                    <div class="col-xs-2">
	                    <a href="##returnId">
	                        <input type="button" class="btn btn-primary" style="width: 92px;background: #0057b4;" value="选择" id="hq2" ng-click="openChoEquModal();"></a>
	                        <input type="hidden" class="inpt_a inpt_o span110" name="equipmentName" ng-model="selectList.equipmentName" >
	                    </div>
	                    <div class="col-xs-1" ng-messages="InfoAddForm.equipmentName.$error" ng-show="showFlag == 'equipmentName'">
	                        <p class="form-control-static" style="color:red;">请选择设备</p>
	                    </div>
	                </div>
					<!-- 设备信息  -->
	                <div class="form-group" ng-show="selectList.equipmentName!=null" >
	                    <label contenteditable="false" class="col-xs-2 control-label" >设备信息：</label>
	                    <div class="col-xs-8">
	                        <table class="table table-bordered" style="background-color: #F5F5F5;margin-bottom: 15px;">
	                            <tbody>
		                            <tr>
		                                <th style="width:2%;text-align: right;">设备名称：</th>
		                                <td style="width:3%;" colspan="5">{{selectList.equipmentName}}</td>
		                            </tr>
		                            <tr>
		                            	<th style="width:2%;text-align: right;">品牌：</th>
		                                <td style="width:3%;">{{selectList.manufacturer}}</td>
		                                <th style="width:2%;text-align: right;">型号：</th>
		                                <td style="width:3%;">{{selectList.modelNumber}}</td>
		                                <th style="width:2%;text-align: right;">规格：</th>
		                                <td style="width:3%;">{{selectList.specifications}}</td>
		                            </tr>
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
					<!-- 设备使用地点  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>设备使用地点：</label>
						
						<div class="col-xs-2">
							<select id="province" name="province" class="inpt_a inpt_o span110" ng-model="recP.proModel" style="position: absolute;z-index:3;"
								ng-options="recP.name as recP.name for recP in areaList" ng-change="changePro(recP);" 
								 ng-disabled="procheck">  														
                        		
                        		<option value="">请选择省份</option>
                    		</select>
                   		</div>
                   		<div class="col-xs-2">  																		
                    		<select class="inpt_a inpt_o span110" id="city" name="city" ng-model="recC.recModel" style="position: absolute;z-index:3;margin-left: 5px"
                    			ng-options="recC.name as recC.name for recC in pList" ng-change="changeCity(recC);" 
                    			 ng-disabled="citcheck">              	
								<option value="">请选择城市</option>  
                    		</select>
                   		</div>
                   		<div class="col-xs-2">  																		 
                    		<select class="inpt_a inpt_o span110" id="district" name="district" ng-model="recD.disModel" style="position: absolute;z-index:3;margin-left: 10px"
                    			ng-options="recD.name as recD.name for recD in cList" ng-change="changeDis(recD)"
                    			 ng-disabled="discheck">                         		
                        		<option value="">请选择区县</option>  
                    		</select>
                   		</div>
						<div class="col-xs-2">
							<label class="checkbox-inline" style="margin-left:20px;">						   
								<input name="allProvince" ng-model="tmp.reason" type="checkbox" ng-change="changeCheck(tmp.reason)">全国								
							</label>
						</div>
						<div class="col-xs-10">
							<div style="float: right;margin-top:-20px;margin-right: 200px;" ng-show="showFlag == 'province'">
								<p class="" style="color: red;margin-top: 3px;">请选择所在省份</p>
							</div>
							<div style="float: right;margin-top:-20px;margin-right: 200px" ng-show="showFlag == 'city'">
								<p class="" style="color: red;margin-top: 3px;">请选择所在城市</p>
							</div>
							<div style="float: right;margin-top:-20px;margin-right: 200px" ng-show="showFlag == 'district'">
								<p class="" style="color: red;margin-top: 3px;">请选择所在区县</p>
							</div>
						</div>
					</div>
					<!-- 详细地址  --> 
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: 5px">详细地址：</label>
						<div class="col-xs-6"  style="margin-top: 5px">
	                        <input type="text" class="inpt_a inpt_o span110" name="address" ng-model="formParms.address" maxlength="50" ng-focus="inputFocus('AddressFlag');">
		                <button ng-show="AddressFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('AddressFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
		                </div>
					</div>
					<!-- 租金单价  -->	
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>租金单价：</label>
						
						<div class="col-xs-2">
							<input type="text" class="inpt_a inpt_o span110" id="price" name="price" ng-model="formParms.price"
								placeholder="请输入正整数" maxlength="18" ng-change="formatMoney(formParms.price,'price',2);" required ng-focus="inputFocus('priceFlag');">
								<button ng-show="priceFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('priceFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
						<div class="col-xs-1">
							<select class=" sel_a sel_ay" ng-model="formParms.priceType" style="position: absolute;z-index:3;width:100%;height: 34px;margin-top: 0px;color: #555;" ;
								 name="priceType" >
								<option value="1" ng-selected="true">元/月</option>
								<option value="2">元/天</option>
								<option value="3">元/小时</option>
							</select>
						</div>
						<div class="col-xs-2">
							<div ng-messages="InfoAddForm.price.$error" ng-show="showFlag == 'price'">
								<p class="form-control-static" style="color: red;margin-left:30px;margin-top:2px;" ng-message="required">请您填写正确的价格</p>
							</div>
						</div>
					</div>
					<!-- 租期  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>租&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;期：</label>
						
						<div class="col-xs-2">
							<input type="text" class="inpt_a inpt_o span110" ng-model="formParms.tenancy" id="tenancy" name="tenancy" ng-pattern="/^[0-9]+$/" required placeholder="请输入正整数" maxlength="3" ng-focus="inputFocus('tenancyFlag');">
						    <button ng-show="tenancyFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('tenancyFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
						<div class="col-xs-1">
							<select class=" sel_a sel_ay" ng-model="formParms.tenancyType" style="position: absolute;z-index:1;width:100%;height: 34px;margin-top: 0px;color: #555;" ;
								 name="priceType">
								<option value="1" ng-selected="true">个月</option>
								<option value="2">天</option>
								<option value="3">年</option>
							</select>
						</div>
						<div class="col-xs-2">
							<div ng-messages="InfoAddForm.tenancy.$error" ng-show="showFlag == 'tenancy'">
								<p class="form-control-static" style="color: red;margin-left:30px;margin-top:2px;" ng-message="pattern">请您填写正确的租期</p>
								<p class="form-control-static" style="color: red;margin-left:30px;margin-top:2px;" ng-message="required">请输入租期</p>
							</div>
						</div>
					</div>
					<!-- 数量  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量：</label>
						
						<div class="col-xs-2">								
					      <input type="text" class="inpt_a inpt_o span110" id="quantity" name="quantity" ng-model="formParms.quantity"	placeholder="请输入正整数" maxlength="15" ng-change="formatMoney(formParms.quantity,'quantity',5);" required ng-focus="inputFocus('quantityFlag');">
						  <button ng-show="quantityFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('quantityFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
						<div class="form-control-static" style="width:30px; margin-left:489px; margin-top:3px;" ng-model="formParms.second" ng-show="Parm.second==null">台</div>
						<div class="form-control-static" style="width:30px; margin-left:489px; margin-top:3px;" ng-model="formParms.second" ng-show="Parm.second==1">台</div>
						<div class="form-control-static" style="width:30px; margin-left:489px; margin-top:3px;" ng-model="formParms.second" ng-show="Parm.second==2">辆</div>
						<div class="form-control-static" style="width:30px; margin-left:489px; margin-top:3px;" ng-model="formParms.second" ng-show="Parm.second==3">套</div>
						<div ng-messages="InfoAddForm.quantity.$error" ng-show="showFlag == 'quantity'">
							<p class="form-control-static" style="color: red; margin-left:550px; margin-top:-31px;" ng-message="required">请您填写数量</p>
							<p class="form-control-static" style="color: red; margin-left:550px; margin-top:-31px;" ng-message="pattern">请您填写正确的数量</p>
						</div>
					</div>
					<!-- 信息标题  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>信息标题：</label>
						
						<div class="col-xs-6"  >
	                    <!-- data-placement="right" data-toggle="tooltip" maxlength="30"  -->
	                        <input type="text" class="inpt_a inpt_o span110" name="infoTitle" 
	                               ng-model="formParms.infoTitle"  ng-focus="inputFocus('infoTitleFlag');" required ng-minlength="2"  maxlength="100">
	                        <button ng-show="infoTitleFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('infoTitleFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
		                </div>
		                <div class="col-xs-3" ng-messages="InfoAddForm.infoTitle.$error" ng-show="showFlag == 'infoTitle'">
		                    <p class="form-control-static" style="color:red;margin-top:2px;" ng-message="required"> 请输入信息标题</p> 
		                </div>
		                <div class="col-xs-3" ng-messages="InfoAddForm.infoTitle.$error" ng-show="showFlag == 'infoTitle2'">
		                    <p class="form-control-static" style="color: red;" ng-message="minlength" >信息标题不可少于2个汉字请补充</p> 
	                    </div>
					</div>
					<!-- 详细说明  -->
					
					
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>详细说明：</label>
						
						<div class="col-xs-6">
							<!-- <textarea class="inpt_a inpt_o span110" rows="10" ng-model="formParms.detailedDescription" name="detailedDescription" maxlength="2000" required></textarea> -->
							<textarea style="margin-left:-1px;margin-bottom: 3px;" ng-model="formParms.detailedDescriptionTemp" id="myEditor" rows="10"
                        	 		   name="detailedDescriptionTemp" maxlength="2000"></textarea>
							
							<font class="Infopub_a1" style="color: #cc0001">温馨提示：输入内容越详细，用户越容易找到此类信息！</font>
						</div>
						<div class="col-xs-3"
							ng-messages="InfoAddForm.detailedDescription.$error" ng-show="showFlag == 'detailedDescription'">
							<p class="form-control-static" style="color: red;margin-top:15px;">请输入详细说明，内容越详细，用户越容易找到此类信息！</p>
						</div>
					</div>					
					
					
					
					
					
<!--  					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label">详细说明：<p style="width:20px; color: red;margin-left:203px;margin-top:-16px;">*</p></label>
						error?
						<div class="col-xs-7">
							<textarea style="margin-bottom: 3px;" class="inpt_a inpt_o span110" rows="10" ng-model="formParms.detailedDescription" name="detailedDescription" maxlength="2000" required></textarea>
							<textarea style="margin-left:-1px;margin-bottom: 3px;" id="myEditor" rows="10"
                        	 		   name="detailedDescription" maxlength="2000" ng-model="formParms.detailedDescription" required></textarea>
							说明：您可以输入<lable style="color: #FF9834">{{2000-formParms.detailedDescription.length}}</lable>个字。
							<font style="color:#FF9834">温馨提示：输入内容越详细，用户越容易找到此类信息！</font>
						</div>
						<div class="col-xs-1"
							ng-messages="InfoAddForm.detailedDescription.$error" ng-show="showFlag == 'detailedDescription'">
							<p class="form-control-static" style="color: red;margin-top:15px;" ng-message="required">请输入详细说明，内容越详细，用户越容易找到此类信息！</p>
						</div>
					</div> -->
					
					
						<hr>
			          	<!-- 联系方式  -->
			          	<div class="form-group" style="margin-left:-44px;">
		         	 		<label contenteditable="false" class="col-xs-2 col-xs-offset-3 control-label" style="font-size:18px;margin-left: 0px;color:#017cfe;">联系方式</label>
			          	</div>
					<!-- 单位名称  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>单位名称：</label>
                        
						<div class="col-xs-3">
							<input type="text" class="inpt_a inpt_o span110" id="enterpriseName"
								name="enterpriseName" ng-model="formParms.enterpriseName" maxlength="30" required ng-focus="inputFocus('enterpriseNameFlag');">
						    <button ng-show="enterpriseNameFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('enterpriseNameFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
						<div class="col-xs-2" ng-messages="InfoAddForm.enterpriseName.$error" ng-show="showFlag == 'enterpriseName'">
							<p class="form-control-static" style="color: red;margin-top:3px;" ng-message="required">请输入单位名称</p>
						</div>
					</div>
					<!-- 所在城市  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>所在城市：</label>
						
						<div class="col-xs-2">
							<select id="province" name="proA"  ng-model="recPro.proAModel" class="sel_a sel_ay" 
							    style="position: absolute;z-index:2;width:100%;height: 34px;margin-top: 0px;color: #555;margin-left: 0px"
								ng-options="recPro.name as recPro.name for recPro in areaListA" ng-change="changeProA(recPro);" 
								 required>  
																						
                        		<option value="">请选择省份</option>
                    		</select>
                   		</div>
                   		<div class="col-xs-2">  																		
                    		<select id ="cityA" class="sel_a sel_ay" name="cityA" ng-model="recCit.cityAModel"  style="position: absolute;z-index:3;width:100%;height: 34px;margin-top: 0px;color: #555;margin-left: 5px"
                    			ng-options="recCit.name as recCit.name for recCit in pListA" ng-change="changeCityA(recCit);" 
                    			 required>  
                        		<option value="">请选择城市</option>  
                    		</select>
                   		</div>
                   		<div class="col-xs-2">  																		 
                    		<select id="districtA" class="sel_a sel_ay" name="districtA" ng-model="recDis.disAModel"  style="position: absolute;z-index:3;width:100%;height: 34px;margin-top: 0px;color: #555;margin-left: 10px"
                    			ng-options="recDis.name as recDis.name for recDis in cListA" ng-change="changeDisA(recDis)"
                    			 required>  
                        		<option value="">请选择区县</option>  
                    		</select>
                   		</div>
						<div class="col-xs-1" ng-messages="InfoAddForm.proA.$error" ng-show="showFlag == 'proA'">
							<p class="form-control-static" style="color: red;margin-left:26px; margin-top:3px;width:130px;" ng-message="required">请选择所在省份</p>
						</div>
						<div class="col-xs-1" ng-messages="InfoAddForm.citA.$error" ng-show="showFlag == 'citA'">
							<p class="form-control-static" style="color: red;margin-left:26px; margin-top:3px;width:130px;" ng-message="required">请选择所在城市</p>
						</div>
						<div class="col-xs-1" ng-messages="InfoAddForm.disA.$error" ng-show="showFlag == 'disA'">
							<p class="form-control-static" style="color: red;margin-left:26px; margin-top:3px;width:130px;" ng-message="required">请选择所在区县</p>
						</div>
					</div>
					<!-- 详细地址  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label">详细地址：</label>
						<div class="col-xs-3">
							<input type="text" class="inpt_a inpt_o span110" id="contactAddress"
								name="contactAddress" ng-model="formParms.contactAddress" maxlength="50" ng-focus="inputFocus('contactAddressFlag');">
						    <button ng-show="contactAddressFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('contactAddressFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
					</div>
					<!-- 联系人  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>联&nbsp;&nbsp;系&nbsp;&nbsp;人：</label>
						
						<div class="col-xs-3">
							<input type="text" class="inpt_a inpt_o span110" id="contactPerson"
								name="contactPerson" ng-model="formParms.contactPerson" maxlength="10" required ng-focus="inputFocus('contactPersonFlag');">
						    <button ng-show="contactPersonFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('contactPersonFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
						<div class="col-xs-2">
							<div ng-messages="InfoAddForm.contactPerson.$error" ng-show="showFlag == 'contactPerson'">
								<p class="form-control-static" style="color: red;text-align: left;margin-top:3px;" ng-message="required">请输入联系人姓名</p>
							</div>
						</div>
					</div>
					<!-- 联系电话  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>联系电话：</label>
						
						<div class="col-xs-3">
						<!-- ng-pattern="/(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)/" -->
							<input type="text" class="inpt_a inpt_o span110" id="contactPhone"  ng-pattern="/(^[0-9,\-]{7,}$)/" 
								name="contactPhone" ng-model="formParms.contactPhone" maxlength="17" ng-minlength="11" required ng-focus="inputFocus('contactPhoneFlag');">
						    <button ng-show="contactPhoneFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('contactPhoneFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						 </div>
						<div class="col-xs-2" ng-messages="InfoAddForm.contactPhone.$error" ng-show="showFlag == 'contactPhone'">
							<p class="form-control-static" style="color: red;margin-top:3px;" ng-message="required">请输入联系电话</p>
							<p class="form-control-static" style="color: red;margin-top:3px;" ng-message="pattern">请输入正确的联系电话</p>
							<p class="form-control-static" style="color: red;margin-top:3px;" ng-message="minlength">请输入正确的联系电话</p>
						</div>
					</div>
					<!-- QQ  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label">Q&nbsp;&nbsp;Q：<font style="color: red;"></font></label>
						<div class="col-xs-3">
							<input type="text" class="inpt_a inpt_o span110" id="qqNo" name="qqNo" ng-model="formParms.qqNo" maxlength="15" ng-pattern="/^[0-9]+$/" ng-focus="inputFocus('qqNoFlag');">
						    <button ng-show="qqNoFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('qqNoFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
						<div class="col-xs-2">
							<div ng-messages="InfoAddForm.qqNo.$error" ng-show="showFlag == 'qqNo'">
								<p class="form-control-static" style="color: red;margin-top:3px;" ng-message="pattern">请输入正确的QQ号码</p>
							</div>
						</div>
					</div>
					<!-- 验证码  -->
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码：</label>
						
						<div class="col-xs-2">
							<input type="text" class="inpt_a inpt_o span110" id="inputCode" name="inputCode" ng-model="formParms.inputCode" required maxlength="4" ng-focus="inputFocus('inputCodeFlag');">
						    <button ng-show="inputCodeFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('inputCodeFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
						</div>
						 <div class="col-xs-1" ng-init="GetVercode()">
		                 <div class="code" id="checkCode" ng-click="GetVercode()"></div>
			             </div>
			             <div class="col-xs-2" style="text-align: left;line-height: 40px">
			                 <a ng-click="GetVercode()" href="#" style="color: #288bc4;">看不清，换一张</a>
			             </div>
			             <div class="col-xs-2" ng-messages="InfoAddForm.inputCode.$error" ng-show="showFlag == 'inputCode'">
			                 <p class="form-control-static" style="color:red;margin-left:-100px;margin-top:5px;" ng-message="required">请您填写验证码</p> 
			             </div>
			             <div class="col-xs-2" ng-messages="InfoAddForm.inputCodeErr.$error" ng-show="showFlag == 'inputCodeErr'">
			                 <p class="form-control-static" style="color:red;margin-left:-100px;margin-top:5px;">请您填写正确的验证码</p>
			             </div>
					</div>
					<div style="padding-bottom: 46px;margin-left: 225px">
	                 <input type="button" class="btn " value="发布信息" ng-click="add(InfoAddForm)" style="background-color: #f48a00;color: white;width:140px;height:40px;font-size: 16px;"> 
		             <input type="button" class="btn " value="返回" ng-click="goBack();" style="background-color: #f48a00;color: white;width:140px;height:40px;font-size: 16px;margin-left: 20px">                
	                </div>
				</div>			
			</div>
		</div>		
	</form>
	
	<jsp:include page="../Include/Bottom.jsp"/>
	<!-- /.modal-content -->
	<!-- /.modal -->
	<div ng-include src="'../../../WebSite/Front/Publish/ChoeDemand.jsp'"></div>
    <div ng-include src="'../../../WebSite/Front/Publish/RentAndSaleSucc.jsp'"></div>
</body>

</html>