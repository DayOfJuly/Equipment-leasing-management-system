<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>角色授权</title>
<jsp:include page="../Include/Head.jsp" />
<script type="text/javascript" src="../../js/JsSvc/unifySvc.js"></script>
<script type="text/javascript" src="../../js/JsSvc/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<script type="text/javascript">
var app = angular.module('RoleGrantApp',['ngResource','unifyModule','myPagination','ngMessages']);



app.controller('RoleGrantController',function($scope,roleSvc,entSvc,authoritySvc){
	
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
	        	$scope.queryRoleList();
	        	$scope.radioTrIndex = null;
	        	if($scope.radioTrIndex == null){
	        		$scope.choosePartyId=null;
	        	}
	        }
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
	 *点选组织机构面包屑
	*/
	$scope.selectTitle=function(parm1,parm2){
		$scope.queryRoleList(parm1,parm2);
		changeTitle(parm1);
	};
	
	//获取角色信息列表
	$scope.searchEntity = {
		deptId:$scope.user.currOrgId,
		deptName:$scope.user.orgName/*,*/
		/*pageNo:$scope.paginationConf.currentPage-1,
		pageSize:$scope.paginationConf.pageRecord*/
	};
	$scope.parOrgList=[{id:$scope.user.currOrgId,name:$scope.user.orgName}];
	$scope.queryRoleList = function(parm1,parm2,PageNo){
		if(PageNo){
			$scope.paginationConf.currentPage = 1;
		}
		if(parm1){
			//如果是点击搜索条件
			$scope.searchEntity.deptId = parm1;
			$scope.searchEntity.deptName = parm2;
			$scope.parOrgList.push({id:parm1,name:parm2});
		}else if($scope.searchEntity.deptId != $scope.user.currOrgId){
			if($scope.searchEntity.deptId == $scope.parOrgList[$scope.parOrgList.length -1].id){
				return;
			}else{
				$scope.searchEntity.deptName = $('#selectDept option:selected').text();
				$scope.parOrgList.push({id:$scope.searchEntity.deptId,name:$scope.searchEntity.deptName});
			}
		}else if($scope.searchEntity.deptId == $scope.user.currOrgId){
			$scope.parOrgList=[{id:$scope.user.currOrgId,name:$scope.user.orgName}];
		}
		$scope.queryNextDepartment($scope.searchEntity.deptId);
		$scope.searchEntity.pageNo=$scope.paginationConf.currentPage-1;
		$scope.searchEntity.pageSize=$scope.paginationConf.pageRecord;
		roleSvc.queryRole($scope.searchEntity,function(rec){
			$scope.entityList =rec.content;
			$scope.paginationConf.totalItems = rec.totalElements;
		},function(){
			
		});
	};
	
	//查询功能，获取下级部门
	$scope.queryNextDepartment = function(varl){
		entSvc.queryPartyInstallList({parTypeId:5,currOrgId:Number(varl)}, function(rec){
			if(rec.content){
				if(rec.content.length <= 0){
					$scope.searchDeptList = {};
					return;
				}else if(rec.content.length > 0){
					$scope.searchDeptList = rec.content;
				}
			}
		},function(){
			$.messager.popup("获取下级部门列表失败");
		});
	};
	
	/*$scope.roleEntity = {};*/
	$scope.actionFlag = {add:false,update:false};
	//查看角色信息
	$scope.checkRoleDetail = function(){
		$scope.queryRoleList();
		if($scope.choosePartyId){
			$scope.getRoleDetail();
			$scope.getAuthorityList();
			$scope.actionFlag = {add:false,update:false};
			$scope.radioCheckValue.deptName;
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}
		$("#RoleGrantCheckModal").modal({backdrop: 'static', keyboard: false});
	};
	


	
	//获取权限列表
	$scope.getAuthorityList = function(){
		authoritySvc.queryAuthorities({},function(rec){
			$scope.authorityList = rec.content;
			/*if($scope.roleEntity.funcInfo != null){
				$scope.checkAuthority($scope.roleEntity.funcInfo);
			}*/
		},function(){});
	/*	$scope.authorityList = [{functionId:0,functionName:'企业管理员维护'},{functionId:1,functionName:'企业设置'},{functionId:2,functionName:'部门设置'},
		                        {functionId:3,functionName:'预定机票管理-个人历史查询'},{functionId:4,functionName:'预定机票管理-统计查询'},{functionId:5,functionName:'预定机票管理-预定机票申请'},
		                        {functionId:6,functionName:'员工信息维护'},{functionId:7,functionName:'审批单管理'},{functionId:8,functionName:'报销管理-报销单查询'},
		                        {functionId:9,functionName:'报销管理-报销信息维护'},{functionId:10,functionName:'报销管理-报销单管理'},{functionId:11,functionName:'审批单审核'},
		                        {functionId:12,functionName:'企业申请审核'}];*/
	};
	
	//全选
	$scope.selectAllbox = function(){

		if($("#allSelect").val()=="全选"){	
			
			for(var j = 0; j < $scope.authorityList.length; ++j){
				$scope.authorityList[j].chck = true;
			}
			$("#allSelect").val("全取消");
		}else if($("#allSelect").val()=="全取消"){
			for(var i = 0; i < $scope.authorityList.length; ++i){
			    
		    	$scope.authorityList[i].chck = false;
			
	        }
			$("#allSelect").val("全选");
	   }
		
		
		
	};

	//勾选已经选中的权限					
	$scope.checkAuthority = function(obj) {
		if($scope.roleEntity.funcInfo){
			for (var i = 0; i < obj.length; i++) {
				for(var j = 0; j < $scope.authorityList.length; ++j){
					if (obj[i].functionId == $scope.authorityList[j].functionId) {
						$scope.authorityList[j].chck = true;
						break;
					}
				}
			}
		}
	};
	
	//获得选中的权限复选框都有哪些
	$scope.getCheckAuthority = function(){
		$scope.roleEntity.funcInfo = [];
		for(var j = 0; j < $scope.authorityList.length; ++j){
			if($scope.authorityList[j].chck){
				$scope.roleEntity.funcInfo.push($scope.authorityList[j].functionId);/* 提交选中的权限复选框序号 */
			}
		}
	};
					
	
	//获取选中的角色ID
	$scope.chooseRole = function(varl){
		$scope.choosePartyId = varl;
		/*$scope.roleEntity.roleId = varl;*/
	};
	
	$scope.closeWindowAdd = function(){
		$scope.showFlag = '';
		$("#RoleGrantAddModal").modal('hide');
		$scope.paginationConf.currentPage = 1;
	};
	
	$scope.closeWindowUpdate = function(){
		$scope.showFlag = '';
		$("#RoleGrantUpdateModal").modal('hide');
	};
	
	$scope.closeWindowCheck = function(){
		$scope.showFlag = '';
		$("#RoleGrantCheckModal").modal('hide');
	};
	
	//根据角色ID获取角色信息
	$scope.getRoleDetail = function(){
		if($scope.choosePartyId){
			
			roleSvc.getRoleDetail({id:$scope.choosePartyId},function(rec){
				
				$scope.roleEntity=rec;
				$scope.parentOrgAdd = $scope.roleEntity.deptId;
				$scope.parentOrgUpd = $scope.roleEntity.deptId;
				if($scope.parentOrgUpd){
					
					function qSucc(rec){
						$scope.roleEntity.deptIdUpd = rec.content[0].parentOrgId;
						$scope.roleEntity.deptNameUpd = rec.content[0].parentOrgName;
						$scope.displayNameUpd = rec.content[0].parentOrgName;
						$scope.parentOrgListUpd = rec.content;
					}
					
					function qErr(){}
					
					entSvc.queryPartyInstallList({
						partyId:$scope.test,
						parTypeId:5,
						currOrgId:Number($scope.parentOrgUpd)
					},qSucc,qErr);
				}
				$scope.checkAuthority($scope.roleEntity.funcInfo);
				$("#RoleGrantModal").modal({backdrop: 'static', keyboard: false});
			});
		}else{
			$.messager.popup("获取角色信息失败");
		}
	};
	
	//添加角色信息--弹出
	$scope.openAddRole = function(varl){
			//获取权限信息
			$scope.roleEntity = {};/* 清空添加时的信息 */
			$scope.getAuthorityList();/*  */
			$scope.actionFlag = {add:true,update:false};
			$scope.roleEntity.deptIdAdd = $scope.user.currOrgId;
			$scope.roleEntity.deptNameAdd = $scope.user.orgName;
			$scope.displayNameAdd="请选择";
			
		$("#RoleGrantAddModal").modal({backdrop: 'static', keyboard: false});
	};
	

	//失去焦点的时候校验
	$scope.loseBlur = function(obj){

		if(obj.$valid){
			$scope.verifyNameRole($scope.roleEntity.name);
		
		}
		
	};
	
	
	//校验名称是否存在
	$scope.verifyNameRole = function(orgName){
		function aSucc(rec){
	        if(rec.msg=="FALSE"){
	        	$.messager.popup("此姓名可以使用");
	        }
	        if(rec.msg=="TRUE"){
	        	$.messager.popup("此姓名已存在,请重新输入");
	        	$scope.roleEntity.name = null;
	        	return;
	        }
			
		}
		function aErr(){}
		roleSvc.verifyNameRole({name:orgName,Action:'CheckExistAdd'},aSucc,aErr);
	};
	
	//失去焦点的时候校验(修改)
	$scope.loseUpdBlur = function(obj){

		if(obj.$valid){
			$scope.verifyNameUpdRole($scope.roleEntity.name,$scope.choosePartyId);
		}
		
	};
	
	
	//校验名称是否存在(修改)
	$scope.verifyNameUpdRole = function(orgName,id){
		function aSucc(rec){
	        if(rec.msg=="FALSE"){
	        	$.messager.popup("此姓名可以使用");
	        }
	        if(rec.msg=="TRUE"){
	        	$.messager.popup("此姓名已存在,请重新输入");
	        	$scope.roleEntity.name = null;
	        	return;
	        }
			
		}
		function aErr(){}
		roleSvc.verifyNameUpdRole({roleId:id,name:orgName,Action:'CheckUniqueUpd'},aSucc,aErr);
	};
	
	//添加角色信息
	$scope.addRole = function(obj){
		if(obj.$valid){
			$scope.getCheckAuthority();/* 获得选中权限的序号 */
		/* 	//功能信息验证
			 if(!$scope.roleEntity.funcInfo){//如果没有权限结果集合
				$scope.showFlag = 'roleFunc';
				return;
			} */
			
			//所属部门验证
			if($scope.displayNameAdd == "请选择"){
				$scope.showFlag = 'dispalyName';
				return;
			}
			//功能信息验证
			if($scope.roleEntity.funcInfo.length<=0){
				$scope.showFlag = 'roleFunc';
				return;
			}
			
			function aSucc(rec){
				$.messager.popup("角色添加成功");
				$scope.searchEntity = {
					deptId:$scope.user.currOrgId,
					deptName:$scope.user.orgName,
					pageNo:0,
					pageSize:$scope.paginationConf.pageRecord
				};
				$scope.closeWindowAdd();
				$scope.queryRoleList(null,null,1);
			}
			function aErr(){
				$scope.closeWindowAdd();
				$.messager.popup("角色添加失败");
			}
			$scope.parentOrgListAdd={};
			$scope.roleEntity.deptId = $scope.roleEntity.deptIdAdd;
			$scope.roleEntity.deptName = $scope.roleEntity.deptNameAdd;
			roleSvc.addRole($scope.roleEntity,aSucc,aErr);
		} else if(!obj.$valid){
			if(!obj.roleName.$valid){
				$scope.showFlag = 'roleName';
				return ;
			} 
		     if(!obj.aaName.$valid){
				$scope.showFlag = 'aaName';
				return ;
			} 
		} 
	};
	
	//跟新角色信息--弹出
	$scope.roleEntity={};
	$scope.openUpdateRole = function(){
		$scope.getAuthorityList();
		if($scope.choosePartyId){
			$scope.getRoleDetail();
			$scope.actionFlag = {add:false,update:true};
		}else{
			$.messager.popup("请选择一条记录");
			return;
		}
		$scope.roleEntity.deptIdUpd = $scope.user.currOrgId;
		$scope.roleEntity.deptNameUpd = $scope.user.orgName;
		$("#RoleGrantUpdateModal").modal({backdrop: 'static', keyboard: false});
	};
	
	
	//更新角色信息
	$scope.updateRole = function(obj){
		if(obj.$valid){
			$scope.getCheckAuthority();
			if(!$scope.roleEntity.funcInfo){
				$scope.showFlag = 'roleFunc';
				return;
			}
			if($scope.roleEntity.funcInfo.length<=0){
				$scope.showFlag = 'roleFunc';
				return;
			}
			roleSvc.updateRole({id:$scope.choosePartyId},$scope.roleEntity,function(rec){
				$.messager.popup("角色修改成功");
				$scope.radioTrIndex=1;
				$scope.paginationConf.currentPage=1;
				$scope.searchEntity = {
					deptId:$scope.user.currOrgId,
					deptName:$scope.user.orgName,
					pageNo:0,pageSize:$scope.paginationConf.pageRecord
				};
				$scope.queryRoleList();
				$("#RoleGrantUpdateModal").modal('hide');
			},function(){
				$scope.closeWindowUpdate();
				$.messager.popup("角色修改失败");
				$("#RoleGrantUpdateModal").modal('hide');
			});
		}else{
			if(!obj.roleName.$valid){
				$scope.showFlag = 'roleName';
			}else if(!obj.chName.$valid){
				$scope.showFlag = 'chName';
			}else if(!obj.aaName.$valid){
				$scope.showFlag = 'aaName';
			}
			return ;
		}
		
	};
	
	/**
	 * 
	 */
	$scope.delRole = function(){
		if($scope.choosePartyId){
			$.messager.confirm("提示", "是否删除？", function() { 
				roleSvc.deleteRole({id:$scope.choosePartyId},function(rec){
					$.messager.popup("角色删除成功");
					$scope.searchEntity = {
						deptId:$scope.user.currOrgId,
						deptName:$scope.user.orgName,
						pageNo:0,
						pageSize:$scope.paginationConf.pageRecord
					};
					$("#RoleGrantModal").modal('hide');
					$scope.queryRoleList(null,null,1);
				},function(){
					$.messager.popup("角色删除失败");
					$("#RoleGrantModal").modal('hide');
				});
		    });
		}else{
			$.messager.popup("请选择要删除的角色");
		}
	};
	
	
	
	
	
	$scope.displayNameAdd="请选择"; //显示框里面显示的值名称
	$scope.parentOrgAdd = "";     //部门标识
	//$scope.parentOrgName = "";  //部门名称
	/*
	*点击查询下级部门事件
	*/
	$scope.chooseChildOrgAdd = function(varl,varl1){
		$scope.showFlag = '';
		$scope.displayNameAdd=varl1;
		$scope.queryEntListAdd(varl,varl1);
	};
	
	/*
	*查询下级部门的具体查询方法
	*/
	$scope.queryEntListAdd = function(flag,varl){
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:Number(flag)
		}, function(rec){
			$scope.roleEntity.deptIdAdd = flag;
			$scope.roleEntity.deptNameAdd = varl;
			if(rec.content.length <= 0){
				$.messager.popup("当前无下级部门查询");
				$scope.parentOrgListAdd = {};
				return;
			}else if(rec.content.length > 0){
				$scope.parentOrgAdd = Number(flag);
				$scope.parentOrgListAdd = rec.content;
			}
		},function(){
			$.messager.popup("获取上级部门列表失败");
		});
	};
	
	
	/*
	*点击查询上级部门事件
	*/
	$scope.chooseParentOrgAdd = function(){
		if($scope.parentOrgAdd == "" || $scope.parentOrgAdd == null){
			$.messager.popup("当前无上级部门查询");
			return;
		}
		if($scope.displayNameAdd == $scope.user.orgName && $scope.parentOrgAdd == $scope.user.currOrgId){
			$.messager.popup("当前无上级部门查询");
		}else{
			//deptIdAdd是下级部门的标识,作为查询上级部门的参数,添加到$scope.getParentOrgListAdd方法中
			$scope.getParentOrgListAdd($scope.roleEntity.deptIdAdd);
		}
	};
	
	/*
	*查询上级部门具体方法
	*/
	$scope.getParentOrgListAdd = function(varl){
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:Number(varl),
			qryParentFlag:true
		}, function(rec){
			if(rec.content.length == 0){
				$scope.parentOrgAdd = Number($scope.user.currOrgId);
				$scope.displayNameAdd = $scope.user.orgName;
				$scope.roleEntity.deptIdAdd = Number($scope.user.currOrgId);
				$scope.roleEntity.displayNameAdd = $scope.user.orgName;
				return;
			}
			if(rec.content.length == 1){
				$scope.parentOrgAdd = rec.content[0].parentOrgId;
				$scope.displayNameAdd = rec.content[0].parentOrgName;
				$scope.roleEntity.deptIdAdd = Number(rec.content[0].parentOrgId);
				$scope.roleEntity.deptNameAdd = rec.content[0].parentOrgName;
				$scope.parentOrgListAdd = rec.content;
				return;
			}
			if(rec.content.length >= 1){
				$scope.parentOrgAdd = rec.content[0].parentOrgId;
				$scope.displayNameAdd = rec.content[0].parentOrgName;
				$scope.roleEntity.deptIdAdd = Number(rec.content[0].parentOrgId);
				$scope.roleEntity.deptNameAdd = rec.content[0].parentOrgName;
				$scope.parentOrgListAdd = rec.content;
			}
		},function(){});
	};
	


	
	
	//设置当前的上级机构-Update
	$scope.displayNameUpd = "请选择";
	$scope.parentOrgUpd = "";
	
	$scope.chooseParentOrgUpd = function(){
		if($scope.parentOrgUpd  == "" || $scope.parentOrgUpd == null){
			$.messager.popup("当前无上级部门查询");
			return;
		}
		if($scope.displayNameUpd == $scope.user.orgName && $scope.parentOrgUpd == $scope.user.currOrgId){
			$.messager.popup("当前无上级部门查询");
		}else{
			//deptIdAdd是下级部门的标识,作为查询上级部门的参数,添加到$scope.getParentOrgListAdd方法中
			$scope.getParentOrgListUpd($scope.roleEntity.deptIdUpd);
		}
	};
	
	//设置当前的下级机构-Update
	$scope.chooseChildOrgUpd = function(varl,varl1){
		$scope.queryEntListUpd(varl,varl1);
		$scope.displayNameUpd = varl1;
		$scope.showFlag = '';
	};
	
	
	//查询部门列表-Update
	$scope.queryEntListUpd = function(flag,varl){
		
		entSvc.queryPartyInstallList({
			parTypeId:5,
			currOrgId:Number(flag)
		}, function(rec){
			$scope.roleEntity.deptIdUpd = flag;
			$scope.roleEntity.deptNameUpd = varl;
			if(rec.content.length <= 0){
				$.messager.popup("没有下级部门");
				$scope.parentOrgListUpd = {};
				return;
			}else if(rec.content.length > 0){
				$scope.parentOrgUpd = Number(flag);
				$scope.parentOrgListUpd = rec.content;
			}
		},function(){
			$.messager.popup("获取部门列表失败");
		});
	};
	//-Update
	$scope.parentOrgListUpd = {};
	$scope.getParentOrgListUpd = function(varl){
		entSvc.queryPartyInstallList({
			currOrgId:Number(varl),
			qryParentFlag:true,
			parTypeId:5
		}, function(rec){
			if(rec.content.length == 0){
				$scope.parentOrgUpd = Number($scope.user.currOrgId);
				$scope.displayNameUpd = $scope.user.orgName;
				$scope.roleEntity.deptIdUpd = Number($scope.user.currOrgId);
				$scope.roleEntity.displayNameUpd = $scope.user.orgName;
				return;
			}
			if(rec.content.length == 1){
				$scope.parentOrgUpd = rec.content[0].parentOrgId;
				$scope.displayNameUpd = rec.content[0].parentOrgName;
				$scope.roleEntity.deptIdUpd = Number(rec.content[0].parentOrgId);
				$scope.roleEntity.deptNameUpd = rec.content[0].parentOrgName;
				$scope.parentOrgListUpd = rec.content;
				return;
			}
			if(rec.content.length >= 1){
				$scope.parentOrgUpd = rec.content[0].parentOrgId;
				$scope.displayNameUpd = rec.content[0].parentOrgName;
				$scope.roleEntity.deptIdUpd = Number(rec.content[0].parentOrgId);
				$scope.roleEntity.deptNameUpd = rec.content[0].parentOrgName;
				$scope.parentOrgListUpd = rec.content;
			}
		},function(){});
	};
	
	$scope.radioList={};
	//选中订单ID
	$scope.check = function(params,varl){
		$scope.radioTrIndex=varl;
		$scope.radioCheckValue = params;
		$scope.chooseRole(params.roleId);
	};
	
	
});

</script>

<style type="text/css">
.radio-inline + .radio-inline, .checkbox-inline + .checkbox-inline{margin-left:0px;}

.container {width: 1500px !important;}  

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}


</style>
</head>

<body ng-app="RoleGrantApp" ng-controller="RoleGrantController" class="container">
	<div ng-include src="'../../WebSite/Include/TopMenu.jsp'" ></div>
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">企业管理</li>
		<li style="font-size: 13px">角色授权</li>
	</ol>
	<form action="" style="width: 95%">
		<div style="margin-right: 55px">
			<table class="table table-hover" style="margin-left: 50px;">
				<tbody>
					<tr class="success">
						<th style="white-space: nowrap; text-align: center;">序号</th>
						<th style="white-space: nowrap; text-align: center;"></th>
						<th style="white-space: nowrap; text-align: center;">角色名称</th>
						<th style="white-space: nowrap; text-align: center;">所属企业</th>
						<th style="white-space: nowrap; text-align: center;">所属部门</th>
						<th style="white-space: nowrap; text-align: center;">最后更新时间</th>
					</tr>
				</tbody>
				<tbody>
					<tr  ng-repeat="entity in entityList" ng-click="check(entity,$index+1);" ng-dblclick="checkRoleDetail();">
						<td style="white-space: nowrap; text-align: center;"><input style="margin-left:-13px;" type="radio" name="onlyOne" ng-click="chooseRole(entity.roleId)" ng-checked="radioTrIndex==$index+1"></td>
						<td style="white-space: nowrap; text-align: center;"><span  style="margin-left:-160px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.pageRecord}}</span></td>
						<td style="white-space: nowrap; text-align: center; width:200px;">{{entity.name}}</td>
						<td style="white-space: nowrap; text-align: center;">{{userCookies.orgName}}</td>
						<td style="white-space: nowrap; text-align: center;">{{entity.deptName}}</td>
						<td style="white-space: nowrap; text-align: center;">{{entity.updateTime}}</td>
					</tr>
				</tbody>
			</table>
			<div style="margin-left: 50px">
				<div style="text-align:right; float: right;">
					<pagination-tag conf="paginationConf"></pagination-tag>
				</div>
				<label></label>
				<div>
					<button type="button" class="btn btn-primary" ng-click="checkRoleDetail();">查看</button>
					<button type="button" class="btn btn-primary" ng-click="openAddRole();">添加</button>
					<button type="button" class="btn btn-primary" ng-click="openUpdateRole();">修改</button>
					<button type="button" class="btn btn-primary" ng-click="delRole();">删除</button>
				</div>
			</div>	
		</div>
	</form>
	<div ng-include src="'../RoleGrantMng/RoleGrantAdd.jsp'" ></div>
	<div ng-include src="'../RoleGrantMng/RoleGrantDetail.jsp'" ></div>
	<div ng-include src="'../RoleGrantMng/RoleGrantUpd.jsp'" ></div>
</body>