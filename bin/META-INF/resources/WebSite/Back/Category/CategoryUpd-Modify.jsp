<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="categoryUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 494px;margin-top:13%">
		<div class="modal-content" ng-click="click_BlurToInitFun('attrTypeSelectUpd','equipment','categorySelectListUpd','nameSelectListUpd');">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<button type="button"  style="margin-left: 445px;margin-top:-45px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="margin-top:-46px;">
				<form action="" novalidate name="categoryForm" autocomplete="off">
					<div class="tab-pane fade in active" >
						<div class="form-horizontal" style="margin-top: 30px;">
							<div class="form-group">
								<input type="hidden" ng-model="formParms.id"/>
								<label contenteditable="false" class="col-xs-4 control-label">类别号：</label>
								<div class="col-xs-3 form-inline">
									<input disabled type="text" class="form-control" ng-model="formParm.typeNo" name="typeNo" />
								</div>
							</div>
							
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-4 control-label">设备分类：</label>
								<div id="classifySelectDiv" class="col-xs-3">
									<select name="equCategoryId" style="width:133%;z-index:1101;position:absolute;" required ng-if="categorySelectListUpd.length > 10"
									        id="attrTypeSelectUpd" class="form-control select-hover" ng-model="formParm.equCategoryId" 
											ng-options="rec.equCategoryId as rec.equipmentCategoryName for rec in categorySelectListUpd" 
											ng-change="changeEquipmentCategoryNameUpd();" ng-click="openProSelect('attrTypeSelectUpd','categorySelectListUpd','class_');">
										<option value="">请选择</option>
									</select> 
									<select name="equCategoryId" style="width:133%;z-index:1101;position:absolute;" required ng-if="categorySelectListUpd.length &lt;= 10"
									        id="attrTypeSelectUpd" class="form-control select-hover" ng-model="formParm.equCategoryId" 
											ng-options="rec.equCategoryId as rec.equipmentCategoryName for rec in categorySelectListUpd" 
											ng-change="changeEquipmentCategoryNameUpd();">
										<option value="">请选择</option>
									</select> 
								</div>
								<div class="col-xs-1">
										<p class="form-control-static" style="color:red;margin-left:46px;">*</p>
								</div>
							 	<div class="col-xs-3" ng-messages="categoryForm.equCategoryId.$error" ng-show="showFlag == 'equCategoryId'">
								  	<p class="form-control-static" style="color:red;margin-left: 24px;  margin-top: 7px;" ng-message="required">请输入设备分类</p>
								</div> 
							</div>
							
							<div class="form-group">
								<label contenteditable="false" class="col-xs-4 control-label">设备名称：</label>
								<div class="col-xs-3">
									<select name="equNameId"  style="width:133%;z-index:110;position:absolute;" required ng-if="nameSelectListUpd.length > 10"
											id="equipment" class="form-control select-hover" ng-model="formParm.equNameId" 
											ng-options="rec.equNameId as rec.equipmentName for rec in nameSelectListUpd"  
											ng-click="openProSelect('equipment','nameSelectListUpd','name');" ng-change="openProSelectChange();"
											><!-- ng-change="changeNameUpd(formParm.equName.equipmentId);" -->
										<option value="">请选择</option>
									</select>
									
									<select name="equNameId"  style="width:133%;z-index:110;position:absolute;" required ng-if="nameSelectListUpd.length &lt;= 10"
											id="equipment" class="form-control select-hover" ng-model="formParm.equNameId" 
											ng-options="rec.equNameId as rec.equipmentName for rec in nameSelectListUpd"  
											><!-- ng-change="changeNameUpd(formParm.equName.equipmentId);" -->
										<option value="">请选择</option>
									</select>
									
									<select name="equNameId"  style="width:133%;z-index:110;position:absolute;" required ng-if="!nameSelectListUpd"
											id="equipment" class="form-control select-hover" ng-model="formParm.equNameId" 
											ng-options="rec.equNameId as rec.equipmentName for rec in nameSelectListUpd"  
											><!-- ng-change="changeNameUpd(formParm.equName.equipmentId);" -->
										<option value="">请选择</option>
									</select>
								</div>
								<div class="col-xs-1">
										<p class="form-control-static" style="color:red;margin-left:46px;">*</p>
								</div>
								<div class="col-xs-3" ng-messages="categoryForm.equNameId.$error" ng-show="showFlag == 'equNameId'">
								  	<p class="form-control-static" style="color:red;margin-left: 24px;  margin-top: 7px;" ng-message="required">请输入设备名称</p>
								</div>
							</div>
							
							
							
						</div>
					</div>
				
				<div class="modal-footer">
					<input type="button" class="btn btn_Under btn-primary" style="margin-top: -20px;" value="保存" ng-show="judge=='add'" ng-click="addType(categoryForm);"/>
					<input type="button" class="btn btn_Under btn-primary" style="margin-top: -20px;" value="保存" ng-show="judge=='upd'" ng-click="upd(categoryForm);"/>
					<input type="button" class="btn btn_Under btn-default" style="margin-top: -20px;" value="取消" ng-click="closeWindowUpd()"/>
				</div>
			</form>
		</div>
			
	  </div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>