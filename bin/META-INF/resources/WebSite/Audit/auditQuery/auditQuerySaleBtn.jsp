<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="auditQuerySaleId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}<button type="button"  style="margin-left: 835px" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" >
					<div class="form-group" style="margin-top: -10px;">
						<input type="hidden" ng-model="formParms.id"/>
						<label contenteditable="false" class="col-sm-2 control-label">信息类型：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{ct.codeTranslate(formParms.dataType,"MESSAGE_TYPE")}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">信息标题：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.infoTitle}}</h5>
						</div>
					</div>

					<div class="form-group" style="margin-top: -10px;">
						<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.equName}}</h5>
						</div>	
						<label contenteditable="false" class="col-sm-2 control-label">转让价格：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.price}}元</h5>
						</div>
					</div>
					
					<div class="form-group" style="margin-top: -10px">
						<label contenteditable="false" class="col-sm-2 control-label">发布日期：</label>
						<div class="col-sm-10 form-inline">
							<h5>{{formParms.releaseDate}}</h5>
						</div>
					</div>
					
					<div class="form-group" style="margin-top: -10px">
						<label contenteditable="false" class="col-sm-2 control-label">详细说明：</label>
						<div class="col-sm-10 form-inline" style="word-break:break-all">
							<p id="detailedDescriptionHtml2" class="form-control-static" rows="3" style="width:85%"></p>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备图片：</label>
						<div class="col-sm-10 form-inline">
							<div id="Pic3" class="col-sm-2 form-inline" ng-repeat="t in PicList">
							      <a href="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}" class="thumbnail">
								<img style="width:100px; height:80px" ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}"  ng-init="createLightBox3();"></a>
							</div>
						</div>
					</div>
					
						<h4>联系方式</h4>
					<hr style="margin-top: -5px;"></hr>
					
					<div class="form-group" style="margin-top: -25px">
						<label contenteditable="false" class="col-sm-2 control-label">企业名称：</label>
						<div class="col-sm-4 form-inline" style="word-break: break-all;">
							<h5>{{formParms.enterpriseName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">所在城市：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.onProvince}}-{{formParms.onCity}}-{{formParms.onDistrict}}</h5>
						</div>
					</div>
					
					<div class="form-group" >
						<label contenteditable="false" class="col-sm-2 control-label">详细地址：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.contactAddress}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">联系人：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.contactPerson}}</h5>
						</div>
					</div>
					
					<div class="form-group" >
						<label contenteditable="false" class="col-sm-2 control-label">联系电话：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.contactPhone}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">QQ：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.qqNo}}</h5>
						</div>
					</div>
				<h4 >审核状态</h4>
				</div>
			</div>
			<div class="modal-footer" style="text-align:center;padding-bottom: 120px;margin-top: -5px">
				<label contenteditable="false" class="col-sm-2 control-label" style="margin-left:-12px;margin-top: -10px">审核状态：</label>
				<div class="col-sm-2 form-inline" style="margin-left:-50px;margin-top:-17px;">
					<h5>{{ct.codeTranslate(formParms.dataState.dataState,"AUDIT_STATE")}}</h5>
				</div>
				<label contenteditable="false" class="col-sm-4 control-label" style="margin-left:117px;margin-top: -10px" ng-if="formParms.dataState.dataState == 4">退回原因：</label>
				<div class="col-sm-2 form-inline" style="margin-left:-118px;margin-top:-17px;"  ng-if="formParms.dataState.dataState == 4">
					<h5 ng-repeat="q in queryAudit" >{{q.reasonNote}}</h5>
					
				</div>
				
			</div>
			<div style="margin-left: 430px;padding-bottom: 3px" >
				    <input type="button" class="btn btn-default btn_Under" value="返回" data-dismiss="modal"  />
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