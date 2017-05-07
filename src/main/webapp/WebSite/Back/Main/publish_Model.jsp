<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal）-->
<div class="modal fade" id="publishBackModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;margin-top: 180px">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">发布结果登记
				<button type="button"  style="float:right;;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<form action="" novalidate name="addForm">
				<div class="modal-body">
					<div class="form-horizontal">
						<div class="form-group" style="margin-top: -10px">
							<label contenteditable="false" class="col-sm-2 control-label">设备编号：</label>
							<div class="col-sm-4" style="margin-top:8px">
								<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.equNo}}</h5>
							</div>
							<label contenteditable="false" class="col-sm-2 control-label">资产编号：</label>
							<div class="col-sm-4" style="margin-top:8px">
								<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.asset}}</h5>
							</div>
						</div>
						<div class="form-group" >
							<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
							<div class="col-sm-4" style="margin-top:8px">
								<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.equipmentName}}</h5>
							</div>
							<label contenteditable="false" class="col-sm-2 control-label">品牌：</label>
							<div class="col-sm-4" style="margin-top:8px">
								<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.brandName}}</h5>
							</div>
						</div>
						<div class="form-group" style="">
						 	<label contenteditable="false" class="col-xs-2 control-label">交易状态：</label>
							<div class="col-xs-2" id="div_2">
								<select  class="form-control select-hover" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.STATETYPE_EQU_STATE" required name="state" ng-model="addPublishList.state" ng-disabled="dis" ng-change="state();" style="position: absolute; z-index:3;">
									<option value="">请选择</option>
								</select>
							</div>
							
							<p  class="" style="color: red;margin-left: 20px; margin-top:9px;float: left; ">*</p>
							<label ng-show="show==2" contenteditable="false" class="col-xs-3 control-label" style="margin-left:53px;">成交单位类型：</label>
							<div class="col-xs-2" id="div_2"  ng-show="show==2">
								<select class="form-control select-hover" required ng-options="r.id_ as r.name_ for r in sysCodeCon.TYPE_EQU_STATE" ng-disabled="type" name="busState" ng-model="addPublishList.busState" ng-click="suerClick(addPublishList.busState)" style="position: absolute; z-index:3;">
								    <option value="">请选择</option>
								</select>
							</div>
							<p  ng-show="show==2" class="" style="color: red;margin-left: 20px; margin-top:9px;float: left; ">*</p>
						</div>
						
						<div class="form-group" style="margin-top: -4px">
						
						
							<label  ng-show="show==2" contenteditable="false" class="col-sm-2 control-label"  style="margin-top: 8px">设备成交单位：</label>
							<div class="col-sm-4"  ng-show="show==2">
								<div class="input-group">
									<input ng-if="name==2"  ng-model="equQryBean.orgName" type="text" maxlength="30" class="form-control" style="width: 170px;margin-top:8px; margin-left: 0; height: 34px; background-color: #fff;">
									<input ng-if="name==1" ng-model="addPublishList.depName" type="text" maxlength="30" class="form-control" style="width: 170px;margin-top:8px; margin-left: 0; height: 34px; background-color: #fff;">
									<div style="margin-left:170px;" ng-show="sh">
										<span class="input-group-btn" style="padding-top: 8px; margin-left:-2px;">
											<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEmployerModel()">…</button>
										</span>
									</div>
								</div>
							</div>
							<span  ng-show="show==2" class="" style="color: red; margin-top:18px;margin-left:-99px;float:left">*</span>					

							<label contenteditable="false" class="col-sm-2 control-label" style="margin-top: 8px">发布日期：</label>
							<div class="col-sm-3" style="margin-top:16px">
								<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.releaseDate}}</h5>
							</div>
						</div>
						<div  ng-show="show==2" class="form-group" style="margin-top: -4px">
							<label contenteditable="false" class="col-sm-2 control-label">预估金额：</label>
							<div class="col-sm-3">
						  		<input type="text" class="form-control" ng-model="addPublishList.forecastSum"  ng-change="formatMoney(addPublishList.forecastSum,'forecastSum',6);"/>
							</div>
							<div class="col-sm-1" style="margin-top:8px;margin-left:-16px">
								万元
							</div>
						</div>
						<div class="form-group">
							<label contenteditable="false" class="col-sm-2 control-label">备注：</label>
							<div class="col-sm-8">
								<textarea style="resize: none;"class="form-control" rows="3"  maxlength="200" placeholder="请输入字符在200个以内" ng-model="addPublishList.note"></textarea>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" >	
					<div style="margin-top:10px">
						<input type="button"  class="btn btn_Under btn-primary" style="margin-top: -20px" value="保存" ng-click="saveClick(addForm)"/>
						<input type="button"  class="btn  btn_Under btn-default" style="margin-top: -20px" value="取消" data-dismiss="modal" ng-click="closemodel();"/>
					</div> 
				</div> 
			</form>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
</div>