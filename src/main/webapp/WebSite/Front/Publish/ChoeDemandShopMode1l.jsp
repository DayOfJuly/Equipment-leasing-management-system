<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 出租信息-请选择或填写：品牌、型号、规格（Modal） -->
<div class="modal fade" id="ChoeDemandShopModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" ng-init="queryallequiData()">
    <!-- Default panel contents -->
    <div class="modal-dialog" style="margin-top:10%;width: 26%;">
        <div class="modal-content">
            <div class="modal-header">
            	<h4>请选择或填写：品牌、型号、规格<button type="button" class="btn btn-link  "  style="float: right;" data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></h4>
            </div>
            <div class="modal-body">
            	<div>
            		<!-- 当前设备名称  -->
            		<label contenteditable="false" class=" control-label" style="margin-top:10px;width:120px;margin-left:10px;"><h4>当前设备名称:</h4></label>
            		<div style="margin-top:-35px;margin-left:130px;">
            			<span style="margin-top:-35px;">{{inputModel.parm}}</span>
            		</div>
            		<!-- 品牌  -->
					<label contenteditable="false" class=" control-label" style="margin-top:30px;width:88px;margin-left:10px;">品牌</label>
					<div ng-show="brandSelectShow">
						<select name="state"  class="form-control select-hover" 
								ng-options="rec.id as rec.name for rec in queryEquBrandList" ng-model="selectList.brandS" 
								style="margin-top:-35px;margin-left:50px;width:260px;position:absolute;z-index:99;" id="state"
						        ng-change="brandChange(selectList.brandS);">
						        <option value=""">请选择</option>
						</select>
					</div>
					<div ng-show="brandSelectShow">
						<input type="text" maxlength="20" ng-model="selectList.brandI" class="form-control" style="margin-top:-30px;margin-left:50px;width:260px;height:25px;" placeholder="请输入品牌名称">
						<a href="" style="text-decoration: none;float: right;margin-top:-20px;" value="" ng-click="addManual('Brand');">手动添加</a>
					</div>
					<div ng-show="brandInputShow">
						<input type="text" maxlength="20" ng-model="selectList.brandI" class="form-control" style="margin-top:-30px;margin-left:50px;width:260px;" placeholder="请输入品牌名称">
						<a ng-click="addSelect('Brand');" href="" style="text-decoration: none;float: right;margin-top:-23px;margin-right:28px;">重选</a>
					</div>
					<!-- 型号  -->
					<label contenteditable="false" class=" control-label" style="margin-top:30px;width:88px;margin-left:10px;">型号</label>
					<div ng-show="modelSelectShow">
						<select name="state" id="state"  ng-model="selectList.modelS"
								ng-options="rec.id as rec.name for rec in queryEquModelList"
								style="margin-top:-30px;margin-left:50px;width:260px;position:absolute;z-index:90;"
						         class="form-control select-hover" ng-change="modelChange(selectList.modelS);">
							<option value=""">请选择</option>
						</select>
					</div>
					<div ng-show="modelSelectShow">	
						<input  type="text"  maxlength="20" ng-model="selectList.modelI" class="form-control" style="margin-top:-30px;margin-left:50px;width:260px;" placeholder="请输入型号">
						<a ng-click="addManual('Model');" href="" style="text-decoration: none;float: right;margin-top:-23px;">手动添加</a>
					</div>
					<div ng-show="modelInputShow">	
						<input  type="text"  maxlength="20" ng-model="selectList.modelI" class="form-control" style="margin-top:-30px;margin-left:50px;width:260px;" placeholder="请输入型号">
						<a ng-click="addSelect('Model');" href="" style="text-decoration: none;float: right;margin-top:-23px;margin-right:28px;">重选</a>
					</div>
					<!-- 规格  -->
					<label contenteditable="false" class=" control-label" style="margin-top:30px;width:88px;margin-left:10px;">规格</label>
					<div ng-show="standardSelectShow">
						<select name="state" id="state"  ng-model="selectList.standardS"
								ng-options="rec.id as rec.name for rec in queryEquStandardList"
								style="margin-top:-30px;margin-left:50px;width:260px;position:absolute;z-index:80;"
						        class="form-control select-hover" ng-change="standardChange(selectList.standardS);">
							<option value=""">请选择</option>
						</select>
					</div>
					<div ng-show="standardSelectShow">	
						<input  type="text" maxlength="20" ng-model="selectList.satndardI" class="form-control" style="margin-top:-30px;margin-left:50px;width:260px;" placeholder="请输入规格">
						<a ng-click="addManual('Standard');" href="" style="text-decoration: none;float: right;margin-top:-23px;">手动添加</a>
					</div>
					<div ng-show="standardInputShow">	
						<input  type="text"  maxlength="20" ng-model="selectList.satndardI" class="form-control" style="margin-top:-30px;margin-left:50px;width:260px;" placeholder="请输入规格">
						<a ng-click="addSelect('Standard');" href="" style="text-decoration: none;float: right;margin-top:-23px;margin-right:28px;">重选</a>
					</div>
				</div>
       		</div>
       		<div class="modal-footer " >
                <input type="button" class="btn btn-primary" value="确定" ng-click="addModelSubimt();">
                <input type="button"  style="margin-right: 30px;"  class="btn btn-default" value="关闭" ng-click="addModelCancel();">
            </div>
       	</div>
    </div>
</div>

