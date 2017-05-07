<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="demandExamineDetailModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					<div class="form-group">
						<input type="hidden" ng-model="formParms.id"/>
						<label contenteditable="false" class="col-sm-2 control-label">信息类型：</label>
						<div class="col-sm-4">
							<h5>{{formParms.process.bizName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">信息标题：</label>
						<div class="col-sm-4">
							<h5>{{formParms.infoTitle}}</h5>
						</div>
					</div>

					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备编号：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.equipmentCategoryTable[0].categoryTable.equipmentNo}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.equipmentCategoryTable[0].categoryTable.equipmentName}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">品牌：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.brandName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">型号：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.models}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">功率：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.power}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">技术状况：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.technicalStatus}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">生产厂家：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.manufacturer}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">出厂日期：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equipmentTable.productionDate}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备归属：</label>
						<div class="col-sm-4">
							<h5>{{}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">最短租期：</label>
						<div class="col-sm-4">
							<h5>{{formParms.shortestLease}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备报价：</label>
						<div class="col-sm-4">
							<h5>{{}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">所在地：</label>
						<div class="col-sm-4">
							<h5>{{}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">发布日期：</label>
						<div class="col-sm-10">
							<h5>{{formParms.releaseDate}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">详细说明：</label>
						<div class="col-sm-8">
							<p>{{formParms.detailedDescription}}</p>
						</div>
					</div>
					
					<!-- <div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备图片：</label>
						<div class="col-sm-10">
							<div class="col-sm-2 form-inline" ng-repeat="t in formParms.equipmentPicList">
								<img style="width:100px; height:80px" ng-src="http://124.205.89.214:8080/Picture/{{t.pic}}/{{t.suffix}}" alt="{{t.pic}}.{{t.suffix}}">
							</div>
						</div>
					</div> -->
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备图片：</label>
						<div class="col-sm-10 ">
							<div class="col-sm-2" ng-repeat="t in formParms.equipmentPicList">
								<img style="width:100px; height:80px" ng-src="{{PicUrl_Copy}}/{{t.pic}}/{{t.suffix}}" alt="{{t.pic}}.{{t.suffix}}">
							</div>
						</div>
					</div>
					
					<h3>联系方式</h3>
					<hr>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">企业名称：</label>
						<div class="col-sm-4">
							<h5>{{formParms.enterpriseName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">所在城市：</label>
						<div class="col-sm-4">
							<h5>{{}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">联系人：</label>
						<div class="col-sm-4">
							<h5>{{formParms.contactPerson}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">联系手机：</label>
						<div class="col-sm-4">
							<h5>{{formParms.contactPhone}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">QQ：</label>
						<div class="col-sm-4">
							<h5>{{formParms.qqNo}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">电子邮箱：</label>
						<div class="col-sm-4">
							<h5>{{formParms.electronicMail}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">固定电话：</label>
						<div class="col-sm-4">
							<h5>{{formParms.fixedTelephone}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">联系地址：</label>
						<div class="col-sm-4">
							<h5>{{formParms.contactAddress}}</h5>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-primary" value="通过" ng-click="Through();"/>
				<input type="button" class="btn btn-primary" value="不通过" ng-click="openOpinionModal();"/>
				<input type="button" class="btn btn-default" value="关闭" data-dismiss="modal"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
<script type="text/javascript">
	$('.form_date').datetimepicker({
		language : 'zh-CN',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		minView : 2,
		forceParse : 0
	});
</script>