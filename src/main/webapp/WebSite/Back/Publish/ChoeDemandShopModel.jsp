<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 出租信息-请选择或填写：品牌、型号、规格（Modal） -->
<div id="fade" class="fades"></div>
<div class="login_bg width300 marleft23" id="openwin4" style="position: fixed;">
<div id="returnId"></div>
	<div class="ihhatitle1">请选择或者填写：品牌、型号、规格</div>
	<div class="fbxx_top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="gwafdg">
			<tr>
				<td class="txt16">当前设备名称： <span class="col_9">{{inputModel.parm}}</span></td>
			</tr>
		</table>
		<div class="clear"></div>

	</div>

	<div class="mar_t15">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tab_hj">
			<tr>
				<th width="30%">品牌</th>
				<td><select ng-show="brandSelectShow" style="width: 230px"
					class="sel_a marr15 span230" name="PayerAcNo"
					ng-options="rec.id as rec.name for rec in queryEquBrandList"
					ng-model="selectList.brandS"
					ng-change="brandChange(selectList.brandS);">
						<option value="">请选择</option>
				</select>
					<div ng-show="brandSelectShow">
						<a href="" style="text-decoration: none; float: left;" value=""
							ng-click="addManual('Brand');">手动添加</a>
					</div>
					<div ng-show="brandInputShow">
						<input type="text" maxlength="20" ng-model="selectList.brandI"
							class="inpt_a inpt_o span230" style="width: 230px;"
							placeholder="请输入品牌名称"> <a ng-click="addSelect('Brand');"
							href="" style="text-decoration: none; float: left;">重选</a>
					</div></td>
			</tr>
			<tr>
				<th>型号</th>
				<td><select ng-show="modelSelectShow" style="width: 230px"
					class="sel_a marr15 span230" name="PayerAcNo"
					ng-model="selectList.modelS"
					ng-options="rec.id as rec.name for rec in queryEquModelList"
					ng-change="modelChange(selectList.modelS);">
						<option value=""">请选择</option>
				</select>
					<div ng-show="modelSelectShow">
						<a ng-click="addManual('Model');" href=""
							style="text-decoration: none; float: left;">手动添加</a>
					</div>
					<div ng-show="modelInputShow">
						<input type="text" maxlength="20" ng-model="selectList.modelI"
							class="inpt_a inpt_o span230" style="width: 230px;"
							placeholder="请输入型号"> <a ng-click="addSelect('Model');"
							href="" style="text-decoration: none; float: left;">重选</a>
					</div></td>
			</tr>
			<tr>
				<th>规格</th>
				<td><select ng-show="standardSelectShow" style="width: 230px"
					class="sel_a marr15 span230" name="PayerAcNo"
					ng-model="selectList.standardS"
					ng-options="rec.id as rec.name for rec in queryEquStandardList"
					ng-change="standardChange(selectList.standardS);">
						<option value=""">请选择</option>
				</select>
					<div ng-show="standardSelectShow">
						<a ng-click="addManual('Standard');" href=""
							style="text-decoration: none; float: left;">手动添加</a>
					</div>
					<div ng-show="standardInputShow">
						<input type="text" maxlength="20" ng-model="selectList.satndardI"
							class="inpt_a inpt_o span230" style="width: 230px;"
							placeholder="请输入规格"> <a ng-click="addSelect('Standard');"
							href="" style="text-decoration: none; float: left;">重选</a>
					</div></td>
			</tr>
		</table>

	</div>


	<div class="ihhaann">
		<a class="iehi_d left close_openwin" ng-click="addModelCancel();">关闭</a><a
			class="iehi_d left" ng-click="addModelSubimt();">确认</a>
	</div>

</div>
<!--弹出div END-->
