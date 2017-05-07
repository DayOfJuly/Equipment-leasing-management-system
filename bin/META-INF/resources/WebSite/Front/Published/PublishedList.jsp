<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>已发布信息</title>
<jsp:include page="../Include/Head.jsp" />
<link href="/WebFront/media/css/heightLight.css" rel="stylesheet">
<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<script type="text/javascript">
var app = angular.module('PublishedApp', ['ngResource','unifyModule','myPagination']);
app.controller('PublishedController', function($scope,published,rentSvc,SaleSvc,DemandRentSvc,DemandSaleSvc,equipment,regionSvc,PicUrl) 
	
	$scope.formParms={};
	$scope.PicUrl_Copy = PicUrl;
	/*
	 *分页标签参数配置
	*/
	$scope.paginationConf = {
        currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        pageRecord:10,/*每页显示多少*/
        pageNum:10,/*分页标签数量显示*/
        /*
         * parm1:当前选择页数
         * parm2:每页显示多少
        */
        queryList:function(parm1,parm2){
        	$scope.paginationConf.currentPage=parm1;
        	$scope.queryPublishedData();
        }
    };
	
	/*
	 * 查询
	*/
	$scope.queryData={};
	$scope.queryPublishedData=function(pageNo)
	{
		if(pageNo)
		{
			$scope.paginationConf.currentPage=1;
		} 
		function success(rec)
		{ 
			
			if(rec.content==""||rec.content==null){
				$.messager.popup("没有符合条件的记录！");
			}
			$scope.publishedList=rec.content;
			$scope.paginationConf.totalItems=rec.totalElements;
		}
		function error(rec){}
		
		$scope.queryData.Action="All";
		$scope.queryData.pageNo=$scope.paginationConf.currentPage-1;
		$scope.queryData.pageSize=$scope.paginationConf.pageRecord;
		
		
		published.unifydo($scope.queryData,success,error);
	};
	
	
	/*
	 * 弹出添加页面模态框
	*/
	$scope.openAddModal=function(){
		$scope.formParms={};
		$scope.judge="add";
		$scope.titleMsg="分类添加";
		$('#categoryModalId').modal({backdrop: 'static', keyboard: false});
	};
	
	/*
	 * 添加
	*/
	$scope.add=function(){
		category.put({data:$scope.formParms},aSucc,aErr);
		function aSucc(rec){
			$('#testModalId').modal('hide');
			$.messager.popup(rec.msg);
		}
		function aErr(rec){
			
		}
	};
	
	 /*
     * 地址查询--面向城市
     */
     $scope.temporary={};
     $scope.requesRegionFace = function(parm){
	     	function qSucc(rec){
 			$scope.FaceDisName=rec.name;
 			$scope.FaceCitName=rec.parentName;
 			$scope.temporary=rec;
 			$scope.queryCities($scope.temporary);
			}
			function qErr(){}
			regionSvc.queryRegionByRegionId2({id:parm},qSucc,qErr);
     };
     
     $scope.queryCities = function(){
   	    function qSucc(rec){
  			$scope.FaceProName=rec.parentName;
		    $scope.formParms.FaceRegionName=$scope.FaceProName+'-'+$scope.FaceCitName+'-'+$scope.FaceDisName;
 		}
	    function qErr(){}
	    regionSvc.queryRegionByRegionId2({id:$scope.temporary.parentRegionId},qSucc,qErr);
    }; 
    
    
    
    /*
     * 地址查询--面向城市
     */
     $scope.atTemporary={};
     $scope.rentCity = function(parm){
	     	function qSucc(rec){
 			$scope.atDisName=rec.name;
 			$scope.atCitName=rec.parentName;
 			$scope.atTemporary=rec;
 			$scope.queryAtCities($scope.atTemporary);
			}
			function qErr(){}
			regionSvc.queryRegionByRegionId2({id:parm},qSucc,qErr);
     };
     
     $scope.queryAtCities = function(){
   	    function qSucc(rec){
  			$scope.atProName=rec.parentName;
		    $scope.formParms.atRegionName=$scope.atProName+'-'+$scope.atCitName+'-'+$scope.atDisName;
 		}
	    function qErr(){}
	    regionSvc.queryRegionByRegionId2({id:$scope.atTemporary.parentRegionId},qSucc,qErr);
    }; 
    
    
     
	
	/*
	 * 弹出修改页面模态框
	*/
	$scope.openUpdModal=function(obj){
		$scope.formParms=obj;
		$scope.formParms.infoType=obj.bizType;
		$scope.titleMsg="已发布信息修改";
 		if($scope.formParms.infoType=='1'){
 			rentSvc.unifydo({parm:$scope.formParms.dataId},
				qSucc=function(rec){
					$scope.formParms=rec;
					if(rec.atCity){
						$scope.rentCity(rec.atCity);
					}
					$scope.resolvePicture();
				},
				qErr=function(rec){}
				
			);
 		}else if($scope.formParms.infoType=='2'){
 			SaleSvc.unifydo({parm:$scope.formParms.dataId},
				qSucc=function(rec){
					$scope.formParms=rec;
					if(rec.atCity){
						$scope.rentCity(rec.atCity);
					}
					$scope.resolvePicture();
				},
				qErr=function(rec){}
				
			);
 		}else if($scope.formParms.infoType=='3'){
 			
 			DemandRentSvc.unifydo({parm:$scope.formParms.dataId},
				qSucc=function(rec){
					$scope.formParms=rec;
						if(rec.faceCity==0){
							$scope.formParms.FaceRegionName="全国";
						}else{
							$scope.requesRegionFace(rec.faceCity);
						}
						if(rec.atCity){
							$scope.rentCity(rec.atCity);
						}
					$scope.resolvePicture();
				},
				qErr=function(rec){}
				
			);
 		}else if($scope.formParms.infoType=='4'){
 			
 			DemandSaleSvc.unifydo({parm:$scope.formParms.dataId},
				qSucc=function(rec){
					$scope.formParms=rec;
						if(rec.faceCity==0){
							$scope.formParms.FaceRegionName="全国";
						}else{
							$scope.requesRegionFace(rec.faceCity);
						}
						if(rec.atCity){
							$scope.rentCity(rec.atCity);
						}
					$scope.resolvePicture();
				},
				qErr=function(rec){}
				
			);
		}
		$('#publishedModalId').modal({backdrop: 'static', keyboard: false});
	};
	
	$scope.resolvePicture=function(){
		$scope.formParms.equipmentPicList=[];
		if($scope.formParms.equipmentPic!=null){
			var picList=$scope.formParms.equipmentPic.split(",");
			for(var i=0,m=picList.length;i<m;i++){
				var picName=picList[i].split(".");
				$scope.formParms.equipmentPicList.push({"pic":picName[0],"suffix":picName[1]});
			}
		}
	};
	
	/*
	 * 修改
	*/
	$scope.upd=function(){
		
		function aSucc(rec){
			$('#publishedModalId').modal('hide');
			$.messager.popup(rec.msg);
		}
		function aErr(rec){}
		
		/* var id = $scope.formParms.equipmentTable.equipmentId; */
		var id = "1";
		equipment.post({Action:"EquipmentState",parm:id},$scope.formParms,aSucc,aErr);

	};
	
	/*
	 * 删除
	*/
	$scope.del=function(obj){
		$.messager.confirm("提示", "是否删除？", function() { 
			var id = obj.id;
			category.del({parm:id},dSucc,dErr);
			function dSucc(rec){
				$.messager.popup(rec.msg);
			}
			function dErr(rec){
				
			}
	    });
	};
});
</script>
<style>
.container {width: 1500px !important;}

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}
</style>
</head>

<body ng-app="PublishedApp" ng-controller="PublishedController" class="container">
	<div ng-include src="'../../WebSite/Include/TopMenu.jsp'" ></div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">已发布信息</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;">
			<ul>
				<div class="form-group">
					<label contenteditable="false" class="col-xs-1 control-label" style="margin-left:-5px;">信息类型：</label>
					<div class="col-xs-1">
						<select class="form-control select-hover" ng-model="queryData.infoType" onmouseover="size=5;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:2">
							<option value="">全部</option>
							<option value="1">出租</option>
							<option value="2">出售</option>
							<option value="3">求租</option>
							<option value="4">求购</option>
						</select>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">信息标题：</label>
					<div class="col-xs-2">
						<input type="text" class="form-control" ng-model="queryData.infoTitle">
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">状态：</label>
					<div class="col-xs-1">
						<select class="form-control select-hover" ng-model="queryData.dataState" onmouseover="size=7;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:2">
							<option value="">全部</option>
							<option value="1">使用中</option>
							<option value="2">可出租</option>
							<option value="3">可出售</option>
							<option value="4">可租售</option>
							<option value="5">已出售</option>
							<option value="6">已报废</option>
						</select>
					</div>
					<label class="col-xs-1"></label>
					<div class="col-xs-1">
						<input type="button" class="btn btn-primary" value="查询" contenteditable="true" ng-click="queryPublishedData(1);"/>
					</div>
				</div>
			</ul>
		</div>
		<div>
			<table class="table table-striped table-hover" style="margin-left: 50px;">
				<thead>
					<tr class="success">
						<th class="text-center">序号</th>
						<th class="text-center">信息类型</th>
						<th class="text-center">信息标题</th>
						<th class="text-center">联系人</th>
						<th class="text-center">联系电话</th>
						<th class="text-center">发布日期</th>
						<th class="text-center">状态</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="t in publishedList">
						<td class="text-center">{{$index+1+(paginationConf.currentPage-1)*paginationConf.pageRecord}}</td>
						<td class="text-center">{{t.bizName}}</td>
						<td class="text-center">{{t.infoTitle}}</td>
						<td class="text-center">{{t.contactPerson}}</td>
						<td class="text-center">{{t.contactPhone}}</td>
						<td class="text-center">{{t.releaseDate}}</td>
						<td class="text-center">{{t.note}}</td>
						<td class="text-center">
							<input type="button" class="btn btn-link" value="修改" ng-click="openUpdModal(t);" style="margin-top: -6px;" > 
						</td>
					</tr>
				</tbody>
			</table>
			<div style="text-align:right;">
				<pagination-tag conf="paginationConf"></pagination-tag>
			</div>
		</div>
		<div ng-include src="'/WebFront/WebSite/Published/PublishedModify.jsp'" ></div>
	</form>
</body>
</html>
