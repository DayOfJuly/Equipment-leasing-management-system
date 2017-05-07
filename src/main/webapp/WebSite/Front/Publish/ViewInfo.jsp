<%@ page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="../Include/Head.jsp"/>
    <jsp:include page="../conmmon/publicSession.jsp" />
    <script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
    <script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
    <script type="text/javascript" src="../../../media/js/pagination.js"></script>
    <script type="text/javascript" src="../../../js/JsSvc/SysCodeConfig.js"></script>
    <script type="text/javascript" src="../../../js/JsSvc/SysCodeTranslate.js"></script>
	<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
	<link href="../../../media/css/css.css" type="text/css" rel="stylesheet"/>	
	 <!-- <script src="../../../media/js/base.js" type=text/javascript></script> -->
	<script src="../../../media/js/lib.js" type=text/javascript></script> 
	<script src="../../../media/js/163css.js" type=text/javascript></script>
	<script language="javascript" type="text/javascript" src="../../../media/js/ss.js"></script><!--左右GUNDONG-->
	<script type="text/javascript">
        var app = angular.module('viewinfoApp', ['ngResource', 'unifyModule','myPagination', 'ngMessages','Config','sysCodeConfigModule','sysCodeTranslateModule']);
        app.controller('viewinfoController', function ($scope,$timeout,$interval,rentSvc,SaleSvc,PicSvc,personSvc, published,regionSvc,busDealInfo,busPublishInfo,PicUrl,SYS_CODE_CON,sysCodeTranslateFactory,IssuSvc) {
        	
        	 $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
        	    
        	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
        	 
        	    var viewinfo="newRent";
        		$scope.cookiesJudge=function(rec){/* 判断cookies是否存在，如已存在直接进入页面，如不存在进入登录页面 */
        			dataId = rec.dataId;
        			infoType = rec.dataType;
        			var isLogin = null;
        				if(isLogin==null){
        							window.location.href="../../Back/Publish/ViewInfo.jsp?id="+dataId+"&infoType="+infoType+"&flag="+viewinfo;
        						}
        			};
            var url = location.search;/* jsp后面的参数 ：?id=432&infoType=1 */
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {/* 如果有？ */
                var str = url.substr(1);/* 去掉？ ：id=432&infoType=1 */
                strs = str.split("&");/* 去掉& ：["id=432", "infoType=1"] */
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
                }
            }
            $scope.requestParms = theRequest;/* {id: "432", infoType: "1"} */
         	//cookies
         	
         	  $scope.userInfo = {};
			    $scope.userInfo.orgCode=SYS_USER_INFO.code;
			    $scope.userInfo.orgId=SYS_USER_INFO.orgId;
			    $scope.userInfo.orgName =  SYS_USER_INFO.orgName;
			    $scope.userInfo.orgParentCode = SYS_USER_INFO.orgParentCode;
			    $scope.userInfo.loginUserId = SYS_USER_INFO.loginUserId;
			    $scope.userInfo.orgLevel =  SYS_USER_INFO.orgLevel;
			    $scope.userInfo.partyId = SYS_USER_INFO.partyId;
            if( $scope.userInfo){
            	$scope.userCookies =  $scope.userInfo;
            }else{
            	$scope.userCookies = "";
            }
            if($scope.userCookies.orgLevel==2 && $scope.userCookies.orgLevel==3 && $scope.userCookies.orgLevel==4 && $scope.userCookies.orgLevel==5 && $scope.userCookies.orgLevel==6){
            	$scope.hidden=1;
            }else{
            	$scope.hidden=2;
            }
            
            var	hidden;
            if($scope.userCookies.loginUserId){
            	$scope.hidden=1;
            }else{
            	$scope.hidden=2;
            }
            /*
             *分页标签参数配置
             */
            $scope.paginationConf = {
                currentPage: 1, /*当前页数*/
                totalItems: 1, /*数据总数*/
                pageRecord: 5, /*每页显示多少*/
                pageNum: 10, /*分页标签数量显示*/
                /*
                 * parm1:当前选择页数
                 * parm2:每页显示多少
                 */
                queryList: function (parm1, parm2) {
                    //$scope.paginationConf.currentPage = parm1;
                    $scope.queryviewData();
                }
            };
            
            /*
             * 地址查询--所在城市
             */
             $scope.temporary={};
             $scope.requesRegionAt = function(parm){
             	function qSucc(rec){
         			$scope.AtDisName=rec.name;
         			$scope.AtCitName=rec.parentName;
         			$scope.temporary=rec;
         			$scope.queryCities($scope.temporary);
 				}
 				function qErr(){}
 				regionSvc.queryRegionByRegionId2({id:parm},qSucc,qErr);
             };
            
              $scope.queryCities = function(){
            	  function qSucc(rec){
           			$scope.AtProName=rec.parentName;
       				$scope.viewList.AtRegionName=$scope.AtProName+'-'+$scope.AtCitName+'-'+$scope.AtDisName;
           		 }
   				 function qErr(){}
       			 regionSvc.queryRegionByRegionId2({id:$scope.temporary.parentRegionId},qSucc,qErr);
              };            
              
             
            /*
             * 查询test数据
             */
            $scope.queryviewData = function () {
                function qSucc(rec) {
                    $scope.addCount();
                    $scope.MyButton();
                	//所在城市
                	if(rec.atCity == 0){
                		$scope.viewList.AtRegionName = "全国";
                	}else{
                		if(rec.atCity){
                			$scope.requesRegionAt(rec.atCity);
                		}
                	}
                	
                    $scope.viewList = rec.issueInfo;
                    $scope.viewList.managerId = rec.issueInfo.managerId;
                	if($scope.userCookies.loginUserId==$scope.viewList.managerId){
                		   $scope.reveal=1;
                    }else{
                    	$scope.reveal=2;
                    }
                	
                    $("#rePayMsg").get(0).innerHTML = $scope.viewList.detailedDescription;
                    
                    $scope.viewList.contactPhone1=$scope.changeValueFun($scope.viewList.contactPhone);
                    $scope.viewList.qqNo1=$scope.changeValueFun($scope.viewList.qqNo);
                    $scope.viewList.viewCount = rec.issueInfo.viewCount; 
                    if($scope.viewList.viewCount==null){
                    	$scope.viewList.viewCount = 1;
                    }
                   	$scope.AtCity =  $scope.viewList.onProvince+""+$scope.viewList.onCity+""+$scope.viewList.onDistrict
                    
                    if($scope.viewList.enterpriseName){
	                    if($scope.viewList.enterpriseName.length > 10){
							$scope.viewList.enterpriseNameA = $scope.viewList.enterpriseName.substring(0,10)+"...";
						}else{
							$scope.viewList.enterpriseNameA =  $scope.viewList.enterpriseName;
						}
                    }
                   	
                    if($scope.AtCity){
	                    if($scope.AtCity.length > 10){
							$scope.AtCityA = $scope.AtCity.substring(0,10)+"...";
						}else{
							$scope.AtCityA =  $scope.AtCity;
						}
                    }
                    if($scope.viewList.contactAddress){
	                    if($scope.viewList.contactAddress.length > 10){
							$scope.viewList.contactAddressA = $scope.viewList.contactAddress.substring(0,10)+"...";
						}else{
							$scope.viewList.contactAddressA =  $scope.viewList.contactAddress;
						}
                    }
                    if($scope.viewList.equipmentTable.specifications){
                 		if($scope.viewList.equipmentTable.specifications.length > 15){
                    		$scope.viewList.equipmentTable.specificationsA = $scope.viewList.equipmentTable.specifications.substring(0,15)+"...";
                    	}else{
                    		$scope.viewList.equipmentTable.specificationsA = $scope.viewList.equipmentTable.specifications;
                    	}
                 	}  
                    
                    if($scope.viewList.brandName){
                 		if($scope.viewList.brandName.length > 15){
                    		$scope.viewList.brandNameA = $scope.viewList.brandName.substring(0,15)+"...";
                    	}else{
                    		$scope.viewList.brandNameA = $scope.viewList.brandName;
                    	}
                 	}  
                	 if($scope.viewList.equipmentTable.models){
                  		if($scope.viewList.equipmentTable.models.length > 15){
                     		$scope.viewList.equipmentTable.modelsA = $scope.viewList.equipmentTable.models.substring(0,15)+"...";
                     	}else{
                     		$scope.viewList.equipmentTable.modelsA = $scope.viewList.equipmentTable.models;
                     	}
                  	}  
                	 if($scope.viewList.standardName){
                  		if($scope.viewList.standardName.length > 15){
                     		$scope.viewList.standardNameA = $scope.viewList.standardName.substring(0,15)+"...";
                     	}else{
                     		$scope.viewList.standardNameA = $scope.viewList.standardName;
                     	}
                  	}  
                    
                    if($scope.viewList.equipmentTable.equNo){
	                    if($scope.viewList.equipmentTable.equNo.length > 20){
							$scope.viewList.equipmentTable.equNoA = $scope.viewList.equipmentTable.equNo.substring(0,20)+"...";
						}else{
							$scope.viewList.equipmentTable.equNoA =  $scope.viewList.equipmentTable.equNo;
						}
                    }
                    if($scope.viewList.equName){
	                    if($scope.viewList.equName.length > 15){
							$scope.viewList.equNameA = $scope.viewList.equName.substring(0,15)+"...";
						}else{
							$scope.viewList.equNameA =  $scope.viewList.equName;
						}
                    }
                    if($scope.viewList.equipmentTable.manufacturer){
	                    if($scope.viewList.equipmentTable.manufacturer.length > 15){
							$scope.viewList.equipmentTable.manufacturerA = $scope.viewList.equipmentTable.manufacturer.substring(0,15)+"...";
						}else{
							$scope.viewList.equipmentTable.manufacturerA =  $scope.viewList.equipmentTable.manufacturer;
						}
                    }
                    $scope.dealCount = rec.dealCount; //意向承租人数
                    $scope.depName = rec.depName;//最终承租人
                    $scope.equState = rec.equState; //设备状态
                    if(rec.issueInfo.priceType==null){
                    	$scope.viewList.priceType=1;
                    }
                    if($scope.depName){
	                    if($scope.depName.length > 10){
							$scope.depNameA = rec.depName.substring(0,10)+"...";
						}else{
							$scope.depNameA = rec.depName;
						}
                    }
                    
                    $scope.viewList.atCity = rec.issueInfo.atCity;
                	//所在城市
                 	if(rec.issueInfo.atCity == null ){
                 		$scope.viewList.atCity = "全国";
                 	}
                	
                    
                    if(rec.issueInfo.infoTitle.length > 15){
                		$scope.viewList.infoTitleB = rec.issueInfo.infoTitle.substring(0,15)+"...";
                	}else{
                		$scope.viewList.infoTitleB = rec.issueInfo.infoTitle;
                	}
                 
                
                    if($scope.viewList.equipmentPic)
                    {
                    	
                        $scope.pic = $scope.viewList.equipmentPic.split(',');//分割逗号，因本没逗号所以把整个值放入数组pic
                        
                        $scope.PicList = [];
                        for ( var i = 0; i < $scope.pic.length; i++) {
                            var fullname = $scope.pic[i].split('.');//截去点号，为前半段图片名和后半段类型名
                            $scope.PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};//把两个值分别和一个key匹配放入一个对象内
                            $scope.PicList.push($scope.PicOne);
                            $scope.PicUrl = PicUrl;
                            $scope.PicSrc=$scope.PicUrl+"/"+$scope.PicList[i].PicName+"/"+$scope.PicList[i].PicType; //拼出一个链接
                        };
                        $scope.PicSrc=$scope.PicUrl+"/"+$scope.PicList[0].PicName+"/"+$scope.PicList[0].PicType; //拼出一个链接
                    }
                     
                }
                
                function qErr(rec) {}
                
                $scope.infoType = $scope.requestParms.infoType;
                
                if ($scope.requestParms.infoType == 1) {
                	
                	document.title="出租信息";
                	
                	published.unifydo({Action:"Rent"},{ parm: $scope.requestParms.id}, qSucc, qErr);
                } else if ($scope.requestParms.infoType == 2) {
                	
                	document.title="出售信息";
                	
                	published.unifydo({Action:"Sale"},{ parm: $scope.requestParms.id}, qSucc, qErr);
                }
            }; 
            //同类产品推荐
            $scope.titleList=[];
             $scope.querySimilar = function(){
            	 if ($scope.requestParms.infoType == 1) {
            		 function qSuc(rec) {
	            		 $scope.equName = rec.issueInfo.equName;
	            		 function qSucc(pram){
	                		 $scope.titleList = pram.content;
	                		  for(var i=0;i<pram.content.length;i++){
	                		 	$scope.titleList[i].infoTitle = pram.content[i].infoTitle;
	                		 		if($scope.titleList[i].infoTitle.length>15){
	                		 			$scope.titleList[i].infoTitleA = $scope.titleList[i].infoTitle.substring(0,15)+"...";
	                		 		}else{
	                		 			$scope.titleList[i].infoTitleA = $scope.titleList[i].infoTitle
	                		 		}
	                		 } 
	                	 }
	                	 
	                	 function qErr(){}
	                	 IssuSvc.post({Action:"Rent"},{dataType:1,equName:$scope.equName,pageNo:0,pageSize:10},qSucc,qErr);
	            	 }
	            	 function qEr(rec) {};
	            	published.unifydo({Action:"Rent"},{parm: $scope.requestParms.id},qSuc,qEr);
            	 }
            	 if ($scope.requestParms.infoType == 2) {
            		 function qSuc(rec) {
	            		 $scope.equName = rec.issueInfo.equName;
	            		 function qSucc(pram){
	                		 $scope.titleList = pram.content;
	                		  for(var i=0;i<pram.content.length;i++){
	                		 	$scope.titleList[i].infoTitle = pram.content[i].infoTitle;
	                		 		if($scope.titleList[i].infoTitle.length>15){
	                		 			$scope.titleList[i].infoTitleA = $scope.titleList[i].infoTitle.substring(0,15)+"...";
	                		 		}else{
	                		 			$scope.titleList[i].infoTitleA = $scope.titleList[i].infoTitle
	                		 		}
	                		 } 
	                	 }
	                	 
	                	 function qErr(){}
	                	 IssuSvc.post({Action:"Sale"},{dataType:2,equName:$scope.equName,pageNo:0,pageSize:10},qSucc,qErr);
	            	 }
	            	 function qEr(rec) {};
	                published.unifydo({Action:"Rent"},{parm: $scope.requestParms.id},qSuc,qEr);
             	 }
            };
            $scope.querySimilar();
            
            
            
            
            /* 浏览次数 */
             $scope.addCount = function()
            {   
            	 function success(rec) {
                 }
                 function error(rec) {}
                 published.addViewCount({ urlPath:$scope.requestParms.id },success,error);
            };
       
            
                 
                //如果手机qq号没登陆超过3位用*显示（传入一个参数用这个参数截取然后返回这个参数，在调用这个方法的方法中在接收这个值，因为传入这个参数后他就是个数，要在赋值给电话和qq号才行
                $scope.changeValueFun = function(value){
                	//如果没登陆cookies显示前三位后面用*补齐（手机，qq）
		                if(value){
		                   		 var par = value;
		                   		 value = par.substring(0,3)+"********";
		                   	 }
	                    return value;
                };
              
                
                //打开我想交易Model
                $scope.formParms = {};
          		
                $scope.openViewInfoModel = function(){
                	
                	function succ(rec){
                		$scope.formParms.depName = rec.deptName;
                   		$scope.formParms.linkName = rec.loginId;
                   		$scope.formParms.linkPhone = rec.mobile;
                   	 $('#viewInfoModel').modal({backdrop: 'static', keyboard: false});
                	}
                	function err(rec){
                		
                	}
                	personSvc.queryPerson({id: $scope.userInfo.partyId},succ,err)
                	
                }
                //关闭我想交易Model
                $scope.closeViewInfoModel = function(formParms){
                	if(formParms){
                		formParms.depName = '';
                    	formParms.linkName = '';
                    	formParms.linkPhone = '';
                	}
                	$('#viewInfoModel').modal('hide');
                }
                $scope.busDealInfoBean = {};
                
                /*
                *我想要交易事件
                */
                $scope.addClick=function(formParms,categoryForm){
             	   
             	   if(!categoryForm.$valid){
             		   if(!categoryForm.depName.$valid){
             			   $scope.showFlag = 'depName';
             			   return;
             		   }else if(!categoryForm.linkName.$valid){
             			   $scope.showFlag = 'linkName';
             			   return;
             		   }else if(!categoryForm.linkPhone.$valid){
             			   $scope.showFlag = 'linkPhone';
             			   return;
             		   }
             	   }else{
            
                 	$scope.busDealInfoBean.dataId = $scope.viewList.dataId;
                 	
                 	$scope.busDealInfoBean.depName = formParms.depName;//单位名称
                 	
                 	$scope.busDealInfoBean.linkName = formParms.linkName;//联系人姓名
                 	
                 	$scope.busDealInfoBean.linkPhone = formParms.linkPhone;//联系方式 
                 	
                 	function qSucc(rec){
 	                		alert("操作成功，您可以在“我的鲁班-想交易的信息”功能中查看");
 	               			$scope.addButton='true';
 	               		    window.location.reload();
 	               			function qSucc(rec){
 	               				$scope.dealCount = rec.dealCount; //意向承租人数
 		                 	}
 		                 	function qErr(){}
 		                 	
 		                 	   if ($scope.requestParms.infoType == 1) {
 		                      	
 		                      	document.title="出租信息";
 		                      	
 		                      	published.unifydo({Action:"Rent"},{ parm: $scope.requestParms.id}, qSucc, qErr);
 		                      } else if ($scope.requestParms.infoType == 2) {
 		                      	
 		                      	document.title="出售信息";
 		                      	
 		                      	published.unifydo({Action:"Sale"},{ parm: $scope.requestParms.id}, qSucc, qErr);
 		                      } 
 	               		}
                 
                 	function qErr(){};
                 	
                 	busDealInfo.put($scope.busDealInfoBean,qSucc,qErr);
             	   }
                 }; 
                
                
                $scope.newList=[];
                $scope.newDataId="";
                $scope.MyButton=function(){
                   	$scope.fun = $scope.requestParms;
         		    $scope.newDataId =  $scope.fun.id;
                   	function qSucc(rec){
                       	$scope.msg = rec.msg
                       	$scope.addButton = $scope.msg;
                            if($scope.addButton=="TRUE"){
                            	$scope.addButton = true;
                            }
                            else
                            {
                            	 $scope.addButton = '';
                            } 
                    }
                   	function qErr(){}
                   	
                   	published.unifydo({Action:"BusDealInfo",dataId:$scope.newDataId, loginUserId:$scope.userCookies.loginUserId},qSucc,qErr);

                };    
                
                $scope.specList=function(){
                	$("#spec-list").jdMarquee({
            			deriction:"left",
            			width:478,
            			height:56,
            			step:2,
            			speed:4,
            			delay:10,
            			control:true,
            			_front:"#spec-right",
            			_back:"#spec-left"
            		});
            		$("#spec-list img").bind("mouseover",function(){
            			var src=$(this).attr("src");
            			$("#spec-n1 img").eq(0).attr({
            				src:src.replace("\/n5\/","\/n1\/"),
            				jqimg:src.replace("\/n5\/","\/n0\/")
            			});
            			$(this).css({
            				"border":"2px solid #ff6600",
            				"padding":"1px"
            			});
            		}).bind("mouseout",function(){
            			$(this).css({
            				"border":"1px solid #ccc",
            				"padding":"2px"
            			});
            		});	
                };
                
        });
        
    </script>
	
	<script type=text/javascript>
	$(function(){			
	   $(".jqzoom").jqueryzoom({
			xzoom:400,
			yzoom:400,
			offset:10,
			position:"right",
			preload:1,
			lens:1
		});
					
	})
	</script>
</head>

<body ng-app="viewinfoApp" ng-controller="viewinfoController" ng-init="queryviewData()">
<jsp:include page="../../../WebSite/Front/Main/Top.jsp" />

<div class="main">
   <div class="position">&nbsp; 您的位置 :首页  &nbsp; <span>></span> &nbsp;
   <span ng-if="infoType==1"><a href="../Main/HomePage.jsp?">最新出租</a></span>
   <span ng-if="infoType==2"><a href="../Main/HomePage.jsp?">最新出售</a></span>
      &nbsp; <span>></span><span title="{{viewList.infoTitle}}">&nbsp;{{viewList.infoTitle}}</span> &nbsp;</div>
   
  <div class="bdi_left">
       <div class="">
         <div class="beft_top_left">
            
    <div id=preview >
		<div class=jqzoom id=spec-n1  >
			<img height=320 src="{{PicSrc}}" jqimg="{{PicSrc}}"  width=460 class="bord1p" />
		</div>
		<div id=spec-n5 >
			<div id="spec-list">
				<ul class=list-h >
					<li  ng-repeat="t in PicList" ng-init="specList();"><img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}" onerror="javascript:this.src='/media/images/default.png';" > </li>
				</ul>
			</div>
	    </div>
</div>
         </div>
         <div class="beft_top_right">
           <div id="ViewInfo_Div1"  ng-show="requestParms.infoType=='1'" style="font-size:16px;color:#000 " title="{{viewList.infoTitle}}"><b>【出租】{{viewList.infoTitleB}}</b></div>
           <div id="ViewInfo_Div2"  ng-show="requestParms.infoType=='2'" style="font-size:16px;color:#000 " title="{{viewList.infoTitle}}"><b>【出售】{{viewList.infoTitleB}}</b></div>
           <p>设备归属：<span class="txt14" style="color:black" title="{{viewList.enterpriseName}}"> {{viewList.enterpriseNameA}}</span></p>

			<div ng-show="requestParms.infoType=='1'">
                                <p ng-show="viewList.priceType==1">设备报价：{{viewList.price}}元/月</p>
		                        <p  ng-show="viewList.priceType==2">设备报价：{{viewList.price}}元/天</p>
		                        <p  ng-show="viewList.priceType==3">设备报价：{{viewList.price}}元/小时</p>
		                        <p  ng-show="viewList.priceType==null">设备报价：</p>
	                          	<p >最短租期：   <span class="col_chen txt14">{{viewList.shortestLease}}天</span> </p> 
            </div>
            <div ng-show="requestParms.infoType=='2'">
                          	 <p>转让价格：{{viewList.price}}元</p>
            </div> 
			<p>最后更新：{{viewList.updateTime}}</p>
			<p>浏览次数：{{viewList.viewCount}}</p>
			<div  ng-show="requestParms.infoType=='1'"><p>意向承租人：<span class="col_chen txt14">{{dealCount}}<span ng-if="dealCount==''" class="col_chen txt14">0</span>人</span></p></div>
			<div  ng-show="requestParms.infoType=='1'"><p>最终承租人：<span class="col_chen txt14" title="{{depName}}">{{depNameA}}</span></p></div>
			<div  ng-show="requestParms.infoType=='2'"><p>意向购买人：<span class="col_chen txt14">{{dealCount}}<span ng-if="dealCount==''" class="col_chen txt14">0</span>人</span></p></div>
			<div  ng-show="requestParms.infoType=='2'"><p>最终购买人：<span class="col_chen txt14" title="{{depName}}">{{depNameA}}</span></p></div>
			<div><p>设备状态：{{ct.codeTranslate(equState,"VIEWINFO_EQU_STATE")}}</p></div>
	         </div>
           <div class="clear"></div>
              <div class="hiofoe_k">
               <p class="jfoiq"><b>设备信息</b></p>
             <ul class="uiig">
                <li><span>设备编号：</span> <font title="{{viewList.equipmentTable.equNo}}">{{viewList.equipmentTable.equNoA}}</font></li>
                <li><span>型号：</span><font title="{{viewList.equipmentTable.models}}">{{viewList.equipmentTable.modelsA}}</font><li>
                <li><span>技术情况：</span><font ng-show="viewList.equipmentTable.technicalStatus==1">一类</font>
					       <font ng-show="viewList.equipmentTable.technicalStatus==2">二类</font>
					      <font ng-show="viewList.equipmentTable.technicalStatus==3">三类</font>  </li>
                <li><span>设备名称：</span><font title="{{viewList.equName}}">{{viewList.equNameA}}</font></li>
                <li><span>规格：</span><font title="{{viewList.equipmentTable.specifications}}">{{viewList.equipmentTable.specifications}}</font></li>
                <li><span>生产厂家：</span><font title="{{viewList.equipmentTable.manufacturer}}">{{viewList.equipmentTable.manufacturerA}}</font></li>
                <li><span>品牌：</span><font title="{{viewList.brandName}}">{{viewList.brandNameA}}</font></li>
                <li><span>功率(kw)：</span><font >{{viewList.power}}</font></li>
                <li><span>出厂日期：</span><font >{{viewList.releaseDate | limitTo:10}}</font></li>
                 <div class="clear"></div>
             </ul>
             <div class="clear"></div>
          </div>
              <div class="hiofoe_l">
               <p class="jfoiq"><b>详细说明</b></p>
             <ul class="uiig qichucss">
               <div style="word-wrap: break-word; word-break: normals;">
                   <span id="rePayMsg" style="text-indent:2em"></span>
               </div>
		       <div ng-show="viewList.detailedDescription==null"><span>该信息无详细描述</span></div>
             </ul>
             <div class="clear"></div>
          </div>
    </div>
   
  </div>
   
   <div class="zb_right"> 
    <div class="gao_fe liok ghiuj">
       <div class="ergkite bd_hui" >
           <div class="ergkite_dd bd_hui" ><b>单位基本资料</b></div>
       </div>
       <ul class="news_ppl ihhaleftr" ng-show="hidden==1" >
          <li><span >联系单位：</span><font title="{{viewList.enterpriseName}}">{{viewList.enterpriseNameA}}</font></li>
          <li><span>所在城市： </span><font title="{{AtCity}}">{{AtCityA}}</font></li>
          <li><span>详细地址： </span><font title="{{viewList.contactAddress}}">{{viewList.contactAddressA}}</font></li>
          <li><span>联 系  人： </span><font title="{{viewList.contactPerson}}">{{viewList.contactPerson}}</font></li>
          <div ng-if="!addButton"> 
          		<li ng-show="reveal==1"><span >联系电话： </span><font>{{viewList.contactPhone}}</font></li>
          		<li ng-show="reveal==2" title="点击“我想交易”按钮后，可以看到联系电话"><span >联系电话： </span><font>{{viewList.contactPhone1}}</font></li>
          
          		<li ng-show="reveal==1"><span >QQ： </span><font>{{viewList.qqNo}}</font></li>
          		<li ng-show="reveal==2" title="点击“我想交易”按钮后，可以看到QQ号码"><span >QQ： </span><font>{{viewList.qqNo1}}</font></li>
          </div>
            <div ng-if="addButton"> 
          		<li><span >联系电话： </span><font>{{viewList.contactPhone}}</font></li>
          		<li><span >QQ： </span><font>{{viewList.qqNo}}</font></li>
          </div>
        <div class=" clear"></div>
      </ul>
       <ul class="news_ppl ihhaleftr" ng-show="hidden==2">
          <li><span>联系单位： </span><font>请  <a class="col_chen" ng-click="cookiesJudge(viewList)">登录</a> 查看</font></li>
          <li><span>所在城市： </span><font>请  <a class="col_chen" ng-click="cookiesJudge(viewList)">登录</a> 查看</font></li>
          <li><span>详细地址： </span><font>请  <a class="col_chen" ng-click="cookiesJudge(viewList)">登录</a> 查看</font></li>
          <li><span>联 系  人： </span><font>请  <a class="col_chen" ng-click="cookiesJudge(viewList)">登录</a> 查看</font></li>
          <li><span >联系电话： </span><font>请  <a class="col_chen" ng-click="cookiesJudge(viewList)">登录</a> 查看</font></li>
          <li><span >QQ： </span><font>请  <a class="col_chen" ng-click="cookiesJudge(viewList)">登录</a> 查看</font></li>
        <div class=" clear"></div>
      </ul>
      
      <div class="panel-body" ng-show="reveal==2">
           <input ng-show="addButton==''"  type="button" class="inpt_booom fowp "  ng-click="openViewInfoModel();"  value="我想交易">
           <input ng-show="addButton==true" type="button" disabled="disabled"  class="inpt_booom fowp  inpt_booom1" value="我想交易" />
	   </div>
	   <div class="panel-body" ng-show="reveal==1" ></div>
	   
	   
       <div class=" clear"></div>
    </div>
    <div class="gao_fe liok nedgwg mar_t15">
       <div class="ergkite_ddd bd_hui" ><b>同类产品推荐</b></div>
       <ul class="news_ppl news_pdds"  >
          <li  ng-repeat="r in titleList" title="{{r.infoTitle}}">
          	<a ng-if="infoType==1" href="../Publish/ViewInfo.jsp?id={{r.dataId}}&infoType=1" >· {{r.infoTitleA}}</a>
         	<a ng-if="infoType==2" href="../Publish/ViewInfo.jsp?id={{r.dataId}}&infoType=2" >· {{r.infoTitleA}}</a>
          </li>
          <div class=" clear"></div>
      </ul>
       <div class=" clear"></div>
    </div>
    <div class="gao_fe liok nedgwg mar_t15">
       <div class="ergkite bd_hui" >
          <div class="ergkite_ddd bd_hui" ><b>最近浏览</b></div>
       </div>
       <ul class="news_ppl news_pdds">
          <li><a href="#">· 小松PC360-7挖掘机</a></li>
          <li><a href="#">· 小松PC360-7挖掘机</a></li>
          <li><a href="#">· 小松PC360-7挖掘机</a></li>
          <li><a href="#">· 小松PC360-7挖掘机</a></li>
          <li><a href="#">· 小松PC360-7挖掘机</a></li>
          <li><a href="#">· 小松PC360-7挖掘机</a></li>
          <li><a href="#">· 小松PC360-7挖掘机</a></li>
        <div class=" clear"></div>
      </ul>
       <div class=" clear"></div>
    </div>
  </div>

  <div class="clear"></div>
</div>
  <div class="opwe mar_t30"><a href="#"><img src="../../../media/images/iopj.png" /></a></div>
<jsp:include page="../Include/Bottom.jsp" />
<div ng-include src="'./ViewInfo_Model.jsp'" ></div>
</body>

</html>
