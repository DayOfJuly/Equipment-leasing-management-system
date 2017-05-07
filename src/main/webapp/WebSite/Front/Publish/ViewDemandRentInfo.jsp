<%@ page  contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
 <title>求租信息</title>
 	<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="../../Front/Include/Head.jsp"/>
    <jsp:include page="../../Front/conmmon/publicSession.jsp" />
    <script type="text/javascript" src="../../../js/JsSvc/unifySvc.js"></script>
    <script type="text/javascript" src="../../../js/JsSvc/Config.js"></script>
    <script type="text/javascript" src="../../../media/js/pagination.js"></script>
	<SCRIPT src="../../../media/js/163css.js" type=text/javascript></SCRIPT>
    <script type="text/javascript" src="../../../js/JsSvc/SysCodeConfig.js"></script>
    <script type="text/javascript" src="../../../js/JsSvc/SysCodeTranslate.js"></script>
	<link href="../../../media/css/ihha.css" rel="stylesheet" type="text/css" />
	<link href="../../../media/css/css.css" type="text/css" rel="stylesheet"/>	
	<script src="../../../media/js/lrtk.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript" src="../../../media/js/ss.js"></script><!--左右GUNDONG-->
	

	 <script type="text/javascript">
        var app = angular.module('viewDemanApp', ['ngResource', 'unifyModule', 'ngMessages', 'myPagination','sysCodeConfigModule','sysCodeTranslateModule']);
        app.controller('viewDemanController', function ($scope, $timeout ,$interval,personSvc, DemandRentSvc,IssuSvc, DemandSaleSvc, PicSvc, regionSvc,published,PicUrl,busDealInfo,SYS_CODE_CON,sysCodeTranslateFactory) {
        	
            var viewinfo="newDemandRent";
        	
            $scope.sysCodeCon=SYS_CODE_CON;//把常量赋值给一个对象这样可以使用了
    	    
       	 $scope.ct=sysCodeTranslateFactory;//把翻译赋值给一个对象
       	 
        	var url = location.search;
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {
                var str = url.substr(1);
                strs = str.split("&");
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
                }
            }
            $scope.requestParms = theRequest;
            
             $scope.userInfo = {};
			 $scope.userInfo.orgCode=SYS_USER_INFO.code;
			 $scope.userInfo.orgId=SYS_USER_INFO.orgId;
			 $scope.userInfo.orgName =  SYS_USER_INFO.orgName;
			 $scope.userInfo.orgParentCode = SYS_USER_INFO.orgParentCode;
			 $scope.userInfo.loginUserId = SYS_USER_INFO.loginUserId;
			 $scope.userInfo.orgLevel =  SYS_USER_INFO.orgLevel;
			 $scope.userInfo.partyId = SYS_USER_INFO.partyId
	         if( $scope.userInfo){
	         	$scope.userCookies =  $scope.userInfo;
	         }else{
	         	$scope.userCookies = "";
	         }
	       
	         var hidden;
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
                   // $scope.paginationConf.currentPage = parm1;
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
                $scope.infoType = $scope.requestParms.infoType;
                	
                function qSucc(rec){
                	  $scope.addCount();
                      $scope.MyButton();
                	//标题长度设定为7
                	$scope.viewList = rec.issueInfo;
                	if($scope.viewList.useProvince == ""){
                		$scope.useAdd = 1;
                	}
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
                 	if(rec.issueInfo.infoTitle){
                 		if(rec.issueInfo.infoTitle.length > 20){
                    		$scope.viewList.infoTitleB = rec.issueInfo.infoTitle.substring(0,30)+"...";
                    	}else{
                    		$scope.viewList.infoTitleB = rec.issueInfo.infoTitle;
                    	}
                 	}
                	
                	if(rec.issueInfo.depName){
                		if(rec.issueInfo.depName.length > 10){
                    		$scope.viewList.depNameA = rec.issueInfo.depName.substring(0,10)+"...";
                    	}else{
                    		$scope.viewList.depNameA = rec.issueInfo.depName;
                    	}
                	}
                	
                	$("#rePayMsg").get(0).innerHTML = $scope.viewList.detailedDescription;
                     $scope.viewList.contactPhone1=$scope.changeValueFun($scope.viewList.contactPhone);
                     $scope.viewList.qqNo1=$scope.changeValueFun($scope.viewList.qqNo);
                     
                     $scope.viewList.viewCount = rec.issueInfo.viewCount; //浏览次数 
                     if($scope.viewList.viewCount==null){
                   	  $scope.viewList.viewCount=1;
                     }
                     $scope.dealCount = rec.dealCount; //意向承租人数
                     $scope.depName = rec.depName;//最终承租人
                     $scope.equState = rec.equState; //设备状态
                     
                     if($scope.viewList.address){
                    	 if($scope.viewList.address.length>25){
	                    	 $scope.viewList.addressA = rec.issueInfo.address.substring(0,20)+"...";
	                 	}else{
	                 		$scope.viewList.addressA = rec.issueInfo.address;
	                 	}
                     }
                	if($scope.viewList.equName){
                 		if($scope.viewList.equName.length > 25){
                    		$scope.viewList.equNameA = $scope.viewList.equName.substring(0,25)+"...";
                    	}else{
                    		$scope.viewList.equNameA = $scope.viewList.equName;
                    	}
                 	}
                	 if($scope.viewList.brandName){
                 		if($scope.viewList.brandName.length > 25){
                    		$scope.viewList.brandNameA = $scope.viewList.brandName.substring(0,25)+"...";
                    	}else{
                    		$scope.viewList.brandNameA = $scope.viewList.brandName;
                    	}
                 	}  
                	 if($scope.viewList.modelName){
                  		if($scope.viewList.modelName.length > 25){
                     		$scope.viewList.modelNameA = $scope.viewList.modelName.substring(0,25)+"...";
                     	}else{
                     		$scope.viewList.modelNameA = $scope.viewList.modelName;
                     	}
                  	}  
                	 if($scope.viewList.standardName){
                  		if($scope.viewList.standardName.length > 25){
                     		$scope.viewList.standardNameA = $scope.viewList.standardName.substring(0,25)+"...";
                     	}else{
                     		$scope.viewList.standardNameA = $scope.viewList.standardName;
                     	}
                  	}  
                     
                     $scope.viewList.atCity = rec.issueInfo.atCity;
                 	//所在城市
                  	if(rec.issueInfo.atCity == null ){
                  		$scope.viewList.atCity = "全国";
                  	}
                  	if(rec.issueInfo.priceType==null){
                     	$scope.viewList.priceType=1;
                    }
                  	//设备的使用城市
                  	$scope.useCity =  $scope.viewList.useProvince+""+$scope.viewList.useCity+""+$scope.viewList.useDistrict
                  	
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
                 }
                function qErr(rec) { }
                
                published.unifydo({Action:"DemandRent"},{parm: $scope.requestParms.id}, qSucc, qErr);
            };
            
          //同类产品推荐
            $scope.titleList=[];
            $scope.querySimilar = function(){
            	
            	 if ($scope.requestParms.infoType == 3) {
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
	                    	 IssuSvc.post({Action:"DemandRent"},{dataType:3,equName:$scope.equName,pageNo:0,pageSize:10},qSucc,qErr);
	            	 }
	            	 function qEr(rec) {};
	            	published.unifydo({Action:"DemandRent"},{parm: $scope.requestParms.id},qSuc,qEr);
	            	
            	 	
            	 }
            };
            $scope.querySimilar();
            
            
            
            
            
            /* 浏览次数 */
            $scope.addCount = function()
            {
            	 function success(rec) {}
                 function error(rec) {}
                 published.addViewCount({urlPath:$scope.requestParms.id},success,error);
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
                $scope.formParms = {};
                //打开我想交易Model
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

            	 /*
                 *我想要交易事件
                 */
                 $scope.busDealInfoBean = {};
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
 	               			$('#viewInfoModel').modal('hide');
 	               			function qSucc(rec){
 	               				$scope.dealCount = rec.dealCount; //意向承租人数
 		                 	}
 		                 	function qErr(){}
 		                 	
 		                      	published.unifydo({Action:"DemandRent"},{ parm: $scope.requestParms.id}, qSucc, qErr);
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
                            if($scope.msg=="TRUE"){
                            		$scope.addButton = 'true';
                            }else{
                            	$scope.addButton = '';
                            	} 
                   		}
                   	function qErr(){}
                   	published.unifydo({Action:"BusDealInfo",dataId:$scope.newDataId, loginUserId:$scope.userCookies.loginUserId},qSucc,qErr);
                };  
        });
    </script>
    <style>
        th {
            text-align: right
        }
    </style>
</head>

<body ng-app="viewDemanApp" ng-controller="viewDemanController" ng-init="queryviewData()" >
<jsp:include page="../../../WebSite/Front/Main/Top.jsp" />

<div class="main">
   <div class="position">&nbsp; 您的位置 :首页  &nbsp; <span>></span> &nbsp;
   <span><a  href="../Main/HomePage.jsp?">最新求租</a></span>
      &nbsp; <span>></span><span title="{{viewList.infoTitle}}">&nbsp;{{viewList.infoTitleB}}</span> &nbsp;</div>
   
  <div class="bdi_left">
         <div class="beft_top_rightr" style="margin-left:50px">
           <div id="ViewInfo_Div1"  title="{{viewList.infoTitle}}" style="font-size:16px;color:#000"><b>【求租】{{viewList.infoTitleB}}</b></div>
           <p ng-show="!useAdd">设备使用地点： {{viewList.useCity}}</p>
           <p ng-show="useAdd==1">设备使用地点： 全国</p>
           <p >详细地址：<span class="txt14" style="color: black;" title="{{viewList.address}}">{{viewList.addressA}}</span></p>
		   <p>租金单价：{{ct.formatCurrency(viewList.price)}}元/{{ct.codeTranslate(viewList.tenancyType,"UNIT_LEASETIME")}}</p>

	       <p >数量：   <span class="col_chen txt14">{{viewList.quantity}}{{ct.codeTranslate(viewList.second,"UNIT_NAME")}}</span> </p> 
            <p >最后更新：{{viewList.updateTime}}</p>
			<p>浏览次数：{{viewList.viewCount}}</p>
			<p>意向承租人：<span class="col_chen txt14">{{dealCount}}<span ng-show="dealCount==''" class="col_chen txt14">0</span>人</span></p>
	       </div>
           <div class="clear"></div>
              <div class="hiofoe_k">
               <p class="jfoiq"><b>设备信息</b></p>
               
             <table style="width:98%;margin-left:10px;margin-top:10px">
             	<tr style="height:30px;">
             		<td style="width: 10%;border:1px solid #CCC; text-align:right">设备名称：</td>
             		<th style="width: 40%;border:1px solid #CCC; text-align:center "  title="{{viewList.equName}}">{{viewList.equNameA}}</th>
             		<td style="width: 10%;border:1px solid #CCC; text-align:right">品牌：</td>
             		<th style="width: 40%;border:1px solid #CCC; text-align:center" title="{{viewList.brandName}}">{{viewList.brandNameA}}</th>
             	</tr>
             	<tr style="height:30px;">
             		<td style="width: 10%;border:1px solid #CCC; text-align:right">规格：</td>
             		<th style="width: 40%;border:1px solid #CCC; text-align:center" title="{{viewList.standardName}}">{{viewList.standardNameA}}</th>
             		<td style="width: 10%;border:1px solid #CCC; text-align:right">型号：</td>
             		<th style="width: 40%;border:1px solid #CCC; text-align:center" title="{{viewList.modelName}}">{{viewList.modelNameA}}</th>
             	</tr>
             </table>
             <div class="clear" style="height: 10px"></div>
          </div>
            <div class="hiofoe_l" style="word-break: break-all;">
               <p class="jfoiq"><b>详细说明</b></p>
             <ul class="uiig qichucss">
             	<span style=" word-break: normals;"><span id="rePayMsg" style="text-indent:2em"></span></span>
		       <div ng-show="viewList.detailedDescription==null"><span>该信息无详细描述</span></div>
             </ul>
             <div class="clear"></div>
          </div>
  </div>
   <div class="zb_right"> 
    <div class="gao_fe liok ghiuj">
       <div class="ergkite bd_hui" >
           <div class="ergkite_dd bd_hui" ><b>单位基本资料</b></div>
       </div>
       
      <ul class="news_ppl ihhaleftr"  >
         <li><span >联系单位：</span><font title="{{viewList.enterpriseName}}">{{viewList.enterpriseNameA}}</font></li>
          <li><span>所在城市： </span><font title="{{AtCity}}">{{AtCityA}}</font></li>
          <li><span>详细地址： </span><font title="{{viewList.contactAddress}}">{{viewList.contactAddressA}}</font></li>
          <li><span>联 系  人： </span><font>{{viewList.contactPerson}}</font></li>
          <div ng-if="!addButton"> 
          		<li ng-show="reveal==1"><span >联系电话： </span><font>{{viewList.contactPhone}}</font></li>
          		<li ng-show="reveal==2" title="点击“我想交易”按钮后，可以看到联系电话"><span>联系电话： </span><font>{{viewList.contactPhone1}}</font></li>
          
          		<li ng-show="reveal==1"><span >QQ： </span><font>{{viewList.qqNo}}</font></li>
          		<li ng-show="reveal==2" title="点击“我想交易”按钮后，可以看到QQ号码"><span >QQ： </span><font>{{viewList.qqNo1}}</font></li>
          </div>
            <div ng-if="addButton"> 
          		<li><span >联系电话： </span><font>{{viewList.contactPhone}}</font></li>
          		<li><span >QQ： </span><font>{{viewList.qqNo}}</font></li>
          </div>
        <div class=" clear"></div>
      </ul>
    <div class="panel-body" ng-show="reveal==2">
	                    	<input ng-show="addButton==''"  type="button" class="inpt_booom fowp "  ng-click="openViewInfoModel();"  value="我想交易">
	                    	<input ng-show="addButton" disabled="disabled" type="button" class="inpt_booom fowp inpt_booom1" value="我想交易" />
	</div>
	   <div ng-show="reveal==1" ></div>
       <div class=" clear"></div>
    </div>
    <div class="gao_fe liok nedgwg mar_t15">
       <div class="ergkite_ddd bd_hui" ><b>同类产品推荐</b></div>
       <ul class="news_ppl news_pdds">
            <li  ng-repeat="r in titleList" title="{{r.infoTitle}}">
          	<a href="../Publish/ViewDemandRentInfo.jsp?id={{r.dataId}}&infoType=3" >· {{r.infoTitleA}}</a>
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
	<jsp:include page="../../Front/Include/Bottom.jsp" />
</body>
<div ng-include src="'./ViewInfo_Model.jsp'" ></div>
</html>
