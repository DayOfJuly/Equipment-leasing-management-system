<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="demandSaleDetailModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg1}}<button type="button"  style="margin-left: 835px" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: -10px;">
					<div class="form-group" style="margin-top: -10px;">
						<input type="hidden" ng-model="formParms.id"/>
						<label contenteditable="false" class="col-sm-2 control-label">信息类型：</label>
						<div class="col-sm-4">
							<h5>{{formParms.dataTypeName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">信息标题：</label>
						<div class="col-sm-4">
							<h5>{{formParms.infoTitle}}</h5>
						</div>
					</div>

					<div class="form-group" style="margin-top: -10px;">
						<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
						<div class="col-sm-4">
							<h5>{{formParms.equName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">设备使用地点：</label>
						<div class="col-sm-4">
							<h5 ng-if="formParms.useProvince">{{formParms.useProvince}}-{{formParms.useCity}}-{{formParms.useDistrict}}</h5>
							<h5 ng-if="!formParms.useProvince">全国</h5>
						</div>
					</div>
					
					<div class="form-group" style="margin-top: -10px;">
						<label contenteditable="false" class="col-sm-2 control-label">详细地址：</label>
						<div class="col-sm-4">
							<h5>{{formParms.address}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label" >购买单价：</label>
						<div class="col-sm-4" >
							<h5 >{{formParms.price}}元</h5>
						</div>
					</div>
					
					<div class="form-group" style="margin-top: -10px;">
						<label contenteditable="false" class="col-sm-2 control-label">数量：</label>
						<div class="col-sm-4">
							<h5>{{formParms.quantity}}{{ct.codeTranslate(formParms.second,"UNIT_NAME")}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">发布日期：</label>
						<div class="col-sm-4">
							<h5>{{formParms.releaseDate}}</h5>
						</div>
					</div>
					
					<div class="form-group" style="margin-top: -10px;">
						<label contenteditable="false" class="col-sm-2 control-label">详细说明：</label>
						<div class="col-sm-8" style="margin-top: 8px;word-break:break-all">
							<span id="rePayMs"  ></span>
						</div>
					</div>
					
					<h4 style="">联系方式</h4>
					<hr style="margin-top: -5px">
					
					<div class="form-group" style="margin-top: -25px;">
						<label contenteditable="false" class="col-sm-2 control-label">联系单位：</label>
						<div class="col-sm-4" style="word-break: break-all;">
							<h5>{{formParms.enterpriseName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">所在城市：</label>
						<div class="col-sm-4">
							<h5>{{formParms.onProvince}}-{{formParms.onCity}}-{{formParms.onDistrict}}</h5>
						</div>
					</div>
					
					<div class="form-group" >
						<label contenteditable="false" class="col-sm-2 control-label">详细地址：</label>
						<div class="col-sm-4">
							<h5>{{formParms.address}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">联系人：</label>
						<div class="col-sm-4">
							<h5>{{formParms.contactPerson}}</h5>
						</div>
					</div>
					
					<div class="form-group" >
						<label contenteditable="false" class="col-sm-2 control-label">联系电话：</label>
						<div class="col-sm-4">
							<h5>{{formParms.contactPhone}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">QQ：</label>
						<div class="col-sm-4">
							<h5>{{formParms.qqNo}}</h5>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="margin-top: -10px;">
				<input type="button" class="btn btn-primary btn_Under" style="margin-top: -20px" value="通过" ng-click="submit('demandSaleDetailModalId');"/>
				<input type="button" class="btn btn-primary btn_Under" style="margin-top: -20px"value="退回" ng-click="openOpinionModal();"/>
				<input type="button" class="btn btn-primary btn_Under" style="margin-top: -20px" value="删除" ng-click="delectAudit('demandSaleDetailModalId');"/>
				<input type="button" class="btn btn-primary btn_Under" style="margin-top: -20px"value="关闭" data-dismiss="modal"/>
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