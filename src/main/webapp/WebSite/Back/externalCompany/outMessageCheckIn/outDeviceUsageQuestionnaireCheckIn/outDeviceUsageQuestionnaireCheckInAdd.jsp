<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="OutAddId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">发布结果登记<button type="button"  style="margin-left: 800px" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<form action="" novalidate name="addForm">
				<div class="modal-body">
					<div class="form-horizontal" >
						<div class="form-group" style="margin-top: -10px;">
							<label contenteditable="false" class="col-sm-2 control-label">设备编号：</label>
							<div class="col-sm-4">
								<h5>{{userInfo.code}}-{{addPublishList.equNo}}</h5>
							</div>
							<label contenteditable="false" class="col-sm-2 control-label">资产编号：</label>
							<div class="col-sm-4">
								<h5>{{addPublishList.asset}}</h5>
							</div>
						</div>
						<div class="form-group" >
							<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
							<div class="col-sm-4">
								<h5>{{addPublishList.equipmentName}}</h5>
							</div>
							<label contenteditable="false" class="col-sm-2 control-label">品牌：</label>
							<div class="col-sm-4">
								<h5>{{addPublishList.brandName}}</h5>
							</div>
						</div>
						<div class="form-group" style="margin-top: -20px;">
						 	<label contenteditable="false" class="col-xs-2 control-label">流程状态：</label>
							<div class="col-xs-2" id="div_2">
								<select  class="form-control select-hover" required ng-model="addPublishList.state" name="state" style="position: absolute; z-index:3;">
								    <option value="2"  >未成交</option>
									<option value="1"  >已成交</option>
								</select>
							</div>
							<p class="" style="color: red;margin-left: 20px; margin-top:8px;float: left; ">*</p>
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-left:127px;">业务状态：</label>
							<div class="col-xs-2" id="div_2">
								<select class="form-control select-hover" required ng-model="addPublishList.busState" name="busState" style="position: absolute; z-index:3;">
								    <option value="">请选择</option>
									<option value="1">自用</option>
									<option value="5">外租</option>
								</select>
							</div>
							<p class="" style="color: red;margin-left: 20px; margin-top:8px;float: left; ">*</p>
							<div ng-messages="addForm.busState.$error" ng-show="showFlag == 'busState'">
					        <p class=""  style="color:red;margin-top: 25px " ng-message="required">请选择业务状态</p>
						</div>
						</div>
						<div style="width:100px;margin-top:-20px;margin-bottom: 10px;" ng-messages="addForm.state.$error" ng-show="showFlag == 'state'">
							<p class="" style="color:red;width:100px;margin-left:160px;" ng-message="required">请选择流程状态</p>
						</div>
						<div class="form-group" style="margin-top: -4px;">
							<label contenteditable="false" class="col-sm-2 control-label">设备成交单位：</label>
							<div class="col-sm-4">
								<!-- <input type="text" class="form-control" required ng-model="addPublishList.depName" name="depName"> -->
								<input data-toggle="dropdown" ng-model="addPublishList.depName" type="text" id="depName" name="depName" required class="form-control"  
								        maxlength="200"  ng-change="KeyWordQuery(addPublishList.depName,'LiNumA_','one');"   ng-blur="blurInput()"/>
							  <input type="text"  style="display:none"/>
							   <ul ng-show="LiNumA_" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs" style="position:absolute;display: block;margin-left:13px;width:290px;">
						           <li class="lable-lablecss" ng-repeat="RentInfo in KeyWordList" title="{{RentInfo.name}}" 
						               role="menuitem" tabindex="-1" ng-click="InputShow(RentInfo.name,'userInfo','Name','LiNumA_');" >
						         	  <a href="" style="margin-left:5px;font-size: 14px">{{RentInfo.infoTitleA}}</a>
						       </li>
					        </ul> 					        			 	        
							</div>
							 <span class="" style="color: red; margin-top:5px;float:left">*</span>
							<label contenteditable="false" class="col-sm-2 control-label" style="margin-left:-6px;">发布日期：</label>
							<div class="col-sm-3">
								<h5>{{addPublishList.releaseDate}}</h5>
							</div>
							<div style="width:150px;margin-top:-20px;margin-bottom: 10px;" ng-messages="addForm.depName.$error" ng-show="showFlag == 'depName'">
						  		<p class="" style="color:red;width:150px;margin-left:145px;margin-top: 50px;" ng-message="required">请填写使用单位</p>
							</div>
						</div>
						<div class="form-group">
							<label contenteditable="false" class="col-sm-2 control-label">备注：</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="3" maxlength="60" placeholder="请输入字符在60个以内" ng-model="addPublishList.note"/>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" >	
					<div style="text-align: center;">
						<input type="button"  class="btn btn_Under btn-default" style="margin-top: -20px" value="保存" ng-click="saveClick(addForm);"/>
						<input type="button"  class="btn btn_Under btn-default" style="margin-top: -20px" value="取消" data-dismiss="modal" ng-click="closemodel();"/>
					</div> 
				</div> 
			</form>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
