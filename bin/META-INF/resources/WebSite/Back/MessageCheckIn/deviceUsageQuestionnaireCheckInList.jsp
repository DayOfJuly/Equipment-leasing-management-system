<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>租赁费登记-设备使用者</title>


<style>
.container {width: 1500px !important;}
.form-horizontal .control-label {
	padding-top: 7px;
	margin-bottom: 0;
	text-align: right;
	min-width : 0px;
}
/**
*新分页的样式css
*/
.page-list .pagination {float:left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float:left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left:3px;}
.page-list .page-total select {width: 50px;}
::-ms-clear, ::-ms-reveal{display: none;} 
</style>
</head>

<body  class="container">
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">信息登记</li>
		<li style="font-size: 13px">租赁费登记-承租方</li>
	</ol>
	<form name="formName" action="" style="width:95%;margin-left:80px" autocomplete="off">
				<div class="form-horizontal" style="margin-top: 10px;">
					<div class="form-group" style="margin-left:70px">
					<div class="col-xs-4" style="margin-top:-17px;">
						<label contenteditable="false" class="col-xs-3 control-label">当前单位：</label>
							   <!--  <div class="container-autocomplete" >
						  		 <input data-toggle="dropdown" ng-click="clickInput(employeeEntity.orgName);" ng-blur="blurInput();" ng-model="employeeEntity.orgName" ng-change="KeyWordQuery(employeeEntity.orgName,'LiNumA');" ng-blur="blurInput();" id="searchContent" name="searchContent" type="text"  style="width:285px;" class="form-control"maxlength="200" />  
								 <ul ng-show="LiNumA" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs" style="position: absolute;display: block;margin-left:142px;margin-top:-1px;">
							           <li style="width:285px" class="lable-lablecss" ng-repeat="RentInfo in KeyWordList" title="{{RentInfo.name}}" 
							               role="menuitem" tabindex="-1" ng-click="InputShow(RentInfo.name,'employeeEntity','orgName','LiNumA',RentInfo.orgLevel,RentInfo.currOrgId,'changeOrgId','changOrgName',RentInfo.code);" >
							         	  <lable style="margin-left:5px;">{{RentInfo.infoTitleA}}</lable><lable style="float: right;">
							           </li>
							      </ul>
					     		</div>  -->
		     			<div ng-show="!userInfo.proId" class="input-group">
							<input ng-model="equQryBean.equAtOrgNameSelect" type="text" class="form-control input-group date form_date" style="margin-top: 6px; width: 100%; height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
							<span class="input-group-btn" style="padding-top: 6px;">
								<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEquAtEmployerModel()">…</button>
							</span>
						</div>
						
					    <input style="margin-left: -23px;" ng-show="userInfo.proId"  ng-model="equQryBean.equAtOrgNameInput" type="text" class="inpt_a inpt_o span230" readonly="readonly" />
					    
						<div class="col-xs-4"  style="margin-top:-28px;margin-left:415px"  ng-show="(equQryBean.equAtOrgFlag==9 || equQryBean.equAtOrgFlag==1 || equQryBean.equAtOrgFlag!=2 && equQryBean.equAtOrgFlag!=3)">
						 	 <input type="checkbox" ng-model="employeeEntity.isInclude" ng-true-value="1" ng-false-value="0"  style="position: absolute;z-index:3;margin-top:11px;">
							 <label contenteditable="false" class="control-label" style="margin-left:-25px;position: absolute;z-index:2">包含下级单位</label> 
						</div>
					</div>
						<!-- 登记月份  -->
						<label contenteditable="false" class="col-xs-1 control-label" style="margin-top:-17px;margin-left:100px">登记月份：</label>
						<div class="col-xs-3" style="float: left; width: 160px; margin-left: -10px;margin-top:-17px;" >
							<input ng-click="clickDateFunEnd();" ng-blur="cleanFlagFunEnd();" id="endDateId" type="text" ng-init="getNowDateStr();"   ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endDate"><!-- 触发事件 --> 
	 						<span class="input-group-addon" style="display: none">
								<span class="glyphicon glyphicon-calendar"> </span>
							</span>
						</div>
						<div class="col-xs-2" style="margin-top:-9px;">
							<input type="button" class="btn btn-primary" value="查询" ng-click="queryAllMess(1);" style="z-index:1;"/>
						</div>
					</div>
					<div class="form-group" >
						<table class="table table-striped table-hover" style="width: 80%;margin-left:50px;z-index:3;margin:10px 0px 0px 0px">
							<thead>
								<tr class="success">
									<th style="text-align:center;width: 1px;white-space: nowrap;"></th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">序号</th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">设备编号</th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">设备名称</th>
									<th style="text-align:center;width: 51px;white-space: nowrap;">品牌</th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">型号</th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">设备牌照</th>
									<th style="text-align:center;width: 50px;white-space: nowrap;">起止日期</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租赁单价(元)</th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">租期单位</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租期数量</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">结算金额(元)</th>
									<th style="text-align:center;width: 50px;white-space: nowrap;">进出场费/安拆费(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">扣除金额(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">备注</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="f in formParmsList" ng-click="selectRow(this)" style="text-align:center;">
									<!-- <td >
			         				    <input style="margin-left:-15px;margin-top:1px;" type="radio" name="onlyOne" ng-checked="radio_flag==$index"/>
			         					<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
			         				</td> -->
			         				<td>
										<input style="margin: 2px -17px 0 29px;" type="radio" name="onlyOne" ng-checked="radio_flag==$index"/>
									</td>
									<td>
										<p align="left" style="margin: 0px -9px -2px 19px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
									</td>					
									<td style="width: 40px;" title="{{f.equNo}}">{{f.equNoA}}</td>
									<td style="width: 70px;" title="{{f.equName}}">{{f.equNameA}}</td>
									<td style="width: 40px;" title="{{f.brandName}}">{{f.brandNameA}}</td>
									<td style="width: 40px;" title="{{f.models}}">{{f.modelsA}}</td>
									<td style="width: 40px;" title="{{f.licenseNo}}">{{f.licenseNoA}}</td>
			                        <td><input type="text" style="margin-top:0px;margin-bottom:0px;height:17px;" class="form-control" maxlength="50" ng-model="f.startEndDate" title="{{f.startEndDate}}"></td>
			                        <td><input type="text" style="margin-top:0px;margin-bottom:0px;height:17px;" class="form-control" maxlength="18" ng-model="f.rent" title="{{f.rent}}" ng-change="formatMoney('formParmsList','rent',2,$index);"></td>
									<td>
										<select name="state" id="state{{$index}}" 
									        ng-model="f.rentType" ng-mouseover="changeZIndex($index,formParmsList.length);"   class="form-control " style="margin-top:0px;margin-bottom:0px; height:17px;font-size:10px" >
									        <option ng-repeat="s in sysCodeCon.TENANCY_UNIT" data-ng-bind="s.name_"  ng-selected="{{s.id_==f.rentType}}" >{{s.id_}}</option>
										</select>                                                                 
									</td>
									<td>
										<input type="text" style="margin-top:0px;margin-bottom:0px;height:17px;" class="form-control" maxlength="15" name="rentCount{{$index}}" ng-model="f.rentCount" title="{{f.rentCount}}"ng-change="formatMoneyNum('formParmsList','rentCount',5,$index);" >
									</td>
									<td><input type="text" style="margin-top:0px;margin-bottom:0px;height:17px;" class="form-control" maxlength="18" ng-model="f.amount" title="{{f.amount}}" ng-change="formatMoney('formParmsList','amount',2,$index);"></td>
									<td><input type="text" style="margin-top:0px;margin-bottom:0px;height:17px;" class="form-control" maxlength="18" ng-model="f.cost" title="{{f.cost}}" ng-change="formatMoney('formParmsList','cost',2,$index);"></td>
									<td><input type="text" style="margin-top:0px;margin-bottom:0px;height:17px;" class="form-control" maxlength="18" ng-model="f.deductCost" title="{{f.deductCost}}" ng-change="formatMoney('formParmsList','deductCost',2,$index);"></td>
									<td><input type="text" style="margin-top:0px;margin-bottom:0px;height:17px;" class="form-control" maxlength="30" ng-model="f.note" title="{{f.note}}"></td>
								</tr>
							</tbody>
						</table>
						<div style="margin-right: 25px;margin-top:-4px;width: 80%;" ng-show="formParmsList.length!=0">
							<tm-pagination conf="paginationConf" style="float :right;"></tm-pagination>
						</div>
						<div style="margin-left: 69%;margin-top: 1%;" ng-show="formParmsList.length==0">
							<span>没有符合条件的记录</span>
						</div>
						<div style="margin-left: 0px;margin-top:30px;width: 80%;" ng-show="formParmsList.length!=0">
							<div  style="margin-left:0px">
							<input  type="button" class="btn btn-primary" value="保存"  ng-click="saveMess(formName);cancel();"/>
							<input  type="button" class="btn btn-primary" value="已退场"  ng-click="walkOff();" />
							<span style="color: red;">&nbsp;&nbsp;&nbsp;如果某个设备已结清相关费用，请在选中后，点击此按钮。</span>
							</div>
						</div>
				</div>
			</div>
	</form>
	<div ng-include src="'../../../WebSite/Back/MessageCheckIn/deviceUsageQuestionnaireCheckInListModel.jsp'"></div>
 <script type="text/javascript">
		$('.form_date').datetimepicker({
			format: 'yyyy-mm',
			language : 'zh-CN',
			autoclose : 1,
			endDate:'setEndDate',
			todayHighlight : 1,
			startView : 3,
			minView : 3,
			forceParse : 0
		});
	</script>
</body>
</html>