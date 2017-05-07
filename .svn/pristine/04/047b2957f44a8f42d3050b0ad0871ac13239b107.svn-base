<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="categoryModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 550px;margin-top:13%">
		<div class="modal-content">
			<!-- <div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div> -->
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<button type="button"  style="margin-left: 500px;margin-top:-48px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="margin-top:-50px;">
				<!-- 分类添加 -->
				<form action="" novalidate name="categoryForm" autocomplete="off">
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 30px;">
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">类别号：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<input type="text" class="form-control" style="  margin-top: 12px;" id="_equipmentCategoryNoId" ng-blur="checkNoFun();"  name="equipmentCategoryNo" ng-pattern="/^[\u4E00-\u9FA5A-Za-z0-9\-]+$/ " ng-model="formParms.equipmentCategoryNo" required maxlength="5" ng-disabled="upd"/>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="  margin-top: 4px;">
										<p class="form-control-static" style="color:red;  margin-left: -11px;  margin-top: 9px;">&nbsp;&nbsp;*</p>
								</div>
								<div  ng-messages="categoryForm.equipmentCategoryNo.$error" ng-show="showFlag == 'equipmentCategoryNo'">
									  <p class="form-control-static" style="color:red;  margin-top: 10px;" ng-message="required">类别号不能为空</p>
									   <p class="form-control-static" style="color:red;  margin-top: 10px;" ng-message="pattern">请输入正确类别号</p>
								</div>
							</div>
						</div>
						<p></p>
					    <div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="  margin-top: -7px;">类别名称：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
										<input type="text" class="form-control" style="  margin-top: -1px;" name="equipmentCategoryName" ng-model="formParms.equipmentCategoryName" required maxlength="10"/>
								</div> 
								<div class="col-xs-1 col-xs-offset-2">
										<p class="form-control-static" style="color:red;  margin-left: -11px;margin-top: 2px;">&nbsp;&nbsp;*</p>
								</div>
								<div  ng-messages="categoryForm.equipmentCategoryName.$error" ng-show="showFlag == 'equipmentCategoryName'" style="  margin-left: 34px;">
									  <p class="form-control-static" style="color:red;  margin-left: -46px;  margin-top: 2px;" ng-message="required">类别名称不能为空</p>

								</div>
							</div>
						</div>  
						
						
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer" style="  margin-top: 9px;">
				<input type="button" class="btn btn_Under btn-primary" style="  margin-top: -20px;" value="保存" ng-show="judge=='add'" ng-click="addCategory(categoryForm);"/>
				<input type="button" class="btn btn_Under btn-primary" style="  margin-top: -20px;" value="保存" ng-show="judge=='upd'" ng-click="updCategory(categoryForm);"/>
				<input type="button" class="btn btn_Under btn-default" style="  margin-top: -20px;" value="取消" ng-click="closeWindow()"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
















<!-- 设备添加 -->
<div class="modal fade" id="equipmentModalId" tabindex="-2" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 550px;margin-top:13%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<button type="button"  style="margin-left: 500px;margin-top:-48px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="margin-top:-50px;">
				<form action="" novalidate name="equipmentForm" autocomplete="off">
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 30px;">
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label">类别名称：</label>
							<div class="col-xs-6 form-inline" style="z-index:1;">
								<p class="form-control-static" ng-repeat=" c in categoryList" ng-if="c.equCategoryId == formParm.equCategoryId">{{c.equipmentCategoryName}}</p>
							</div>
						</div>
						<p></p>
					   
					   	<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: -13px;">设备分类号：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<input type="text" class="form-control" style="  margin-top: -13px;" name="equipmentNo" required maxlength="5" ng-model="formParm.equipmentNo" ng-pattern="/^\w*$/"/>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="  margin-top: 4px;">
										<p class="form-control-static" style="color:red;  margin-left: -11px;  margin-top: -6px;">&nbsp;&nbsp;*</p>
								</div>
								<div  ng-messages="equipmentForm.equipmentNo.$error" ng-show="showFlag == 'equipmentNo'">
									  <p class="form-control-static" style="color:red;  margin-top: -5px;" ng-message="required">设备分类号不能为空</p>
									   <p class="form-control-static" style="color:red;  margin-top: -5px;" ng-message="pattern">请输入正确的设备分类号</p>
								</div>
							</div>
						</div>
						
					    <div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: -6px;">设备名称：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<input type="text" id="_equNameId" style="margin-top: 3px;" ng-if="flagName_ == 'add'" name="equipmentName" ng-blur="checkName('add');" class="form-control" ng-model="formParm.equipmentName" required maxlength="10" ng-pattern="/^[A-Za-z0-9\u4e00-\u9fa5]+$/"/>
									<input type="text" id="_equNameId" style="margin-top: 3px;" ng-if="flagName_ == 'upd'" name="equipmentName" ng-blur="checkName('upd');" class="form-control" ng-model="formParm.equipmentName" required maxlength="10" ng-pattern="/^[A-Za-z0-9\u4e00-\u9fa5]+$/"/>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="  margin-top: 4px;">
										<p class="form-control-static" style="color:red;  margin-left: -11px;  margin-top: 1px;">&nbsp;&nbsp;*</p>
								</div>
								<div  ng-messages="equipmentForm.equipmentName.$error" ng-show="showFlag == 'equipmentName'">
									  <p class="form-control-static" style="color:red;  margin-top: 3px;" ng-message="required">设备名称不能为空</p>
									   <p class="form-control-static" style="color:red;  margin-top: 3px;" ng-message="pattern">请输入正确的设备名称</p>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: -6px;">计量单位：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									  <select class="form-control select-hover"  ng-options="s.id_ as s.name_ for s in sysCodeCon.UNIT_NAME"   required ng-model="formParm.second" name="second" style="width:155px;position: absolute;z-index:3;margin-top: 3px;">
					                      <option value="">请选择</option>
									  </select>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="  margin-top: 4px;">
										<p class="form-control-static" style="color:red;  margin-left: -11px;  margin-top: 1px;">&nbsp;&nbsp;*</p>
								</div>
								<div  ng-messages="equipmentForm.second.$error" ng-show="showFlag == 'second'">
									  <p class="form-control-static" style="color:red;  margin-top: 3px;" ng-message="required">请选择计量单位</p>
								</div>
							</div>
						</div>
						
<!-- 					   	
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="  margin-top: -12px;">设备分类号：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<input type="text" class="form-control" style="  margin-top: -11px;" name="equipmentNo" required maxlength="5" ng-model="formParm.equipmentNo" ng-pattern="/^\w*$/"/>
								</div> 
								<div class="col-xs-1 col-xs-offset-2">
										<p class="form-control-static" style="color:red;margin-top: -2px;margin-left:-11px">&nbsp;&nbsp;*</p>
								</div>
								<div  ng-messages="equipmentForm.equipmentNo.$error" ng-show="showFlag == 'equipmentNo'" style="margin-top:7px;">
									  <p  style="color:red;" ng-message="required"> &nbsp;&nbsp;请输入设备分类号</p>
									   <p  style="color:red;width:400px;" ng-message="pattern"> &nbsp;&nbsp;请输入正确的设备分类号</p>
								</div> 
							</div>
					   </div>
					   <p></p> 

						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="  margin-top: -12px;">设备名称：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<input type="text" id="_equNameId" style="margin-top: -11px;" ng-if="flagName_ == 'add'" name="equipmentName" ng-blur="checkName('add');" class="form-control" ng-model="formParm.equipmentName" required maxlength="10" ng-pattern="/^[A-Za-z0-9\u4e00-\u9fa5]+$/"/>ng-pattern="/^\w*$/"
									<input type="text" id="_equNameId" style="margin-top: -11px;" ng-if="flagName_ == 'upd'" name="equipmentName" ng-blur="checkName('upd');" class="form-control" ng-model="formParm.equipmentName" required maxlength="10" ng-pattern="/^[A-Za-z0-9\u4e00-\u9fa5]+$/"/>ng-pattern="/^\w*$/"
								</div> 
								<div class="col-xs-1 col-xs-offset-2">
										<p class="form-control-static" style="color:red;  margin-top: -2px;margin-left:-11px">&nbsp;&nbsp;*</p>
								</div>
								<div   ng-messages="equipmentForm.equipmentName.$error" ng-show="showFlag == 'equipmentName'">
									   <p class="form-control-static" style="color:red;" ng-message="required">&nbsp;&nbsp;设备名称不能为空</p>
									   <p class="form-control-static" style="color:red;width:400px;" ng-message="pattern"> &nbsp;&nbsp;请输入正确的设备名称</p> 
								</div> 
							</div>
					   </div>
					   <p></p>
						
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="  margin-top: -12px;">计量单位：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
						        	  <select class="form-control select-hover"  ng-options="s.id_ as s.name_ for s in sysCodeCon.UNIT_NAME"   required ng-model="formParm.second" name="second" style="width:180px;width:155px;position: absolute;z-index:3;  margin-top: -3px;">
					                      <option value="">请选择</option>
									  </select>
							   </div> 
						       <div class="col-xs-1 col-xs-offset-2" >
							   		<p style="color: red;  margin-top: -2px;margin-left:-11px" class="form-control-static">&nbsp;&nbsp;*</p>
							   </div>
							   <div ng-messages="equipmentForm.second.$error" ng-show="showFlag == 'second'">
									<p class="form-control-static" style="color:red;" ng-message="required">&nbsp;&nbsp; 请选择计量单位</p>
							   </div> 
						   </div>
						</div>  -->
						
						
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer" style="  margin-top: 11px;">
				<input type="button" class="btn btn_Under btn-primary" value="保存" style="margin-top: -20px;" ng-show="judge=='add'" ng-click="addEquipment(equipmentForm);"/>
				<input type="button" class="btn btn_Under btn-primary" value="保存" style="margin-top: -20px;" ng-show="judge=='upd'" ng-click="updEquipment(equipmentForm);"/>
				<input type="button" class="btn btn_Under btn-default" value="取消" style="margin-top: -20px;" data-dismiss="modal"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>