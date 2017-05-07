<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->

<!-- <div class="modal-backdrop fade in" ng-show="modalBackdropId" style="z-index:1399;"></div> -->

<div class="modal fade" id="OpinionModalId_" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" style="z-index:1400;">
<form action=""novalidate name="DemandCheck" style="width: 50%;margin-left:25%;margin-top: 12%;opacity: 1;" ng-click="FormBlur();"	>
	<div class="modal-dialog"  >
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}<button type="button"  style="margin-left: 257px" class="btn btn-link  "  ng-click="closeModal();"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<div class="modal-body">
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 15px;">
						<div class="form-group">
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo1">
									 信息标题不合格
								</label>
							</div>
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo2">
									 详细说明不合格
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo3">
									设备图片不合格
								</label>
							</div>
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-pattern="/(^[0-9,\-]{7,}$)/" ng-model="formParms.typeNo4">
									 联系方式不合格
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-3">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo5"  ng-click="changeCheck(formParms.typeNo5)"
									ng-change="checkR(formParms.checkNote,5);">其他
								</label>
							</div>
							<div class="col-sm-8" style="margin-left: 48px;margin-top:-30px;">
								<input maxlength="50"  type="text" id="prod_no" name="note" class="form-control"  ng-disabled="changeNote" ng-model="formParms.checkNote"  placeholder="可手动填写不通过原因" ng-focus="inputFocus();">
								<button ng-show="checkNote" type="button" class="close" aria-hidden="true" ng-click="deleteText();" style="margin-top:-23px;">&times;</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-primary btn_Under" style="margin-top: -20px" value="确认" ng-click="Refuse()"/>
				<input type="button" class="btn btn-default btn_Under" style="margin-top: -20px" value="关闭" ng-click="closeModal();"/>
			</div>
		</div>
	</div>
</form>
		<!-- /.modal-content -->
</div>
	<!-- /.modal -->