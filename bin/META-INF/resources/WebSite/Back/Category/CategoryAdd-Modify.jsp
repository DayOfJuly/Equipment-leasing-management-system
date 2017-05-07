<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="categoryModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" >
	<div class="modal-dialog" style="width: 494px;margin-top:13%">
		<div class="modal-content" ng-click="click_BlurToInitFun('attrTypeSelect','equipmentSelect','categorySelectList','nameSelectList');">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<button type="button"  style="margin-left: 445px;margin-top:-45px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="margin-top:-46px;">
				<form action="" novalidate name="categoryFormA" autocomplete="off">
					<div class="tab-pane fade in active">
						<div class="form-horizontal" style="margin-top: 30px;">
							<div class="form-group">
								<input type="hidden" ng-model="formParms.id"/>
								<label contenteditable="false" class="col-xs-4 control-label">类别号：</label>
								<div class="col-xs-3 form-inline">
									<input type="text" class="form-control" ng-model="formParms.typeNo" name="typeNo" maxlength="5" required ng-pattern="/^[A-Za-z0-9\u4e00-\u9fa5]+$/"/>
								</div>
							   <div class="col-xs-1">
										<p class="form-control-static" style="color:red;  margin-left: 46px;">*</p>
								</div>
								<div class="col-xs-3" ng-messages="categoryFormA.typeNo.$error" ng-show="showFlag == 'typeNo'">
								  	<p class="form-control-static" style="color:red;  margin-left: 21px;  margin-top: 7px;" ng-message="required">类别号不能为空</p>
								  	<p class="form-control-static" style="color:red;margin-left: 21px;  margin-top: 7px;" ng-message="pattern"> &nbsp;&nbsp;请输入正确的类别号</p> 
								</div>
							</div>
							
							
							
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-4 control-label">设备分类：</label>
								<div id="classifySelectDiv" class="col-xs-3" ng-if="categorySelectList.length &lt;= 10">
									<select name="equCategoryId" style="width:133%;z-index:1101;position:absolute;" required
											id="attrTypeSelect" class="form-control select-hover" ng-model="formParms.equCategoryId" 
											ng-options="rec.equCategoryId as rec.equipmentCategoryName for rec in categorySelectList" 
											ng-change="changeEquipmentCategoryName(formParms.equCategoryId);" >
										<option value="">请选择</option>
									</select>
								</div>
								
								<div id="classifySelectDiv" class="col-xs-3" ng-if="categorySelectList.length > 10">
									<select name="equCategoryId" style="width:133%;z-index:1101;position:absolute;" required
											id="attrTypeSelect" class="form-control select-hover" ng-model="formParms.equCategoryId" 
											ng-options="rec.equCategoryId as rec.equipmentCategoryName for rec in categorySelectList" 
											ng-change="changeEquipmentCategoryName(formParms.equCategoryId);" ng-click="openProSelect('attrTypeSelect','categorySelectList','class_');">
										<option value="">请选择</option>
									</select>
								</div>
							   <div class="col-xs-1">
										<p class="form-control-static" style="color:red;margin-left: 46px;">*</p>
								</div>
								<div class="col-xs-3" ng-messages="categoryFormA.equCategoryId.$error" ng-show="showFlag == 'equCategoryId'">
								  	<p class="form-control-static" style="color:red;margin-left: 21px;  margin-top: 7px;" ng-message="required">请选择设备分类</p>
								</div>
							</div>
							
							
							
							
							
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-4 control-label">设备名称：</label>
						 		<div class="col-xs-3" ng-if="nameSelectList.length > 10">
									<select name="equNameId"  style="width:133%;z-index:110;position:absolute;" required
											id="equipmentSelect" class="form-control select-hover" ng-model="formParms.equNameId" 
											ng-options="rec.equNameId as rec.equipmentName for rec in nameSelectList" ng-click="openProSelect('equipmentSelect','nameSelectList','name');" ng-change="openProSelectChange();"
											>
										<option value="">请选择</option>
									</select>
								</div>
								
								<div class="col-xs-3" ng-if="nameSelectList.length &lt;= 10">
									<select name="equNameId"  style="width:133%;z-index:110;position:absolute;" required
											id="equipmentSelect" class="form-control select-hover" ng-model="formParms.equNameId" 
											ng-options="rec.equNameId as rec.equipmentName for rec in nameSelectList" 
											>
										<option value="">请选择</option>
									</select>
								</div> 
								
							 	<div class="col-xs-3"  ng-if="!nameSelectList">
									<select name="equNameId"  style="width:133%;z-index:110;position:absolute;" required
											id="equipmentSelect" class="form-control select-hover" ng-model="formParms.equNameId" 
											ng-options="rec.equNameId as rec.equipmentName for rec in nameSelectList"
											>
										<option value="">请选择</option>
									</select>
								</div> 
							    <div class="col-xs-1">
										<p class="form-control-static" style="color:red;margin-left: 46px;">*</p>
								</div>
								<div class="col-xs-3" ng-messages="categoryFormA.equNameId.$error" ng-show="showFlag == 'equNameId'">
								  	<p class="form-control-static" style="color:red;margin-left: 21px;  margin-top: 7px;" ng-message="required">请选择设备名称</p>
								</div>
							</div>
							
							
							
						</div>
					</div>
					
					
					
					
					<div class="modal-footer">
						<input type="button" class="btn btn_Under btn-primary" style="margin-top: -20px;" value="保存" ng-show="judge=='add'" ng-click="addType(categoryFormA);"/>
						<input type="button" class="btn btn_Under btn-primary" style="margin-top: -20px;" value="保存" ng-show="judge=='upd'" ng-click="upd(categoryFormA);"/>
						<input type="button" class="btn btn_Under btn-default" style="margin-top: -20px;" value="取消" ng-click="closeWindowAdd()"/>
					</div>
				</form>
			</div>
			
			
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>