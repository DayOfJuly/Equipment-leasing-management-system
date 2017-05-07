<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>
<link href="../../../media/css/emailstyle.css" rel="stylesheet"> 
<script type="text/javascript" src="/media/js/emailstylejs.js"></script>


<script type="text/javascript">

	$('#element_id  a').lightBox({maxWidth:500,maxHeight:500}); 
	
	$('#element_id2  a').lightBox({maxWidth:500,maxHeight:500}); 
    
</script>
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
<div class="modal fade" id="EmployeeAddId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;margin-top:120px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">外部管理员信息维护</h4>
			</div>
		    <button type="button"  style="margin-left: 900px;margin-top:-45px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="text-align: center;">
				<form name="emForm" action="" method="post" id="form" enctype="application/x-www-form-urlencoded" autocomplete="off">
					<div class="form-horizontal" style="margin-top: -20px;">
						<ul>
							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">登录用户名：</label>
								<div class="col-xs-4">
									<input  type="text" class="form-control" style="width: 90%; float: left;" id="addId" name="loginName" ng-model="employeeEntityAdd.loginId" required maxlength="30">
									<input type="text"  style="display:none"/>
									<p class="form-control-static" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.loginName.$error" ng-show="showFlag == 'loginName'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="required">请输入登录用户名</p>
									<!-- 	<p class="form-control-static" style="color: red;" ng-message="pattern">只能是数字、汉字、字母   ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/"</p> -->
									</div>
								</div>
								<div class="col-xs-1" style="margin-left:-34px;  margin-top: 8px;">
									<button type="button" id="addBtn" class="btn btn_ btn-primary" ng-click="getAdministrator();">查询</button>
								</div> 
							</div>
							
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -3px;">企业名称：</label>
								<div class="col-xs-4" style="text-align:left;">
									<!-- <input  type="text" class="form-control" style="width: 90%; float: left;margin-top: 6px;"   ng-model="employeeEntityAdd.orgName"  maxlength="30"> -->
									<p   style="width: 90%; float: left;margin-top: 6px;margin-left: 11px;" ng-if="employeeEntityAdd.orgName.length!=0">{{employeeEntityAdd.orgName}}</p>
									<p   style="width: 90%; float: left;margin-top: 6px;margin-left: 11px;" ng-if="employeeEntityAdd.orgName.length==0">-</p>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -4px;">注册手机号码：</label>
								<div class="col-xs-4" style="text-align:left;">
									<p  style="margin-left:11px;margin-top: 5px;" ng-if="employeeEntityAdd.phoneNo.length!=0">{{employeeEntityAdd.phoneNo}}</p>
									<p  style="margin-left:11px;margin-top: 5px;" ng-if="employeeEntityAdd.phoneNo.length==0">-</p>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -7px;">注册电子邮箱：</label>
								<div class="col-xs-4" style="text-align:left;">
									<p  style="margin-left:11px;margin-top: 1px;"ng-if="employeeEntityAdd.mail.length!=0">{{employeeEntityAdd.mail}}</p>
									<p  style="margin-left:11px;margin-top: 1px;"ng-if="employeeEntityAdd.mail.length==0">-</p>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -6px;">员工姓名：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control"  style="width: 90%; float: left;margin-top: 3px;" ng-model="employeeEntityAdd.name" name="name" required maxlength="20" ><!-- ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/" -->
									<p class="form-control-static" style="color: red;margin-left:-70px;margin-top: 3px;">*</p>
									<div ng-messages="emForm.name.$error" ng-show="showFlag == 'name'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="required">请输入员工姓名</p>
									</div>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -3px;">员工编号：</label>
								<div class="col-xs-4">
									<input ng-blur="checkCodeFun();" id="CodeId" type="text" class="form-control"  style="width: 90%; float: left;margin-top: 6px;" ng-model="employeeEntityAdd.code" name="code" required maxlength="30" ng-pattern="/^[a-zA-Z0-9]+$/">
									<p class="form-control-static" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.code.$error" ng-show="showFlag == 'code'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="required">请输入员工编号</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="pattern">员工编号不正确，请重新输入</p>
									</div>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -5px;">联系手机号码：</label><!-- new -->
								<div class="col-xs-4" >
									<input type="text" class="form-control" name="telephone" style="width: 90%; float: left;margin-top: 4px;" ng-model="employeeEntityAdd.mobile" required ng-minlength="7" maxlength="20" ng-pattern="/(^[0-9,\-]{7,}$)/">
									<p class="form-control-static" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.telephone.$error" ng-show="showFlag == 'telephone'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="required">请输入联系手机号码</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="pattern">请输入正确的格式</p>
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="minlength">请至少输入7位</p>
									</div>
								</div>
							</div>
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="margin-top: -7px;">QQ：</label><!-- new -->
								<div class="col-xs-4">
									<input type="text" class="form-control" name="qq" maxlength="15" ng-model="employeeEntityAdd.qq"  style="width: 90%; float: left;margin-top: 2px;" ng-pattern="/^[0-9]+$/">
									<label></label>
									<div ng-messages="emForm.qq.$error" style="margin-top: -21px;padding-bottom: 14px;" ng-show="showFlag == 'qq'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="pattern">QQ号码格式不正确</p>
									</div>
								</div>
							</div>
							
				 		   <div class="form-group" style="    margin-top: -4px;">   
				                <label contenteditable="false" class="col-xs-2 control-label" style="margin-top:-21px;">联系电子邮箱：<font style="color: red;"></font></label>
								<div class="col-xs-4" style="margin-top:-18px;">
			                        <input type="text" style="width: 90%;margin-top: 6px;"  maxlength="30" class="form-control" id="electronicMail" tabindex="1" 
			                        	   ng-pattern="/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/"
			                               autocomplete="off" node-type="electronicMail" class="name" name="electronicMail" ng-model="formParms.electronicMail"  ng-blur="emailBlur('electronicMail');">
			                        <ul id="suggest" style="z-index:10;margin-left:-4px;width:258px;">
										<li class="note">请选择邮箱类型</li>
										<li email="" class="item active"></li>
										<li email="@qq.com" class="item">@qq.com</li>        
										<li email="@163.com" class="item">@163.com</li>
										<li email="@gmail.com" class="item">@gmail.com</li>
										<li email="@foxmail.com" class="item">@foxmail.com</li>
										<li email="@sina.com" class="item">@sina.com</li>
										<li email="@sohu.com" class="item">@sohu.com</li>
									</ul> 
									<div  ng-messages="emForm.electronicMail.$error" ng-show="showFlag == 'electronicMail'">
										<p class="form-control-static" style="color: red;margin-left:-50px;" ng-message="pattern">邮箱格式有误,请重新输入!</p>
									</div> 
		                        </div>
								
				         </div>  
				          	
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-sm-2 control-label" style="margin-top: -3px;">授权功能：</label>
								<div class="col-xs-7" style="text-align: left;margin-left:-14px;margin-top: -3px;">
									
							 			<div class="col-xs-6" style="margin: 11px 0px 0px 0px;">
											<table class="table table-hover" style="width: 91%;">
												<thead>
													<tr class="success">
														<th>功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.firstTr == true" ng-click="trClick(this);">
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
													<tr ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.secondTr == true" ng-click="trClick(this);">
														<td >{{authorityEntity.note}}</td>
													</tr>
												</tbody>
											</table>
										</div> 
								</div>
							</div> 
							
							<div class="form-group" style="    margin-top: -4px;">
								<label contenteditable="false" class="col-xs-2 control-label" style="  margin-top: -23px;">备注：</label>
								<div class="col-xs-8" style="  margin-top: -20px;">
									<textarea class="form-control" rows="3" maxlength="60" ng-model="employeeEntityAdd.note" placeholder="{{placeholders.note}}"> </textarea>
 									<!-- <textarea class="form-control" rows="3" maxlength="60" ng-model="employeeEntityAdd.note" placeholder="请输入字符在60个以内"></textarea> -->
								</div>
							</div>
							
				 	 
							
						</ul>
					</div>
					<input class="btn_Under btn-primary" style="margin-left: 20px;margin: -6px 0px 4px 0px;" type="button" value="提交" ng-click="addEmployeeEntity(emForm);">
					<input class="btn_Under btn-default" style="margin-left: 20px;margin: -6px 0px 4px 0px;border: 1.2px solid #ddd;" type="button" value="返回" ng-click="closeAddEmployee();">
			 </form>
		   </div>			
		</div>
	</div>
</div>
