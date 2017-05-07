<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<div class="modal fade" id="AdministratorQueModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
		
			<div class="modal-header">
				<h4 class="modal-title">企业管理员维护</h4>
			</div>
			
			<div class="modal-body" style="text-align: center;">
				<form name="form" action="" method="post" id="form2" enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal" style="margin-top: 10px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">登录用户名：</label>
								<div class="col-xs-4" >
									<p class="form-control-static" align="left">{{updData.loginId}}</p>
								</div>
								
							</div>
							 
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">联系人姓名：</label>
								<div class="col-xs-4">
									<p class="form-control-static" align="left">{{updData.name}}</p>
								</div>
							</div>
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">移动电话：</label>
								<div class="col-xs-4">
									<p class="form-control-static" align="left">{{updData.mobile}}</p>
								</div>
							</div>
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">电子邮箱：</label>
									<div class="col-xs-4">
									<p class="form-control-static" align="left">{{updData.email}}</p>
								</div>
							</div>
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">企业名称：</label>
								<div class="col-xs-4">
									<p class="form-control-static" align="left">{{updData.orgName}}</p>
								</div>
							</div>
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">详细描述：</label>
								<div class="col-xs-6">
									<p class="form-control-static" align="left">{{updData.note}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">状态：</label>
								<div class="col-xs-6">
									<p class="form-control-static" align="left">{{updData.state==1?"停用":"启用"}}</p>
								</div>
							</div>
						</ul>
					</div>
					 <input class="btn btn-primary" style="margin-left: 20px;" type="button" value="返回" ng-click="closeWindow()" />
			</form>
          </div>
          	
		  <div class="modal-footer"></div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal -->
