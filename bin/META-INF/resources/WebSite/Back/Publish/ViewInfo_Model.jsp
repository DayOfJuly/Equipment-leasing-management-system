<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="viewInfoModel" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 550px;margin-top:13%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" style="width:75%">请填写单位名称、联系人姓名和联系方式</h4>
				<button type="button"  style="float:right;margin-top:-30px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			</div>
			
			<div class="modal-body">
				<!-- 分类添加 -->
				<form action="" novalidate name="categoryForm" autocomplete="off">
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="">
						<div class="form-group" ng-show="infoType==1 || infoType==2">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">设备编号：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline" style="  margin-top: 10px;">
									 {{viewList.equipmentTable.equNo}}
								</div> 
							</div>
						</div>
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">设备名称：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline" style="  margin-top: 10px;">
									 {{viewList.equName}}
								</div> 
							</div>
						</div>
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">单位名称：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<input type="text" class="form-control" name="depName" style="  margin-top: 12px;"  ng-model="formParms.depName" required maxlength="30"/>
								</div> 
								<div class="col-xs-4 col-xs-offset-2" style="  margin-top: 4px;">
									<p class="form-control-static" style="color:red;  margin-left: 5px;  margin-top: 9px;">&nbsp;&nbsp;*</p>
									<div ng-messages="categoryForm.depName.$error" ng-show="showFlag == 'depName'">
										  <p class="form-control-static" style="color:red;margin-top: -32px;margin-left: 25px;" ng-message="required">请输入单位名称</p>
									</div>
								</div>
							</div>
						</div>
						<p></p>
					    <div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="  margin-top: -7px;">联系人姓名：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
										<input type="text" class="form-control"  name="linkName"style="  margin-top: -1px;" ng-model="formParms.linkName" required maxlength="30"/>
								</div> 
								<div class="col-xs-1 col-xs-offset-2">
										<p class="form-control-static" style="color:red;  margin-left: 5px;margin-top: 2px;">&nbsp;&nbsp;*</p>
										<div ng-messages="categoryForm.linkName.$error" ng-show="showFlag == 'linkName'">
								 			 <p class="form-control-static" style="color:red;margin-top: -32px;margin-left: 25px;" ng-message="required">请输入联系人姓名</p>
										</div>
								</div>
							</div>
						</div>  
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="  margin-top: -7px;">联系方式：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
										<input type="text" class="form-control" name="linkPhone" style="  margin-top: -1px;" ng-pattern="/(^[0-9,\-]{7,}$)/" ng-minlength="7" ng-model="formParms.linkPhone" required />
								</div> 
								<div class="col-xs-1 col-xs-offset-2">
										<p class="form-control-static" style="color:red;  margin-left: 5px;margin-top: 2px;">&nbsp;&nbsp;*</p>
										<div ng-messages="categoryForm.linkPhone.$error" ng-show="showFlag == 'linkPhone'">
								 			 <p class="form-control-static" style="color:red;margin-top: -32px;margin-left: 25px;" ng-message="required">请输入联系电话</p>
											 <p class="form-control-static" style="color:red;margin-top: -32px;margin-left: 25px;" ng-message="pattern">请输入正确的联系电话</p>
											 <p class="form-control-static" style="color:red;margin-top: -32px;margin-left: 25px;" ng-message="minlength">请输入正确的联系电话</p>
										</div>
								</div>
							</div>
						</div> 
						
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer" style="margin-top: 9px;">
				<input type="button" class="btn btn_Under btn-primary"  value="我想交易" ng-click="addClick(formParms,categoryForm);"/>
				<input type="button" class="btn btn_Under btn-default"  value="取消" ng-click="closeViewInfoModel(formParms);"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>