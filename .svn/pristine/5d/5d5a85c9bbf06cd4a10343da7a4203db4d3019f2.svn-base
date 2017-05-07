<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<div class="modal fade" id="departmentUpdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">部门设置</h4>
			</div>
			<div class="modal-body" style="text-align:center;">
				<form name="signForm" role="form" novalidate method="post" id="signForm" enctype="application/x-www-form-urlencoded" novalidate>
					<div class="form-horizontal" style="margin-top: 10px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">所属企业</label>
								<div class="col-xs-4">
									 <p class="form-control-static" align="left" style="margin-left:14px">{{userCookies.orgName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">上级部门</label>
								<div class="col-xs-4">
									<input type="hidden" ng-model="parentOrgUpd"/>
							    	<div class="dropdown">
									   <button type="button"  class="btn btn-default" id="dropdownMenu1" style="width:90%;float:left;text-align: left;" data-toggle="dropdown"> 
									   		<lable style="margin-left:3px">{{displayNameUpd}}</lable>
									   </button>
									   <ul  class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs"  style="width:90%;margin-top:35px">
									   	  <!-- <li role="presentation"><a>--请选择--</a></li> -->
									   	  <li role="presentation"><a ng-click="chooseParentOrgUpd();">返回上级部门</a></li>
									      <li role="presentation">
									         <a role="menuitem" tabindex="-1"
									         	ng-click="chooseChildOrgUpd(departEntity.parentOrgIdUpd,departEntity.parentOrgNameUpd)">
									         	{{departEntity.parentOrgNameUpd}}
									         </a>
									      </li>
									      <li role="presentation">
									         <a role="menuitem" tabindex="-1"
									         	ng-repeat="parentOrg in parentOrgListUpd" 
									         	ng-click="chooseChildOrgUpd(parentOrg.currOrgId,parentOrg.name)">
									         	{{parentOrg.name}}
									         </a>
									      </li>
									   </ul>
									</div>
									<p class="form-control-static" style="color:red;">*</p>
								</div>
								<div class="col-xs-4" ng-show="showFlag == 'displayName'">
								 	<p class="form-control-static" style="color:red;"> 请选择上级部门</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">部门名称</label>
								<div class="col-xs-4">
									<input type="text" name="deptName" class="form-control" style="width:90%;float:left;" ng-model="departEntityUpd.name" required maxlength="50" ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/"></input>
							    	<p class="form-control-static" style="color:red;">*</p>
								</div>
								<div class="col-xs-4" ng-messages="signForm.deptName.$error" ng-show="showFlag == 'deptName'">
									 <p class="form-control-static" style="color:red;" ng-message="required"> 请输入部门名称</p>
					                 <p class="form-control-static" style="color:red;" ng-message="maxlength">请输入部门名称</p>
					                 <p class="form-control-static" style="color:red;" ng-message="pattern">只能是数字、汉字、字母</p>
								</div>
							</div>
							<div class="form-group" >
								<label contenteditable="false" class="col-xs-2 control-label">部门性质</label>
								<div class="col-xs-4" >
									<select class="form-control" name="departType" ng-model="departEntityUpd.type" style="width:90%;float:left;" required>
								    	<option value="">--请选择--</option>
								    	<option value="1">职能部门</option>
								    	<option value="2">法人单位</option>
								    	<option value="3">项目部</option>
								    	<option value="4">责任部门</option>
								    	<option value="5">科室</option>
								    	<option value="6">临时机构</option>
							    	</select>
							    	<p class="form-control-static" style="color:red;">*</p>
								</div>
								<div class="col-xs-4" ng-messages="signForm.departType.$error" ng-show="showFlag == 'departType'">
									 <p class="form-control-static" style="color:red;" ng-message="required"> 请选择部门性质</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">部门描述</label>
								<div class="col-xs-9">
									<textarea class="form-control" name="note"  maxlength="60" rows="3" style="width:90%;float:left;" ng-model="departEntityUpd.note"></textarea>	
								</div>
								<div class="col-xs-4" ng-messages="signForm.note.$error" ng-show="showFlag == 'note'">
									 <p class="form-control-static" style="color:red;" ng-message="maxlength">请输入字符在60个以内</p>
								</div>
							</div>
							
						</ul>
					</div>
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="提交"  ng-click="updateDepartEntity(signForm);">
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="返回" ng-click="closeWindowUpdate();"></div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
