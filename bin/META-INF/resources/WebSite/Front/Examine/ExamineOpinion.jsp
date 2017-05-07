<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="examineOpinionModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 450px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<div class="modal-body">
				<form action="" novalidate name="opinionForm">
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 30px;">
					
						<div class="form-group">
							<div class="col-md-6 ">
								<label class="checkbox-inline"><input type="checkbox"  ng-model="formParms.reason1" ng-click="check1('信息标题不合格',formParms.reason1)"/>&nbsp;信息标题不合格
							    </label>
							</div>
							<div class="col-md-6 ">
								<label class="checkbox-inline"><input type="checkbox"  ng-model="formParms.reason2" ng-click="check2('详细说明不合格',formParms.reason2)"/>
								详细说明不合格 </label>
							</div>
					 	</div>
						
						<div class="form-group">
							<div class="col-sm-6 ">
								<label class="checkbox-inline"><input type="checkbox"  ng-model="formParms.reason3" ng-click="check3('设备图片不合格',formParms.reason3)"/>
								设备图片不合格 </label>
							</div>
							<div class="col-sm-6 ">
								<label class="checkbox-inline"><input type="checkbox" ng-pattern="/(^[0-9,\-]{7,}$)/"  ng-model="formParms.reason4" ng-click="check4('联系方式不合格',formParms.reason4)"/>
								联系方式不合格 </label>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-3 ">
								<input type="checkbox"  ng-model="formParms.reasonOther" ng-click="check5('其它',formParms.reasonOther)"/>
								其它
							</div>
							<div class="col-sm-9 ">
								<input type="text" name="reasonOtherDesc" class="form-control" ng-model="formParms.reasonOtherDesc" ng-disabled="reason" placeholder="可手动填写不通过原因" maxlength="50" ng-maxlength="50"/>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-9 col-sm-offset-3" ng-messages="opinionForm.reasonOtherDesc.$error" ng-show="showFlag == 'reasonOtherDesc'">
								  <p class="form-control-static" style="color:red;" ng-message="maxlength"> 最大长度是50</p>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-primary" value="确认" ng-click="submitResult(opinionForm)"/>
				<input type="button" class="btn btn-default" value="关闭" data-dismiss="modal"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>