<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="demandExamineOpinionModalId" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
<form action=""novalidate name="DemandCheck" style="width: 50%;margin-left:500px">	
	<div class="modal-dialog"  >
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<div class="modal-body">
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 15px;">
						<div class="form-group">
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo1" ng-click="checkR('信息标题不合格',tmp.reason1);">
									 信息标题不合格
								</label>
							</div>
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo2" ng-click="checkR('详细说明不合格',tmp.reason2);">
									 详细说明不合格
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo3" ng-click="checkR('设备图片不合格',tmp.reason3);">
									设备图片不合格
								</label>
							</div>
							<div class="col-sm-5">
								<label class="checkbox-inline">
									<input type="checkbox" ng-pattern="/(^[0-9,\-]{7,}$)/" 
									 ng-model="formParms.typeNo4" ng-click="checkR(' 联系方式不合格',tmp.reason4);">
									 联系方式不合格
								</label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-3">
								<label class="checkbox-inline">
									<input type="checkbox" ng-model="formParms.typeNo5" ng-checked="checkSelect" ng-click="changeCheck(formParms.typeNo5)">
								</label>
							</div>
							<div class="col-sm-8" style="margin-left: -120px;margin-top:10px;">
								<input maxlength="50"  type="text" id="prod_no" name="note" class="form-control"  ng-disabled="changeNote" ng-model="formParms.checkNote"  placeholder="手动输入不通过原因">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-primary" value="确认" ng-click="Refuse()"/>
				<input type="button" class="btn btn-default" value="关闭" data-dismiss="modal"/>
			</div>
		</div>
	</div>
</form>
		<!-- /.modal-content -->
</div>
	<!-- /.modal -->