
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 出租信息新增模态框（Modal） -->
<div id="fade" class="fades"></div>

<div class="login_bg width600 marleft3" id="openwin3" >
<div id="returnId"></div>
	<div class="ihhatitle1">设备信息</div>
	<div class="fbxx_top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="gwafdg">
			<tr>
				<td width="5%"></td>
				<td width="8%">设备分类：</td>
				<td width="25%"><select class="sel_a marr15 span230"
					name="PayerAcNo" ng-model="rec.equCategoryId"
					ng-click="queryClassify(rec);">
						<option value="">请选择</option>
						<option value="{{rec.equCategoryId}}"
							ng-repeat="rec in categorySelectList"
							>{{rec.equipmentCategoryName}}</option>
				</select></td>

				<td width="8%">设备名称：</td>
				<td width="25%">
					<!-- <select class="sel_a marr15 span230"
					name="PayerAcNo" ng-model="equ_List.equNameId"
					ng-click="IEChange(equ_List,'equName');">
						<option value="">请选择</option>
						<option value="{{rec.equNameId}}" ng-repeat="rec in equList"
							ng-click="saveValueOfEquList(rec);">{{rec.equipmentName}}</option>
					</select> -->
					<input class="inpt_a inpt_o span110" style="width:72%" value="" type="text" ng-model="equ_List.name" />
				</td>
				<td width="29%"><input class="inpt_booom inpt_booom_pol"
					value="查询" type="submit" ng-click="query(rec.equCategoryId,1);" /></td>
			</tr>
		</table>
		<div class="clear"></div>

	</div>

	<div class="mar_t15">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tab_hj table-hover">
			<tr>
				<th style="text-align: center;">序号</th>
				<th style="text-align: center;">设备类别号 </th>
				<th style="text-align: center;">设备分类</th>
				<th style="text-align: center;">设备名称</th>
			</tr>
			<tr ng-repeat="t in categoryList" style="text-align: center;"
				ng-click="Select(t,$index);"
				ng-dblclick="selectSubmit(equipment_obj,this,inputModel);">
				<td><input type="radio" ng-checked="radioTrIndex==$index" /> <span
					style="float:; margin-left: 0px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</span>
				</td>
				<td>{{t.equCategory.equipmentCategoryNo}}</td>
				<td>{{t.equCategory.equipmentCategoryName}}</td>
				<td>{{t.equName.equipmentName}}</td>
			</tr>
		</table>

	</div>
	<div class="goper">
		<div style="margin-top: -20px; margin-left: 300px"
			ng-show="categoryList.length!=0">
			<tm-paginationss conf="paginationConf" ng-click="queryCategoryData();"></tm-paginationss>
		</div>
	</div>

    <div>
    	<input type="text" class="inpt_a inpt_o width50" ng-show="categoryList.length!=0"  ng-model="inputModel.parm" maxlength="200"  />
		<a style="margin-left: 180px;" class="iehi_d left" href="####" ng-click="selectSubmit(equipment_obj,this,inputModel);">确认</a>
		<a style="margin-left: 5px"	class="iehi_d left close_openwin" href="####" ng-click="cancelSubmit();">关闭</a>
    </div>
	
</div>
<div ng-include src="'../../../WebSite/Front/Publish/ChoeDemandModel.jsp'"></div>
	

