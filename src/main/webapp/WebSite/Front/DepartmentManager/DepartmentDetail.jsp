<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<div class="modal fade" id="departmentDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">部门设置</h4>
			</div>
			<div class="modal-body" style="text-align:center;">
				<form name="signForm" style="width: 95%" role="form" novalidate method="post" id="signForm" enctype="application/x-www-form-urlencoded" novalidate>
					<div class="form-horizontal" style="margin-top: 10px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">所属企业</label>
								<div class="col-xs-4">
									 <p class="form-control-static" align="left">{{userCookies.orgName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">上级部门</label>
								<div class="col-xs-4">
									 <p class="form-control-static" align="left">{{departEntityDetail.parentOrgName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">部门名称</label>
								<div class="col-xs-4">
							    	 <p class="form-control-static" align="left">{{departEntityDetail.name}}</p>
								</div>
							</div>
							<div class="form-group" >
								<label contenteditable="false" class="col-xs-2 control-label">部门性质</label>
								<div class="col-xs-4" >
									<p class="form-control-static" align="left">{{departEntityDetail.typeName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">部门描述</label>
								<div class="col-xs-9">
									<p class="form-control-static" align="left">{{departEntityDetail.note}}</p>
								</div>
							</div>
							
						</ul>
					</div>
						<input class="btn btn-primary" style="margin-left: 20px;" type="button" value="返回" ng-click="closeWindowCheck();"></div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
