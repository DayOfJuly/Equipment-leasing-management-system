<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>部门设置</title>
<jsp:include page="../Include/Head.jsp" />
<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<script type="text/javascript">
var app = angular.module('departmentApp',['ngResource','unifyModule','myPagination', 'ngMessages']);


app.controller('departmentController',function($scope,entSvc){
	
	//假设当前登录的用户所在的企业ID是5
	if($scope.userCookies!=null||$scope.userCookies!=""){
		$scope.user={currOrgId:$scope.userCookies.orgId,orgName:$scope.userCookies.orgName};
	}
	
	//分页
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
        	$scope.paginationConf.currentPage = parm1;
        	if($scope.fuzzyData){	//如果点击搜索，就查询searchEntityList()
        		$scope.searchEntityList();
        	}else{
        		if($scope.searchName != null && $scope.searchName != ''){
	        		$scope.searchEntityList($scope.chooseParPartyId,$scope.chooseParName);
	        	}else{
	        		$scope.queryEntitylist($scope.chooseParPartyId,$scope.chooseParName);
	        	}
        	}
        	
        	//当页面跳转时，清空已经点击的单选项
        	$scope.radioTrIndex=null;
        	if($scope.radioTrIndex==null){
        		$scope.choosePartyId=null;
        	}
        }
	};
	
	
	/*
	*查询部门列表
	*/
	$scope.queryEntList = function(flag,varl,parm){
		if(parm){
			$scope.paginationConf.currentPage=1;
		}
		if(flag){
			entSvc.queryPartyInstallList({
				parTypeId:5,
				currOrgId:Number(flag)
			},
			function(rec){
				$scope.departEntity.parentOrgId = flag;
				$scope.departEntity.parentOrgName = varl;
				if(rec.content){
					if(rec.content.length <= 0){
						$.messager.popup("没有下级部门");
						$scope.parentOrgList = {};
						return;
					}else if(rec.content.length > 0){
						$scope.parentOrg = Number(flag);
						$scope.parentOrgList = rec.content;
					}
				}
				$scope.paginationConf.totalItems = rec.totalElements;
			},function(){
				$.messager.popup("获取上级部门列表失败");
			});
		}else{
			entSvc.queryPartyInstallList({
				parTypeId:5,
				currOrgId:$scope.userCookies.orgId,
				pageNo:$scope.paginationConf.currentPage-1,
				pageSize:$scope.paginationConf.pageRecord}, 
				function(rec){
				$scope.entityList = rec.content;
				$scope.paginationConf.totalItems = rec.totalElements;
			},function(){
				$.messager.popup("获取部门列表失败");
			});
		}
	};
	
	
	/*
	 *点选组织机构面包屑
	*/
	$scope.selectTitle=function(parm1,parm2){
		$scope.queryEntitylist(parm1,parm2);
		changeTitle(parm1);
	};
	
	
	/*
	 *动态切换组织机构面包屑
	*/
	function changeTitle(parm){
		for(var i=0;i<$scope.parOrgList.length;i++){
			var id = $scope.parOrgList[i].id;
			if(id==parm){
				$scope.parOrgList.splice(i,$scope.parOrgList.length-i-1);
				break;
			}
		}
	}
	
	
	/*
	 *查询部门列表循环
	*/
	$scope.ParOrgListA=[];
	$scope.queryEntitylist = function(parm1,parm2){
		if(parm1){
			$scope.parOrgId=parm1;
			$scope.parOrgName=parm2;
			$scope.parOrgList.push({id:parm1,name:parm2});
		}else{
			$scope.parOrgId=$scope.user.currOrgId;
			$scope.parOrgName=$scope.user.orgName;
			$scope.parOrgList=[{id:$scope.user.currOrgId,name:$scope.user.orgName}];
		}
		changeTitle(parm1);
		function qSucc(rec){
			if(rec.content){
				if(rec.content.length == 0){
					$scope.parOrgList.splice($scope.parOrgList.length-1);
					$.messager.popup("无相关数据");
					$scope.qshow=false;
	    			$scope.ashow=false;
	    			$scope.ushow=false;
	    			$scope.dshow=false;
					return;
				}else{
					$scope.qshow=true;
	    			$scope.ashow=true;
	    			$scope.ushow=true;
	    			$scope.dshow=true;
				}
			}
			$scope.entityList = rec.content;
			$scope.chooseParPartyId=$scope.parOrgId;/*获取当前所有机构的上级机构Id*/
			$scope.chooseParName=$scope.parOrgName;/*获取当前所有机构的上级机构Name*/
			$scope.paginationConf.totalItems = rec.totalElements;
		}
		function qErr(){
			$.messager.popup("获取部门列表失败");
		}
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:$scope.parOrgId,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.pageRecord
		},qSucc,qErr);
		
	};
	
	
	/*
	 *条件查询
	*/
	$scope.searchName = "";
	$scope.searchEntityList = function(pageNo){
		if(pageNo){
			$scope.paginationConf.currentPage=1;
		}
		function qSucc(rec){
			$scope.entityList=rec.content;
			$scope.paginationConf.totalItems = rec.totalElements;
			if(rec.content == "" || rec.content == null){
				$scope.qshow=false;
				$scope.ashow=false;
				$scope.ushow=false;
				$scope.dshow=false;
			}else{
				$scope.qshow=true;
				$scope.ashow=true;
				$scope.ushow=true;
				$scope.dshow=true;
			}
		}
		function qErr(){
			$.messager.popup("查询失败");
		}
		entSvc.queryPartyInstallList({
			//类型---默认4：企业
			parTypeId:5,
			//当前企业标识
			currOrgId:$scope.userCookies.orgId,
			//企业编号
			fuzzyData:$scope.fuzzyData,
			pageNo:$scope.paginationConf.currentPage-1,
			pageSize:$scope.paginationConf.pageRecord
		},qSucc,qErr);
	};
	

	//标识是添加还是更新
	$scope.actionFlag ={add:false,update:false};
	//添加部门-弹出
	$scope.openAddDept = function(){
		$scope.departEntity = {};
		$scope.departEntity.parTypeId=5;
		$scope.departEntity.currOrgId=$scope.user.currOrgId;
		//此处应该设置当前企业的ID
		$scope.parentOrg = $scope.user.currOrgId;
		$scope.departEntity.parentOrgId = Number($scope.user.currOrgId);
		$scope.departEntity.parentOrgName =$scope.user.orgName;
		$scope.queryEntList($scope.user.currOrgId,$scope.user.orgName);
		$scope.actionFlag.add = true;
		$scope.actionFlag.update = false;
		$scope.displayName="请选择";
		$("#departmentAddModal").modal({backdrop: 'static', keyboard: false});
	};
	
	
	/*
	*添加部门信息
	*/
	$scope.departEntity = {};
	$scope.addDepartment = function(obj){
		if(obj.$valid){
			function aSucc(rec){
				$scope.showFlag='';
				$scope.queryEntList(null,null,1);
				$scope.departEntity={};
				$scope.parentOrgList=[];
				$scope.displayName="请选择";
				$.messager.popup("添加部门成功");
				$("#departmentAddModal").modal('hide');
				$scope.queryEntitylist($scope.chooseParPartyId,$scope.chooseParName);
			}
			function aErr(rec){
				$scope.departEntity={};
				if(rec.data.message){
					$scope.showFlag='';
					$scope.departEntity={};
					$scope.parentOrgList=[];
					$scope.displayName="请选择";
					$.messager.popup(rec.data.message);
					$("#departmentAddModal").modal('hide');
				}
			}
			entSvc.addPartyInstallDetail($scope.departEntity,aSucc,aErr);
		}else{
			if($scope.displayName == "请选择"){
				$scope.showFlag = 'displayName';
			}
			else if(!obj.deptName.$valid){
				$scope.showFlag = 'deptName';
			}
			else if(!obj.departType.$valid){
				$scope.showFlag = 'departType';
			}
			else if(!obj.note.$valid){
				$scope.showFlag = 'note';
			}
			return;
		}
	};
	
	
	/*
	*获取选中的部门ID
	*/
	$scope.chooseParty = function(varl){
		$scope.choosePartyId = varl;
	};
	
	
	/*
	*获取部门信息
	*/
	$scope.getDepartEntity = function(varl,varl2){
		entSvc.queryPartyInstallDetail({id:varl},function(rec){
			$scope.departEntity = rec;
			if($scope.departEntity.type==1){
				$scope.departEntity.typeName="职能部门";
			}
			else if($scope.departEntity.type==2){
				$scope.departEntity.typeName="法人单位";
			}
			else if($scope.departEntity.type==3){
				$scope.departEntity.typeName="项目部";
			}
			else if($scope.departEntity.type==4){
				$scope.departEntity.typeName="责任部门";
			}
			else if($scope.departEntity.type==5){
				$scope.departEntity.typeName="科室";
			}
			else if($scope.departEntity.type==6){
				$scope.departEntity.typeName="临时机构";
			}
			//获取上级部门信息
			$scope.parentOrg = rec.parentOrgId;
			$scope.getParentOrgList($scope.parentOrg);
		},function(){
			$.messager.popup("获取部门详细信息失败");
		});
	};
	
	$scope.parentOrgAdd = ""; 
	$scope.displayName="请选择";
	/*
	*点击查询下级部门事件Add
	*/
	$scope.chooseChildOrgM = function(varl,varl1){
		if($scope.departEntity.partyId == varl){
			$.messager.popup("不能选择本部门下的子部门");
			return;
		}
		$scope.showFlag='';
		$scope.displayName=varl1;
		$scope.queryEntList(varl,varl1);
	};
	
	/*
	*设置当前的上级机构Add
	*/
	$scope.parentOrg ="";
	$scope.chooseParentOrgM = function(){
		if($scope.parentOrg == "" || $scope.parentOrg == null){
			$.messager.popup("当前无上级部门查询");
			$scope.displayName="请选择";
			$scope.parentOrgList={};
			return;
		}
		if($scope.displayName == $scope.user.orgName && $scope.parentOrg == $scope.user.currOrgId){
			$.messager.popup("当前无上级部门查询");
			$scope.displayName="请选择";
			$scope.parentOrgList={};
		}else{
			//deptIdAdd是下级部门的标识,作为查询上级部门的参数,添加到$scope.getParentOrgListAdd方法中
			$scope.getParentOrgList($scope.departEntity.parentOrgId);
		}
	};
	
	/*
	*获取部门的上级部门Add
	*/
	$scope.parentOrgList = {};
	$scope.getParentOrgList = function(varl){
		entSvc.queryPartyInstallList({
			currOrgId:Number(varl),
			qryParentFlag:true,
			parTypeId:5
		},
			function(rec){
				if(rec.content.length == 0){
					$scope.parentOrg = Number($scope.user.currOrgId);
					$scope.displayName = $scope.user.orgName;
					$scope.roleEntity.deptIdAdd = Number($scope.user.currOrgId);
					$scope.roleEntity.displayNameAdd = $scope.user.orgName;
					$scope.parentOrgList={};
					return;
				}
				if(rec.content.length == 1){
					$scope.parentOrg = rec.content[0].parentOrgId;
					$scope.displayName = rec.content[0].parentOrgName;
					$scope.departEntity.parentOrgId = Number(rec.content[0].parentOrgId);
					$scope.departEntity.parentOrgName =rec.content[0].parentOrgName;
					$scope.parentOrgList=rec.content;
					return;
				}
				if(rec.content.length >= 1){
					$scope.parentOrg = rec.content[0].parentOrgId;
					$scope.displayName = rec.content[0].parentOrgName;
					$scope.departEntity.parentOrgId = Number(rec.content[0].parentOrgId);
					$scope.departEntity.parentOrgName =rec.content[0].parentOrgName;
					$scope.parentOrgList = rec.content;
				}
		},function(){});
	};

	
	/*
	*更新部门信息Upd
	*/
	$scope.updateDepartEntity = function(obj){
		if(obj.$valid){
			if($scope.departEntityUpd.partyId == $scope.departEntityUpd.parentOrgId){
				//更新时，如果部门的上级部门是自己，提示返回
				$.messager.popup("部门不能是自己的子部门");
				return;
			}
			entSvc.updatePartyInstallDetail({id:$scope.departEntityUpd.partyId},$scope.departEntityUpd,function(rec){
				$scope.queryEntList();
				$.messager.popup("更新部门成功");
				$scope.radioTrIndex=1;
				$scope.paginationConf.currentPage=1;
				$("#departmentUpdModal").modal('hide');
				$scope.queryEntitylist($scope.chooseParPartyId,$scope.chooseParName);
			},function(){
				$.messager.popup("更新部门失败");
			});
		}else{
			if(!obj.deptName.$valid){
				$scope.showFlag = 'deptName';
			}else if(!obj.departType.$valid){
				$scope.showFlag = 'departType';
			}
			return;
		}
	};
	
	$scope.parentOrgUpd = ""; 
	$scope.displayNameUpd="请选择";
	/*
	*点击查询下级部门事件Upd
	*/
	$scope.chooseChildOrgUpd = function(varl,varl1){
		if($scope.departEntity.partyId == varl){
			$.messager.popup("不能选择本部门下的子部门");
			return;
		}
		$scope.showFlag='';
		$scope.displayNameUpd=varl1;
		$scope.queryEntListUpd(varl,varl1);
	};
	
	/*
	*查询下级部门的具体查询方法
	*/
	$scope.queryEntListUpd = function(flag,varl){
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:Number(flag)
		}, function(rec){
			$scope.departEntity.parentOrgIdUpd = flag;
			$scope.departEntity.parentOrgNameUpd = varl;
			if(rec.content.length <= 0){
				$.messager.popup("当前无下级部门查询");
				$scope.parentOrgListUpd = {};
				return;
			}else if(rec.content.length > 0){
				$scope.parentOrgUpd = Number(flag);
				$scope.parentOrgListUpd = rec.content;
			}
		},function(){
			$.messager.popup("获取上级部门列表失败");
		});
	};
	
	/*
	*设置当前的上级机构Upd
	*/
	$scope.parentOrgUpd ="";
	$scope.chooseParentOrgUpd = function(){
		if($scope.parentOrgUpd == "" || $scope.parentOrgUpd == null){
			$.messager.popup("当前无上级部门查询");
			$scope.displayNameUpd="请选择";
			$scope.parentOrgListUpd={};
			return;
		}
		if($scope.displayNameUpd == $scope.user.orgName && $scope.parentOrgUpd == $scope.user.currOrgId){
			$.messager.popup("当前无上级部门查询");
			$scope.displayNameUpd="请选择";
			$scope.parentOrgListUpd={};
		}else{
			//deptIdAdd是下级部门的标识,作为查询上级部门的参数,添加到$scope.getParentOrgListAdd方法中
			$scope.getParentOrgListUpd($scope.departEntity.parentOrgIdUpd);
		}
	};
	
	/*
	*获取部门的上级部门Upd
	*/
	$scope.parentOrgListUpd = {};
	$scope.getParentOrgListUpd = function(varl){
		entSvc.queryPartyInstallList({
			currOrgId:Number(varl),
			qryParentFlag:true,
			parTypeId:5
		},
			function(rec){
				if(rec.content.length == 0){
					$scope.parentOrgUpd = Number($scope.user.currOrgId);
					$scope.displayNameUpd = $scope.user.orgName;
					$scope.departEntity.parentOrgIdUpd = Number(rec.content[0].parentOrgId);
					$scope.departEntity.parentOrgNameUpd =rec.content[0].parentOrgName;
					$scope.parentOrgListUpd={};
					return;
				}
				if(rec.content.length == 1){
					$scope.parentOrgUpd = rec.content[0].parentOrgId;
					$scope.displayNameUpd = rec.content[0].parentOrgName;
					$scope.departEntity.parentOrgIdUpd = Number(rec.content[0].parentOrgId);
					$scope.departEntity.parentOrgNameUpd =rec.content[0].parentOrgName;
					$scope.parentOrgListUpd=rec.content;
					return;
				}
				if(rec.content.length >= 1){
					$scope.parentOrgUpd = rec.content[0].parentOrgId;
					$scope.displayNameUpd = rec.content[0].parentOrgName;
					$scope.departEntity.parentOrgIdUpd = Number(rec.content[0].parentOrgId);
					$scope.departEntity.parentOrgNameUpd =rec.content[0].parentOrgName;
					$scope.parentOrgListUpd = rec.content;
				}
		},function(){});
	};
	
	/*
	*打开查看部门详细信息页面
	*/
	$scope.openCheckDetail = function(){
		if($scope.choosePartyId){
			entSvc.queryPartyInstallDetail({id:$scope.choosePartyId},function(rec){
				$scope.departEntityDetail = rec;
				if($scope.departEntityDetail.type==1){
					$scope.departEntityDetail.typeName="职能部门";
				}
				else if($scope.departEntityDetail.type==2){
					$scope.departEntityDetail.typeName="法人单位";
				}
				else if($scope.departEntityDetail.type==3){
					$scope.departEntityDetail.typeName="项目部";
				}
				else if($scope.departEntityDetail.type==4){
					$scope.departEntityDetail.typeName="责任部门";
				}
				else if($scope.departEntityDetail.type==5){
					$scope.departEntityDetail.typeName="科室";
				}
				else if($scope.departEntityDetail.type==6){
					$scope.departEntityDetail.typeName="临时机构";
				}
				//获取上级部门信息，功能不明
				$scope.parentOrg = rec.parentOrgId;
				$scope.getParentOrgList($scope.parentOrg);
			},function(){
				$.messager.popup("获取部门详细信息失败");
			});
			$scope.actionFlag.add = false;
			$scope.actionFlag.update = false;
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}
		$("#departmentDetailModal").modal({backdrop: 'static', keyboard: false});
	};
	
	
	/*
	*打开更新部门信息页面
	*/
	$scope.addOrUpd = function(){
		if($scope.choosePartyId){
			entSvc.queryPartyInstallDetail({id:$scope.choosePartyId},function(rec){
				$scope.departEntityUpd = rec;
				if($scope.departEntityUpd.type==1){
					$scope.departEntityUpd.typeName="职能部门";
				}
				else if($scope.departEntityUpd.type==2){
					$scope.departEntityUpd.typeName="法人单位";
				}
				else if($scope.departEntityUpd.type==3){
					$scope.departEntityUpd.typeName="项目部";
				}
				else if($scope.departEntityUpd.type==4){
					$scope.departEntityUpd.typeName="责任部门";
				}
				else if($scope.departEntityUpd.type==5){
					$scope.departEntityUpd.typeName="科室";
				}
				else if($scope.departEntityUpd.type==6){
					$scope.departEntityUpd.typeName="临时机构";
				}
				//获取上级部门信息
				$scope.parentOrgUpd = rec.parentOrgId;
				$scope.displayNameUpd = rec.parentOrgName;
				$scope.chooseChildOrgUpd($scope.parentOrgUpd,$scope.displayNameUpd);
			},function(){
				$.messager.popup("获取部门详细信息失败");
			});
			$scope.actionFlag.add = false;
			$scope.actionFlag.update = true;
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}
		$("#departmentUpdModal").modal({backdrop: 'static', keyboard: false});
	};
	
	$scope.closeWindowCheck = function(){
		//去除验证信息
		$scope.showFlag = '';
		$scope.departEntity = {};
		$("#departmentDetailModal").modal('hide');
	};
	
	$scope.closeWindowAdd = function(){
		//去除验证信息
		$scope.showFlag = '';
		$scope.departEntity = {};
		$("#departmentAddModal").modal('hide');
	};
	
	$scope.closeWindowUpdate = function(){
		//去除验证信息
		$scope.showFlag = '';
		$scope.departEntity = {};
		$("#departmentUpdModal").modal('hide');
	};
	
	
	/*
	*删除部门信息
	*/
	$scope.deleteDepart = function(){
		if($scope.choosePartyId){
			$.messager.confirm("提示", "是否删除？", function() { 
				entSvc.deletePartyInstallDetail({id:$scope.choosePartyId},function(rec){
					$.messager.popup("删除成功");
					$scope.queryEntitylist($scope.chooseParPartyId,$scope.chooseParName);
					$scope.searchEntityList(1);
				},function(rec){
					if(rec.data.message){
						$.messager.popup(rec.data.message);
					}
				});
		    });
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}
	};
	
	
	/*
	 *点击行选中radio
	*/
	$scope.radioList={};
	$scope.check = function(params,varl){
		$scope.radioTrIndex=varl;
		$scope.choosePartyId = params.currOrgId;
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

<body ng-app="departmentApp" ng-controller="departmentController" class="container">
	<div ng-include src="'../../WebSite/Include/TopMenu.jsp'" ></div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">企业管理</li>
		<li style="font-size: 13px">部门设置</li>
		<li style="font-size: 13px" ng-repeat="titleTxt in parOrgList">
			<a href="javascript:void();" ng-click="selectTitle(titleTxt.id,titleTxt.name);">{{titleTxt.name}}</a>
	    </li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;" >
			<ul>
				<div class="form-group">
				    <label contenteditable="false" class="col-xs-1 control-label" ></label>
				    <div class="col-xs-5">
						<input type="text" class="form-control" ng-model="fuzzyData" placeholder="查询   部门名称">
					</div>
					<div class="col-xs-offset-6">
						<input type="button" class="btn btn-primary" value=" 查  询 " ng-click="searchEntityList(1);" >
					</div>
				</div>

			</ul>
			
				<table class="table table-hover" style="margin-left: 30px;" >
						<tbody>
						<tr class="success">
							<td style="text-align: center;">序号</td>
							<th></th>
							<td style="text-align: center;">部门名称</td>
							<td style="text-align: center;">所属企业</td>
							<td style="text-align: center;">上级部门</td>
							<td style="text-align: center;">最后更新时间</td>
						</tr>
					</tbody>
					<tbody>
						<!-- 点击查询下级部门 -->
						<!-- <a ng-click="queryEntitylist(entity.currOrgId,entity.name);">{{entity.name}}</a> -->
						<tr style="text-align: center;" ng-repeat="entity in entityList" ng-click="check(entity,$index+1);" ng-dblclick="openCheckDetail();"> 
							<td style="text-align: center;"><input style="margin-left:-13px;" type="radio" name="onlyOne" ng-click="chooseParty(entity.currOrgId)" ng-checked="radioTrIndex==$index+1"></td>
							<td style="text-align: center;"><span  style="margin-left:-140px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.pageRecord}}</span></td>
							<td><a href="javascript:void();" ng-click="queryEntitylist(entity.currOrgId,entity.name);">{{entity.name}}</a></td>
							<td>{{userCookies.orgName}}</td>
							<td>{{entity.parentOrgName}}</td>
							<td>{{entity.updateTime}}</td>
						</tr>
					</tbody>
				</table>
				<div style="margin-left: 50px">
					<div style="text-align:right; float:right;">
						<pagination-tag conf="paginationConf"></pagination-tag>
					</div>
					<label></label>
					<!-- <div>
						<button ng-show="qshow" type="button" class="btn btn-primary" ng-click="openCheckDetail()">查看</button>
						<button ng-show="ashow" type="button" class="btn btn-primary" ng-click="openAddDept()">添加</button>
						<button ng-show="ushow" type="button" class="btn btn-primary" ng-click="addOrUpd()">修改</button>
						<button ng-show="dshow" type="button" class="btn btn-primary" ng-click="deleteDepart()">删除</button>
					</div> -->
					<div>
						<button  type="button" class="btn btn-primary" ng-click="openCheckDetail()">查看</button>
						<button  type="button" class="btn btn-primary" ng-click="openAddDept()">添加</button>
						<button  type="button" class="btn btn-primary" ng-click="addOrUpd()">修改</button>
						<button  type="button" class="btn btn-primary" ng-click="deleteDepart()">删除</button>
					</div>
				</div>	
			
		</div>
	</form>
	<div ng-include src="'../DepartmentManager/DepartmentAdd.jsp'"></div>
	<div ng-include src="'../DepartmentManager/DepartmentDetail.jsp'"></div>
	<div ng-include src="'../DepartmentManager/DepartmentrUpd.jsp'"></div>
</body>
</html>