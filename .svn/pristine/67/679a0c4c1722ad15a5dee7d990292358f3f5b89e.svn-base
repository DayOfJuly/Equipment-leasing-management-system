<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!-- 设备资源添加/修改-模态框（Modal） -->
<div class="modal fade" id="equipmentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 1000px;">
		<div class="modal-content">
			<h4 class="modal-title" style="font-weight: 800;">
				<span style="margin-left: 10px;">设备基本信息登记</span>
				<button type="button" style="margin-left: 785px; outline: none;" class="btn btn-link" ng-click="closeAddModal()"><span class="glyphicon glyphicon-remove"></span></button>
			</h4>
			<hr style="margin-top: -2px;" />
		<form action="" novalidate name="setForm" autocomplete="off">
			<div class="modal-body" id="equipmentModalIdA">
				<dateTimePickerTab></dateTimePickerTab>
				<div class="form-horizontal">
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">单位名称：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipmentBean.bureauName"></p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备编号：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.equNo" type="text" id="equNo" name="equNo" class="form-control" maxlength="30" required ng-blur="checkEquNoToExist()" style="height: 22px; width: 122px; margin-left: -10px;" />
								<span style="color: red;">&nbsp;&nbsp;*</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">资产编号：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.asset" type="text" id="asset" name="asset" class="form-control" maxlength="30" style="height: 22px;" />
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">设备名称：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<div class="input-group">
									<input ng-model="equipmentBean.equName" id="equName" name="equName" required type="text" class="form-control" style="width: 124px; height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
									<span class="input-group-btn" style="padding-top: 3px;">
										<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEquNameModel()">…</button>
									</span>
									<span style="color: red;">&nbsp;&nbsp;*</span>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">生产厂家：</label>
						<div class="col-xs-2 div_Modify" title="{{equipmentBean.manufacturerName}}">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipmentBean.manufacturerNameCopy"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">品牌：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipmentBean.brandName"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: 6px;">型号：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipmentBean.models"></p>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-1 control-label">规格：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<p class="form-control-static" ng-bind="equipmentBean.specifications"></p>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备原值：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.equipmentCost" type="text" id="equipmentCost" name="equipmentCost" class="form-control" maxlength="20" style="height: 22px; width: 122px; margin-left: -10px;" placeholder="{{placeholders.equipmentCost}}"/>
								<span>万元</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">功率（KW）：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.power" type="text" id="power" name="power" class="form-control" maxlength="8" style="height: 22px;" />
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">出厂编号：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.facortyNo" type="text" id="facortyNo" name="facortyNo" class="form-control" maxlength="30" style="height: 22px;" />
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">出厂日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline" style="margin-left: -10px;">
								<input ng-model="equipmentBean.productionDate" id="productionDate" name="productionDate" type="text" class="form-control input-group date form_date" style="height: 22px; width: 122px; position: absolute; display: block;" data-date-format="yyyy-mm-dd">
								<span class="input-group-addon" style="display: none">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">购置日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.purchaseDate" id="purchaseDate" name="purchaseDate" type="text" class="form-control input-group date form_date" style="height: 22px; position: absolute; display: block;" data-date-format="yyyy-mm-dd">
								<span class="input-group-addon" style="display: none">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">牌照号码：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.licenseNo" type="text" id="licenseNo" name="licenseNo" class="form-control" maxlength="30" style="height: 22px;" />
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">技术状况：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<select ng-model="equipmentBean.technicalStatus" ng-options="s.id_ as s.name_ for s in sysCodeCon.TECHNOLOGY_STATE" name="technicalStatus" id="technicalStatus" 
									class="form-control select-hover" style="height: 22px; margin-left: -10px; width: 122px;">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">动力种类：</label>
						<div class="col-xs-6 div_Modify">
							<div class="form-inline">
								<select ng-model="equipmentBean.powerType" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.POWER_TYPE" name="powerType" id="powerType" 
									class="form-control select-hover" style="height: 22px; width: 155px;">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
					</div>

					<h4 class="modal-title" style="padding-top: 15px; font-weight:800">
						<span style="margin-left: 10px;">设备使用情况登记</span>
						<span ng-show="equipmentBean.flagShow_=='upd'" style="margin-left: 15px;"><input type="button" class="btn btn-primary" style="height: 22px; width: 130px; margin-top: -6px;" ng-click="saveButton(setForm)" ng-disabled="equipmentBean.equState!='2'" value="当前使用情况完成 "/></span>
						<span ng-show="equipmentBean.flagShow_=='upd'" style="font-size: 12px; color: red;">提示：点击此按钮后，即将当前设备的情况记入历史数据</span>
					</h4>
					<hr style="margin-top: -2px;" />

					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备来源说明：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline" style="width: 810px; margin-left: -10px">
								<textarea style="width: 730px;" maxlength="100" class="form-control" name="equipmentSourceName" ng-model="equipmentBean.equipmentSourceName"></textarea>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备状态：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<select ng-model="equipmentBean.equState" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.EQU_STATE" required name="equState" 
									class="form-control select-hover" style="height: 22px; margin-left: -10px; width: 122px;" ng-change="changeEquState()">
									<option value="">请选择</option>
								</select>
								<span style="color: red;">&nbsp;&nbsp;*</span>
							</div>
						</div>
						<div ng-show="equipmentBean.equState=='3'">
							<label contenteditable="false" class="col-xs-2 control-label">出售价格：</label>
							<div class="col-xs-2 div_Modify">
								<div class="form-inline">
									<input ng-model="equipmentBean.sellPrice" type="text" name="sellPrice" class="form-control" maxlength="20" style="height: 22px; width: 106px; margin-left: -10px;" placeholder="{{placeholders.sellPrice}}" required />
									<span>万元</span>
									<span style="color: red;">&nbsp;&nbsp;*</span>
								</div>
							</div>
						</div>
						<div ng-show="equipmentBean.equState=='4'">
							<label contenteditable="false" class="col-xs-2 control-label">报废残值：</label>
							<div class="col-xs-2 div_Modify">
								<div class="form-inline">
									<input ng-model="equipmentBean.scrapPrice" type="text" name="scrapPrice" class="form-control" maxlength="20" style="height: 22px; width: 106px; margin-left: -10px;" placeholder="{{placeholders.scrapPrice}}" required />
									<span>万元</span>
									<span style="color: red;">&nbsp;&nbsp;*</span>
								</div>
							</div>
						</div>
						<div ng-show="equipmentBean.equState!='3' && equipmentBean.equState!='4'">
							<label contenteditable="false" class="col-xs-2 control-label"></label>
							<div class="col-xs-2 div_Modify">
								<div class="form-inline">
									&nbsp;
								</div>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">业务状态：</label><!-- 这里的校验需要做不是必选项的判断！！！ -->
						<div class="col-xs-3 div_Modify">
							<div class="form-inline">
								<select ng-model="equipmentBean.busState" ng-options="rec.id_ as rec.name_ for rec in sysCodeCon.EQUIPMENT_SOURCE_COPY" name="busState" required class="form-control select-hover" 
									ng-disabled="equipmentBean.equShowDisFlag_" ng-change="changeBusState()" style="height: 22px; width: 140px; background-color: #fff;">
									<option value="">请选择</option>
								</select>
								<span ng-show="equipmentBean.equShowRedFlag_" style="color: red;">&nbsp;&nbsp;*</span>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备使用单位：</label>
						<div class="col-xs-3 div_Modify">
							<div class="form-inline" style="margin-top: 6px;">
								<input type="button" class="btn btn-primary" ng-disabled="equipmentBean.equShowDisFlag_ || equipmentBean.busState=='1'" style="margin-left: -10px; height: 22px; width: 120px;" value="请选择" ng-click="openEquAtProjectModel()" />
								<span ng-show="equipmentBean.equShowRedFlag_" style="color: red;">&nbsp;&nbsp;*</span>
							</div>
						</div>
						<div class="col-xs-7 div_Modify" style="margin-left: -100px;">
							<div class="form-inline">
								<input ng-model="equipmentBean.equAtName" type="text" name="equAtName" style="height: 22px; width: 577px; background-color: #fff;" class="form-control" disabled="disabled" required />
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">发布状态：</label>
						<div class="col-xs-3 div_Modify" style="margin-top: 7px;">
							<div class="form-inline">
								<input type="checkbox" disabled="disabled" ng-checked="equipmentBean.pubState==2 || equipmentBean.pubState==4"/><span class="text-primary">出租发布中</span>
								<input type="checkbox" disabled="disabled" ng-checked="equipmentBean.pubState==3 || equipmentBean.pubState==4" style="margin-left: 10px;"/><span class="text-primary">出售发布中</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: -77px;">所在城市：</label>
						<div class="col-xs-6 div_Modify" style="padding: 0px; margin-left: -2px;">
							<div class="form-inline">
								<select ng-model="equipmentBean.onProvinceId" ng-options="recPro.regionId as recPro.name for recPro in areaList" id="onProvinceId" name="onProvinceId" required 
									class="form-control select-hover" ng-change="changeProvince()" style="width: 140px;">  	
	                        		<option value="">请选择省份</option>
	                    		</select>
								<select ng-model="equipmentBean.onCityId" ng-options="recCit.regionId as recCit.name for recCit in pList" id="onCityId" name="onCityId" required 
									class="form-control select-hover" ng-change="changeCity()" style="width: 140px;">  	
	                        		<option value="">请选择城市</option>
	                    		</select>
								<select ng-model="equipmentBean.onDistrictId" ng-options="recDis.regionId as recDis.name for recDis in cList" id="onDistrictId" name="onDistrictId" required 
									class="form-control select-hover" style="width: 140px;">  	
	                        		<option value="">请选择区县</option>
	                    		</select>
	                    		<span style="color: red;">&nbsp;&nbsp;*</span>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">详细地址：</label>
						<div class="col-xs-6 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.address" type="text" name="address" class="form-control" maxlength="50" style="height: 22px; margin-left: -10px; width: 445px;" />
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: -35px;">保管人：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.custodian" type="text" name="custodian" class="form-control" maxlength="10" style="height: 22px; width: 140px;" />
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">联系电话：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.contactPersonPhone" type="text" name="contactPersonPhone" class="form-control" maxlength="20" style="height: 22px; width: 122px; margin-left: -10px;" required />
	                    		<span style="color: red;">&nbsp;&nbsp;*</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">进场日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline" style="margin-left: -10px;">
								<input ng-model="equipmentBean.approachDate" name="approachDate" type="text" class="form-control input-group date form_date" style="height: 22px; position: absolute; display: block;" data-date-format="yyyy-mm-dd" required >
								<span class="input-group-addon" style="display: none">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">出场日期：</label>
						<div class="col-xs-2 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.exitDate" name="exitDate" type="text" class="form-control input-group date form_date" style="height: 22px; width: 140px; position: absolute; display: block;" data-date-format="yyyy-mm-dd" required >
								<span class="input-group-addon" style="display: none">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>

					<h4 class="modal-title" style="padding-top: 15px; font-weight:800">
						<span style="margin-left: 10px;">交易信息登记</span>
					</h4>
					<hr style="margin-top: -2px;" />

					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">租赁方式：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<select ng-model="equipmentBean.leaseModeName" ng-options="rentType.id_ as rentType.name_ for rentType in sysCodeCon.RENT_TYPE" name="leaseModeName" 
									class="form-control select-hover" style="height: 22px; margin-left: -10px; width: 122px; background-color: #fff;" ng-disabled="equipmentBean.SupplementStar">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">结算方式：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<select ng-model="equipmentBean.settlementModeName" ng-options="closeType.id_ as closeType.name_ for closeType in sysCodeCon.COLSE_TYPE" name="leaseModeName" 
									class="form-control select-hover" style="height: 22px; margin-left: -10px; width: 122px; background-color: #fff;" ng-disabled="equipmentBean.SupplementStar">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">租赁单价：</label>
						<div class="col-xs-1 div_Modify" style="padding: 0px;">
							<div class="form-inline">
								<input ng-model="equipmentBean.leasePrice" type="text" name="leasePrice" class="form-control" maxlength="20" 
									style="height: 22px; margin-left: -10px; width: 72px; background-color: #fff;" ng-disabled="equipmentBean.SupplementStar" />
								<span>元</span>
							</div>
						</div>
						<label contenteditable="false" class="col-xs-2 control-label">合同编号：</label>
						<div class="col-xs-1 div_Modify">
							<div class="form-inline">
								<input ng-model="equipmentBean.contractNo" type="text" name="contractNo" class="form-control" maxlength="20" 
									style="height: 22px; margin-left: -10px; width: 102px; background-color: #fff;" ng-disabled="equipmentBean.SupplementStar" />
							</div>
						</div>
					</div>
					<div class="form-group" style="margin: 0px;">
						<label contenteditable="false" class="col-xs-2 control-label">备注：</label>
						<div class="col-xs-10 div_Modify">
							<div class="form-inline" style="width: 810px; margin-left: -10px">
								<textarea style="width: 730px; background-color: #fff;" maxlength="120" rows="3" class="form-control" name="remark" ng-model="equipmentBean.remark" ng-disabled="equipmentBean.SupplementStar" placeholder="{{placeholders.remark}}" ></textarea>
							</div>
						</div>
					</div>
				</div>

				<div class="modal-footer" style="height: 70px;">
					<div class="col-xs-12 text-center">
						<span ng-messages="setForm.equNo.$error" ng-show="showFlag=='equNo'">
							<span style="font-size: 18px; color: red;" ng-message="required">请输入设备编号</span>
						</span>
						<span ng-messages="setForm.equName.$error" ng-show="showFlag=='equName'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择设备名称</span>
						</span>

						<span ng-messages="setForm.equState.$error" ng-show="showFlag=='equState'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择设备状态</span>
						</span>
						<span ng-messages="setForm.busState.$error" ng-show="showFlag=='busState'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择业务状态</span>
						</span>
						<span ng-messages="setForm.equAtName.$error" ng-show="showFlag=='equAtName'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择设备使用单位</span>
						</span>
						<span ng-messages="setForm.sellPrice.$error" ng-show="showFlag=='sellPrice'">
							<span style="font-size: 18px; color: red;" ng-message="required">请输入出售价格</span>
						</span>
						<span ng-messages="setForm.scrapPrice.$error" ng-show="showFlag=='scrapPrice'">
							<span style="font-size: 18px; color: red;" ng-message="required">请输入报废残值</span>
						</span>
						<span ng-messages="setForm.onProvinceId.$error" ng-show="showFlag=='onProvinceId'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择所在省份</span>
						</span>
						<span ng-messages="setForm.onCityId.$error" ng-show="showFlag=='onCityId'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择所在城市</span>
						</span>
						<span ng-messages="setForm.onDistrictId.$error" ng-show="showFlag=='onDistrictId'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择所在区县</span>
						</span>
						<span ng-messages="setForm.contactPersonPhone.$error" ng-show="showFlag=='contactPersonPhone'">
							<span style="font-size: 18px; color: red;" ng-message="required">请输入联系电话</span>
						</span>
						<span ng-messages="setForm.approachDate.$error" ng-show="showFlag=='approachDate'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择进场日期</span>
						</span>
						<span ng-messages="setForm.exitDate.$error" ng-show="showFlag=='exitDate'">
							<span style="font-size: 18px; color: red;" ng-message="required">请选择出场日期</span>
						</span>

						<span ng-show="showFlag=='sellPricePattern'">
							<span style="font-size: 18px; color: red;">请输入正确的出售价格</span>
						</span>
						<span ng-show="showFlag=='scrapPricePattern'">
							<span style="font-size: 18px; color: red;">请输入正确的报废残值</span>
						</span>
						<span ng-show="showFlag=='leasePricePattern'">
							<span style="font-size: 18px; color: red;">请输入正确的租赁单价</span>
						</span>
						<span ng-show="showFlag=='equipmentCostPattern'">
							<span style="font-size: 18px; color: red;">请输入正确的设备原值</span>
						</span>
						<span ng-show="showFlag=='powerPattern'">
							<span style="font-size: 18px; color: red;">请输入正确的功率</span>
						</span>

						<span ng-show="showFlag=='contactPersonPhonePartten'">
							<span style="font-size: 18px; color: red;">请输入正确的联系电话</span>
						</span>
						
						<span class="pull-right">
							<input type="button" class="btn btn_Under btn-primary" style="width: 110px;" value="保存并关闭" ng-show="equipmentBean.flagShow_=='add'" ng-click="addEqu(setForm,1)"/>
							<input type="button" class="btn btn_Under btn-primary" style="width: 90px;" value="继续添加" ng-show="equipmentBean.flagShow_=='add'" ng-click="addEqu(setForm,2)"/>
							<input type="button" class="btn btn_Under btn-primary" style="width: 50px;" value="保存" ng-show="equipmentBean.flagShow_=='upd'" ng-click="updEqu(setForm)"/>
							<input type="button" class="btn btn_Under btn-default" style="width: 50px;" value="取消" ng-click="closeAddModal()" />
						</span>
					</div>
				</div>
			</div>
		</form>
		</div>
	</div>
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
		forceParse : 0,
		container:'dateTimePickerTab'
	}).on('hide', function(ev){
		$('#equipmentModal').focus();
	});
</script>
