<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<div class="modal fade" id="AdministratorUpdModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">企业管理员维护</h4>
			</div>
			<div class="modal-body" style="text-align: center;">
				<form name="userForm" action="" method="post" id="form2"
					enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal" style="margin-top: 10px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">登录用户名：</label>
								<div class="col-xs-4" >
								    <input type="hidden" ng-model="updData.partyId">
								    <input type="text"  style="display:none"/>
									<input type="text" class="form-control" name="name" id="updId_"
										style="width: 90%; float: left;" ng-model="updData.loginId" maxlength="30" required ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/">
									<p class="form-control-static" style="color: red;">*</p>
								</div>
								<div class="col-xs-2">
									<button type="button" id="updBtn_" class="btn btn-primary" ng-click="queryLoginID(userForm)">查询</button>
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-4 col-xs-offset-2" ng-messages="userForm.name.$error" ng-show="showFlag == 'name'" class="help-block">
									<p class="form-control-static" style="color:red;" ng-message="required">请输入登陆用户名</p>
									<p class="form-control-static" style="color:red;" ng-message="maxlength">请输入字符在30个以内</p>
									<p class="form-control-static" style="color:red;" ng-message="pattern">只能是数字、汉字、字母</p>
								</div>								
							</div>	
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" >联系人姓名：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" ng-model="updData.name" style="margin-left:15px;">{{updData.name}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">移动电话：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" ng-model="updData.mobile" style="margin-left:15px;">{{updData.mobile}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">电子邮箱：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" ng-model="updData.email" style="margin-left:15px;">{{updData.email}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">企业名称：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" ng-model="updData.orgName" style="margin-left:15px;">{{updData.orgName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">详细描述：</label>
								<div class="col-xs-6">
									<textarea class="form-control" rows="3" ng-model="updData.note" maxlength="60" placeholder="请输入字符在60个以内" name="textareaName"  placeholder="请输入字符在60个以内"></textarea>
								</div>
								<div class="col-xs-4" ng-messages="userForm.textareaName.$error" ng-show="showFlag == 'textareaName'" style="margin-left:90px">
					                 <p class="form-control-static" style="color:red;" ng-message="maxlength">请输入字符在60个以内</p>
								</div>
							</div>
						</ul>
					</div>
					<input class="btn btn-primary" style="margin-left: 20px;"
						type="button" value="提交" ng-click="updAdmin(userForm);"> <input class="btn btn-primary"
						style="margin-left: 20px;" type="button" value="返回"
						data-dismiss="modal">
			</div>
			</form>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal -->
</div>
