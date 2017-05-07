<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>租赁费登记-出租方</title>


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
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">信息登记</li>
		<li style="font-size: 13px">租赁费登记-出租方</li>
	</ol>
	<form action="" style="width: 95%;margin-left:150px" autocomplete="off">
		<div class="form-horizontal" style="margin-top: 10px;">
				<div class="form-group">
					<div class="col-xs-4" style="margin-top:-17px;">
				    	<!--  <label contenteditable="false" class="col-xs-3  control-label" >当前单位：</label>
					     <div class="container-autocomplete" style="float:left;">
						  	 <input  data-toggle="dropdown" ng-click="clickInput(employeeEntity.orgName);"  ng-model="employeeEntity.orgName" ng-change="KeyWordQuery(employeeEntity.orgName,'LiNumA');" ng-blur="blurInput();" id="searchContent" name="searchContent" type="text"  style="width:250px;" class="form-control"maxlength="200" />  
							 <ul ng-show="LiNumA" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs" style="position: absolute;display: block;margin-left:142px;margin-top:-1px;z-index:5;">
						           <li style="width:249px" class="lable-lablecss" ng-repeat="RentInfo in KeyWordList" title="{{RentInfo.name}}" 
						               role="menuitem" tabindex="-1" ng-click="InputShow(RentInfo.name,'employeeEntity','orgName','LiNumA',RentInfo.orgLevel,RentInfo.currOrgId,'changeOrgId',RentInfo.code,'code');" >
						         	  <lable style="margin-left:5px;">{{RentInfo.infoTitleA}}</lable>
						           </li>
							 </ul>   
					    </div>  
				        <div class="col-xs-4" style="margin-top:-28px;margin-left:375px" ng-show = "userInfo.orgLevel_show!=3">
						     <input type="checkbox"  style="position: absolute;z-index:3;margin-top:11px;"ng-model="employeeEntity.isInclude">
						     <label contenteditable="false" class="control-label " style="text-align: left;margin-left:20px;position: absolute;z-index:2">包含下级单位</label> 
					    </div>  -->
					    <label contenteditable="false" class="col-xs-1 control-label" style="margin-left: -10%;">当前单位：</label>
						<div class="col-xs-2" style="width: 180px;">
							<div class="input-group" ng-show="!userInfo.proId">
								<input ng-model="employeeEntity.orgName" type="text" class="form-control" style="width: 120%; margin-left: -20%; height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
								<span class="input-group-btn" style="padding-top: 8px;">
									<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEmployerModel()">…</button>
								</span>
							</div>
							<input ng-show="userInfo.proId" ng-model="employeeEntity.orgNameInput" type="text" class="form-control" style="width: 117%; margin-left: -17%; height: 22px; background-color: #fff;" readonly="readonly">
						</div>
						<div class="col-xs-3" style="margin-top: 3px; margin-left: -62px;" ng-show="!userInfo.proId && (employeeEntity.orgFlag==9 || employeeEntity.orgFlag==1)">
							<input ng-model="employeeEntity.isInclude" ng-true-value="1" ng-false-value="0" type="checkbox" style="position: absolute; z-index: 3; margin-left: 56%; margin-top: 10px;">
							<label contenteditable="false" class="control-label" style="text-align: left; margin-left: 71%; position: absolute; z-index: 2;">包含下级单位</label>
						</div>
				    </div> 
				    
					<!-- 登记月份  -->
					<label contenteditable="false" class="col-xs-2 control-label" style="margin-top:-17px;margin-left:80px">登记月份：</label>
					<div class="col-xs-3" style="float: left; width: 160px; margin-left: -10px;margin-top:-19px;">
						<input id="endDateId" type="text" ng-init="getNowDateStr();"  ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endDate"><!-- 触发事件 --> 
 						<span class="input-group-addon" style="display: none">
							<span class="glyphicon glyphicon-calendar"> </span>
						</span>
					</div>
					<div class="col-xs-2" style="margin-top:-17px;">
						<input type="button" class="btn btn-primary" style="margin-top:5px;" value="查询" ng-click="queryAllMess(1);" style="z-index:1;"/>
					</div>
				</div>
		</div>
		<div>
			<table class="table table-striped table-hover" style="margin-left: 28px;z-index:3;margin:10px 0px 0px 0px;width: 80%">
				<thead>
					<tr class="success">
						<th style="text-align:center;white-space: nowrap;"></th>
						<th style="text-align:center;white-space: nowrap;width: 3%;">序号</th>
						<th style="text-align:center;white-space: nowrap;">设备编号</th>
						<th style="text-align:center;white-space: nowrap;">资产编号</th>
						<th style="text-align:center;white-space: nowrap;">设备名称</th>
						<th style="text-align:center;white-space: nowrap;">品牌</th>
						<th style="text-align:center;white-space: nowrap;">结算金额(元)</th>
						<th style="text-align:center;white-space: nowrap;">进出场费/安拆费(元)</th>
						<th style="text-align:center;white-space: nowrap;">扣除金额(元)</th>
					</tr>
				</thead>
				<tbody>
					<tr  ng-click="selectRow(this,1)" style="text-align: center;" ng-repeat="q in queryAllList" ng-dblclick="openQuery();">
						<!-- <td >
         				   <input style="margin-left:-15px;margin-top:1px;" type="radio" name="onlyOne"  ng-checked="radio_flag==$index"/>
			         		<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
         				</td> -->
         				<td>
							<input style="margin: 2px -17px 0 0px;" type="radio" name="onlyOne"  ng-checked="radio_flag==$index"/>
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px 19px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
						</td>					
                        <td title="{{q.equNo}}">{{q.equNoA}}</td>
						<td title="{{q.asset}}">{{q.assetA}}</td>
						<td title="{{q.equipmentName}}">{{q.equipmentNameA}}</td>
						<td title="{{q.brandName}}">{{q.brandNameA}}</td>
						<td title="{{q.amount}}">{{q.amountTemp}}</td>
						<td title="{{q.cost}}">{{q.costTemp}}</td>
						<td title="{{q.deductCost}}">{{q.deductCostTemp}}</td>
					</tr>
				</tbody>
			</table>
			<div  style="margin-left:0px;margin-top: 10px;width: 79%">
				<div ng-show="queryAllList.length!=0">
					<input type="button"  class="btn btn-primary" value="查看" ng-click="openQuery();">
					<input type="button"  class="btn btn-primary" value="登记" ng-click="openAdd();">
				</div>
				<div style="text-align: right; float: right;margin-right:-18px;margin-top:-50px;" >
					<tm-pagination conf="paginationConf" ng-if="queryAllList.length!=0"></tm-pagination>
				</div>
				<div style="text-align: right;">
					<span  ng-if="queryAllList.length==0">没有符合条件的记录</span>
				</div>
			</div>
		</div>
	</form>
	<div ng-include src="'./MessageCheckIn/employer.jsp'" ></div>
	<div ng-include src="'./MessageCheckIn/DeviceHave/deviceHaveAdd.jsp'" ></div>
	<div ng-include src="'./MessageCheckIn/DeviceHave/deviceHaveQuery.jsp'" ></div>
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