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
				<h4 class="modal-title">内部员工信息维护</h4>
			</div>
			<button type="button"  style="margin-left: 900px;margin-top:-45px;outline: none;" class="btn btn-link  " ng-click="closeUpdateEmployee();" ><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="text-align: center;">
				<form name="emForm" action="" method="post" id="form" autocomplete="off"
					enctype="application/x-www-form-urlencoded">
					<div class="form-horizontal form-horizontal_">
						<!-- <ul> -->
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-10px;">登录用户名：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control form-control_ form-control_test style_compact style_margin" id="updId_" ng-change="changeName();"
										style="width: 90%; float: left;" name="loginName"
										ng-model="employeeEntityAdd.loginId"  required maxlength="30"
										ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/" ng-disabled="true">
									<input type="text"  style="display:none"/>
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.loginName.$error"
										ng-show="showFlag == 'loginName'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;"
											ng-message="required">请输入登录用户名</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;"
											ng-message="maxlength">最多只能输入30字</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;"
											ng-message="pattern">只能是数字、汉字、字母</p>
									</div>
								</div>
								<div class="col-xs-1" style="margin-left:-34px;">
									<button type="button" id="updBtn" class="btn btn_ btn-primary"  ng-disabled="queryBtnState" ng-click="getAdministrator();">查询</button>
								</div>
							</div>
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-6.5px;">注册手机号码：</label>
								<div class="col-xs-4" style="text-align:left;">
									<p class="form-control-static form-control-static_" style="margin-left:11px" ng-if="employeeEntityAdd.phoneNo.length!=0">{{employeeEntityAdd.phoneNo}}</p>
									<p class="form-control-static form-control-static_" style="margin-left:11px" ng-if="employeeEntityAdd.phoneNo.length==0">-</p>
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
							<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-9px;">员工姓名：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control form-control_ form-control_test" placeholder="请输入员工姓名"
										style="width: 90%; float: left;margin-top:0px;"
										ng-model="employeeEntityAdd.name" name="name" required
										maxlength="20" ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/">
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.name.$error"
										ng-show="showFlag == 'name'">
									     <p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;"
									    	 ng-message="required">请输入员工姓名</p>
										 <p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;"
											ng-message="maxlength">最大长度是20</p>
										 <p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;"
											ng-message="pattern">员工编号不正确，请重新输入</p>
									</div>
								</div>
							</div>
				 			<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-9px;">员工编号：</label>
								<div class="col-xs-4">
									<input type="text" class="form-control form-control_ form-control_test"  style="width: 90%; float: left;margin-top:0px;" placeholder="请输入员工编号"
										ng-model="employeeEntityAdd.code" name="code" required
										maxlength="30" ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/">
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;margin-top:0px;">*</p>
									<div ng-messages="emForm.code.$error"
										ng-show="showFlag == 'code'">
										<p class="form-control-static form-control-static_"  style="color: red;margin-left:-50px;"
											ng-message="required">请输入员工编号</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;"
											ng-message="maxlength">最大长度是30</p>
										<p class="form-control-static form-control-static_"  style="color: red;margin-left:-50px;"
											ng-message="pattern">只能是数字、汉字、字母</p>
									</div>
								</div>
							</div>
							
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-6px;">联系手机号码：</label><!-- new -->
								<div class="col-xs-4" style=" margin-top: 2px;">
									<input type="text" class="form-control form-control_ form-control_test" name="telephone" required style="width: 90%; float: left;margin-top:0px;" ng-minlength="7" maxlength="20" ng-pattern="/(^[0-9,\-]{7,}$)/" ng-model="employeeEntityAdd.mobile">
									<p class="form-control-static form-control-static_" style="color: red;margin-left:-70px;">*</p>
									<div ng-messages="emForm.telephone.$error" ng-show="showFlag == 'telephone'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="required">请输入11位手机号码</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="pattern">请输入正确的格式</p>
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="minlength">请至少输入7位</p>
									</div>
								</div>
							</div>
							
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-9px;">QQ：</label><!-- new -->
								<div class="col-xs-4" style="  margin-top: -8px;">
									<input type="text" class="form-control form-control_ form-control_test" name="qq" maxlength="15"  
									style="width: 90%; float: left;" ng-model="employeeEntityAdd.qq">
									<label></label>
									<div ng-messages="emForm.qq.$error" ng-show="showFlag == 'qq'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="pattern">QQ号码格式不正确</p>
									</div>
								</div>
							</div>
							
<!-- 							<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label">联系电子邮箱：</label>new
								<div class="col-xs-4" style="text-align:left;">
									<input type="text" class="form-control"  style="width: 90%; float: left;" ng-model="employeeEntityAdd.email">
								</div>
							</div>
 -->							
						 <div class="form-group form-group_ style_margin">   
				                <label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-25px;">电子邮箱：<font style="color: red;"></font></label>
								<div class="col-xs-4" style="margin-top: -24px;">
			                        <input type="text" style="width: 90%;"  maxlength="30" class="form-control form-control_ form-control_test" id="electronicMailUpd" tabindex="1" 
			                        	   ng-pattern="/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/"
			                               autocomplete="off" node-type="electronicMailUpd" class="name" name="electronicMailUpd" ng-model="employeeEntityAdd.email" 
			                               ng-blur="emailBlurUpd('electronicMailUpd');">
			                        <ul id="suggestUpd" style="z-index:10;margin-left:-4px;width:259px;">
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
									<div  ng-messages="emForm.electronicMailUpd.$error" ng-show="showFlag == 'electronicMailUpd'">
										<p class="form-control-static form-control-static_" style="color: red;margin-left:-50px;" ng-message="pattern">邮箱格式有误,请重新输入!</p>
									 </div>	
		                        </div>
				         </div>  
						
							
						 	<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-5px;">所属企业：</label>
								<div class="col-xs-4" style="text-align: left;">
									<p class="form-control-static form-control-static_" style="margin-left:11px;width: 87%;">{{employeeEntityAdd.deptName}}</p>
								</div>
							</div>
							<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-8px;">所属项目：</label>
								<div class="col-xs-4" style="margin-top:-6px;">
						        	<select class="form-control form-control_ form-control_test select-hover" ng-model="employeeEntityAdd.proId" 
						        	style="width:81.5%;position: absolute;z-index:3;">
										<option value="">请选择</option>
					                    <option value="{{p.currOrgId}}" ng-selected="{{p.currOrgId==employeeEntityAdd.proId}}" ng-repeat="p in proListCopy" title="{{p.name}}">{{p.nameCopy}}</option>
									</select>
								</div> 
							</div>  
							
							<div class="form-group form-group_ style_margin" >
							    <label  contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:1.3px;">员工照片：</label>
							    <div class="col-xs-1">
									<input id="updFileUpLoadId" type="file"
										ng-file-select="onFileSelect($files,'uploadId')"
										style="display: none">
									<div class="input-group">
								    <!--<div class="col-xs-4" style="text-align: left;">
											<button ng-if="PListLength &lt; 2"  ng-disabled="PListLength &gt;= 2" class="btn btn-primary"  type="button" ng-click="upLoadBtn('updFileUpLoadId');" >点击上传</button>
											<button ng-if="PListLength==2" ng-disabled="true" class="btn"  type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
										</div> -->
										<span class="input-group-btn" >
										<!-- 	<button ng-if="PListLength &lt; 2"  ng-disabled="PListLength &gt;= 2" class="btn btn-primary"  type="button" ng-click="upLoadBtn('updFileUpLoadId');" >点击上传</button>
											<button ng-if="PListLength==2" ng-disabled="true" class="btn"  type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button> -->
											
											<button  ng-if="PListLength==0" class="btn btn_ btn-primary" style="margin:9px 0px 9px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
											<button  ng-if="PListLength==2" ng-disabled="true" class="btn btn_" style="margin:9px 0px 0px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
											<button  ng-if="PListLength==1" class="btn btn_ btn-primary" style="margin:9px 0px 0px 0px;" type="button" ng-click="upLoadBtn('fileUpLoadId');" >点击上传</button>
										</span>
									</div>
								</div>
							</div>
		<!-- 					<div class="form-group">
								<label contenteditable="false" class="col-xs-2 control-label"></label>
								<div ng-repeat="imageEntity in employeeEntityAdd.uploadFileInfo">
			                        <div class="col-xs-2">
			                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="deletePic($index,imageEntity,1);">&times;</button>
			                            <div id="element_id">
				                            <a href="/Picture/{{imageEntity.picName}}/{{imageEntity.picType}}" class="thumbnail">
											<img ng-src="/Picture/{{imageEntity.picName}}/{{imageEntity.picType}}" alt="" style="width: 300px;height: 130px;" ng-init="createLightBox();"/> 
										</a>
			                            </div>
			                        </div>
			                   </div>
			                   <div ng-repeat="t in PicList">
			                        <div class="col-xs-2">
			                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="removePic($index,t,2);">&times;</button>
			                            <div id="element_id">
				                            <a href="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" class="thumbnail">
				                                <img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" alt="" style="width: 300px;height: 130px;" ng-init="createLightBox();"/> 
				                                <input type="hidden" id="delPicNum" name="delPicNum" ng-model="delPicNum" class="form-control" >
				                            </a>
			                            </div>
			                        </div>
			                   </div>
							</div> -->
							
							<div class="form-group form-group_ style_margin" >
								 <label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-9.2px;"></label>
								<div style="margin-left:156px;width:120%;margin-top:8px;">
									<div ng-repeat="imageEntity in employeeEntityAdd.uploadFileInfo">
				                        <div class="col-xs-2">
				                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="deletePic($index,imageEntity,1);">&times;</button>
				                            <div id="element_id">
					                            <a href="/Picture/{{imageEntity.picName}}/{{imageEntity.picType}}" class="thumbnail">
													<img ng-src="/Picture/{{imageEntity.picName}}/{{imageEntity.picType}}" alt="" style="width: 300px;height: 130px;" ng-init="createLightBox();"/> 
												</a>
				                            </div>
				                        </div>
				                   </div>
			                   </div>
			                   <div style="margin-left:156px;width:120%;margin-top:8px;">
				                   <div ng-repeat="t in PicList">
				                        <div class="col-xs-2">
				                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="removePic($index,t,2);">&times;</button>
				                            <div id="element_id">
					                            <a href="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" class="thumbnail">
					                                <img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" alt="" style="width: 300px;height: 130px;" ng-init="createLightBox();"/> 
					                                <input type="hidden" id="delPicNum" name="delPicNum" ng-model="delPicNum" class="form-control" >
					                            </a>
				                            </div>
				                        </div>
				                   </div>
			                   </div>
							</div>
							
							
						<div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-sm-2 control-label control-label_" style="margin-top:-24.6px;">授权功能：</label>
								<div class="col-xs-7 " style="text-align: left;margin-top:-14px;">
									<!-- 	<label class="checkbox-inline" style="text-align: left;height: 47px;width:40%" ng-repeat="authorityEntity in authorityListTemp">
											<input type="checkbox"  ng-model="authorityEntity.chck"> {{authorityEntity.note}}
										</label> --> 
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
														<td style="width:50px;text-align: center;" ng-show="authorityEntity.showFlag"><input type="checkbox" ng-model="authorityEntity.chck" ng-ckecked="authorityEntity.chck" ng-click="trClick(this);"></td>
														<td style="text-align: center;" ng-show="authorityEntity.showFlag">{{authorityEntity.note}}</td>
													</tr>
												</tbody>
											</table>
										</div>
										
								 		<div class="col-xs-6" style="margin-left:-50px;">
											<table class="table table-hover table_test" >
												<thead>
													<tr class="success style_compact">
														<th style="text-align: center;">选择</th>
														<th style="text-align: center;">功能名称</th>
													</tr>
												</thead>
												<tbody>
													<tr class="style_compact" ng-repeat="authorityEntity in authorityListTemp" ng-if="authorityEntity.secondTr == true" ng-click="trClick(this);">
														<td style="width:50px;text-align: center;" ng-show="authorityEntity.showFlag"><input type="checkbox" ng-model="authorityEntity.chck" ng-ckecked="authorityEntity.chck" ng-click="trClick(this);"></td>
														<td style="text-align: center;" title="{{authorityEntity.note}}" ng-show="authorityEntity.showFlag">{{authorityEntity.note}}</td>
													</tr>
												</tbody>
											</table>
										</div> 
								</div>
							 	<div class="col-xs-1" style="margin-left:-90px;margin-top:-15px;">
										<input type="button" class="btn btn_ btn-primary " id="allSelectUpd" value="全选" ng-click="selectAllboxUpd('authorityListTemp');"/>
								</div> 
							</div> 
							
							
							
							
							
						 	<div class="form-group form-group_ style_margin" ng-if="showManageFlag">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-10px;">管理员权限：</label>
								<div class="col-xs-1" style="margin-top:-3px;">
									<input type="checkbox"  ng-model="employeeEntityAdd.admFlag" ng-true-value="1" ng-false-value="0"/>
									<p style="margin-top: -22px;margin-left: 40px;">是</p>
								</div>
							</div>
							
							 <div class="form-group form-group_ style_margin">
								<label contenteditable="false" class="col-xs-2 control-label control-label_" style="margin-top:-16.2px;">员工描述：</label>
								<div class="col-xs-8 " style="margin-top:8px;">
								 	<textarea  class="form-control control-label_ form-control_test" rows="3" name="note" style="margin-top:-12px"
										maxlength="60" ng-model="employeeEntityAdd.note" placeholder="{{placeholders.note}}"> </textarea> 
											<!-- <textarea  class="form-control control-label_ form-control_test" rows="3" name="note" style="margin-top:-12px"
										maxlength="60" ng-model="employeeEntityAdd.note" placeholder="请输入字符在60个以内"></textarea> -->
								</div>
							</div>
						<!-- </ul> -->
					</div>
					<input class="btn_Under btn-primary" style="margin-left: 20px;margin:4px;"
						type="button" value="提交" ng-click="updateEmployeeEntity(emForm);">
					<input class="btn_Under btn-default" style="margin-left: 20px;margin:4px;border: 1.2px solid #ddd;"
						type="button" value="返回" ng-click="closeUpdateEmployee();">
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
