<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!-- 借款申请-模态框（Modal） -->
<div class="modal fade" id="EnterPriseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:1200px;  margin-top: 13%;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">企业设置<button type="button"   class="btn btn-link  " style="margin-left:1078px;" data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
		<form action="" novalidate name="setForm" autocomplete="off">
			<div class="modal-body" style="margin-right: 40px;">
			     
				<div class="form-horizontal">
					<div class="form-group">
						<label class="col-xs-2 control-label">单位编号：</label> 
						<div class="col-xs-4">
						<!-- 	<input type="text" name="code" class="form-control" style="width:90%;float:left;" ng-model="allparms.code" required maxlength="40" ng-pattern="/^[a-zA-Z0-9]+$/">
							<p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
                    		<div ng-messages="setForm.code.$error" ng-show="showFlag == 'code'">
								  <p class="form-control-static" style="color:red;" ng-message="required">请输入单位编号</p>
						          <p class="form-control-static" style="color:red;" ng-message="pattern">请输入正确的单位编号</p>
							</div> -->
							<p class="form-control-static">{{allparms.code}}</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label" >单位名称：</label>
						<div class="col-xs-4"><!-- ng-pattern="/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/" -->
							<input type="text" name="name" class="form-control" style="width:90%;float:left;" ng-model="allparms.name" required maxlength="200" >
							<p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
							<!-- 企业名称 -->
						</div>
						<div ng-messages="setForm.name.$error" ng-show="showFlag == 'name'">
							  <p class="form-control-static" style="color:red;  margin-left: 3px;" ng-message="required">请填写单位名称</p>
						</div>
					</div>
					<div class="form-group">
                        <label class="col-xs-2 control-label">组织级别：</label>
                        
                        
						<div class="col-xs-4" ng-if="userInfo.orgLevel == 1">
							<div  class="col-xs-11" style="margin-left:-15px;width:90%">
								 <select id="brandSelect" class="form-control" name="orgLevel"  required ng-model="allparms.orgLevel"  style="position: absolute;z-index:5;float:left;">
									<option value="">请选择</option>
									<option value="{{b.id_}}" ng-blur="loseFocus();"  ng-repeat="b in sysCodeCon.ENTERPRISE_LEVEL_ALLCompany">{{b.name_}}</option>
								</select> 
							</div>
						    <div class="col-xs-1">
								<p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
							</div> 
						</div>
						
						<div class="col-xs-4" ng-if="userInfo.orgLevel == 2">
							<div  class="col-xs-11" style="margin-left:-15px;width:90%">
								 <select id="brandSelect__" class="form-control select-hover" name="orgLevel" required ng-model="allparms.orgLevel"  style="position: absolute;z-index:5;float:left;">
									<option value="">请选择</option><!-- ng-click="loseFocus();" -->
									<option value="{{b.id_}}" ng-blur="loseFocus();"   ng-repeat="b in sysCodeCon.ENTERPRISE_LEVEL_COMPANY">{{b.name_}}</option>
								</select> 
							</div>
						    <div class="col-xs-1">
								<p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
							</div> 
						</div>	
												
						<div ng-messages="setForm.orgLevel.$error" ng-show="showFlag == 'orgLevel'">
								  <p class="form-control-static" style="color:red;margin-left: 3px;" ng-message="required">请选择组织级别</p>
						</div>					
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label">上级单位编号：</label>
						<div class="col-xs-4">
							<p class="form-control-static">{{allparms.orgParentCode}}</p>
						</div>	
					</div>
					
					<div class="form-group">
						<label class="col-xs-2 control-label" style="margin-top:-3px">备注：</label>
						<div class="col-xs-10">

 							<textarea class="form-control" maxlength="120" cols="80" rows="3" id="note" name="note"  placeholder="{{placeholders.note_}}" ng-model="allparms.note" > </textarea>
						
 							<!-- <textarea class="form-control"  name="note" maxlength="120" cols="80" rows="3" id="note" name="note"  placeholder="请输入字符在120个以内" ng-model="allparms.note" ></textarea> -->
 						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" ng-show="judgeBottomBtn!=0">
				<button type="button" class="btn btn_Under btn-primary" style="margin-top:-20px;"  ng-show="judgeAddUpd=='add'" ng-click="addLoanApply(setForm)">提交</button>
				<button type="button" class="btn btn_Under btn-primary" style="margin-top:-20px;"  ng-show="judgeAddUpd=='upd'" ng-click="updLoanApply(setForm)">保存</button>
				<button type="button" class="btn btn_Under btn-default" style="margin-top:-20px;" data-dismiss="modal" ng-click="closeWindow()">关闭</button>
			</div>
		</form>	
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<style>
.form-control-static {
 width:600px;
}
</style>





