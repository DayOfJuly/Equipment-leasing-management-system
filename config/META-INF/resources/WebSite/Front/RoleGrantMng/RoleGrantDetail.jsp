<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<div class="modal fade" id="RoleGrantCheckModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
								<div class="col-sm-8"  style="text-align: left;">
								 	<p class="form-control-static">{{roleEntity.name}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label" ng-model="roleEntity.orgId">所属企业：</label>
								<div class="col-sm-8"  style="text-align: left;">
									<p class="form-control-static" >{{userCookies.orgName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">所属部门：</label>
								<div class="col-sm-8"  style="text-align: left;">
									<input type="hidden" ng-model="parentOrg"> 
									<p class="form-control-static">{{radioCheckValue.deptName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">功能信息：</label>
								<div class="col-xs-10" style="text-align: left;">
									<label class="checkbox-inline" style="text-align: left;height: 47px;margin-left:-20px;width:40%;" ng-repeat="authorityEntity in roleEntity.funcInfo">
										<span>{{authorityEntity.note}}</span> 
									</label>
								</div>
								
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-sm-2 control-label">角色用途：</label>
								<div class="col-sm-8"  style="text-align: left;">
									<p class="form-control-static"> {{roleEntity.note}}</p>
								</div>
							</div>
						</ul>
					</div>
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="返回" ng-click="closeWindowCheck();"> 
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
