<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<div class="modal fade" id="equipmentMessage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 1000px;">
		<div class="modal-content">
			<h4 class="modal-title" style="font-weight:800">
				<span style="margin-left: 10px;">设备基本信息登记</span>
				<button type="button" style="margin-left: 785px; outline: none;" class="btn btn-link" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></button>
			</h4>
			<hr style="margin-top: -2px;" />
		<form action="" novalidate name="setForm" autocomplete="off">
			<div class="form-horizontal">
				<div class="form-group" style="margin: 0px;">
					<label contenteditable="false" class="col-xs-2 control-label">局级单位：</label>
					<div class="col-xs-5 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.bureauOrgPartyName"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">子公司名称：</label>
					<div class="col-xs-3 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.sonOrgName"></p>
						</div>
					</div>
				</div>
				<div class="form-group" style="margin: 0px;">
					<label contenteditable="false" class="col-xs-2 control-label">项目名称：</label>
					<div class="col-xs-10 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.proOrgName"></p>
						</div>
					</div>
				</div>
				<div class="form-group" style="margin: 0px;">
					<label contenteditable="false" class="col-xs-2 control-label">设备编号：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.equNo"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">资产编号：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.asset"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 34px;">设备名称：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.equName"></p>
						</div>
					</div>
				</div>
				<div class="form-group" style="margin: 0px;">
					<label contenteditable="false" class="col-xs-2 control-label">生产厂家：</label>
					<div class="col-xs-2 div_Modify" title="{{equipment.manufacturerName}}">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.manufacturerNameCopy"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">品牌：</label>
					<div class="col-xs-1 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.brandName"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: 5px;">型号：</label>
					<div class="col-xs-1 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.models"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-1 control-label">规格：</label>
					<div class="col-xs-1 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.specifications">&nbsp;</p>
						</div>
					</div>
				</div>
				<div class="form-group" style="margin: 0px;">
					<label contenteditable="false" class="col-xs-2 control-label">设备原值：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static">{{equipment.equipmentCost}}<span ng-show="equipment.equipmentCost">万元</span></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">功率（KW）：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.power"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 34px;">出厂编号：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.facortyNo"></p>
						</div>
					</div>
				</div>
				<div class="form-group" style="margin: 0px;">
					<label contenteditable="false" class="col-xs-2 control-label">出厂日期：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.productionDate"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">购置日期：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.purchaseDate"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 34px;">牌照号码：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="equipment.licenseNo"></p>
						</div>
					</div>
				</div>
				<div class="form-group" style="margin: 0px;">
					<label contenteditable="false" class="col-xs-2 control-label">技术状况：</label>
					<div class="col-xs-2 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="ct.codeTranslate(equipment.technicalStatus, 'TECHNOLOGY_STATE')"></p>
						</div>
					</div>
					<label contenteditable="false" class="col-xs-2 control-label">动力种类：</label>
					<div class="col-xs-6 div_Modify">
						<div class="form-inline">
							<p class="form-control-static" ng-bind="ct.codeTranslate(equipment.powerType, 'POWER_TYPE')"></p>
						</div>
					</div>
				</div>

				<h4 class="modal-title" style="padding-top: 15px; font-weight:800">
					<span style="margin-left: 10px;">设备使用情况登记</span>
					<span style="margin-left: 30px; font-size: 14px;">设备使来源分类</span>
					<span style="margin-left: 15px; font-size: 14px;" ng-show="qryEquDetail.equFlag==1"><input ng-checked="equipment.equipmentSourceNo==1" type="radio" disabled="disabled">自有</span>
					<span style="margin-left: 15px; font-size: 14px;" ng-show="qryEquDetail.equFlag==1"><input ng-checked="equipment.equipmentSourceNo==2" type="radio" disabled="disabled">外租</span>
					<span style="margin-left: 15px; font-size: 14px;" ng-show="qryEquDetail.equFlag==1"><input ng-checked="equipment.equipmentSourceNo==3" type="radio" disabled="disabled">外协</span>
					
					<span style="margin-left: 15px; font-size: 14px;" ng-show="qryEquDetail.equFlag==0"><input ng-checked="equipment.busState==2" type="radio" disabled="disabled">调拨</span>
					<span style="margin-left: 15px; font-size: 14px;" ng-show="qryEquDetail.equFlag==0"><input ng-checked="equipment.busState==3" type="radio" disabled="disabled">局内租</span>
					<span style="margin-left: 15px; font-size: 14px;" ng-show="qryEquDetail.equFlag==0"><input ng-checked="equipment.busState==4" type="radio" disabled="disabled">外局租</span>
					<span style="margin-left: 15px; font-size: 14px;" ng-show="qryEquDetail.equFlag==0"><input ng-checked="equipment.busState==5" type="radio" disabled="disabled">外租</span>
				</h4>
				<hr style="margin-top: -2px;" />

				<div ng-show="association">
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备来源说明：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline" style="width: 810px; margin-left: -7px">
								<textarea style="width: 730px; background-color: #fff;" class="form-control" ng-bind="equipment.equipmentSourceName" disabled="disabled"></textarea>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备状态：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="ct.codeTranslate(equipment.equState,'EQU_STATE')"></p>
							</div>
						</div>
						<div ng-show="equipment.equState==3">
							<label contenteditable="false" class="col-xs-2 control-label">出售价格：</label>
							<div class="col-xs-2 div_Modify">
								<div class="form-inline">
									<p class="form-control-static">{{equipment.sellPrice}}万元</p>
								</div>
							</div>
						</div>
						<div ng-show="equipment.equState==4">
							<label contenteditable="false" class="col-xs-2 control-label">报废残值：</label>
							<div class="col-xs-2 div_Modify">
								<div class="form-inline">
									<p class="form-control-static">{{equipment.scrapPrice}}万元</p>
								</div>
							</div>
						</div>
						<div ng-show="equipment.equState!=3 && equipment.equState!=4">
								<label contenteditable="false" class="col-xs-2 control-label"></label>
								<div class="col-xs-2 div_Modify">
									<div class="form-inline">
										&nbsp;
									</div>
								</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">业务状态：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="ct.codeTranslate(equipment.busState,'WORK_STATE')"></p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备使用单位：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.equAtName"></p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">发布状态：</label>
						<div class="col-xs-3 div_Modify" style="margin-top: 7px;">
							<div class="form-inline">
								<input type="checkbox" disabled="disabled" ng-checked="equipment.pubState==2 || equipment.pubState==4"/><span>出租发布中</span>
								<input type="checkbox" disabled="disabled" ng-checked="equipment.pubState==3 || equipment.pubState==4" style="margin-left: 10px;"/><span>出售发布中</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">所在城市：</label>
						<div class="col-xs-5 div_Modify">
							<div class="form-inline">
								<p class="form-control-static">{{equipment.onProvince}} - {{equipment.onCity}} - {{equipment.onDistrict}}</p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">详细地址：</label>
						<div class="col-xs-5 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.address"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">保管人：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.custodian"></p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">联系电话：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.contactPersonPhone"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">进场日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.approachDate"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: -47px;">出场日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.exitDate"></p>
							</div>
						</div>
					</div>
				</div>
				<div ng-show="own">
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备来源说明：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline" style="width: 810px; margin-left: -7px">
								<textarea style="width: 730px; background-color: #fff;" class="form-control" ng-bind="equipment.equipmentSourceName" disabled="disabled"></textarea>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">所在城市：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline">
								<p class="form-control-static">{{equipment.onProvince}} - {{equipment.onCity}} - {{equipment.onDistrict}}</p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">详细地址：</label>
						<div class="col-xs-5 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.address"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">保管人：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.custodian"></p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">联系电话：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.contactPersonPhone"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">进场日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.approachDate"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: -47px;">出场日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.exitDate"></p>
							</div>
						</div>
					</div>
				</div>
				<div ng-show="stocks">
					<h4 class="modal-title" style="padding-top: 15px; font-weight:800">
						<span style="margin-left: 10px;">交易信息登记</span>
					</h4>
					<hr style="margin-top: -2px;" />

					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">租赁方式：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="ct.codeTranslate(equipment.leaseModeName, 'RENT_TYPE')"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">结算方式：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="ct.codeTranslate(equipment.settlementModeName,'COLSE_TYPE')"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 5px;">租赁单价：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.leasePrice"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">合同编号：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipment.contractNo"></p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">备注：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline" style="width: 810px; margin-left: -7px">
								<textarea style="width: 730px; background-color: #fff;" rows="3" class="form-control" ng-bind="equipment.remark" disabled="disabled"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal-footer">
				<input type="button" class="btn btn_Under btn-default" style="margin-top: -20px; width: 50px;" value="取消" data-dismiss="modal" />
			</div>
		</form>
		</div>
	</div>
</div>
