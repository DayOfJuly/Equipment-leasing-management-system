<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<div class="modal fade" id="RoleGrantAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">角色授权</h4>
			</div>
			<div class="modal-body" style="text-align:center;">
				<form name="roleForm" id="roleForm" role="form" novalidate action="" method="post" enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal" style="margin-top: 10px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">角色名称：</label>
								<div class="col-sm-4">
									<input type="text" name="roleName" required maxlength="20" ng-pattern="/^[0-9a-zA-Z_\u3E00-\u9FA5]+$/" 
										class="form-control" style="width:90%;float:left;" ng-model="roleEntity.name" ng-blur="loseBlur(roleForm);">
									<p class="form-control-static" style="color:red;">*</p>
									<div ng-messages="roleForm.roleName.$error" ng-show="showFlag == 'roleName'">
										 <p class="form-control-static" style="color:red;" ng-message="required"> 请输入角色名称</p>
						                 <p class="form-control-static" style="color:red;" ng-message="pattern"> 角色名称只能是数字、汉字、字母</p>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label" ng-model="roleEntity.orgId">所属企业：</label>
								<div class="col-sm-4">
									<p class="form-control-static" style="text-align: left;"><label style="margin-left:15px">{{userCookies.orgName}}</label></p>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label" style="margin-left:10px;">所属部门：</label>
									<input type="hidden" ng-model="parentOrgAdd">
									<input type="hidden" ng-model="parentOrgAddName"> 
									<div class="col-xs-4">
										<div class="dropdown">
										   <button type="button" class="btn btn-default"  id="dropdownMenu1" style="width:90%;float:left;text-align: left;" data-toggle="dropdown"> 
										   		<lable style="margin-left:1px">{{displayNameAdd}}</lable>
										   </button>
										   <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs" style="width:90%;margin-top:35px">
										   	  <!-- <li role="presentation"><a>--请选择--</a></li> -->
										   	  <li role="presentation"><a ng-click="chooseParentOrgAdd();">
										   	  <lable style="margin-left:-5px">返回上级部门</lable></a></li>
										      <li role="presentation">
										         <a role="menuitem" tabindex="-1" ng-click="chooseChildOrgAdd(roleEntity.deptIdAdd,roleEntity.deptNameAdd)">
										         	<lable style="margin-left:-5px">{{roleEntity.deptNameAdd}}</lable>
										         </a>
										      </li>
										      <li role="presentation">
										         <a role="menuitem" tabindex="-1" ng-repeat="parentOrg in parentOrgListAdd"  
										         	ng-click="chooseChildOrgAdd(parentOrg.currOrgId,parentOrg.name)">
										         	<lable style="margin-left:-5px">{{parentOrg.name}}</lable>
										         </a>
										      </li>
										   </ul>
										</div>
										<p class="form-control-static" style="color: red;">*</p>
										<div ng-show="showFlag == 'dispalyName'"> 
											<p class="form-control-static" style="color:red;">请选择部门</p>
										</div>
									</div>
									
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">功能信息：</label>
								<div class="col-sm-10" style="text-align: left;">
										<label class="checkbox-inline" style="text-align: left;height: 47px;width:40%" ng-repeat="authorityEntity in authorityList">
											<input type="checkbox"  ng-model="authorityEntity.chck"> {{authorityEntity.note}}
										</label>
								</div>
								<input type="button" id="allSelect" value="全选" ng-click="selectAllbox();"/>
								<div ng-show="showFlag == 'roleFunc'">
						                <p class="form-control-static" style="color:red;"> 请选择"功能信息"中的相关功能</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">角色用途：</label>
								<div class="col-sm-9">
									   <textarea class="form-control" name="aaName" rows="3" maxlength="60" ng-model="roleEntity.note" placeholder="请输入字符在60个以内"></textarea> 
								</div>
							</div>
								<div ng-messages="roleForm.aaName.$error" ng-show="showFlag == 'aaName'">
						               <p class="form-control-static" style="color:red;" ng-message="maxlength">请输入字符在60个以内</p>
								</div>
						</ul>
					</div>
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="提交" ng-click="addRole(roleForm);">
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="返回" ng-click="closeWindowAdd();"> 
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
