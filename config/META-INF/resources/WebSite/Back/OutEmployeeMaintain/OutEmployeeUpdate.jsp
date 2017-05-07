<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<style type="text/css">
label {
	width: 100%;
}

#div2 {
	margin-left: -130px;
}

#div3 {
	margin-left: -280px;
}
</style>
<div class="modal fade" id="EmployeeUpdateId" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;margin-top:120px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">外部管理员信息维护</h4>
			</div>
			<button type="button"  style="margin-left: 900px;margin-top:-45px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="text-align: center;">
				<form name="emForm" action="" method="post" id="form" autocomplete="off"
					enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal" style="margin-top: -20px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">登录用户名：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control" id="updId_" ng-change="changeName();"
										style="width: 90%; float: left;" name="loginName"
										ng-model="employeeEntityAdd.loginId"  required maxlength="30"
										ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/">
									<input type="text"  style="display:none"/>
									<p class="form-control-static" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.loginName.$error"
										ng-show="showFlag == 'loginName'">
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="required">请输入登录用户名</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="maxlength">最多只能输入30字</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="pattern">只能是数字、汉字、字母</p>
									</div>
								</div>
								<div class="col-xs-4" style="  margin-left: -154px;margin-top: 8px;">
									<button type="button" id="updBtn" class="btn btn-primary" ng-disabled="queryBtnState"   ng-click="getAdministrator();">查询</button>
								</div>
							</div>
						<!-- 	<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">企业名称：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-left:10px">{{employeeEntityAdd.deptName}}</p>
								</div>
							</div> -->
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -3px;">企业名称：</label>
								<div class="col-xs-4" style="text-align:left;">
									<!-- <input  type="text" class="form-control" style="width: 90%; float: left;margin-top: 6px;"   ng-model="employeeEntityAdd.deptName"  maxlength="30"> -->
									<p   style="width: 90%; float: left;margin-top: 6px;" ng-if="employeeEntityAdd.deptName.length!=0">{{employeeEntityAdd.deptName}}</p>
									<p   style="width: 90%; float: left;margin-top: 6px;" ng-if="employeeEntityAdd.deptName.length==0">-</p>
								</div>
							</div>
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -3px">注册手机号码：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-left:10px;margin-top: 5px;" ng-if="employeeEntityAdd.phoneNo.length!=0">{{employeeEntityAdd.phoneNo}}</p>
									<p class="form-control-static" style="margin-left:10px;margin-top: 5px;" ng-if="employeeEntityAdd.phoneNo.length==0">-</p>
								</div>
							</div>
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top:-6px">注册电子邮箱：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static" style="margin-left:10px;margin-top: 1px;" ng-if="employeeEntityAdd.mail.length!=0">{{employeeEntityAdd.mail}}</p>
									<p class="form-control-static" style="margin-left:10px;margin-top: 1px;" ng-if="employeeEntityAdd.mail.length==0">-</p>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -6px;">员工姓名：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control" placeholder="请输入员工姓名"
										style="width: 90%; float: left;margin-top: 3px;"
										ng-model="employeeEntityAdd.name" name="name" required
										maxlength="20" ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/">
									<p class="form-control-static" style="color: red;margin-left:-70px;margin-top: 5px;">*</p>
									<div ng-messages="emForm.name.$error"
										ng-show="showFlag == 'name'">
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="required">请输入员工姓名</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="maxlength">最大长度是20</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="pattern">只能是数字、汉字、字母</p>
									</div>
								</div>
							</div>
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -5px;">员工编号：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control" placeholder="请输入员工编号"
										style="width: 90%; float: left;margin-top: 4px;"
										ng-model="employeeEntityAdd.code" name="code" required
										maxlength="30" ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/">
									<p class="form-control-static" style="color: red;margin-left:-70px;margin-top: 5px;">*</p>
									<div ng-messages="emForm.code.$error"
										ng-show="showFlag == 'code'">
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="required">请输入员工编号</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="maxlength">最大长度是30</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;"
											ng-message="pattern">员工编号不正确，请重新输入</p>
									</div>
								</div>
							</div>
							
						<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -4px;">联系手机号码：</label><!-- new -->
								<div class="col-xs-4" >
									<input type="text" class="form-control" name="telephone" required style="width: 90%; float: left;margin-top: 5px;" ng-minlength="11" maxlength="11" ng-pattern="/(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)/" ng-model="employeeEntityAdd.mobile">
									<p class="form-control-static" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.telephone.$error" ng-show="showFlag == 'telephone'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="required">请输入11位手机号码</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="pattern">请输入11位手机号码</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="minlength">请输入11位手机号码</p>
									</div>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -6px;">QQ：</label><!-- new -->
								<div class="col-xs-4" style="text-align:left;">
									<input type="text" class="form-control" name="qq" maxlength="15"  style="width: 90%; float: left;margin-top: 3px;" ng-pattern="/^[0-9]+$/" ng-model="employeeEntityAdd.qq">
									<label></label>
									<div ng-messages="emForm.qq.$error" style="margin-top: -21px;padding-bottom: 14px;" ng-show="showFlag == 'qq'">
										<p class="form-control-static" style="color: red;margin-left:55px;" ng-message="pattern">QQ号码格式不正确</p>
									</div>
								</div>
							</div>
							
					     <div class="form-group" style="    margin-top: -4px;">   
				           <label contenteditable="false" class="col-xs-2 control-label" style="margin-top:-21px;">联系电子邮箱：<font style="color: red;"></font></label>
								<div class="col-xs-4" style="margin-top:-18px;">
			                        <input type="text" style="width: 90%;margin-top: 6px;"  maxlength="30" class="form-control" id="electronicMailUpdOut" tabindex="1" 
			                        	   ng-pattern="/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/"
			                               autocomplete="off" node-type="electronicMailUpdOut" class="name" name="electronicMailUpdOut" ng-model="employeeEntityAdd.email" ng-blur="emailBlurUpd('electronicMailUpdOut');">
			                        <ul id="suggestUpdOut" style="z-index:10;margin-left:-4px;width:258px;">
										<li class="note">请选择邮箱类型</li>
										<li email="" class="item active"></li>
										<li email="@qq.com" class="item">@qq.com</li>        
										<li email="@163.com" class="item">@163.com</li>
										<li email="@gmail.com" class="item">@gmail.com</li>
										<li email="@foxmail.com" class="item">@foxmail.com</li>
										<li email="@sina.com" class="item">@sina.com</li>
										<li email="@sohu.com" class="item">@sohu.com</li>
								<!-- 		<li email="@gmail.com" class="item">@gmail.com</li>
										<li email="@sohu.com" class="item">@sohu.com</li>
										<li email="@yahoo.cn" class="item">@yahoo.cn</li>
										<li email="@139.com" class="item">@139.com</li>
										<li email="@wo.com.cn" class="item">@wo.com.cn</li>
										<li email="@189.cn" class="item">@189.cn</li> -->
									</ul>  
									<div  ng-messages="emForm.electronicMailUpdOut.$error" ng-show="showFlag == 'electronicMailUpdOut'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="pattern">邮箱格式有误,请重新输入!</p>
									 </div>	
		                        </div>
				         </div> 
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-sm-2 control-label">授权功能：</label>
							<div class="col-xs-7" style="text-align: left;margin-left:-14px;margin-top: -3px;">
									
							 			<div class="col-xs-6" style="margin: 11px 0px 0px 0px;">
											<table class="table table-hover" style="width:91%">
												<thead>
													<tr class="success">
														<th>功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.firstTr == true" ng-click="trClick(this);" style="z-index:8">
														<td>{{authorityEntity.note}}</td>
													</tr>
												</tbody>
											</table>
										</div>
								 		<div class="col-xs-6" style="margin-left:-50px;  margin-top: 11px;">
											<table class="table table-hover" >
												<thead>
													<tr class="success">
														<th>功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.secondTr == true" ng-click="trClick(this);" style="z-index:8">
														<td >{{authorityEntity.note}}</td>
													</tr>
												</tbody>
											</table>
										</div> 
								</div>
							</div> 
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="  margin-top: -23px;">备注：</label>
								<div class="col-xs-8" style="  margin-top: -17px;">
									 <textarea class="form-control" rows="3" name="note"
										maxlength="60" ng-model="employeeEntityAdd.note" placeholder="{{placeholders.note}}" style="margin-top: 5px;"
										> </textarea> 
										<!-- <textarea class="form-control" rows="3" name="note"
										maxlength="60" ng-model="employeeEntityAdd.note" placeholder="请输入字符在60个以内" style="margin-top: 5px;"
										></textarea> -->
								</div>
							</div>
						</ul>
					</div>
					<input class="btn_Under btn-primary" style="margin-left: 20px;margin: -6px 0px 4px 0px;" type="button" value="提交" ng-click="updateEmployeeEntity(emForm);">
					<input class="btn_Under btn-default" style="margin-left: 20px;margin: -6px 0px 4px 0px;border: 1.2px solid #ddd;" type="button" value="返回" ng-click="closeUpdateEmployee();">
				</form>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- <script>
	$(function() {
		$(".dropdown-toggle").dropdown('toggle');
	});

	/*
	 * 上传文件的地址栏改变 触发事件
	 */
</script> -->

<!-- /.modal -->
</div>
