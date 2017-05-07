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
<div class="modal fade" id="EmployeeState" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;margin-top:120px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">外部管理员信息维护</h4>
			</div>
		    <button type="button"  style="margin-left: 900px;margin-top:-45px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="text-align: center;">
				<form name="emForm" action="" method="post" id="form" enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal" style="margin-top: -20px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">登录用户名：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static">{{employeeEntityAdd.loginId}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">企业名称：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" >{{employeeEntityAdd.deptName}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">注册手机号码：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" >{{employeeEntityAdd.phoneNo}}</p><!-- employeeEntityAdd.mobile -->
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">注册电子邮箱：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" >{{employeeEntityAdd.mail}}</p><!-- employeeEntityAdd.mail -->
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">员工姓名：</label>
								<div class="col-xs-4" style="text-align: left;">
								<p class="form-control-static">{{employeeEntityAdd.name}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">员工编号：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static">{{employeeEntityAdd.code}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">联系手机号码：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static">{{employeeEntityAdd.mobile}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">QQ：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static">{{employeeEntityAdd.qq}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">联系电子邮箱：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" >{{employeeEntityAdd.email}}</p>
								</div>
							</div>
							<!-- <div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">所属企业：</label>
								<div class="col-xs-4" style="text-align: left;">
								<p class="form-control-static">{{employeeEntityAdd.deptName}}</p>
							    </div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">所属项目：</label>
								<div class="col-xs-4" style="text-align: left;">
								<p class="form-control-static">{{employeeEntityAdd.proName}}</p>
							    </div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">员工照片：</label>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label"></label>
								<div class="col-xs-4" ng-repeat="imageEntity in employeeEntityAdd.uploadFileInfo" style="text-align:left;">
									<img ng-show="imageEntity.uploadId != null" style="width: 80px; height: 80px;" ng-src="/File/Download/{{imageEntity.uploadId}}" class="img-rounded">
								</div>
							</div> -->
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">授权功能：</label>
								<div class="col-xs-6">
									<div class="col-xs-6" style="text-align: left;" ng-repeat="authorityEntity in employeeEntityAdd.funInfo">
										<p class="form-control-static" >{{authorityEntity.funNote}}</p>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">员工描述：</label>
								<div class="col-xs-6" style="text-align: left;">
									<p class="form-control-static" >{{employeeEntityAdd.note}}</p>
								</div>
							</div>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">员工状态：</label>
								<div class="col-xs-6" style="text-align: left;">
									<p class="form-control-static" >{{ct.codeTranslate(employeeEntityAdd.state,"PERSON_STATE")}}</p>
								</div>
							</div>
						</ul>
					</div>
					<input class="btn btn_Under btn-primary" style="margin-left: 20px;margin:0px 0px 5px" type="button" value="提交" ng-click="stateSubmit();">
					<input class="btn btn_Under btn-primary" style="margin-left: 20px;margin:0px 0px 5px" type="button" value="返回" ng-click="closeStateSubmit();">
			</div>
			</form>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- <script>
   $(function(){
      $(".dropdown-toggle").dropdown('toggle');
   }); 
   
   /*
    * 上传文件的地址栏改变 触发事件
   */
 </script> -->

<!-- /.modal -->
</div>
