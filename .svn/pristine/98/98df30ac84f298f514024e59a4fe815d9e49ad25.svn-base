<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!-- 借款申请-模态框（Modal） -->
<div class="modal fade" id="EnterPriseQueryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:1200px;  margin-top: 13%;">
		<div class="modal-content">
		
		<div class="modal-header">
			<h4 class="modal-title">企业设置<button type="button"   class="btn btn-link  " style="margin-left:1078px;" data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
		</div>
						
		<form action="" novalidate name="setForm" >
			<div class="modal-body" style="margin-right: 40px;">
				<div class="form-horizontal">
					<div class="form-group">
						<label class="col-xs-2 control-label">单位编号：</label>
						<div class="col-xs-4">
							<p class="form-control-static">{{allparms.code}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label" >单位名称：</label>
						<div class="col-xs-4">
							<!-- <p class="form-control-static" style="word-wrap: break-word;">{{allparms.name}}</p> -->
							<p class="form-control-static" title="{{allparms.name}}">{{allparms.nameCopy}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">组织级别：</label>
						<div class="col-xs-4">
							<p class="form-control-static">{{ct.codeTranslate(allparms.orgLevel,"LEVEL_ALL")}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label" >上级单位编号：</label>
						<div class="col-xs-4">
							<p class="form-control-static">{{allparms.parentCode}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">备注：</label>
						<div class="col-xs-7">
							<p class="form-control-static" style="word-wrap: break-word;">{{allparms.note}}</p>
						</div>
					</div>
					
				</div>
			</div>
			<div class="modal-footer" ng-show="judgeBottomBtn!=0">
				<button type="button" class="btn btn_Under btn-default" style="margin-top:-20px;" ng-click="closeWindowQuery()">关闭</button>
			</div>
		</form>	
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>







