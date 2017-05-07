<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>求租/求购信息</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        .gallery {
            width: 610px;
            margin: 0 auto;
        }

        .gallery img {
            display: block;
        }

        .main-image img {
            padding: 4px;
            width: 560px;
            height: 400px;
            border: 1px solid #ccc;
            background-color: #fff;
        }

        .thumbnails {
            height: 63px;
            margin: 15px 0 0 -15px;
            list-style-type: none;
        }

        .thumbnails li {
            float: left;
            margin-left: 15px;
            display: inline;
        }

        .thumbnails img {
            padding: 4px;
            width: 100px;
            height: 100px;
            border: 1px solid #ccc;
            background-color: #fff;
        }
    </style>
    <jsp:include page="../Include/Head.jsp"/>

    <script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
    <script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
    <script type="text/javascript" src="../../media/js/pagination.js"></script>
    <script type="text/javascript">
        var app = angular.module('viewDemanApp', ['ngResource', 'unifyModule',
            'myPagination']);
        app.controller('viewDemanController', function ($scope, DemandRentSvc, DemandSaleSvc, PicSvc,regionSvc) {
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
                    $scope.paginationConf.currentPage = parm1;
                    $scope.queryviewData();
                }
            };
            /*
             * 查询test数据
             */
            $scope.queryviewData = function () {
                //        + $scope.requestParms.infoType);
                $scope.infoType = $scope.requestParms.infoType;
                if ($scope.requestParms.infoType == 3) {
                	
                    DemandRentSvc.unifydo({parm: $scope.requestParms.id}, qSucc, qErr);
                } 
                else if ($scope.requestParms.infoType == 4) {
                	
                    DemandSaleSvc.unifydo({parm: $scope.requestParms.id}, qSucc, qErr);
                }
                function qSucc(rec){
                	
                	$scope.viewList = rec;
                	//面向城市
                	if(rec.faceCity == 0){
                		$scope.viewList.faceCityName = "全国";
                	}else{
                		
                		
                		
                	}
                	//所在城市
                	if(rec.atCity == 0){
                		$scope.viewList.atCityName = "全国";
                	}else{
                		function aSucc(rec){
                			
        				}
        				function aErr(){}
        				/* regionSvc.queryRegionArea({}, aSucc,aErr); */
        				/* regionSvc.queryRegions({Action:"All"}, aSucc,aErr);//查询所有的行政区域 */
        				regionSvc.queryRegionByRegionId2({id:"1"}, aSucc,aErr);//根据子级行政区域查询父级行政区域
                		
                		
                	}
                   /*  $scope.pic = $scope.viewList.equipmentPic.split(',');
                    $scope.PicList = [];
                    for (var i = 0; i < $scope.pic.length; i++) {
                        var fullname = $scope.pic[i].split('.');
                        $scope.PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};
                        $scope.PicList.push($scope.PicOne);
                        $scope.PicUrl = "http://124.205.89.214:8080/Picture";
                    }
                   $scope.PicSrc=$scope.PicUrl+"/"+$scope.PicList[0].PicName+"/"+$scope.PicList[0].PicType; */
                }
                function qErr(rec) { } 
            };
            /**
            * 点击查询图片
            */
            $scope.num=1;
            $scope.PicChange = function (parm,parm1) {
            	$scope.num=parm1+1;
                $scope.PicSrc=parm;
            };
   
            /*
            * 上一张
            */
            /*{{PicUrl}}/{{PicList[0].PicName}}/{{PicList[0].PicType}}*/
            $scope.prevQuery = function(){
            	$scope.num=$scope.num-1;
            	var len = $scope.PicList.length;
            	if($scope.num <= 0){
            		$scope.PicSrc = $scope.PicUrl+"/"+$scope.PicList[len-1].PicName+"/"+$scope.PicList[len-1].PicType;
            		$scope.changeImgCss(len-1,0);
					$scope.num = len;
					
				}else{
					$scope.PicSrc = $scope.PicUrl+"/"+$scope.PicList[$scope.num-1].PicName+"/"+$scope.PicList[$scope.num-1].PicType;
					$scope.changeImgCss($scope.num-1,$scope.num);
					
				}
            };
            
            /*
             * 下一张
             */
             $scope.NextQuery = function(){
            	
            	$scope.num=$scope.num+1;
             	var len = $scope.PicList.length;
             	if($scope.num > len){
             		$scope.PicSrc = $scope.PicUrl+"/"+$scope.PicList[0].PicName+"/"+$scope.PicList[0].PicType;
             		$scope.changeImgCss(0);
 					$scope.num = 1;
 					
 				}else{
 					$scope.PicSrc = $scope.PicUrl+"/"+$scope.PicList[$scope.num-1].PicName+"/"+$scope.PicList[$scope.num-1].PicType;
 					$scope.changeImgCss($scope.num-1);
 					
 				}
             	
             };
            /* $('#myCarousel').carousel({interval: 5000}); */
            
            
           /*  var num=0;
            $scope.testA=function(){
            	num++;
            	if(num>3){
            		num=0;
            	}
            };
            
            $scope.testB=function(){
            	num--;
            	if(num<0){
            		num=3;
            	}
            };
             */
            
             $scope.changeImgCss=function(addCssIndex,delCssIndex){
                 $("#imgId"+addCssIndex).css("border-color","red"); 
                 $("#imgId"+delCssIndex).css("border-color","green"); 
             };

        });
        
        
        
    </script>
    <style>
        th {
            text-align: right
        }
    </style>
</head>

<body ng-app="viewDemanApp" ng-controller="viewDemanController" ng-init="queryviewData()">
<!-- <ol class="breadcrumb">
    <li style="font-size: 13px">您的位置：首页</li>
    <li style="font-size: 13px">信息浏览</li>
    <li style="font-size: 13px">{{viewList.infoTitle}}</li>
</ol> -->
<ol class="breadcrumb" >
    <li style="font-size: 13px">
    	<span target="_bank" style="font-weight: 900;font-size: 16px;">您的位置：</span>
    	<a target="_bank" href="../Main/HomePage.jsp?" style="font-weight: 900;font-size: 16px;">首页</a>
    </li>
    <li style="font-size: 13px"><a target="_bank" href="../Main/HomePage.jsp?" style="font-weight: 900;font-size: 16px;">最新求租/购</a></li>
    <li style="font-size: 13px"><span target="_bank" style="font-weight: 900;font-size: 16px;">{{viewList.infoTitle}}</span></li>
</ol>
<!-- Start Content -->
<div class="container">
    <div class="row">
        <div class="col-md-9">
            <div>
                <div class="row">
                   <!--  <div class="col-md-8">
                        <div class="gallery">
                             <div class="main-image">
                                <img id="mainImg" ng-src="{{PicUrl}}/{{PicList[0].PicName}}/{{PicList[0].PicType}}" alt="Placeholder" class="custom">
                            </div>

                            <ul class="thumbnails">
                                <li ng-repeat="t in PicList">
                                	<a  href="" ng-click="PicChange(PicUrl+'/'+t.PicName+'/'+t.PicType);">
                                    	<img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}" alt="">
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div> -->
                   
					
					<div class="col-md-8">
                        <div class="gallery">
                             <div class="main-image">
                                <img id="mainImg" ng-src="{{PicSrc}}" alt="Placeholder" class="custom">
                           		<!-- 轮播（Carousel）导航 -->
							   <a style="margin-left:15px;width: 60px;height: 400px;" class="carousel-control left" ng-click="prevQuery();" >&nbsp;</a>
							   <a style="margin-right:10px;width: 60px;height: 400px;" class="carousel-control right" ng-click="NextQuery();">&nbsp;</a>
                            </div>
                    		<ul class="thumbnails">
                                <li ng-repeat="t in PicList">
                                	<a  href="" ng-click="PicChange(PicUrl+'/'+t.PicName+'/'+t.PicType,$index);" >
                                    	<img Id="imgId{{$index}}"  style="border:2px solid green; " ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}"  alt="" >
                                    </a>
                                </li>
                            </ul>
                        </div>
                        
                    </div>
                    <!-- <div class="col-md-8">
                    	<div class="gallery">
                    		<ul class="thumbnails">
                                <li ng-repeat="t in PicList">
                                	<a  href="" ng-click="PicChange(PicUrl+'/'+t.PicName+'/'+t.PicType);">
                                    	<img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}"  alt="" data-target="#myCarousel" data-slide-to="{{$index}}">
                                    </a>
                                </li>
                            </ul>
                    	</div>
                    </div> -->
                    
                    <div class="col-md-4" style="">
                        <div class="panel panel-default" style="height:400px;">
                            <!-- 如果Infotype=3，显示求租，如果为4，显示求购 -->
                            <div class="panel-heading" ng-show="requestParms.infoType=='3'" style="font-weight:bolder;font-size:18px;" title="{{viewList.infoTitle}}">【求租】{{viewList.infoTitle}}
                            </div>
                            <div class="panel-heading" ng-show="requestParms.infoType=='4'" style="font-weight:bolder;font-size:18px;" title="{{viewList.infoTitle}}">【求购】{{viewList.infoTitle}}
                            </div>
                            <div class="panel-body">面向城市：{{viewList.faceCityName}}</div>
                            <div class="panel-body">期望金额：{{viewList.expectedAmount}} 元/台</div>
                            <div class="panel-body">期望押金：{{viewList.expectedDeposit}} 元</div>
                            <div class="panel-body">数量：{{viewList.quantity}}</div>
                            <div class="panel-body">设备状态：未成交【{{viewList.dataState.note}}】
                            </div>
                            <div class="panel-body"><a href="Infopub.jsp?infoType=1" ng-show="requestParms.infoType=='3'" role="button" class="btn btn-danger btn-lg">我要出租</a></div>
                            <div class="panel-body"><a href="Infopub.jsp?infoType=2"  ng-show="requestParms.infoType=='4'" role="button" class="btn btn-danger btn-lg">我要出售</a></div>
                        </div>
                    </div>
                </div>
                <br>

                <div class="row" >
                    <div class="col-md-12" style="margin-top: 100px">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="font-weight:bolder;font-size:18px;">详细说明</div>
                            <div align="center" style="padding: 25px;height:320px">
                                {{viewList.detailedDescription}}<span
                                    ng-show="viewList.detailedDescription==null">该信息无详细描述</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 边框开始 -->
        <div class="sidebar right-sidebar col-md-3">
            <div class="widget sidebar-widget widget-agents">
                <div class="panel panel-primary">
                    <div class="panel-heading" style="font-weight:bolder;font-size:18px;">企业基本资料</div>
                    <div class="panel-body">企业名称：{{viewList.enterpriseName}}</div>
                    <div class="panel-body">所在城市：{{viewList.atCityName}}</div>
                    <div class="panel-body">联系人：{{viewList.contactPerson}}</div>
                    <div class="panel-body">联系手机：{{viewList.contactPhone}}</div>
                    <div class="panel-body">QQ：{{viewList.qqNo}}</div>
                    <div class="panel-body">电子邮箱：{{viewList.electronicMail}}</div>
                    <div class="panel-body">固定电话：{{viewList.fixedTelephone}}</div>
                    <div class="panel-body">联系地址：{{viewList.contactAddress}}</div>
                </div>
            </div>
            <div class="widget sidebar-widget widget-properties">
                <div class="panel panel-primary">
                    <div class="panel-heading" style="font-weight:bolder;font-size:18px;">同类产品推荐</div>
                    <div class="panel-body">
                        <li>相关设备1</li>
                    </div>
                    <div class="panel-body">
                        <li>相关设备2</li>
                    </div>
                    <div class="panel-body">
                        <li>相关设备3</li>
                    </div>
                    <div class="panel-body">
                        <li>相关设备4</li>
                    </div>
                    <div class="panel-body">
                        <li>相关设备5</li>
                    </div>

                </div>
            </div>
            <div class="widget sidebar-widget widget-properties">
                <div class="panel panel-primary">
                    <div class="panel-heading" style="font-weight:bolder;font-size:18px;">最近浏览</div>
                    <div class="panel-body">
                        <table width="100%">
                            <td align="left">
                                <li>用户名1</li>
                            </td>
                            <td> 07/12</td>
                        </table>
                    </div>
                    <div class="panel-body">
                        <table width="100%">
                            <td align="left">
                                <li>用户名2</li>
                            </td>
                            <td> 07/12</td>
                        </table>
                    </div>
                    <div class="panel-body">
                        <table width="100%">
                            <td align="left">
                                <li>用户名3</li>
                            </td>
                            <td> 07/12</td>
                        </table>
                    </div>
                    <div class="panel-body">
                        <table width="100%">
                            <td align="left">
                                <li>用户名4</li>
                            </td>
                            <td> 07/12</td>
                        </table>
                    </div>
                    <div class="panel-body">
                        <table width="100%">
                            <td align="left">
                                <li>用户名5</li>
                            </td>
                            <td> 07/12</td>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../../media/js/jquery-1.8.3.min.js"></script>
<script src="../../media/js/jquery.simpleGal.js"></script>
<script>
    $(document).ready(function () {
        $('.thumbnails').simpleGal({
            mainImage: '.custom'
        });
    });
</script>

</body>
</html>