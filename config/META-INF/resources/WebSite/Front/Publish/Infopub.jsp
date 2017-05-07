<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>发布出租信息</title> 
	<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="../../Front/Include/Head.jsp"/>
	<link href="../../../media/css/emailstyle.css" rel="stylesheet">
	<link href="../../../media/css/heightLight.css" rel="stylesheet">
	<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="../../../media/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="../../../media/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="../../../js/JsSvc/SysCodeConfig.js"></script>
	<script type="text/javascript" src="../../../js/JsSvc/SysCodeTranslate.js"></script>
	<script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
	<script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
	<script type="text/javascript" src="../../../media/js/tm.paginationRentSale.js"></script>
	<script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.fileupload.js"></script>
	<script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.fileupload-ui.js"></script>
	<script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.fileupload-process.js"></script>
	
	<!-- <script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.ui.widget.js"></script> -->
	<!-- <script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.iframe-transport.js"></script> -->
	<script type="text/javascript" src="../../../media/js/common.js"></script>
	
	<script type="text/javascript">
        var app = angular.module('infoPubApp', ['ngResource', 'unifyModule','tm.paginationRentSale', 'angularFileUpload','sysCodeTranslateModule','sysCodeConfigModule', 'ngMessages','Config']);
        app.controller('infoPubController', function ($scope,$timeout,proSvc,rentSvc, SaleSvc,partyConTactSvc , equipment, PicSvc, $upload, regionSvc,sysCodeTranslateFactory, entSvc,SYS_CODE_CON, category,PicUrl) {
        	
        	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
     	    
        	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
        	  $scope.formParms={};
        	
			//$scope.priceType="1";
        	
        	var SYS_USER_INFO={};
        	SYS_USER_INFO.orgId="${sessionScope.userInfo.orgId}";
        	SYS_USER_INFO.orgCode="${sessionScope.userInfo.orgCode}";
        	SYS_USER_INFO.orgName="${sessionScope.userInfo.orgName}";
        	SYS_USER_INFO.orgParentCode="${sessionScope.userInfo.orgParentCode}";
        	SYS_USER_INFO.orgLevel="${sessionScope.userInfo.orgLevel}";
        	SYS_USER_INFO.perName="${sessionScope.userInfo.perName}";
        	SYS_USER_INFO.perMobile="${sessionScope.userInfo.perMobile}";
        	SYS_USER_INFO.perQq="${sessionScope.userInfo.perQq}";
        	SYS_USER_INFO.proId="${sessionScope.userInfo.proId}";
        	SYS_USER_INFO.partyId="${sessionScope.userInfo.perPartyId}";
        	 $scope.formParms.enterpriseName = SYS_USER_INFO.orgName;
        	$scope.userInfo={};

     		$scope.userInfo.orgLevel = SYS_USER_INFO.orgLevel;
     		$scope.userInfo.orgId = SYS_USER_INFO.orgId;
     		$scope.userInfo.orgCode = SYS_USER_INFO.orgCode;
     		$scope.userInfo.orgName = SYS_USER_INFO.orgName;
     		$scope.userInfo.proId = SYS_USER_INFO.proId;
     		$scope.userInfo.proName = SYS_USER_INFO.proName;
     		$scope.userInfo.partyId = SYS_USER_INFO.partyId;
         	$scope.formParm={}
        	$scope.formParm.contactPerson=SYS_USER_INFO.perName;
        	$scope.formParm.contactPhone=SYS_USER_INFO.perMobile;
        	$scope.formParm.qqNo=SYS_USER_INFO.perQq; 
        	
        	
        	$scope.Parm = {};
        	$scope.Parm.second = null;
        	
        	
        	
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
	    		onChange : function(parm1) {
	    		    $scope.paginationConf.currentPage = parm1;                  
                   
                    $scope.MessageBack();
                    $scope.formParms.detailedDescription=null;
                    $scope.zuQi==false;
                    /* $scope.queryallequiData(); */   
                    if($scope.equQryBean.equAtOrgPartyId){
                    	$scope.queryallequiData($scope.paginationConf.currentPage);
                    }
                    $scope.formParms={priceType:"1",enterpriseName:SYS_USER_INFO.orgName,contactPerson:$scope.formParm.contactPerson,contactPhone:$scope.formParm.contactPhone,qqNo:$scope.formParm.qqNo, 'equipmentPic' :'' };
            		if($scope.infoType == 1){
            			$scope.queryPublish();
            			$scope.udp=true;
            		}else{
            			$scope.udp=false;
            		}
	    		}
            
            };
            
            $scope.queryCity=function(){
            	function aSucc(rec){
        			$scope.areaList=[];
        			$scope.areaList=rec;
        		}
        		function aErr(rec){}
        		regionSvc.queryRegionArea({}, aSucc,aErr);//查询省级单位
            };
            $scope.queryCity();
            
            
            
        	/*上一级信息  */
        	$scope.MessageBack = function(currOrgId){//传入参数为在返回上一级按钮出现之前点击的企业id（这个id是每次点击展示下一级企业时手动存储的）
    			function qSucc(rec){
    			
    				$scope.parentOrg={};
    				$scope.parentOrg.name = rec.name;
    				
    				
    			}
    			function qErr(rec){}
    			entSvc.queryPartyInstallDetail({id:SYS_USER_INFO.orgId},qSucc,qErr);
    		};
        	
       
        	
        	/*
        	* 富文本编辑器
        	*/
        	$scope.ue=UE.getEditor('myEditorAA');
    	  	$scope.getEditContent=function(){
    	  		$scope.ue.getContent();
    	  		$scope.ue.setContent($scope.formParms.detailedDescription);
    	  	};
        	
        	//获取页面传递过来的信息
        	var url = location.search;
        	var theRequest = new Object();
        	if (url.indexOf("?") != -1) {
        	    var str = url.substr(1);
        	    strs = str.split("&");
        	    for (var i = 0; i < strs.length; i++) {
        	        theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
        	    }
        	}
        	//接收其他页面传递过来的id和infoType
        	$scope.id=theRequest.id;
        	$scope.infoType=theRequest.infoType;
           /*
        	*如果有已发布页面传过来的值，则进行查询，回显到页面
        	*/
        	$scope.tmp = {};
        	$scope.equiList={};
        	$scope.queryPublish=function(){
        	
         		if($scope.infoType == 1){
         			qSucc=function(rec){
        				$scope.formParms=rec;
        				if($scope.formParms.priceType==1){
        					$scope.formParms.priceType = "1";
        				}
        				if($scope.formParms.priceType==2){
        					$scope.formParms.priceType = "2";
        				}
        				if($scope.formParms.priceType==3){
        					$scope.formParms.priceType = "3";
        				}
    			    	$scope.formParms.enterpriseName = rec.enterpriseName;
        			    $scope.formParms.equipmentId = rec.equipmentTable.equipmentId; 
        			   
        			   if($scope.formParms.shortestLease=='999'){
        			  	 	$scope.zuQi=true;
        				   $scope.tmp.reason2 = 1;
        			   }
        			   $scope.formParms.price = $scope.ct.formatCurrency($scope.formParms.price);
        			    $scope.equiList.equNo = rec.equNo;
        			    $scope.equiList.equName = rec.equName;
        			    $scope.equiList.brandName = rec.brandName;
        			    $scope.equiList.models = rec.equipmentTable.models;
        			    $scope.equiList.specifications = rec.equipmentTable.specifications;
        			    $scope.equiList.power = rec.equipmentTable.power;
        			    if(rec.equipmentTable.technicalStatus=="一类"){
        			    	rec.equipmentTable.technicalStatus=1;
        			    }else if(rec.equipmentTable.technicalStatus=="一类"){
        			    	rec.equipmentTable.technicalStatus=2;
        			    }else{
        			    	rec.equipmentTable.technicalStatus=3;
        			    }
        			    $scope.equiList.technicalStatus = rec.equipmentTable.technicalStatus;
        			    
        			    $scope.equiList.manufacturerName  = rec.equipmentTable.manufacturer;
        			   
        			    $scope.equiList.productionDate = rec.productionDate;
        			   
            			setTimeout(function(){
        	         		$scope.ue.setContent(rec.detailedDescription);
             			},1000)
        				/*弹出修改模态框 根据省中文查出省id，然后依次查询出市数据源和区数据源*/
        				/*查询省市区数据源 start*/
        				$scope.recPro={};
						$scope.recCit={};
						$scope.recDis={};
        				var provinceId="";
        				var cityId="";
        				var cityNum=0;
        				var districtNum=0;
        				for(var i=0;i<$scope.areaList.length;i++){
        					var tmpProvince=$scope.areaList[i];
        					if(tmpProvince.name==rec.onProvince){
        						provinceId=tmpProvince.regionId;
        						provinceNum=i;
        						break;
        					}
        					
        				}
        				regionSvc.queryRegionArea(
        					{regionId:provinceId},
        					function qCitySucc(recProvince){
        						$scope.pList=[];
        						$scope.pList=recProvince;
        						for(var i=0;i<$scope.pList.length;i++){
        							var tmpCity=$scope.pList[i];
        							if(tmpCity.name==rec.onCity){
        								cityId=tmpCity.regionId;
        								cityNum=i;
        								break;
        							}
        						}
        						regionSvc.queryRegionArea(
        							{regionId:cityId},
        							function qSucc(recCity){
        								$scope.cList=[];
        								$scope.cList=recCity;
        								for(var i=0;i<$scope.cList.length;i++){
        									var tmpDistrict=$scope.cList[i];
        									if(tmpDistrict.name==rec.onDistrict){
        										districtNum=i;
        										break;
        									}
        								}
        								/*$scope.pList=[{name:rec.onCity}];
        								$scope.cList=[{name:rec.onDistrict}];*/
        								$scope.recPro.proModel=$scope.formParms.onProvince;
        								$scope.recCit.recModel=$scope.formParms.onCity;
        								$scope.recDis.disModel=$scope.formParms.onDistrict;
        								setTimeout(function(){
        									cityNum=Math.abs($('#city option').length*1-$scope.pList.length*1)+cityNum*1;
        									districtNum=Math.abs($('#district option').length*1-$scope.cList.length*1)+districtNum*1;
        									$('#city')[0].selectedIndex = cityNum;
        									$('#district')[0].selectedIndex = districtNum;
        								},500);
        							},
        							function(recCity){}
        						);
        					},
        					function(recProvince){}
        				);
        				/*查询省市区数据源 end*/
            	  		if($scope.formParms.equipmentPic)
            	        {
            	        	
            	            $scope.pic = $scope.formParms.equipmentPic.split(',');//分割逗号，因本没逗号所以把整个值放入数组pic
            	           
            	            
            	            $scope.PicListD = [];
            	            for ( var i = 0; i < $scope.pic.length; i++) {
            	                var fullname = $scope.pic[i].split('.');//截去点号，为前半段图片名和后半段类型名
            	                $scope.PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};//把两个值分别和一个key匹配放入一个对象内
            	                $scope.PicListD.push($scope.PicOne);
            	                $scope.PicUrl = PicUrl;
            	               
            	            };
            	            //$scope.PicSrc=$scope.PicUrl+"/"+$scope.PicList[0].PicName+"/"+$scope.PicList[0].PicType; //拼出一个链接
            	        }
            	  		
        			}
        			qErr=function(rec){}
         			rentSvc.unifydo({parm:$scope.id},qSucc,qErr);
         		}
        	};
            
        	
        	
         	$scope.fixedTelephone=null;
         	$scope.radioTrIndex = {};
        	/* $scope.fixedTelephone.fixedTelephone2={};
        	$scope.fixedTelephone.fixedTelephone3={};  */
        	/*
        	提交表单后刷新页面
        	*/
        	$scope.closeAndGoBack=function ()
        	{
        		window.location.reload(true);
        	};
        	
            
            $scope.requestParms = theRequest;
            $scope.equipmentid = $scope.requestParms.equipmentId;
            $scope.titleMsg = "免费发布信息步骤：";
            $scope.titleMsg2 = "填写详细内容";
            $scope.titleMsg3 = "> 审核详细内容 > 发布成功";
            
            
            //提示信息
            $(function () { $("[data-toggle='tooltip']").tooltip(); });
			$('li.dropdown').mouseover(function() {$(this).addClass('open');}).mouseout(function() {$(this).removeClass('open');}); 
			
			/*
			 *省份
			*/
			$scope.province="";//省份标识名
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
				}
			
			/*
			 *城市
			*/
			$scope.city="";	//市区标识名
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
				regionSvc.queryRegionArea({regionId:regionId},qSucc,qErr);
			};
			
			/*
			 *区县
			*/
			$scope.district="";//区县标识名
			$scope.changeDis=function(parm){
				
				$scope.formParms.onDistrict=parm.disModel.name;
			};
			/* 外部用户的回显  */
			$scope.Contactinfo=function(){
        		
        		if($scope.userInfo.orgLevel!=='6'){
                	
        			$scope.formParms={priceType:"1",enterpriseName:SYS_USER_INFO.orgName,contactPerson:$scope.formParm.contactPerson,contactPhone:$scope.formParm.contactPhone,qqNo:$scope.formParm.qqNo};
        		}else{
                		  
                			function qSucc(rec){
                				
                				$scope.queryAllList = rec.content; 
                				
                				$scope.formParms={contactPerson:$scope.queryAllList[0].name,contactPhone:$scope.queryAllList[0].tel,qqNo:$scope.queryAllList[0].qq,contactAddress:$scope.queryAllList[0].address};
                				
                				$scope.recPro={};
                        		$scope.recCit={};
                        		$scope.recDis={};
                        		
                        		$scope.pList=[{name:$scope.queryAllList[0].onCity}];
                    			$scope.cList=[{name:$scope.queryAllList[0].onDistrict}]
                            	$scope.recPro.proModel=$scope.queryAllList[0].onProvince;
                    			$scope.recCit.recModel=$scope.queryAllList[0].onCity;
                    			$scope.recDis.disModel=$scope.queryAllList[0].onDistrict;
                			};                			
                			function qErr(){};               			
                			partyConTactSvc.post({currOrgId:SYS_USER_INFO.orgId,pageNo:$scope.paginationConf.currentPage-1,pageSize:$scope.paginationConf.itemsPerPage},qSucc,qErr);               		  
                	  }
        	}
			$scope.Contactinfo();
     
            
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
 
          
           
            /*
             * 添加信息
             */
             $scope.orgName = 2;
            $scope.add = function (obj,tmp) {
       			$scope.formParms.detailedDescription=$scope.ue.getContent();
            	//验证码判断是否正确
                if (!obj.$valid) {
	                 if (!obj.equipmentId.$valid) {
	                    $scope.showFlag = 'equipmentId';
	                    if(obj.equipmentId.$error.required==true){
	                    	$.messager.popup("请选择设备");
	                    }
	                    return;
	                 }
	                 if (!obj.shortestLease.$valid&&$scope.zuQi==false) {
	                	 $scope.showFlag = 'shortestLease';//验证最短租期
	                   if(obj.shortestLease.$error.required==true){	                	   
	                    	if($scope.formParms.shortestLease==7){
	                    	     $.messager.popup("请输入正确的最短租期");
	                    	}else{
	                    		 $.messager.popup("请输入最短租期");
	                    	}
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
	                if(!$scope.formParms.enterpriseName){
	                	$scope.orgName = 1;
	                 	$.messager.popup("请输入联系单位");
	                	return;
	                }else{
	                	$scope.orgName = 2;
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
            	}
               
	            //验证码输入正确校验
	            if( $scope.formParms.inputCode && ($scope.formParms.inputCode.toUpperCase()!=document.getElementById("checkCode").innerHTML.toUpperCase())) {
	                $scope.showFlag = 'inputCodeErr';
	                $.messager.popup("请输入正确的验证码");
	                return;
	            }  
              
                
                var tmpLastIndex = $scope.formParms.equipmentPic.lastIndexOf(",");
                if(tmpLastIndex==$scope.formParms.equipmentPic.length-1){
	                $scope.formParms.equipmentPic = $scope.formParms.equipmentPic.substring(0, $scope.formParms.equipmentPic.length - 1);
                }
                
                
               
                
                function aSucc(rec) {
                	$("#fade,#openwin5").show();
                    $scope.formParms={};
                    $scope.showFlag='';
                }
                function aErr(rec) {
                    $.messager.popup(rec.data.message);
                }
                
                //去掉逗号
                $scope.formParms.price = $scope.formParms.price.toString().replace(/\,/g,'');
               
                $scope.formParms.infoRadio = 1;
                $scope.formParms.equNo = $scope.equiList.equNo;
                $scope.formParms.power = $scope.equiList.power;
                if($scope.equiList.technicalStatus==1){
                    $scope.formParms.technicalStatus = "一类";
                    }else if($scope.equiList.technicalStatus==2){
                    	$scope.formParms.technicalStatus = "二类";
                    }else{
                    	$scope.formParms.technicalStatus = "三类";
                    }
                $scope.formParms.manufacturer = $scope.equiList.manufacturerName;
                $scope.formParms.productionDate = $scope.equiList.productionDate;
                $scope.formParms.equName = $scope.equiList.equName;
                $scope.formParms.brandName = $scope.equiList.brandName;
                $scope.formParms.modelName = $scope.equiList.models;
                $scope.formParms.standardName = $scope.equiList.specifications;
                $scope.formParms.onProvince = $scope.recPro.proModel;
                $scope.formParms.onCity = $scope.recCit.recModel;
                $scope.formParms.onDistrict = $scope.recDis.disModel;
                 if($scope.zuQi==true){
            		$scope.formParms.shortestLease='999';
            		//$scope.tmp.reason2 = true;
            	} 
                if($scope.udp == true){
            	   //$scope.formParms.dataId=$scope.id;
            	   rentSvc.post({urlPath:$scope.id},$scope.formParms, aSucc, aErr);
                }else{
            	   rentSvc.put($scope.formParms, aSucc, aErr);
            	   
                }
            };
            
            
            /*
             * pic
             */
            $scope.upLoadBtn = function () {
                $('input[id=fileUpLoadId]').click();
            };

            $('input[id=fileUpLoadId]').change(function () {
                $scope.upPicName += $(this).val();
            });
           
          
        	$scope.PListLength = 0;
        	
            
            /*
            * 页面输入框得到焦点出现 -- X
            */
            $scope.inputFocus = function(parm)
            {
            	
            	if(parm == "priceFlag"){
            		$scope.priceFlag=true;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.equName=false;
            	}
            	else if(parm == "shortestLeaseFlag"){
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=true;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.equName=false;
            	}
            	else if(parm == "infoTitleFlag"){
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=true;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.equName=false;
            	}
            	else if(parm == "contactAddressFlag"){
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=true;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.equName=false;
            	}
            	else if(parm == "contactPersonFlag"){
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=true;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.equName=false;
            	}
            	else if(parm == "contactPhoneFlag"){
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=true;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.equName=false;
            	}
            	else if(parm == "qqNoFlag"){
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=true;
            		$scope.inputCodeFlag=false;
            		$scope.equName=false;
            	}
            	else if(parm == "inputCodeFlag"){
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=true;
            		$scope.equName=false;
            	}
            	else if(parm == "equName")
            	{
            		$scope.priceFlag=false;
            		$scope.shortestLeaseFlag=false;
            		$scope.infoTitleFlag=false;
            		$scope.contactAddressFlag=false;
            		$scope.contactPersonFlag=false;
            		$scope.contactPhoneFlag=false;
            		$scope.qqNoFlag=false;
            		$scope.inputCodeFlag=false;
            		$scope.equName=true;}
            };
            
            /*
             * 页面输入框点击事件 -- X
             */
            $scope.deleteText=function(parm){
            	if(parm == "priceFlag"){
            		$scope.formParms.price=" ";
            		$scope.priceFlag=false;
            	}
            	else if(parm == "shortestLeaseFlag"){
            		$scope.formParms.shortestLease=" ";
            		$scope.shortestLeaseFlag=false;
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
            	}else if(parm == "equName"){
            		$scope.searBean.equName=" ";
            		$scope.equName=false;
            	}
            } 
            
            
            //删除图片
            $scope.removePic=function(parm,obj){
				var picName = obj.PicName+"."+obj.PicType;//+",";
				var arrPics=$scope.formParms.equipmentPic.split(",");
				$scope.formParms.equipmentPic="";
				
				for(var i=0;i<arrPics.length;i++){
					if(arrPics[i] && picName!=arrPics[i]){
						$scope.formParms.equipmentPic += arrPics[i]+",";
					}
				}
				
				//$scope.formParms.equipmentPic=$scope.formParms.equipmentPic.substring(0,$scope.formParms.equipmentPic.length-1); 这段代码我没看懂，截取自己所有的信息在赋值给自己有意义么
				
				//$scope.PListLength = $scope.formParms.equipmentPic.length; 原来赋值用的有错误因为不能用一个字符串的长度去赋值给数组的长度这样不合理也不正确
				$scope.PicList.splice(parm,1);
				$scope.PListLength = $scope.PListLength - 1;
			};
         
			
            //验证需要
            $scope.submitForm = function(isValid) {
        		if (isValid) {
        			alert('our form is amazing');
        		}
        	};
         	

    	$("button").focus(function(){this.blur()});	
    	
    	
    	/**
 	    * 初始化向下查询（当前登陆人下级企业查询）
 	    * 用session中的登录人id和name当参数，查询当前登录人的信息展示本企业和下级企业
 	    */
 		$scope.NextProject = function(orgId){
 			
 	 	   function qSucc(rec)
 	 	   {
 	 		    $scope.goSelect = true;//刚开始是最高级别显示请选择
 	 		    $scope.nextArray=[];//定义一个数组用于接收拼接的数组
 	 			var initArray=[{"currOrgId":$scope.userInfo.orgId,"name":$scope.userInfo.orgName}];//初始值为当前登录人的信息
 	 			var nextArray = [];//定义一个数组接收当前登陆人下的企业信息
 	 			nextArray = rec.content;
 	 			$scope.nextArray=initArray.concat(nextArray)//拼接2个数组的值付一个新的数组里展示
 	 			$scope.paginationConf.totalItems = rec.totalElements;
 	 			if(rec.content.length>0){
 	 				$scope.checkShow=true;
 	 			}else{
 	 				$scope.checkShow=false;
 	 			}
 	 		}
 	 		
 	 		function qErr(rec){}
 	 		
 	 		entSvc.queryPartyInstallList({
 				currOrgId:orgId,
 				pageNo:$scope.paginationConf.currentPage-1,
 				pageSize:$scope.paginationConf.itemsPerPage
 			},qSucc,qErr);
 		};
 	
 		$scope.NextProject($scope.userInfo.orgId);//调用初始化方法传入当前企业的id
 		
 		/**
 		 * 展示对应表格的方法（展示下级企业方法）
 		 * 总结：获取展示的信息其中包括当前登陆人信息和展示下一级信息
 		 */
 		$scope.shouTableFun = function(obj){//传参数为对象，准备拿id和name赋值，展示当前的级别使用
 			$scope.showTable = true;
			   $scope.saveId = obj.currOrgId;//保存当前id用于返回上一级使用
			   function qSucc(rec)
		 	   {
				   if(rec.content.length>0){
					   if(rec.content[0].parentOrgId!=$scope.userInfo.orgId){
						   $scope.goSelect = false;//如果公司的父公司id不等于session的id那就不显示请选择（证明不是最高级）
						   $scope.goBack = true;//相同条件展示返回上一级
					   } 
				   }
				   if(rec.content.length>0){
					   if(rec.content[0].parentOrgId==$scope.userInfo.orgId){
						   $scope.goBack = false;//如果公司的父公司id等于session的id那就不显示返回上一级（证明是最高级）
						   $scope.goSelect = true;//相同条件出现请选择
					   } 
				   }
				  
				 
				   var initArray=[{"currOrgId":obj.currOrgId,"name":obj.name}];//展示当前登录人的信息
				   var nextArray =[];//定义空数组用于接收返回的企业信息（展示下一级的信息）
				   nextArray=rec.content;
				   $scope.nextArray=initArray.concat(nextArray)//拼接2个数组的值付一个新的数组里展示，因为需要一个当前登录人的信息，所以把当前登录人信息和查询的结果集并在一起展示
		 		  
		 	}
			function qErr(rec){}
			entSvc.queryPartyInstallList({
				currOrgId:$scope.userInfo.orgId,
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.itemsPerPage
			},qSucc,qErr);
 		};
 		
 		
 		/**
 		 * 返回上一级
 		 * 总结：需要先接收之前保存的返回上一级按钮出现之前最后一次点击展示下级方法的企业id，然后用这个id调用返回上一级方法，得到了是之前传入id的企业的所有信息，其中包括上一级的id和name
 		 * 用这个id和name传入对象当参数调用展示下一级的方法，达到返回上一级的效果。
 		 * 就是说要返回上一级和展示下一级并在一起使用才能达到效果，先查询父级id和name，在传入展示下级方法中当参数，就能展示父级的下级，也就是返回上级的效果
 		 */
 		$scope.goBackFun = function(currOrgId){//传入参数为在返回上一级按钮出现之前点击的企业id（这个id是每次点击展示下一级企业时手动存储的）
 			function qSucc(rec){
 				$scope.obj = {"currOrgId":rec.parentOrgId,"name":rec.parentOrgName};//这个是一会调用展示下一级方法传入的参数，其中用到了上一级的id和上一级的名字，这些参数是返回值所得
 				$scope.shouTableFun($scope.obj);//调用一下展示下级的方法其中传入刚才保存的上一级id和name，也就是说展示了上一级的所包括的所有企业（达到了返回上一级的效果）
 			}
 			function qErr(rec){}
 			entSvc.queryPartyInstallDetail({id:currOrgId},qSucc,qErr);
 		};
 		
 		$scope.closeTable = function(){
 			$scope.showTable = false;
 		};
 		
 		
 		/*
 		*是否包含下级单位事件
 		*/
 		$scope.checkShow=false;
 		$scope.modalSelect='true';
 		$scope.modalCheckClick=function(parm){
 			if(parm == true){
 				$scope.modalSelect='';
 			}else{
 				$scope.modalSelect='true';
 			}
 		};
 		
 		
 		//单选框
        $scope.selectP={};
        
 		/*
 		*点击行效果
 		*/
        $scope.Select=function(params,parm1)
        {
            /*  $scope.selectP.equipmentId=params.t.equipmentId;   */  
            $scope.equiList=params;
             $scope.radioTrIndex=parm1;
        };
        
        $scope.clearMessage = function(){
        	$scope.radioTrIndex={};
        	$scope.selectP={};
        };
        
      //URL获取设备ID，执行查询
        /* if ($scope.requestParms.equipmentId != null) {
            function qSucc(rec) {
                $('#ChoEquModalId').modal('hide');
                $scope.equiList = rec;
                $scope.formParms = {'equipmentId': rec.equipmentId};
                $scope.formRadio = 'true';
                $scope.formParms = {'equipmentPic': '', 'equipmentId': $scope.requestParms.equipmentId};
            }
            function qErr(rec) {}
            equipment.unifydo({ parm: $scope.requestParms.equipmentId }, qSucc, qErr);

        } */
       
        /*
         * 弹出选择设备信模态框
         */
        $scope.openChoEquModal = function () {	
        	$scope.radioTrIndex =null;
        	$scope.userInfo.orgLevel=SYS_USER_INFO.orgLevel;
        	$scope.judge = "cho";
        	$scope.save_level = $scope.userInfo.orgLevel;
        	$scope.searBean.isInclude = null;
        	$scope.LiNumA_ = false;
        	$scope.tableShow = false;
        	$scope.userInfo.orgName = SYS_USER_INFO.orgName;
        	$scope.queryallequiData(); 
        	
        	//清空选择信息和单选框
   			
   			
   			
   			
   		    //查询设备编号和设备名称
           /*  $('#ChoEquModalId').modal({backdrop: 'static', keyboard: false}); */
        };
        
        $scope.close = function(){
        	$scope.radioTrIndex =null;
        	$scope.searBean.equName=null;
        	$scope.equNameObj.equName = null;
        	$("#fade,#openwin2").hide();
        }
        
        /*
         *获取所有设备信息
         */
        //$scope.queryallequiData = function (parm,pageNo,checkbox_,presentcomPany_) {
       	 $scope.queryallequiData = function (pageNo,equQryBean) {
        	$scope.LiNumA_ = false;
        	
        	$scope.tableShow = false;
        	//$scope.searBean.isInclude = parm;

            if($scope.userInfo.orgLevel!=='6'){
            	
	            if(pageNo)
	    		{
	    			$scope.paginationConf.currentPage=1;
	    		} 
	    		function qSucc(rec){
	    			if(rec.content.length!=0){
	    				$scope.allequiList=rec.content;
	    				$scope.paginationConf.totalItems=rec.totalElements;
	    				$scope.testFun();
	    				
	    				$scope.btnShow_ = true;
	    			}else{
	    				$.messager.popup("没有符合条件的记录");
	    				$scope.allequiList=rec.content;
	    				$scope.btnShow_ = false;
	    				$scope.paginationConf.totalItems=rec.totalElements;
	    			}
	    		}
    		function qErr(rec){}
   				if($scope.equQryBean.equAtOrgPartyId){
		    			equipment.post({Action:"All"},{
		        			pageNo:$scope.paginationConf.currentPage-1,
		        			pageSize:$scope.paginationConf.itemsPerPage,
		                  	orgName:$scope.equQryBean.equAtOrgNameInput,
		                  	orgPartyId:$scope.equQryBean.equAtOrgPartyId,
		                  	equName:$scope.equQryBean.equName, 
		                  	orgFlag:$scope.equQryBean.equAtOrgFlag,
		                  	equState:1,
		                    pubType:1,
		                    equipmentSourceNo:1,
		        			equName:$scope.equNameObj.equName, 
		        			isInclude:$scope.equQryBean.isInclude,
		        			},qSucc,qErr);
   				}else{
   					if(1==$scope.userInfo.orgLevel){
    	    			$scope.userInfo.orgFlag = 9;
    				}
    				else if(2==$scope.userInfo.orgLevel){
    					$scope.userInfo.orgFlag = 1;
    				}
    				else if(3==$scope.userInfo.orgLevel){
    					$scope.userInfo.orgFlag = 2;
    				}
   					
    	    		equipment.post({Action:"All"},{
            			pageNo:$scope.paginationConf.currentPage-1,
            			pageSize:$scope.paginationConf.itemsPerPage,
                      	orgName:$scope.userInfo.orgName,
                      	orgPartyId:$scope.userInfo.orgId,
                      	orgFlag:$scope.userInfo.orgFlag,
                      	equName:$scope.equQryBean.equName, 
                      	equState:1,
                        pubType:1,
                        equipmentSourceNo:1,
            			isInclude:0,
            			},qSucc,qErr);
   				}
            }else{
            	if(1==$scope.userInfo.orgLevel){
	    			$scope.userInfo.orgFlag = 9;
				}
				else if(2==$scope.userInfo.orgLevel){
					$scope.userInfo.orgFlag = 1;
				}
				else if(3==$scope.userInfo.orgLevel){
					$scope.userInfo.orgFlag = 2;
				}
            	if(pageNo)
        		{
        			$scope.paginationConf.currentPage=1;
        		} 
        		function qSucc(rec){
        			if(rec.content.length!=0){
        				$scope.allequiList=rec.content;
        				$scope.testFun();
        				$scope.paginationConf.totalItems=rec.totalElements;
        				$scope.btnShow_ = true;
        			}else{
        				$.messager.popup("没有符合条件的记录");
        				$scope.allequiList=rec.content;
        				$scope.btnShow_ = false;
        				$scope.paginationConf.totalItems=rec.totalElements;
        			}
        		
        		}
        		function qErr(rec){}
        		
        		equipment.post({Action:"Provider"},{
        			pageNo:$scope.paginationConf.currentPage-1,
        			pageSize:$scope.paginationConf.itemsPerPage,
                  	orgPartyId:$scope.userInfo.orgId,
                  	equState:1,
                    pubType:1,
                    equipmentSourceNo:1,
                    orgFlag:$scope.userInfo.orgFlag,
        			equName:$scope.equNameObj.equName, 
        			},qSucc,qErr);
            }
        };
        $scope.testFun = function(){
    		$scope.changeListValue($scope.allequiList,'bureauOrgPartyName');
    		$scope.changeListValue($scope.allequiList,'sonOrgName');
    		$scope.changeListValue($scope.allequiList,'proOrgName');
    		$scope.changeListValue($scope.allequiList,'equNo');
    		$scope.changeListValue($scope.allequiList,'brandName');
    		$scope.changeListValue($scope.allequiList,'models');
    		$scope.changeListValue($scope.allequiList,'specifications');
    		$scope.changeListValue($scope.allequiList,'power');
    		$scope.changeListValue($scope.allequiList,'manufacturerName');
    		
    	};
    	$scope.testFun1 = function(){
    		$scope.changeListValueA($scope.allequi,'equipmentCategoryName');
    		$scope.changeListValueA($scope.allequi,'equName');
    	}
    	
    	$scope.changeListValue = function(objList,obj){
    		for(var i=0;i<objList.length;i++)
    		{
    			if(objList[i][obj]&&objList[i][obj].length>5)
    			{
    				objList[i][obj+'Temp']=objList[i][obj].substr(0,6)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
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
    			if(objList[i][obj]&&objList[i][obj].length>7)
    			{
    				objList[i][obj+'Temp']=objList[i][obj].substr(0,7)+"...";/* 将infoTitle截取长度后赋值给infoTitleTemp */
    			}
    			else
    			{
    				
    				objList[i][obj+'Temp']=objList[i][obj];
    				
    			}
    			
    		}

    	};	
        /*
         *获取选中设备信息
         */
         $scope.queryequiData = function () {
        	
        	//判断选中的设备是否闭环
           	if($scope.equiList.equipmentId){
           		
           		function qSuc(rec){
					if(rec.equCanRelease=="N"){
						$.messager.popup("该设备出租尚未闭环,请重新选择！");
						//$scope.radioTrIndex =null;
			        	//$scope.searBean.equName=null;
			        	//$scope.equNameObj.equName = null;
						return;
					}else{
						

		           		$("#fade,#openwin2").hide();
		           		$scope.formParms.equipmentId=$scope.equiList.equipmentId; // 把选中的值赋值给formParms.equipmentId 
		           		$scope.formParms.equCategoryId = $scope.equiList.equCategoryId;//设备大类ID
		           		$scope.formParms.equCategoryName = $scope.equiList.equipmentCategoryName//设备大类名称
		           		
		           		$scope.formParms.equNameId = $scope.equiList.equNameId;//设备小类ID
		           		$scope.formParms.manufacturerId = $scope.equiList.manufacturerNo;//生产厂家ID
		           		$scope.formParms.manufacturerName = $scope.equiList.manufacturerName;//生产厂家名称 
		           		
		           		$scope.formParms.brandId = $scope.equiList.brandNo;//品牌ID
		           		
		           		/* $scope.formParms.infoTitle = "【"+$scope.equiList.brandName+"】"+$scope.equiList.equName+"("+$scope.equiList.models+","+$scope.equiList.specifications+")"; */
		           		$scope.formParms.infoTitle=$scope.equiList.brandName?"【"+$scope.equiList.brandName+"】":"";
		    			$scope.formParms.infoTitle+=$scope.equiList.equName;
		    			
		    			if($scope.equiList.models)
		    			{
		    				if($scope.equiList.specifications){$scope.formParms.infoTitle+="("+$scope.equiList.models+","+$scope.equiList.specifications+")";}
		    				else
		    				{
		    					$scope.formParms.infoTitle+="("+$scope.equiList.models+")";
		    				}
		    			}
		    			else
		    			{
		    				if($scope.equiList.specifications){$scope.formParms.infoTitle+="("+$scope.equiList.specifications+")";}
		    			}
		    			
		           	}
		           	$scope.recPro={};
		    		$scope.recCit={};
		    		$scope.recDis={};
		    		$scope.pList=[{name:$scope.equiList.onCity}];
					$scope.cList=[{name:$scope.equiList.onDistrict}]
		        	$scope.recPro.proModel=$scope.equiList.onProvince;
					$scope.recCit.recModel=$scope.equiList.onCity;
					$scope.recDis.disModel=$scope.equiList.onDistrict;
					function qSucc(rec){
						$scope.formParms.contactAddress = rec.address;
					}
					function qErr(){}
					
					$scope.equNameObj.equName = '';
					equipment.unifydo({urlPath:$scope.formParms.equipmentId},qSucc,qErr);
					}
					
	        	}else{
	           		$.messager.popup("请您选择一条设备信息！");
	           		return;
	           	}
				function qEr(){}
           		
           		equipment.unifydo({Action:"EQU_CAN_RELEASE",pubType:1,equipmentId:$scope.equiList.equipmentId},qSuc,qEr);
           		
           
        }; 
        
        /**
    	 * 设备名称去重复查询
    	 */
    	$scope.click_checkEquName = function(){
    	 	
        	if($scope.userInfo.orgLevel!=6){
        		if(a == 0){//input为空时，如果缓存有值，点击一次显示下拉框，点击一次隐藏下拉框
              		$scope.tableShow=true;
              		tableIdList.style.display = 'block';
          			a=a+1;
          		}else{
          			$scope.tableShow=false;
          			tableIdList.style.display = 'none';
          			a = 0;
          		}  
        	}
        	
        	if($scope.userInfo.orgLevel==6){
        		if(a == 0){//input为空时，如果缓存有值，点击一次显示下拉框，点击一次隐藏下拉框
              		$scope.tableShow=true;
              		tableIdList2.style.display = 'block';
          			a=a+1;
          		}else{
          			$scope.tableShow=false;
          			tableIdList2.style.display = 'none';
          			a = 0;
          		}  
        	}
      		
    		if($scope.searBean.isInclude == true){
    			$scope.searBean.isInclude = 1;
    		}
    		
    		if($scope.searBean.isInclude == false){
    			$scope.searBean.isInclude = 0;
    		}
    		
    		if($scope.save_Code){
    			$scope.userInfo.orgCode = $scope.save_Code;
    		}
    		
    		function qScc(rec){
    			
    			if($scope.searBean.isInclude == 1){
    				$scope.searBean.isInclude = true;
    			}
    			
    			if($scope.searBean.isInclude == 0){
    				$scope.searBean.isInclude = false;
    			}
    			
    			$scope.allequi=rec.content;
    			$scope.testFun1();
    			 
    		};
    		
    		function qErr(){};
    		
    		equipment.post({Action:'GetEquName'},{orgCode:$scope.userInfo.orgCode,isInclude:$scope.searBean.isInclude},qScc,qErr);
    	};
    	
 
        /*
        *设备信息模块，设备名称输入框点击事件
        */
        var a=0;
        $scope.applianceClick=function(){
        	 
        	 if(a == 0){//input为空时，如果缓存有值，点击一次显示下拉框，点击一次隐藏下拉框
        		$scope.tableShow=true;
    			a=a+1;
    		}else{
    			$scope.tableShow=false;
    			a = 0;
    		} 
        };
 		
 		/*
 		 * 查询设备分类/查询设备名称
 		*/
 		$scope.queryCategoryData=function()
 		{
 			function success(rec)
 			{
 				if(rec.content.length == 0){
 					$.messager.popup("无相应记录");
 				}else{
 					$.messager.popup("无相应记录");
 					rec.content.length=0;
 					$scope.allequiList=rec.content;
 				    	
 					/* $scope.paginationConf.totalItems=rec.totalElements; */
 				}
 			}
 			function error(){}
 			category.unifydo({
 				Action:"All",
 				pageNo:0,
 				pageSize:1
 			},success,error);
 		}; 
 		
 		/*
 		* 设备名称下拉框的值显示在input
 		*/
		$scope.equipmentNameClick=function(parm,parm1){
			if(parm){
				$scope.inputName=parm+" "+parm1;
			}
			$scope.tableShow=false;
			a=0;
		};

 		
 		/*
 		*最短租期不限checkBox事件
 		*/
 		$scope.zuQi='';
 		$scope.zuQiClick=function(parm){
 		   
 			if(parm == true){
 				$scope.zuQi=true;
 				$scope.showFlag="";
 			  $scope.shortestLease=$scope.formParms.shortestLease; 
 			}else{
 				$scope.zuQi=false;
 			}
 		};
 		
 		
 		
 		////
 		
 		$scope.KeyWordQue = function(inputValue,showFlag,count_){/* 需要 */
 			if(inputValue.length == 0){//如果输入框没有值了，就隐藏下面的展示结果域
 				$scope[showFlag] = false;
 				companyListId.style.display = 'none';
 			}
 			$scope.KeyWordList=[];/* 需要 */

 			function qSucc(rec){/* 需要 */
 				if(rec.content.length<=0){/* 需要 */
 					$scope[showFlag]=false;/* 需要 */
 					companyListId.style.display = 'none';
 				}else{
 					$scope[showFlag]=true;/* 需要 */
 					companyListId.style.display = 'block';
 				/*	if($scope.formParms.busState == 2){
 						
 					}*/
 					$scope.KeyWordList=rec.content;/* 需要 */
 					$scope.KWList(rec.content,1);//字数超过9个后用...代替/
 				}
 			}
 			function qErr(){}
 			//根据传参数的不同决定action是什么
 			var actionName = '';
 			
 			if(count_ == 'one'){
 				 actionName = 'QueryEnts';
 			}
 			if(count_ == 'all'){
 				actionName = 'QueEnts';
 			}
 			
 			if(inputValue){
 				entSvc.queryPartyInstallList({Action:actionName},{
 					orgCode:SYS_USER_INFO.orgCode,
 					orgName:inputValue,
 					pageNo:$scope.paginationConf.currentPage-1,
 					pageSize:$scope.paginationConf.itemsPerPage
 				},qSucc,qErr);
 			}
 		};
 		/////
 		
 		$scope.searBean = {};
 		$scope.equNameObj = {};//设备名称
 		$scope.InputShow = function(parm,searBean,infoTitleBean,LiNumA,code,level,theCompany_){/* 参数为点击的信息 parm是设备名称 */		
 		    
 			a = 0;
 			 
 			$scope.temporaryParame = '';
 			$scope.tableShow=false;	
 			if($scope.userInfo.orgLevel == 2){
 				$scope.proListBureauCopy = [];
 			}
 			
 			if(parm){
			    $scope.temporaryParame = parm;//临时参数
 				$scope[searBean][infoTitleBean] = parm;
 				//$scope[searBean][id]=currOrgId;//这个值目前用于拿到登录中项目的id
 				//$scope[searBean][subsidiaryId] = currOrgId;//这个值用于子公司名称传值
 			 	$scope.save_Code = code;//保存被点击的code
 			 	$scope.save_level = level;
 			 	
 				$scope[LiNumA] = false;
 				
 				if($scope.userInfo.orgLevel == 2){
 					 $scope.shouTableFun($scope.userInfo.orgId); 
 				}
 				
 				//	 $scope.queryallequiData(); 
 				if(!theCompany_){
 					$scope.equNameObj.equName = parm;
 				}
 				return;
 			}
 		}; 
 		
 		
 		
 		////
 		$scope.KWList = function(val,obj){
 			
 			if(obj == 2){
 				for(var i=0;i<val.length;i++){
 					if(val[i].name.length > 9){
 						$scope.KeyWordListAddOut[i].infoTitleA = val[i].name.substring(0,7)+"...";
 		        	}else{
 		        		$scope.KeyWordListAddOut[i].infoTitleA = val[i].name;
 		        	}
 				}
 			}
 			
 			if(obj == 1){
 				for(var i=0;i<val.length;i++){
 					if(val[i].name.length > 9){
 						$scope.KeyWordList[i].infoTitleA = val[i].name.substring(0,7)+"...";
 		        	}else{
 		        		$scope.KeyWordList[i].infoTitleA = val[i].name;
 		        	}
 				}
 			}
 			
 			if(obj == 0){
 				for(var i=0;i<val.length;i++){
 					if(val[i].name.length > 9){
 						$scope.KeyWordListAdd[i].infoTitleA = val[i].name.substring(0,7)+"...";
 		        	}else{
 		        		$scope.KeyWordListAdd[i].infoTitleA = val[i].name;
 		        	}
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
 				if(num[0] == 0){
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
 		$scope.formParms = { };
    	
    	
 		/* $scope.formatCurrency= function()
 		{
 			$scope.formParms.price= $scope.ct.formatCurrency($scope.formParms.price+"");
 		} */

    	
    	$scope.search = function(obj,parm){
    		
    		if(!$scope.equQryBean.equAtOrgFlag){
				if(1==$scope.userInfo.orgLevel){
					$scope.equQryBean.equAtOrgFlag = 9;
				}
				else if(2==$scope.userInfo.orgLevel){
					$scope.equQryBean.equAtOrgFlag = 1;
				}
				else if(3==$scope.userInfo.orgLevel){
					$scope.equQryBean.equAtOrgFlag = 2;
				}
			}
    		$scope.equQryBean.equName = obj;
    		$scope.queryallequiData(1,$scope.equQryBean);
    		/* a = 0;
    		
    		 if(parm!=SYS_USER_INFO.orgName){
    			 $scope.userInfo.orgCode= parm;
             	 $scope.queryallequiData(1);
     	     }else{
         	    	 $scope.userInfo.orgCode=SYS_USER_INFO.orgCode;
         	    	 $scope.queryallequiData(1);
         	       }
        	if(obj==""){
        		 $scope.queryallequiData(1);
        	} */
        }
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
    	
    	/*图片批量上传*/
		/* $scope.initFileUpLoad=function(){
			var settings = {
                flash_url : "../../../media/swfupload/swfupload.swf",
                upload_url: "/Picture",
                file_post_name: "file",
                post_params: {
                    "ASPSESSID": "hjd"
                },
                file_size_limit : "100 MB",
                file_types : "*.jpg;*.gif;*.png;*.jpeg",    //这是全部文件都可以上传，如果要限制只有某些文件上传，则可以这么写 file_types : "*.jpg;*.gif;*.png",
                file_types_description : "All Files",
                file_upload_limit : 100,
                file_queue_limit : 0,
                custom_settings : {
                    progressTarget : "fsUploadProgress",
                    cancelButtonId : "btnCancel"
                },
                debug: false,


                // Button settings

               //这儿是swfupload v2新增加的功能，由于flash player 10的安全性的提高所以增加了此功能。

              //在SWFUpload v2中，不能再使用html的button来触发SWFUpload，必须使用定制的Button，这其中比较要注意的是，button不能再用css控制，需要用图片来显示
                button_image_url: "images/XPButtonNoText_160x22.png",
                button_placeholder_id: "spanButtonPlaceHolder",
                button_width: 160,
                button_height: 22,
                button_text: '<span class="button">&nbsp; &nbsp;选择文件 &nbsp;  &nbsp;<span class="buttonSmall">(2 MB Max)</span></span>',
                button_text_style: '.button { font-family: Helvetica, Arial, sans-serif; font-size: 14pt;color:#483d8b } .buttonSmall { font-size: 10pt; }',
                button_text_top_padding: 1,
                button_text_left_padding: 5, 
                // The event handler functions are defined in handlers.js
                file_queued_handler : fileQueued,
                file_queue_error_handler : fileQueueError,
                file_dialog_complete_handler : fileDialogComplete,
                upload_start_handler : uploadStart,
                upload_progress_handler : uploadProgress,
                upload_error_handler : uploadError,
                //upload_success_handler : uploadSuccess,
                upload_success_handler : function(file,data){
                	data=eval("("+data+")");
                    $scope.FileSize = file.size;
                    $scope.PicRealName = data.fileName;
                    if(!$scope.formParms.equipmentPic){//防止出现第一次下载图片出现图片名字为undefind，试图片加载失败
                    	$scope.formParms.equipmentPic = "";
                    }
                    $scope.formParms.equipmentPic += data.fileName + ",";
                    $scope.ay = $scope.formParms.equipmentPic.split(',');
                    $scope.PicList = [];
                    $scope['PicOneCopy'] = {};
                    for (i = 0; i < $scope.ay.length - 1; i++) {
                        var fullname = $scope.ay[i].split('.');  
                        var PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};
                        if (i < 5) {
                        	$scope.$apply(function(){
                            $scope.PicList.push(PicOne);
                            $scope.PListLength = $scope.PicList.length;
                            $scope.PicUrl = PicUrl;
                            $scope.PicAction = "Action=TmpPic";
                        	});
                        } else {
                            $.messager.popup("最多上传5张图片");
                        }
                    } 
                },
                upload_complete_handler : uploadComplete,
                queue_complete_handler : queueComplete    // Queue plugin event
            };
            $scope.swfu = new SWFUpload(settings);
		}; */
		
		$scope.newFileUpLoad=function(){
				$("#fileupload").click();
		};
		
		$scope.PicList = [];/*初始化$scope.PicList = [];*/
		
		
		$('#fileupload').fileupload({
			
    		//url: "/Picture",
   	        dataType: 'json',
   	        
   	        autoUpload: true,
   	        
            add: function (e, data) {
                data.submit();
            },
            done: function (e,res) {
            	var data=res.result;
                $scope.FileSize = res.files[0].size;
                $scope.FileType = res.files[0].type;
                if($scope.FileSize > 2097152){
                	$.messager.popup("上传失败，请选择格式为BMP、GIF、JPG、JPEG且小于2M的图片。");
                    return;
                }
                if($scope.FileType !== 'image/png' && $scope.FileType!=='image/jpeg' && $scope.FileType!=='image/gif'){
                	$.messager.popup("上传失败，请选择格式为BMP、GIF、JPG、JPEG且小于2M的图片。");
                	return;
                }
                $scope.PicRealName = data.fileName;
                if(!$scope.formParms.equipmentPic){//防止出现第一次下载图片出现图片名字为undefind，试图片加载失败
                	$scope.formParms.equipmentPic = "";
                }
                
                if($scope.PicListD && $scope.PicListD.length>0)
                {
                	$scope.formParms.equipmentPic +=","+ data.fileName;
                }
                else
                {
                	 $scope.formParms.equipmentPic += data.fileName + ",";
                }
               
                $scope.ay = $scope.formParms.equipmentPic.split(',');
                
                $scope['PicOneCopy'] = {};
                
                var fullname = data.fileName.split('.');  
                var PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};
                if ($scope.PListLength < 5) {
                	$scope.$apply(function(){
                		if($scope.PicListD){
                    		
                			$scope.PicList.push(PicOne);
                		}else{
                			$scope.PicList.push(PicOne);
                		}
                        if($scope.PicListD){
                        	$scope.PListLength = $scope.PicList.length+$scope.PicListD.length;
                        }else{
                        	$scope.PListLength = $scope.PicList.length;
                        }
                        $scope.PicUrl = PicUrl;
                        $scope.PicAction = "Action=TmpPic";
                	});
                } else {
                	
                	 $.messager.popup("最多上传5张图片");
                }
            }
        });
		$scope.FormBlur=function(){
    		var tag=window.event.target;

    		if(tag && tag.tagName.toLowerCase()=="div"){
    			$scope.priceFlag=false;
        		$scope.shortestLeaseFlag=false;
        		$scope.infoTitleFlag=false;
        		$scope.contactAddressFlag=false;
        		$scope.contactPersonFlag=false;
        		$scope.contactPhoneFlag=false;
        		$scope.qqNoFlag=false;
        		$scope.inputCodeFlag=false;
        		$scope.equName=false;
    		}
    	};
    	$scope.checkPrice = function(num){
    		var reg="^\\d+$";
    		if(num!=null&&!isNaN(num)){
    			$scope.formParms.price=Number(n);
    		}else{
    			n=null;
    		}
    		 $scope.test_ = [];//不能有2个以上的点，这个数组用于接收点的数目
  			if(num==null||num==""){
  				return;
  			}else{
  				$scope.numArray_=num.split("");//把输入的字符变成数组用于判断其中点的数目
  			}
  			for(var i=0;i<num.length;i++){//数值第一位不能是0，是0就返回0
  				if(num[0] == 0){
  					/* $scope.formParms[parm] = 0; */
  					return;
  				}
  				
  			}
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
  			if(parm='price'){
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
    	
    	
    	setTimeout(function() {
    	    $scope.$apply(function() {
    	    	var inputs = document.getElementsByTagName("input");
    	    	var pf=new window.placeholderFactory(); 
    	    	pf.createPlaceholder(inputs);
    	    	//document.getElementById("eeeee").value="asd";
    	    });  
    	}, 500);
    	
    	/* $scope.mouseFlagInf = true;
    	$scope.mouseOverFunInf = function(){
    		$scope.mouseFlagInf = false;
    	};
    	
        $scope.mouseLeaveFunInf = function(){
        	$scope.mouseFlagInf = true;
    	};
    	
    	$scope.mouseFlagInf2 = true;
 		$scope.mouseOverFunInf2 = function(){
 			$scope.mouseFlagInf2 = false;
    	};
    	
        $scope.mouseLeaveFunInf2 = function(){
        	$scope.mouseFlagInf2 = true; 
    	};
    	
    	document.onmousedown=function(){
    		if($scope.mouseFlagInf == true && $scope.LiNumA_ == true){
    			companyListId.style.display = 'none';
    		}
    		
    		if($scope.mouseFlagInf2 == true && $scope.tableShow == true){
    			tableIdList.style.display = 'none';
    		}
	    } */
    	
    	
	    
    	$scope.closeDiv = function(obj){
	    	if(obj == 'theCompany'){
	    		setTimeout(function(){
		    		companyListId.style.display = 'none';
		    		$scope.LiNumA_ = false;
		    	},150);
	    	}else if(obj == 'equName'){
	    		a = 0;
	    		setTimeout(function(){
	    			tableIdList.style.display = 'none';
	    			$scope.tableShow = false;
	    		},150);
	    	}else if(obj == 'equName2'){
	    		a = 0;
	    		setTimeout(function(){
	    			tableIdList2.style.display = 'none';
	    			$scope.tableShow = false;
	    		},150);
	    	}
	    };
    	
	    $scope.equQryBean = {};
		$scope.equQryBean.isInclude = 0;
		$scope.equQryBean.isCrecOrg = 0;
		$scope.equQryBean.equAtOrgNameSelect = SYS_USER_INFO.orgName;
		$scope.inputDeptName = SYS_USER_INFO.orgName;	    
	    
	    
		
		/* 资源管理列表查询分页标签参数配置 */
		$scope.paginationConfOrgORProject = {
			currentPage: 1,/** 当前页数 */
			totalItems: 1,/** 数据总数 */
			itemsPerPage: 10,/** 每页显示多少 */
			pagesLength: 10,/** 分页标签数量显示 */
			perPageOptions: [10, 20, 30, 40],
			onChange: function(currentPage){
				if($scope.queryEquAtEmployer.currOrgId){
					$scope.clickEquAtProjects(currentPage);
					}
			}
		};
		
		$scope.equAtEmployers = [];
		$scope.equAtEmployer = {};
		$scope.queryEquAtEmployer = {};
		$scope.equAtCheck = true;	//	项目选项 显示标志
		$scope.queryEquAtEmployer.check = false;	//	项目选项值
		$scope.checkEquAtTrEmployer = true;	//	列名称 - 单位名称 显示标志
		$scope.checkEquAtTrProjects = false;	//	列名称 - 项目名称 显示标志
	    
		$scope.openEquAtEmployerModel = function(){
			if($scope.equAtEmployers.length==0){//	首次打开
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

				$scope.queryEquAtEmployer.currOrgId = $scope.userInfo.orgId;

				/** 放入单位信息，且查询该组织下的机构/项目 */
				$scope.equAtEmployers = [{name: $scope.userInfo.orgName, currOrgId: $scope.userInfo.orgId, orgFlag: orgLv}];

				$scope.queryEquAtEmployer.pageNo = 0;
				$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

				if(2==orgLv){
					$scope.checkEquAtTrProjects = true;
					$scope.checkEquAtTrEmployer = false;
					$scope.queryEquAtEmployer.check = true;
					$scope.equAtCheck = false;

					/** 根据currOrgId，查询该组织下的项目 begin */
					function qSucc(rec){
						$scope.equAtEmployerList = rec.content;
						$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
						$('#equAtEmployerModel').modal('show');
					}
					function qErr(){
						
					}
					proSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
					/** 根据currOrgId，查询该组织下的项目 end */
					}
				else{
					$scope.checkEquAtTrProjects = false;
					$scope.checkEquAtTrEmployer = true;
					$scope.queryEquAtEmployer.check = false;
					$scope.equAtCheck = true;

					/** 根据currOrgId，查询该组织下的机构 begin */
					function qSucc2(rec){
						$scope.equAtEmployerList = rec.content;
						$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
						$('#equAtEmployerModel').modal('show');
					}
					function qErr2(){
						
					}
					entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc2, qErr2);
					/** 根据currOrgId，查询该组织下的机构 end */
				}
			}
			else{//	非首次打开
				$('#equAtEmployerModel').modal('show');
			}
		};
		
		/* 点击查询下级单位，且保存点击的机构信息 */
		$scope.clickEquAtEmployer = function(currentPage, orgInfo){
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
			$scope.equAtEmployer = {};

			$scope.equAtEmployer.name = orgInfo.name;
			$scope.equAtEmployer.currOrgId = orgInfo.currOrgId;
			$scope.equAtEmployer.orgFlag = orgLv;

			$scope.equAtEmployers.push($scope.equAtEmployer);

			$scope.queryEquAtEmployer.currOrgId = orgInfo.currOrgId;

			if(2==orgLv){/** 处级单位 */
				$scope.checkEquAtTrProjects = true;
				$scope.checkEquAtTrEmployer = false;
				$scope.queryEquAtEmployer.check = true;
				$scope.equAtCheck = false;

				$scope.qryEquAtProject();
			}
			else{/** 总公司/局级单位 */
				$scope.checkEquAtTrProjects = false;
				$scope.checkEquAtTrEmployer = true;
				$scope.queryEquAtEmployer.check = false;
				$scope.equAtCheck = true;

				$scope.qryEquAtEmployer();
			}
		};
		
		/* 点击项目，变更保存的项目信息 */
		$scope.clickEquAtProject = function(orgInfo){
			/** 变更保存点击的项目信息 */
			$scope.equAtEmployer = {};

			$scope.equAtEmployer.name = orgInfo.name;
			$scope.equAtEmployer.currOrgId = orgInfo.currOrgId;
			$scope.equAtEmployer.orgFlag = 3;

			var employersLength = $scope.equAtEmployers.length;
			if(employersLength>0 && 3==$scope.equAtEmployers[employersLength - 1].orgFlag){
				$scope.equAtEmployers.splice(employersLength - 1, 1);
			}
			$scope.equAtEmployers.push($scope.equAtEmployer);
		};
		
		
		/* 点击当前位置的单位/项目，变更当前位置、单位/项目列表 */
		$scope.clickEquAtEmployers = function(currentPage, orgInfo, employersIndex){
			if(currentPage)
			{
				$scope.paginationConfOrgORProject.currentPage = currentPage;
			}

			/** 变更当前位置 */
			var employersLength = $scope.equAtEmployers.length;
			if(employersLength<=0){
				return ;
			}

			$scope.equAtEmployers.splice(employersIndex + 1, employersLength - employersIndex - 1);

			/** 保存点击的机构信息 */
			$scope.queryEquAtEmployer.currOrgId = orgInfo.currOrgId;

			var orgLv = $scope.equAtEmployers[employersIndex].orgFlag;
			if(3==orgLv){/** 项目 */
				return ;
			}
			else if(2==orgLv){/** 处级单位 */
				$scope.checkTrProjects = true;
				$scope.checkTrEmployer = false;
				$scope.queryEquAtEmployer.check = true;
				$scope.equAtCheck = false;

				$scope.qryEquAtProject();
			}
			else{/** 总公司/局级单位 */
				$scope.checkEquAtTrProjects = false;
				$scope.checkEquAtTrEmployer = true;
				$scope.queryEquAtEmployer.check = false;
				$scope.equAtCheck = true;

				$scope.qryEquAtEmployer();
			}
		};
		
		/* 勾选项目，根据当前位置的最下级单位id，查询单位/项目列表 */
		$scope.clickEquAtProjects = function(currentPage) {
			if(currentPage)
			{
				$scope.paginationConfOrgORProject.currentPage = currentPage;
			}

			var employersLength = $scope.equAtEmployers.length;
			if(employersLength<=0){
				return ;
			}

			if($scope.equAtEmployers[employersLength - 1].orgFlag==3){
				return ;
			}

			$scope.queryEquAtEmployer.currOrgId = $scope.equAtEmployers[employersLength - 1].currOrgId;

			if($scope.queryEquAtEmployer.check){
				$scope.checkEquAtTrProjects = true;
				$scope.checkEquAtTrEmployer = false;

				$scope.qryEquAtProject();
			}
			else{
				$scope.checkEquAtTrProjects = false;
				$scope.checkEquAtTrEmployer = true;

				$scope.qryEquAtEmployer();
			}
		};

		/* 根据currOrgId，查询该组织下的机构 */
		$scope.qryEquAtEmployer = function(){
			$scope.queryEquAtEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
			$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

			/** 根据currOrgId，查询该组织下的机构 begin */
			function qSucc(rec){
				$scope.equAtEmployerList = rec.content;
				$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
			}
			function qErr(){
				
			}
			entSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
			/** 根据currOrgId，查询该组织下的机构 end */
		};
		
		/* 根据currOrgId，查询该组织下的项目 */
		$scope.qryEquAtProject = function(){
			$scope.queryEquAtEmployer.pageNo = $scope.paginationConfOrgORProject.currentPage - 1;
			$scope.queryEquAtEmployer.pageSize = $scope.paginationConfOrgORProject.itemsPerPage;

			/** 根据currOrgId，查询该组织下的项目 begin */
			function qSucc(rec){
				$scope.equAtEmployerList = rec.content;
				$scope.paginationConfOrgORProject.totalItems = rec.totalElements;
			}
			function qErr(){
				
			}
			proSvc.queryPartyInstallList($scope.queryEquAtEmployer, qSucc, qErr);
			/** 根据currOrgId，查询该组织下的项目 end */
		};
		
		/* 变更并关闭 选择单位/项目模态框 */
		$scope.modifyEquAtEmployerModel = function(val){
			$('#equAtEmployerModel').modal('hide');

			var employersLength = $scope.equAtEmployers.length;
			if(employersLength<=0){
				return ;
			}

			$scope.equAtEmployer = $scope.equAtEmployers[employersLength - 1];

			$scope.equQryBean.equAtOrgFlag = $scope.equAtEmployer.orgFlag;
			$scope.equQryBean.equAtOrgPartyId = $scope.equAtEmployer.currOrgId;
			$scope.equQryBean.equAtOrgNameSelect = $scope.equAtEmployer.name;
			
		};
		
		/* 取消并关闭 选择单位/项目模态框 */
		$scope.closeEquAtEmployerModel = function(){
			$('#equAtEmployerModel').modal('hide');
		} 

		
		$scope.clearEquAtEmployerModel = function(){
			$scope.equQryBean.equAtOrgFlag = null;
			$scope.equQryBean.equAtOrgPartyId = null;
			$scope.equQryBean.equAtOrgNameSelect = null;

			$scope.equAtEmployers = [];
			$scope.equAtEmployer = {};
			$scope.queryEquAtEmployer = {};
			$scope.equAtCheck = true;	//	项目选项 显示标志
			$scope.queryEquAtEmployer.check = false;	//	项目选项值
			$scope.checkEquAtTrEmployer = true;	//	列名称 - 单位名称 显示标志
			$scope.checkEquAtTrProjects = false;	//	列名称 - 项目名称 显示标志

			$('#equAtEmployerModel').modal('hide');
		};
		$scope.external = 2;
	    $scope.click = function(){
	    	if($scope.equQryBean.isCrecOrg==1){
	    		$scope.external = 1;
	    	}
	    	if($scope.equQryBean.isCrecOrg==0){
	    		$scope.external = 2;
	    	}
	    }
   	});
    </script>
  
 
    
    <style type="text/css">
        ::-ms-clear, ::-ms-reveal{display: none;} 
        .lable {
           font-size:30px
         }
        .code {
            background: url(../../../media/images/vcode.png);
            font-family: Arial;
            color: blue;
            font-size: 25px;
            cursor: pointer;
            text-align: center;
            vertical-align: middle;

        }
       
        #relationWay{
            margin:0 0 0px;
        }
        .Infopub_a1:link {
			text-decoration: none;
		}
		.Infopub_a1:visited {
			text-decoration: none;
		}
		.Infopub_a1:hover {
			text-decoration: none;
		}
		.Infopub_a1:active {
			text-decoration: none;
		}
		.container {width: 1500px !important;}
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
	    .page-list .page-total {float:left; margin: 20px 20px;}
	    .page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
	    .page-list .page-total input {width: 40px; padding-left:3px;}
	    .page-list .page-total select {width: 50px;}
	    .table-hover > tbody > tr:hover > td,
		.table-hover > tbody > tr:hover > th {
		  background-color: #f5f5f5;
		}
    </style>
</head>
<body ng-app="infoPubApp" ng-controller="infoPubController" class="container" >
<jsp:include page="../../Front/Main/Top.jsp"/>

<form action="" style="width: 95%; " novalidate name="InfoAddForm" ng-click="FormBlur();" >	
    <div class="form-horizontal" style="margin-top: 10px;margin-left:50px;">
    <div class="col-xs-12" style="margin-top: -20px"><div class="position"><span>&gt;</span>  &nbsp;首页  &nbsp; <span>&gt;</span> &nbsp;发布出租信息  &nbsp;</div>  </div>
        <div class="modal-body">
            <div class="form-horizontal" style="background-color: #f7f7f7;">
                <div class="panel " style="margin-top: 5px;">                   
                </div>
                <!-- 设备选择  -->
                <div class="form-group" style="margin-top: 5px;">
                    <label contenteditable="false" class="col-xs-2 control-label" style="width: 300px;margin-left:-30px; font-size:14px;color: #000" ><span style="color: red; ">*</span>设备选择：</label>
                    
                    <div class="col-xs-2">
                        <input type="button" id="hq" class="btn btn-primary" value="选择" ng-click="openChoEquModal();" style="width: 92px;background: #0057b4;">
                        <input type="hidden" class="form-control" name="equipmentId" ng-model="formParms.equipmentId" required>
                    </div>
                    <div class="col-xs-6" ng-messages="InfoAddForm.equipmentId.$error" ng-show="showFlag == 'equipmentId'">
                        <p class="form-control-static" style="color:red;" ng-message="required">请选择设备</p>
                    </div>
                </div>
                <!-- 设备信息  -->
                <div class="form-group" ng-show="formParms.equipmentId!=null" style="margin-left:45px;">
                    <label contenteditable="false" class="col-xs-2 control-label" style="margin-left:-5px;font-size:14px;color: #000">设备信息：</label>
                    <div class="col-xs-8">
                        <table class="table table-bordered "style="background-color: #F5F5F5;margin-bottom: 0px;">
                            <tbody>
	                            <tr>
	                                <th width="2%" style="text-align: right;">设备编号：</th>
	                                <td width="3%" ng-bind="equiList.equNo"></td>
	                                <th width="2%" style="text-align: right;">设备名称：</th>
	                                <td width="3%" ng-bind="equiList.equName"></td>
	                                <th width="2%" style="text-align: right;">品牌：</th>
	                                <td width="3%" ng-bind="equiList.brandName"></td>
	                            </tr>
	                            <tr>
	                                <th style="text-align: right;">型号：</th>
										<td ng-bind="equiList.models"></td>

										<th style="text-align: right;">规格：</th>
										<td ng-bind="equiList.specifications"></td>
										<th style="text-align: right;">功率（KW）：</th>
										<td ng-bind="equiList.power"></td>
	                       
                                
	                            </tr>
	                            <tr>
	                                <th style="text-align: right;">技术情况：</th>
	                                <td ng-model="equiList.technicalStatus">
			                            <span ng-show="equiList.technicalStatus==1">一类</span>
			                            <span ng-show="equiList.technicalStatus==2">二类</span>
			                            <span ng-show="equiList.technicalStatus==3">三类</span>
			                        </td>
	                                <th style="text-align: right;">生产厂家：</th>
	                                <td ng-bind="equiList.manufacturerName"></td>
	                                <th style="text-align: right;">出厂日期：</th>
	                                <td ng-bind="equiList.productionDate"></td>
	                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- 最短租期  -->
              	<div class="form-group">
                    <label contenteditable="false" class="col-xs-2 control-label" style="width:300px;margin-left:-31px;"><span style="color: red; ">*</span>最短租期：</label>
                  
                    <div class="col-xs-3">
                        <input type="text" class="inpt_a inpt_o span110" id="shortestLease" name="shortestLease" ng-model="formParms.shortestLease" required maxlength="3" pattern="^\+?[1-9][0-9]*$"
                        	    ng-focus="inputFocus('shortestLeaseFlag');" ng-disabled="zuQi">
                        <button ng-show="shortestLeaseFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('shortestLeaseFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
                    </div>
                    <div class="col-xs-1">
                        <select  style="position: absolute;z-index:3;width:100%;height: 34px;margin-top: 0px;color: #555;" id="priceTypeId" class="sel_a sel_ay" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.UNIT_LEASETIME"  ng-model="formParms.priceType">
         				 </select>
                    </div>
                   
                    <div class="col-xs-2" style="margin-top:2px;margin-left:38px">
						<label class="checkbox-inline" ><input  type="checkbox" ng-model="tmp.reason2" ng-true-value="1" ng-false-value="0" ng-click="zuQiClick(tmp.reason2);">不限</label> 
					</div>
                    <div class="col-xs-2">
                        <div ng-messages="InfoAddForm.shortestLease.$error" ng-show="showFlag == 'shortestLease'">
                            <p class="form-control-static" style="color:red;margin-left:-100px;margin-top:5px;" ng-message="required">请输入最短租期</p>
                            <p class="form-control-static" style="color:red;margin-left:-100px;margin-top:5px;" ng-message="pattern">请输入正确的最短租期</p>
                        </div>
                    </div>
              	</div>
                <!-- 价格  -->
                <div class="form-group">
                    <label contenteditable="false" class="col-xs-2 control-label" style="width:300px;margin-left:-31px;"><span style="color: red; ">*</span>价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：</label>
                   
                    <div class="col-xs-3" ng-show="!infoType">
                        <input type="text" class="inpt_a inpt_o span110" id="price" name="price" ng-model="formParms.price" required maxlength="18" 
                               ng-change="formatMoney(formParms.price,'price',2);" ng-focus="inputFocus('priceFlag');" > 
                        <button ng-show="priceFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('priceFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
                    </div>
                     <div class="col-xs-3" ng-show="infoType==1">
                        <input type="text" class="inpt_a inpt_o span110" id="price" name="price" ng-model="formParms.price" required maxlength="18" 
                               ng-change="formatMoney(formParms.price,'price',2);" ng-focus="inputFocus('priceFlag');"> 
                        <button ng-show="priceFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('priceFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
                    </div>
                    <label class="col-xs-1 control-label" style="margin-top:2px;width:91px;">元/{{ct.codeTranslate(formParms.priceType,"UNIT_LEASETIME")}}</label>
                    <div class="col-xs-2">
                        <div ng-messages="InfoAddForm.price.$error" ng-show="showFlag == 'price'">
                            <p class="form-control-static" style="color:red;margin-left:30px;" ng-message="required"> 请您填写正确的价格</p>
                            <p class="form-control-static" style="color: red;margin-left:30px;" ng-message="pattern">请您填写正确的价格</p>
                        </div>
                    </div>
              	</div>
              	
             	<!-- 信息标题  -->
             	<div class="form-group" >
                    <label contenteditable="false" style="width: 300px;margin-left:-30px;" class="col-xs-2 control-label"><span style="color: red; ">*</span>信息标题：</label>
                    	
                    <div class="col-xs-6">
                        <input type="text" class="inpt_a inpt_o span110"  ng-model="formParms.infoTitle" id="infoTitleId" name="infoTitle" required  
                        	   maxlength="100"  ng-minlength="2" minlength="2"  ng-focus="inputFocus('infoTitleFlag');" >
                        <button ng-show="infoTitleFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('infoTitleFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
                    </div><!--  -->
                    <div class="col-xs-3" ng-messages="InfoAddForm.infoTitle.$error" ng-show="showFlag == 'infoTitle'">
                        <p class="form-control-static" style="color:red;" ng-message="required"> 请输入信息标题</p> 
                    </div>
                    <div class="col-xs-3" ng-messages="InfoAddForm.infoTitle.$error" ng-show="showFlag == 'infoTitle2'">
                        <p class="form-control-static" style="color: red;" ng-message="minlength" >信息标题不能少于2个汉字请补充</p> 
                    </div>
                </div>
             	<!-- 详细说明  -->
             	<div class="form-group">
                    <label contenteditable="false" class="col-xs-2 control-label" style="width:300px;margin-left:-30px;"><span style="color: red; ">*</span>详细说明：</label>
                   
                    <div class="col-xs-6">
                        	<textarea style="margin-left:-1px;margin-bottom: 3px;" ng-model="formParms.detailedDescription"  id="myEditorAA" rows="10"
                        	 		   name="detailedDescription" maxlength="2000" ></textarea>
                        
							<font class="Infopub_a1" style="color: #cc0001">温馨提示：输入内容越详细，用户越容易找到此类信息！</font>
						
                    </div>
                    <div class="col-xs-3" ng-messages="InfoAddForm.detailedDescription.$error" ng-show="showFlag == 'detailedDescription'">
                        <p class="form-control-static" style="color: red;margin-top:15px;">请输入详细说明，内容越详细，用户越容易找到此类信息！</p>
                    </div>
             	</div>
                <!-- 设备图片  -->
	          	<div class="form-group" style="margin-left:55px;">
				    <label style="margin-left:-13px;" contenteditable="false" class="col-xs-2 control-label"><span style="color: red; ">*</span>设备图片：</label>
				  
					<div class="col-xs-1">
						 <input id="fileUpLoadId" type="file" ng-file-select="onFileSelect($files)" style="display: none">

						<div class="input-group" style="">
							<input type="hidden" readonly class="inpt_a inpt_o span110" ng-model="formParms.equipmentPic" name="equipmentPic" required >
							<input type="button" class="btn btn-primary" ng-if="PListLength!=5" value="点击上传" ng-click="newFileUpLoad();"  style="width: 92px;background: #0057b4;">
							<input type="button" class="btn btn-primary" ng-if="PListLength==5" value="点击上传" ng-click="newFileUpLoad();"  style="width: 92px;background: #0057b4;" ng-disabled="true">
							<input id="fileupload" type="file" name="file" data-url="/Picture" multiple style="display:none;" >
						</div> 
						
						
					</div>
			  	</div>	
			  	<!-- 上传图片  -->		
			  	<div class="form-group"  style="margin-left:300px;margin-top:-20px;">			
					<div class="col-xs-4">
						<p style="color:#cc0001;margin-top:-35px;margin-left:20px;">上传图片，信息效果提高60%；上传图片的数量，最多不超过5张,只允许上传BMP、GIF、JPG、JPEG格式文件，图片大小不能超过2M。</p>
					</div>
					<div class="col-xs-8"
						 ng-messages="InfoAddForm.equipmentPic.$error" ng-show="showFlag == 'equipmentPic'">
						<p class="form-control-static" style="color: red;margin-left:400px;margin-top:-40px;" ng-message="required">请上传设备图片</p>
					</div>
			  	</div>
			  	<!-- 图片显示   -->
	          	<div class="form-group" >
                    <label contenteditable="false" class="col-xs-2 control-label"></label>

                   <div ng-repeat="t in PicList" >
                        <div class="col-xs-2" style="height: 160px">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="removePic($index,t);">&times;</button>
                            <a href="#" class="thumbnail">
                               <img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" alt="" style="width: 300px;;height: 130px;" onerror="javascript:this.src='/media/images/default.png';"/>                               
                            </a>
                        </div>
                   </div>
                   <div ng-repeat="t in PicListD" >
                        <div class="col-xs-2" style="height: 160px">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="removePic($index,t);">&times;</button>
                            <a href="#" class="thumbnail">
                                <img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}" alt="" style="width: 300px;;height: 130px;" onerror="javascript:this.src='/media/images/default.png';"/>
                                <input type="hidden" id="delPicNum" name="delPicNum" ng-model="delPicNum" class="inpt_a inpt_o span110" >
                            </a>
                        </div>
                   </div>
	          	</div>
	          	<hr>
	          	<!-- 联系方式  -->
	          	<div class="form-group" style="margin-left:-44px;">
         	 		<label contenteditable="false" class="col-xs-2 col-xs-offset-3 control-label" style="font-size:18px;margin-left: 0px;color:#017cfe;">联系方式</label>
	          	</div>
	          	<!-- 企业名称  -->      
	          	<div class="form-group">
              		<label contenteditable="false" class="col-xs-2  control-label" style="margin-left:38px;"><span style="color: red; ">*</span>联系单位：</label>
	              	
	              	<div class="col-xs-3" style="margin-left: 5px">
              			<input type="text" id="" class="inpt_a inpt_o span110" ng-model="formParms.enterpriseName" required style=" margin-top:7px;float: left; font-size: 14px;color: #000; " maxlength="30"/>
	              	</div>
              		<div class="col-xs-2">
	                   	<div class="col-xs-12" ng-if="orgName==1">
	                       	<p class="form-control-static" style="color:red;margin-left:35px;" >请输入联系单位</p>
	                   	</div>
               		</div> 
	          	</div>
	          	<!-- 设备所在城市  -->      
	          	<div class="form-group">
               		<label contenteditable="false" class="col-xs-2 control-label" style="margin-left:38px;"><span style="color: red; ">*</span>所在城市：</label>
	               
	                <div class="col-xs-2">
                   		<select id="province" name="SelectProvince" ng-model="recPro.proModel" class="sel_a sel_ay" required
	                   		    ng-options="recPro.name as recPro.name for recPro in areaList" ng-change="changePro(recPro);" 
	                     	     style="position: absolute;z-index:2;margin-left: 5px;width:100%;height: 34px;margin-top: 0px;color: #555;"> 
                       		<option value="" >--请选择省份--</option>
	                   </select>
	               	</div>
	               	<div class="col-xs-2">
                    	<select id="city" name="SelectCity" ng-model="recCit.recModel" class="sel_a sel_ay"
	               				ng-options="recCit.name as recCit.name for recCit in pList" ng-change="changeCity(recCit);"  required
	               				  style="position: absolute;z-index:2;margin-left:10px;width:100%;height: 34px;margin-top: 0px;color: #555;">  
                   			<option value="">--请选择城市--</option>  
                		</select>             
	               </div>
	               <div class="col-xs-2">
	                   	<select class="sel_a sel_ay" id="district" name="SelectCounty" ng-model="recDis.disModel" 
	               			    ng-options="recDis.name as recDis.name for recDis in cList" ng-change="changeDis(recDis)" required
	               			      style="position: absolute;z-index:2;margin-left:15px;width:100%;height: 34px;margin-top: 0px;color: #555;">  
                   			<option value="">--请选择区县--</option>  
                		</select>
               		</div> 
	               	<div class="col-xs-2">
	                   	<div class="col-xs-12" ng-messages="InfoAddForm.SelectProvince.$error" ng-show="showFlag == 'SelectProvince'">
	                       	<p class="form-control-static" style="color:red;margin-left:35px;" ng-message="required">请选择所在省份</p>
	                   	</div>
	                   	<div class="col-xs-12" ng-messages="InfoAddForm.SelectCity.$error" ng-show="showFlag == 'SelectCity'">
	                       	<p class="form-control-static" style="color:red;margin-left:35px;" ng-message="required">请选择所在城市</p>
	                   	</div>
	                   	<div class="col-xs-12" ng-messages="InfoAddForm.SelectCounty.$error" ng-show="showFlag == 'SelectCounty'">
	                       	<p class="form-control-static" style="color:red;margin-left:35px;" ng-message="required">请选择所在区县</p>
	                   	</div>
               		</div> 
       	      	</div>
	         	<!-- 设备详细地址   -->
	         	<div class="form-group">     
					<label contenteditable="false" class="col-xs-2 control-label" style="margin-left:36px;margin-top: 5px">详细地址：</label>
					<div class="col-xs-3" style="margin-left: 7px;margin-top: 5px">
			      		<input type="text" class="inpt_a inpt_o span110" id="contactAddress" name="contactAddress" ng-model="formParms.contactAddress" 
		      		 			  maxlength="50" ng-focus="inputFocus('contactAddressFlag');">
					  	<button ng-show="contactAddressFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('contactAddressFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
					</div>
	         	</div>
	         	<!-- 联系人   -->
	         	<div class="form-group">
             		<label contenteditable="false" class="col-xs-2 control-label" style="margin-left:38px;"><span style="color: red; ">*</span>联&nbsp;&nbsp;系&nbsp;&nbsp;人：</label>
           			
	             		<div class="col-xs-3"style="margin-left: 5px">
	                 		<input type="text" class="inpt_a inpt_o span110" id="contactPerson"  name="contactPerson" ng-model="formParms.contactPerson" required 
	                 				maxlength="10" ng-focus="inputFocus('contactPersonFlag');">
	                 		<button ng-show="contactPersonFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('contactPersonFlag');" style="margin-right:10px;margin-top:-29px;color: b">&times;</button>
	             		</div>
		             	<div class="col-xs-2">
		                 	<div class="col-xs-12" ng-messages="InfoAddForm.contactPerson.$error" ng-show="showFlag == 'contactPerson'">
		                     	<p class="form-control-static" style="color:red;margin-left:-12px;" ng-message="required">请输入联系人姓名</p>
	                 		</div>
	             		</div>
        		</div>
        		
        		
	        	<!-- 联系电话  -->
	        	<div class="form-group">
		            <label contenteditable="false" class="col-xs-2 control-label" style="margin-left:38px;"><span style="color: red; ">*</span>联系电话 ：</label>
		           
		            <div class="col-xs-3" style="margin-left: 5px">
		           <!--  ng-pattern="/(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)/" -->
		                 <input type="text" class="inpt_a inpt_o span110" id="contactPhone" name="contactPhone" ng-model="formParms.contactPhone" required 
		                 	ng-pattern="/(^[0-9,\-]{7,}$)/"	maxlength="17"  ng-minlength="7" ng-focus="inputFocus('contactPhoneFlag');">
		              	 <button ng-show="contactPhoneFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('contactPhoneFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
		            </div>
		            <div class="col-xs-2 " ng-messages="InfoAddForm.contactPhone.$error" ng-show="showFlag == 'contactPhone'">
		                 <p class="form-control-static" style="color:red;" ng-message="required">请输入联系电话</p>
		                 <p class="form-control-static" style="color:red;" ng-message="pattern">请输入正确的联系电话</p>
		                 <p class="form-control-static" style="color:red;" ng-message="minlength">请输入正确的联系电话</p>
		            </div> 
	        	</div>
	        	
	        	
	        	
	        	
	        	
	        	
	        	
	        	<!-- QQ  -->
	        	<div class="form-group">
			          <label contenteditable="false" class="col-xs-2 control-label" style="margin-left:38px;">Q&nbsp;&nbsp;Q：</label>
			
			          <div class="col-xs-3" style="margin-left: 5px">
			               <input type="text" ng-pattern="/^[0-9]*$/" class="inpt_a inpt_o span110" id="qqNo" name="qqNo" ng-model="formParms.qqNo" 
		               			  maxlength="15" ng-focus="inputFocus('qqNoFlag');">
			               <button ng-show="qqNoFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('qqNoFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
			          </div>
			          <div class="col-xs-2 " ng-messages="InfoAddForm.qqNo.$error" ng-show="showFlag == 'qqNo'">
		                  <p class="form-control-static" style="color:red;" ng-message="pattern">请输入正确的QQ号码</p>
		              </div> 
			          <div class="col-xs-1"></div>
	        	</div>    
		        <!-- 验证码  -->	
	         	<div class="form-group">
		             <label contenteditable="false" class="col-xs-2 control-label" style="margin-left:38px;"><span style="color: red; ">*</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码：</label>
		            
		             <div class="col-xs-2" style="margin-left: 5px">
		                 <input type="text" class="inpt_a inpt_o span110" id="inputCode" name="inputCode" ng-model="formParms.inputCode" required 
		                 		placeholder="请输入验证码" maxlength="4" ng-focus="inputFocus('inputCodeFlag');">
		                 <button ng-show="inputCodeFlag" type="button" class="close" aria-hidden="true" ng-click="deleteText('inputCodeFlag');" style="margin-right:10px;margin-top:-29px;">&times;</button>
		             </div>
		             <div class="col-xs-1" ng-init="GetVercode()">
		                 <div class="code" id="checkCode" ng-click="GetVercode()"></div>
		             </div>
		             <div class="col-xs-2" style="text-align: left;line-height: 40px">
		                 <a ng-click="GetVercode()" href="javascript:void(0);">看不清，换一张</a>
		             </div>
		             <div class="col-xs-2" ng-messages="InfoAddForm.inputCode.$error" ng-show="showFlag == 'inputCode'">
		                 <p class="form-control-static" style="color:red;margin-left:-100px;margin-top:5px;" ng-message="required">请您填写验证码</p> 
		             </div>
		             <div class="col-xs-2" ng-messages="InfoAddForm.inputCodeErr.$error" ng-show="showFlag == 'inputCodeErr'">
		                 <p class="form-control-static" style="color:red;margin-left:-100px;margin-top:5px;">请您填写正确的验证码</p>
		             </div>
	         	</div> 
	         	<div style="padding-bottom: 46px;margin-left: 266px">
	         	<a href="##returnTopId">
		         	 <input type="button" class="btn " value="发布信息" ng-click="add(InfoAddForm,tmp.reason2)" style="background-color: #f48a00;color: white;width:140px;height:40px;font-size: 16px;">
	         	</a>
                 <input type="button" class="btn " ng-click="goBack();" value="返回"  style="background-color: #f48a00;color: white;width:140px;height:40px;font-size: 16px;margin-left: 20px">                
                </div>
          </div>
      </div>
   </div>
</form>

<div ng-include src="'../../../WebSite/Back/Publish/Choequipment.jsp'"></div>
<div ng-include src="'../../../WebSite/Back/Publish/RentAndSaleSucc.jsp'"></div>



<jsp:include page="../../Front/Include/Bottom.jsp"/>


</body>
</html>