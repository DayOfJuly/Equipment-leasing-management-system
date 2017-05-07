<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<div class="modal fade" id="RoleGrantModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">修改角色</h4>
			</div>
			<div class="modal-body" style="text-align:center;">
				<form name="form" action="" method="post" id="form" enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal" style="margin-top: 10px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">角色名称：</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" style="width:90%;float:left;" ng-model="roleEntity.roleName">
									<p class="form-control-static" style="color:red;">*</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label" ng-model="roleEntity.orgId">所属企业：</label>
								<div class="col-sm-4">
									<p class="form-control-static" >当前所在企业</p>
							</div></div>
							<div class="row">
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">所属部门：</label>
									<input type="hidden" ng-model="parentOrg"> 
									<div class="col-xs-4">
									<select id="parentOrgs" multiple="multiple" class="form-control" style="width: 90%; float: left;">
										<option value="{{roleEntity.roleDeptId}}" ng-click="chooseChildOrgM(roleEntity.roleDeptId,roleEntity.deptName)" style="background-color: rgba(135, 200, 228, 1);">{{roleEntity.deptName}}</option>
										<option ng-repeat="parentOrg in parentOrgList" value="{{parentOrg.currOrgId}}" ng-click="chooseChildOrgM(parentOrg.currOrgId,parentOrg.name)"><p>{{parentOrg.name}}</p></option>
									</select>
									<p class="form-control-static" style="color: red;">*</p>
									</div>
									<div class="col-xs-4">
										<input class="btn btn-primary" type="button" value="获取上级部门" ng-click="chooseParentOrgM();">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">功能信息：</label>
								<div class="col-sm-10" style="text-align: left;">
										<label class="checkbox-inline" style="text-align: left;height: 47px;" ng-repeat="authorityEntity in authorityList">
										<input type="checkbox" ng-model="authorityEntity.chck"> {{authorityEntity.functionName}}
										</label>
									</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">角色用途：</label>
								<div class="col-sm-10">
									  <textarea class="form-control" rows="3" ng-model="roleEntity.note"></textarea>
								</div>
							</div>
						</ul>
					</div>
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="提交" ng-click="addRole();" ng-show="actionFlag.add">
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="提交" ng-click="updateRole();" ng-show="actionFlag.update">
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="返回" ng-click="closeWindow();"> 
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
