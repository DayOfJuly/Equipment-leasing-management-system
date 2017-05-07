<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!-- 查询项目详情模态框（Modal） -->
<div class="modal fade" id="projectStateId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:1200px;  margin-top: 13%;">
		<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title">项目设置<button type="button"  style="outline: none;margin-left:1078px;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
		</div>
		<form action="" novalidate name="setForm" >
			<div class="modal-body" style="margin-right: 40px;">
				<div class="form-horizontal">
					<div class="form-group">
						<label class="col-xs-3 control-label" style="width: 160px;">项目所属单位编号：</label>
						<div class="col-xs-4">
							<p class="form-control-static">{{projectDetail.parentCode}}</p>
						</div>
					</div>				
				
					<div class="form-group">
						<label class="col-xs-3 control-label" style="width: 160px;">项目编号：</label>
						<div class="col-xs-4">
							<p class="form-control-static">{{projectDetail.code}}</p>
						</div>
					</div>
					<div class="form-group">
					    <label class="col-xs-3 control-label" style="width: 160px;">项目名称：</label>
						<div class="col-xs-6">
							<p class="form-control-static">{{projectDetail.name}}</p>
						</div>
					</div>
					<div class="form-group">
					    <label class="col-xs-3 control-label" style="width: 160px;">负责人：</label>
						<div class="col-xs-3">
							<p class="form-control-static">{{projectDetail.contacts}}</p>
						</div>
						  <label class="col-xs-3 control-label" style="width: 160px;">联系电话：</label>
						<div class="col-xs-3">
							<p class="form-control-static">{{projectDetail.contactsMobile}}</p>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-xs-3 control-label" style="width: 160px;">所在城市：</label>
						<div class="col-xs-3" style="margin-top:5px">
							<p class="form-control-static">{{projectDetail.atProvinceName}}</p>
                   		</div>
                   		<div class="col-xs-3" style="margin-top:5px">
							<p class="form-control-static">{{projectDetail.atCityName}}</p>
                   		</div>
                   		<div class="col-xs-3" style="margin-top:5px"> 
							<p class="form-control-static">{{projectDetail.atDistrictName}}</p>
                   		</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label" style="width: 160px;">详细地址：</label>
						<div class="col-xs-6" style="margin-top:7px">
							<p class="form-control-static">{{projectDetail.offAddr}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label" style="width: 160px;">状态：</label>
						<div class="col-xs-4">
							<p class="form-control-static">{{ct.codeTranslate(projectDetail.state, "PRO_STATE")}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label" style="width: 160px;">备注：</label>
						<div class="col-xs-9">
							<p class="form-control-static" style="word-wrap: break-word;">{{projectDetail.note}}</p>
						</div>
					</div>
					
				</div>
			</div>
			<div class="modal-footer" ng-show="judgeBottomBtn!=0">
				<button type="button" class="btn btn_Under btn-primary" style="margin-top:-20px; width: 50px;" ng-click="opStAdmin()">提交</button>
				<button type="button" class="btn btn_Under btn-default" style="margin-top:-20px; width: 50px;" ng-click="closeWindowState()">返回</button>
			</div>
		</form>	
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
