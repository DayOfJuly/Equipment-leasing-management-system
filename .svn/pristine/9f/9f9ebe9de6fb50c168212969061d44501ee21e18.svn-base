<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<style type="text/css">
label {
width: 100%;
}
#div2{
margin-left: -130px;
}
#div3{
margin-left: -280px;
}
</style>
<div class="modal fade" id="EmployeeDetailId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;margin-top:160px;">
		<div class="modal-content">
		 	<div class="modal-header">
				<h4 class="modal-title">内部员工信息维护</h4>
			</div> 
 			<button type="button"  style="margin-left: 900px;margin-top:-45px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="text-align: center;">
				<form name="emForm" action="" method="post" id="form" enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal" style="margin-top: -20px;">
						<ul>
							<div class="form-group" style="margin-top: -3%;">
								<label contenteditable="false" class="col-xs-2 control-label">登录用户名：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static">{{employeeEntityAdd.loginId}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">注册手机号码：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.phoneNo}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">注册电子邮箱：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.mail}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">员工姓名：</label>
								<div class="col-xs-4" style="text-align: left;">
								<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.name}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">员工编号：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.code}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">联系手机号码：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.mobile}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">QQ：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.qq}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1%;">联系电子邮箱：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.email}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">所属企业：</label>
								<div class="col-xs-4" style="text-align: left;">
								<p class="form-control-static" style="margin-top:-2%;width: 87%;">{{employeeEntityAdd.deptName}}</p>
							    </div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">所属项目：</label>
								<div class="col-xs-4" style="text-align: left;">
								<p class="form-control-static" style="margin-top:-2%;">{{employeeEntityAdd.proName}}</p>
							    </div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.3%;">员工照片：</label>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label"></label>
								<div class="col-xs-4" ng-repeat="imageEntity in employeeEntityAdd.uploadFileInfo" style="text-align:left;width: 99px;">
									<img ng-show="imageEntity.uploadId != null" style="width: 80px; height: 80px;margin-top: -17px;margin-left:1px;" ng-src="/Picture/{{imageEntity.picName}}/{{imageEntity.picType}}" class="img-rounded">
								</div>
							</div>
							<div class="form-group" style="margin-top: 24px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -2.5%;">授权功能：</label>
								<div class="col-xs-6" style="margin-top:-1.4%">
									<div class="col-xs-6" ng-repeat="authorityEntity in employeeEntityAdd.funInfo" style="margin-left: -4%;margin-top: -2.6%;">
										<p class="form-control-static" style="text-align: left;margin-top:5%;" >{{authorityEntity.funNote}}</p>
									</div>
								</div>
							</div>
							<div class="form-group" ng-if="employeeEntityAdd.admFlag == 1">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">管理员权限：</label>
								<div class="col-xs-6" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-1.4%;">是</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">员工描述：</label>
								<div class="col-xs-6" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-1.4%;">{{employeeEntityAdd.note}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -1.4%;">员工状态：</label>
								<div class="col-xs-6" style="text-align: left;">
									<p class="form-control-static" style="margin-top:-1.4%;">{{ct.codeTranslate(employeeEntityAdd.state,"PERSON_STATE")}}</p>
								</div>
							</div>
						</ul>
					</div>
					<input class="btn_Under btn-default" style="margin:0px 0px 5px;border: 1.2px solid #ddd;" type="button" value="返回" ng-click="closeCheckEmployee();">
				</form>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<script>
/*    $(function(){
      $(".dropdown-toggle").dropdown('toggle');
   });  */
   
   /*
    * 上传文件的地址栏改变 触发事件
   */
 </script>

<!-- /.modal -->
</div>
