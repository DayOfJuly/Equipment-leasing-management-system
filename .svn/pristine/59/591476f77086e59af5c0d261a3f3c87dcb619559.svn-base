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
			<div class="modal-header modal-header_test">
				<h4 class="modal-title modal-title_test">内部员工信息维护</h4>
			</div>
			<button type="button"  style="margin-left: 900px;margin-top:-45px;outline: none;" class="btn btn-link  " ng-click="closeAddEmployee();"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body modal-body_test" style="text-align: center;">
				<form name="emForm" action="" method="post" id="form" enctype="application/x-www-form-urlencoded" autocomplete="off">
				
					<div class="form-horizontal form-horizontal_" ><!-- 问题 -->
						<!-- <ul> -->
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-8px;">登录用户名：</label>
								<div class="col-xs-4">
									<input  type="text" class="form-control form-control_ form-control_test style_compact style_margin" 
									style="width: 90%; float: left;" id="addId" name="loginName" ng-model="employeeEntityAdd.loginId" required maxlength="30">
									<input type="text"  style="display:none"/>
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.loginName.$error" ng-show="showFlag == 'loginName'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="required">请输入登录用户名</p>
									</div>
								</div>
							 	<div class="col-xs-1" style="margin-left:-34px;">
									<button type="button" id="addBtn" class="btn btn_ btn-primary" ng-click="getAdministrator();">查询</button>
								</div> 
							</div>
							
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-6.5px;">注册手机号码：</label>
								<div class="col-xs-4" style="text-align:left;">
									<p class="form-control-static form-control-static_" style="margin-left:11px" ng-if="employeeEntityAdd.phoneNo.length == 0">-</p>
									<p class="form-control-static form-control-static_" style="margin-left:11px" ng-if="employeeEntityAdd.phoneNo.length != 0">{{employeeEntityAdd.phoneNo}}</p>
								</div>
							</div>
							
						 	<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-6.5px;">注册电子邮箱：</label>
								<div class="col-xs-4" style="text-align:left;">
									<p class="form-control-static form-control-static_" style="margin-left:11px" ng-if="employeeEntityAdd.mail.length!=0">{{employeeEntityAdd.mail}}</p>
									<p class="form-control-static form-control-static_" style="margin-left:11px" ng-if="employeeEntityAdd.mail.length==0">-</p>
								</div>
							</div>
							
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-8px;">员工姓名：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control form-control_ form-control_test"  style="width: 90%; float: left;margin-top:0px;" ng-model="employeeEntityAdd.name" name="name" required maxlength="20" ><!-- ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/" -->
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.name.$error" ng-show="showFlag == 'name'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="required">请输入员工姓名</p>
									</div>
								</div>
							</div>
							
					 		<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-8px;">员工编号：</label>
								<div class="col-xs-4">
									<input ng-blur="checkCodeFun();" id="CodeId" type="text" class="form-control form-control_ form-control_test"  style="width: 90%; float: left;margin-top:0px;" ng-model="employeeEntityAdd.code" name="code" required maxlength="30" ng-pattern="/^[a-zA-Z0-9]+$/">
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;margin-top:0px;">*</p>
									<div ng-messages="emForm.code.$error" ng-show="showFlag == 'code'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="required">请输入员工编号</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="pattern">员工编号不正确，请重新输入</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-show="codeFlag">员工编号不正确，请重新输入</p>
									</div>
								</div>
							</div> 
							
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-6px;">联系手机号码：</label><!-- new -->
								<div class="col-xs-4" style=" margin-top: 2px;">
									<input type="text" class="form-control form-control_ form-control_test" name="telephone" style="width: 90%; float: left;margin-top:0px;" ng-model="employeeEntityAdd.mobile" required ng-minlength="7" maxlength="20" ng-pattern="/(^[0-9,\-]{7,}$)/">
								
<!-- 									<input type="text" class="form-control form-control_ form-control_test" name="telephone" style="width: 90%; float: left;margin-top:0px;" ng-model="employeeEntityAdd.mobile" required ng-minlength="11" maxlength="11" ng-pattern="/(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)/"> -->
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.telephone.$error" ng-show="showFlag == 'telephone'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="required">请输入联系手机号码</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="pattern">请输入正确的格式</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="minlength">请至少输入7位</p>
									</div>
								</div>
							</div>
							
						 	<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-8px;">QQ：</label>
								<div class="col-xs-4" style="margin-top: -8px;">
									<input type="text" class="form-control form-control_ form-control_test" name="qq" maxlength="15" ng-model="employeeEntityAdd.qq"  
									style="width: 90%; float: left;" ng-pattern="/^[0-9]+$/">
									<div ng-messages="emForm.qq.$error" ng-show="showFlag == 'qq'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="pattern">QQ号码格式不正确</p>
									</div>
								</div>
							</div> 
							
				 		   <div class="form-group form-group_ style_margin">   
				                <label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-5px;">电子邮箱：<font style="color: red;"></font></label>
								<div class="col-xs-4" style="margin-top:-4px;">
			                        <input type="text" style="width: 90%;"  maxlength="30" class="form-control form-control_ form-control_test" id="electronicMail" tabindex="1" 
			                        	   ng-pattern="/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/"
			                               autocomplete="off" node-type="electronicMail" class="name" name="electronicMail" ng-model="formParms.electronicMail" 
			                               ng-blur="emailBlur('electronicMail');">
			                        <ul id="suggest" style="z-index:10;margin-left:-4px;width:259px;">
										<li class="note">请选择邮箱类型</li>
										<li email="" class="item active"></li>
										<li email="@qq.com" class="item">@qq.com</li>        
										<li email="@163.com" class="item">@163.com</li>
										<li email="@gmail.com" class="item">@gmail.com</li>
										<li email="@foxmail.com" class="item">@foxmail.com</li>
										<li email="@sina.com" class="item">@sina.com</li>
										<li email="@sohu.com" class="item">@sohu.com</li>
									</ul> 
									<div   ng-messages="emForm.electronicMail.$error" ng-show="showFlag == 'electronicMail'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="pattern">邮箱格式有误,请重新输入!</p>
									</div> 
		                        </div>
		                   
				         </div>  
				      
							
						 	<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-5px;">所属企业：</label>
								<div class="col-xs-4" style="text-align:left;">
									<!-- <p class="form-control-static form-control-static_" style="margin-left:11px;width: 87%;">{{employeeEntityAdd.orgName}}</p> -->
									<select id="dept" class="form-control form-control_ form-control_test select-hover"  ng-model="employeeEntityAdd.deptId" 
						        	style="width:81.5%;position: absolute;z-index:3;" ng-options="r.currOrgId as r.name for r in nextArray" ng-change="change(employeeEntityAdd.deptId,r);">
<!-- 					                    <option value="">请选择</option> -->
									</select>
								</div>                                                        
							</div> 
								
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-9px;">所属项目：</label>
								<div class="col-xs-4" style="margin-top:-6px;">
						        	<select class="form-control form-control_ form-control_test select-hover"  ng-model="employeeEntityAdd.proId" 
						        	style="width:81.5%;position: absolute;z-index:3;">
					                    <option value="">请选择</option>
					                    <option value="{{p.currOrgId}}" ng-repeat="p in proListCopy" title="{{p.name}}">{{p.nameCopy}}</option>
									</select>
								</div> 
							</div> 
							
							<div class="form-group form-group_ style_margin" >
							    <label  contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:1.3px;">员工照片：</label>
								<div class="col-xs-1">
									<input id="fileUpLoadId" ng-repeat="p in picBtnJudgeList" type="file" ng-file-select="onFileSelect($files)" style="display: none">
									<div class="input-group">
										<input type="hidden" readonly class="form-control form-control_ form-control_test" ng-model="employeeEntityAdd.equipmentPic" name="equipmentPic" > 
										<span class="input-group-btn" >
									   <!-- <button  ng-if="PListLength!=2" class="btn btn_ btn-primary" style="margin:9px 0px 0px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
											<button  ng-if="PListLength==2" ng-disabled="true" class="btn btn_" style="margin:9px 0px 0px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button> -->
											<button  ng-if="PListLength==0" class="btn btn_ btn-primary" style="margin:9px 0px 9px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
											<button  ng-if="PListLength==2" ng-disabled="true" class="btn btn_" style="margin:9px 0px 0px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
											<button  ng-if="PListLength==1" class="btn btn_ btn-primary" style="margin:9px 0px 0px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
										</span>
									</div>
								</div>
						  	</div>	
						  	<!-- 图片显示   -->
						  	 <div class="form-group form-group_ style_margin">
			                    <label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-9.2px;"></label>
			                    <div style="margin-left:156px;width:120%;margin-top:8px;">
			                    	<div ng-repeat="t in PicList">
				                        <div class="col-xs-2" style="margin:0px;" >
				                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="removePicAdd($index,t);">&times;</button>
				                            <div id="element_id">
					                            <a href="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" class="thumbnail">
					                                <img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" alt="" style="width: 300px;height: 130px;" ng-init="createLightBox();"/> 
					                                <input type="hidden" id="delPicNum" name="delPicNum" ng-model="delPicNum" class="form-control form-control_ form-control_test" >
					                            </a>
				                            </div>
				                        </div>
			                    	</div>
			                    </div>
				          	</div> 
			<!-- 			 	<div class="form-group style_margin">
								<label contenteditable="false" class="col-sm-2 control-label">授权功能：</label>
								<div class="col-xs-7 " style="text-align: left;">
							 			<div class="col-xs-6">
											<table class="table table-hover table_test" >
												<thead>
													<tr class="success style_compact">
														<th style="text-align: center;">选择</th>
														<th style="text-align: center;">功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr class="style_compact" ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.firstTr == true" ng-click="trClick(this);">
														<td style="width:50px;text-align: center;"><input type="checkbox" ng-model="authorityEntity.chck" ng-click="trClick(this);" ng-ckecked="authorityEntity.chck"></td>
														<td style="text-align: center;">{{authorityEntity.note}}</td>
													</tr>
												</tbody>
											</table>
										</div>
										
								 		<div class="col-xs-6 " style="margin-left:-50px;">
											<table class="table table-hover table_test">
												<thead>
													<tr class="success style_compact">
														<th style="text-align: center;">选择</th>
														<th style="text-align: center;">功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr class="style_compact" ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.secondTr == true" ng-click="trClick(this);">
														<td style="width:50px;text-align: center;"><input type="checkbox" ng-model="authorityEntity.chck" ng-click="trClick(this);" ng-ckecked="authorityEntity.chck"></td>
														<td style="text-align: center;" title="{{authorityEntity.note}}">{{authorityEntity.showName}}</td>
													</tr>
												</tbody>
											</table>
										</div> 
								</div>
								<div class="col-xs-1">
										<input type="button" class="btn btn-primary " id="allSelectAdd" value="全选" ng-click="selectAllboxAdd('authorityListTemp');"/>
								</div>
							</div>  -->
							
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-sm-2 control-label control-label_" style="margin-top:-24.6px;">授权功能：</label>
								<div class="col-xs-7 " style="text-align: left;margin-top:-14px;">
							 			<div class="col-xs-6">
											<table class="table table-hover table_test" >
												<thead>
													<tr class="success style_compact">
														<th style="text-align: center;">选择</th>
														<th style="text-align: center;">功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr class="style_compact" ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.firstTr == true" ng-click="trClick(this);">
														<td style="width:50px;text-align: center;" ng-show="authorityEntity.showFlag"><input type="checkbox" ng-model="authorityEntity.chck" ng-click="trClick(this);" ng-ckecked="authorityEntity.chck"></td>
														<td style="text-align: center;" ng-show="authorityEntity.showFlag">{{authorityEntity.note}}</td>
													</tr>
												</tbody>
											</table>
										</div>
										
								 		<div class="col-xs-6 " style="margin-left:-50px;">
											<table class="table table-hover table_test">
												<thead>
													<tr class="success style_compact">
														<th style="text-align: center;">选择</th>
														<th style="text-align: center;">功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr class="style_compact" ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.secondTr == true" ng-click="trClick(this);">
														<td style="width:50px;text-align: center;" ng-show="authorityEntity.showFlag"><input type="checkbox" ng-model="authorityEntity.chck" ng-click="trClick(this);" ng-ckecked="authorityEntity.chck"></td>
														<td style="text-align: center;" title="{{authorityEntity.note}}" ng-show="authorityEntity.showFlag">{{authorityEntity.showName}}</td>
													</tr>
												</tbody>
											</table>
										</div> 
								</div>
								<div class="col-xs-1" style="margin-left:-90px;margin-top:-15px;">
										<input type="button" class="btn btn_ btn-primary " id="allSelectAdd" value="全选" ng-click="selectAllboxAdd('authorityListTemp');"/>
								</div>
							</div> 
							
							
							<div class="form-group form-group_ style_margin" ng-if="showManageFlag">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-10px;">管理员权限：</label>
								<div class="col-xs-1" style="margin-top:8px;bottom: 10px;left: 12px;">
									<input type="checkbox" style="margin-left:8px" ng-model="employeeEntityAdd.admFlag" ng-true-value="1" ng-false-value="0"/>
									<p style="margin-top: -22px;margin-left: 40px;">是</p>
								</div>
							</div>
							
					     	<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-26.2px;">员工描述：</label>
								<div class="col-xs-8 " style="margin-top:-22px;">
 									<textarea class="form-control control-label_ form-control_test" rows="3" maxlength="60" ng-model="employeeEntityAdd.note" placeholder="{{placeholders.note}}"> </textarea>
								    <!-- <textarea class="form-control control-label_ form-control_test" rows="3" maxlength="60" ng-model="employeeEntityAdd.note" placeholder="请输入字符在60个以内"></textarea> -->
								</div>
							</div> 
							
						<!-- </ul> -->
					</div>
					<input class="btn_Under btn-primary" style="margin-left: 20px;margin:4px;" type="button" value="提交" ng-click="addEmployeeEntity(emForm);">
					<input class="btn_Under btn-default" style="margin-left: 20px;margin:4px;border: 1.2px solid #ddd;" type="button" value="返回" ng-click="closeAddEmployee();">
			 </form>
		   </div>			
		</div>
	</div>
</div>
