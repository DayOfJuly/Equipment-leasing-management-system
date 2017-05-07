<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!-- 借款申请-模态框（Modal） -->
<div class="modal fade" id="EnterPriseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:1200px;  margin-top: 13%;">
		<div class="modal-content">
		
		<div class="modal-header">
			<h4 class="modal-title">项目设置<button type="button"  style="outline: none;margin-left:1078px;" class="btn btn-link  "   data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
		</div>
		
		<form action="" novalidate name="setForm" autocomplete="off">
			<div class="modal-body" style="margin-right: 40px;">
				<div class="form-horizontal">
				
					<div class="form-group">
						<label class="col-xs-2 control-label" style="width: 160px;">项目所属单位编号：</label>
						<div class="col-xs-4">
							<p class="form-control-static" >{{projectBean.parentCode}}</p>
						</div>	
					</div>				
				
					<div class="form-group">
						<label class="col-xs-2 control-label" style="width: 160px;">项目编号：</label> 
						<div class="col-xs-4">
							<input type="text" name="code" ng-model="projectBean.code" class="form-control" style="width:90%;float:left;"  required maxlength="30" >
							<p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
							<!-- 企业编号 -->
                    		<div ng-messages="setForm.code.$error" ng-show="showFlag == 'code'">
								  <p class="form-control-static" style="color:red;" ng-message="required">请输入项目编号</p>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label" style="width: 160px;">项目名称：</label>
						<div class="col-xs-4">
							<input type="text" name="name" ng-model="projectBean.name" class="form-control" style="width:90%;float:left;"  required maxlength="50">
							<p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
							<!-- 企业名称 -->
                    		<div ng-messages="setForm.name.$error" ng-show="showFlag == 'name'">
								  <p class="form-control-static" style="color:red;" ng-message="required">请输入项目名称</p>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-xs-2 control-label" style="width: 160px;">负责人：</label>
						<div class="col-xs-4">
							<input type="text" name="contacts" ng-model="projectBean.contacts" class="form-control" style="width:90%;float:left;"   maxlength="10">
							<!-- <p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p> -->
						</div>
						<label class="col-xs-2 control-label" style="width: 160px;">联系电话：</label>
						<div class="col-xs-4">
							<input type="text" name="contactsMobile" ng-model="projectBean.contactsMobile" class="form-control" style="width:90%;float:left;" ng-pattern="/(^[0-9,\-]{7,}$)/" ng-minlength="7" maxlength="20"  required maxlength="20">
							<p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
							<div ng-messages="setForm.contactsMobile.$error" ng-show="showFlag == 'contactsMobile'">
								  <p class="form-control-static" style="color:red;" ng-message="required">请输入联系电话</p>
								  <p class="form-control-static" style="color:red;" ng-message="pattern">请输入正确的联系电话</p>
								  <p class="form-control-static" style="color:red;" ng-message="minlength">请输入正确的联系电话</p>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label" style="width: 160px;"><span style="color: red; ">*</span>所在城市：</label>
						<div class="col-xs-2" style="margin-top:5px">
							<select id="province" name="province" class="inpt_a inpt_o span110" ng-model="projectBean.atProvince" style="position: absolute;z-index:3;"
								ng-options="recPro.regionId as recPro.name for recPro in areaListA" ng-change="changeProA()" 
								 required>  														
                        		<option value="">请选择省份</option>
                    		</select>
                   		</div>
                   		<div class="col-xs-2" style="margin-top:5px">  																		
                    		<select class="inpt_a inpt_o span110" name="city" id="city" ng-model="projectBean.atCity"  style="position: absolute;z-index:3;margin-left: 5px"
                    			ng-options="recCit.regionId as recCit.name for recCit in pListA" ng-change="changeCityA()" 
                    			 required>  
                        		<option value="">请选择城市</option>  
                    		</select>
                   		</div>
                   		<div class="col-xs-2" style="margin-top:5px">  																		 
                    		<select class="inpt_a inpt_o span110" name="district" id="district" ng-model="projectBean.atDistrict"  style="position: absolute;z-index:3;margin-left: 10px"
                    			ng-options="recDis.regionId as recDis.name for recDis in cListA"
                    			 required>  
                        		<option value="">请选择区县</option>  
                    		</select>
                   		</div>
						<div class="col-xs-1" ng-messages="setForm.province.$error" ng-show="showFlag == 'proA'">
							<p class="form-control-static" style="color: red;margin-left:26px; margin-top:3px;width:130px;" ng-message="required">请选择所在省份</p>
						</div>
						<div class="col-xs-1" ng-messages="setForm.city.$error" ng-show="showFlag == 'citA'">
							<p class="form-control-static" style="color: red;margin-left:26px; margin-top:3px;width:130px;" ng-message="required">请选择所在城市</p>
						</div>
						<div class="col-xs-1" ng-messages="setForm.district.$error" ng-show="showFlag == 'disA'">
							<p class="form-control-static" style="color: red;margin-left:26px; margin-top:3px;width:130px;" ng-message="required">请选择所在区县</p>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label" style="width: 160px;">详细地址：</label>
						<div class="col-xs-4">
							<input type="text" name="offAddr" ng-model="projectBean.offAddr" class="form-control" style="width:90%;float:left;"   maxlength="50">
							<!-- <p class="form-control-static" style="color:red;">&nbsp;&nbsp;*</p>
							<div ng-messages="setForm.offAddr.$error" ng-show="showFlag == 'offAddr'">
								  <p class="form-control-static" style="color:red;" ng-message="required">请输入详细地址</p>
							</div> -->
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-2 control-label" style="margin-top:-3px; width: 160px;">备注：</label>
						<div class="col-xs-10">
							<textarea class="form-control" id="note" name="note" ng-model="projectBean.note" maxlength="50" cols="80" rows="3" placeholder="{{placeholders.note}}"> </textarea>
						
 						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" ng-show="judgeBottomBtn!=0">
				<button type="button" class="btn btn_Under btn-primary" style="margin-top:-20px; width: 50px;"  ng-show="projectBean.judgeAddUpd=='add'" ng-click="addLoanApply(setForm)">提交</button>
				<button type="button" class="btn btn_Under btn-primary" style="margin-top:-20px; width: 50px;"  ng-show="projectBean.judgeAddUpd=='upd'" ng-click="updLoanApply(setForm)">保存</button>
				<button type="button" class="btn btn_Under btn-default" style="margin-top:-20px; width: 50px;" data-dismiss="modal" ng-click="closeWindow()">取消</button>
			</div>
		</form>	
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>







