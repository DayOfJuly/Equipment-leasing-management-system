<%@ page contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>

<title>内部员工信息维护</title>
<style>
.container {width: 1500px !important;}  

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}

 textarea {
	width: 1200px;
	max-width: 550px;
	height: 60px;
	max-height: 60px;
 }

.abc {
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	float: left;
	min-width: 160px;
	padding: 5px 0;
	margin: 2px 0 0;
	font-size: 14px;
	text-align: left;
	list-style: none;
	background-color: #fff;
	-webkit-background-clip: padding-box;
	background-clip: padding-box;
	border: 1px solid #ccc;
	border: 1px solid rgba(0, 0, 0, .15);
	border-radius: 4px;
	-webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	box-shadow: 0 6px 12px rgba(0, 0, 0, .175)
}

::-ms-clear, ::-ms-reveal{display: none;}

.page-list .pagination {float:left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float:left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left:3px;}
.page-list .page-total select {width: 50px;}

/* ======================================================================================================== */

/* textarea {
margin:0px 0px 0px 0px;
} */

.style_compact {
padding: 0px 0px 0px 0px; /* 自定义样式内边距为0 用在tr上*/
margin:0px 0px 0px 0px;
}

.style_margin{
margin:0px 0px 0px 0px;
}

.form-control_test {
  display: block;
  width: 100%;
  height: 20px;/* 输入框高 */
  padding: 0px;/* 输入框内边距 */
  font-size: 14px;
  line-height: 1.428571429;/* 光标高 */
  color: #555555;
  vertical-align: middle;
  background-color: #ffffff;
  background-image: none;
  border: 1px solid #cccccc;
  border-radius: 0px;/* 输入框圆角 默认4px */
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  -webkit-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
          transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
}

.modal-header_test {
  min-height: 0px;
  padding: 0px;
  border-bottom: 1px solid #e5e5e5;
   margin-top: 0px;
}

.modal-body_test {
  position: relative;
  padding: 0px;
  margin:0px;
}

.table_test > thead > tr > th,
.table_test > tbody > tr > th,
.table_test > tfoot > tr > th,
.table_test > thead > tr > td,
.table_test > tbody > tr > td,
.table_test > tfoot > tr > td {
  padding: 0px 0px 0px 0px;/* 内边距 0  */
  line-height: 1;/* 边距比较重要 */
  vertical-align: none;/* 上下对其，不对齐 */
  border-top: 1px solid #dddddd;/* 这个不改 */
  margin:0px 0px 0px 0px;
}

.form-horizontal_ ,
.form-horizontal_ .radio_,
.form-horizontal_ .checkbox_,
.form-horizontal_ .radio-inline_,
.form-horizontal_ .checkbox-inline_ {
  padding: 0px;
  margin-top: 0;
  margin-bottom: 0;
  margin:2px 2px 2px 2px;
}

.form-horizontal_ .form-group_ {
  margin-right: 0px;
  margin-left: 0px;
  padding: 0px;
  margin:2px 2px 2px 2px;
}

.form-horizontal_ .form-group_:before,
.form-horizontal_ .form-group_:after {
  display: table;
  content: " ";
  padding: 0px;
  margin:2px 2px 2px 2px;
}

.form-horizontal_ .form-group_:after {
  clear: both;
  padding: 0px;
  margin:2px 2px 2px 2px;
}

.form-horizontal_ .form-group_:before,
.form-horizontal_ .form-group_:after {
  display: table;
  content: " ";
  padding: 0px;
  margin:2px 2px 2px 2px;
}

.form-horizontal_ .form-group_:after {
  clear: both;
  padding: 0px;
  margin:2px 2px 2px 2px;
}

.form-horizontal_ .form-control-static_ {
 padding: 0px;
 margin:2px 2px 2px 2px;
}

@media (min-width: 768px) {
  .form-horizontal_ {
    text-align: none;
    padding: 0px;
    margin:2px 2px 2px 2px;
  }
}


.btn_Under {
  display: inline-block;
  padding: 0px ;
  margin-bottom: 0;
  font-size: 18px;
  font-weight: normal;
  line-height: 1.428571429;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
       -o-user-select: none;
          user-select: none;
}

.btn_ {
  display: inline-block;
  padding: 0px ;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.428571429;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
       -o-user-select: none;
          user-select: none;
}




</style>

</head>
<body class="container" onLoad="javascript:document.yourFormName.reset()">
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">系统管理</li>
		<li style="font-size: 13px">内部员工信息维护</li>
	</ol>
	<form action="" style="width: 95%" autocomplete="off">
		<div class="form-horizontal" style="margin-top: 10px;"  ><!-- ng-click="click_BlurToInitFun('addTest','proListCopy');" -->
				<div class="form-group">
			 	     <div class="col-xs-4" style="margin-top:-17px;margin-left: 5%;">
				    	 <label contenteditable="false" class="col-xs-3  control-label" >当前单位：</label>
<!-- 						  	 <button ng-click="cleanDateFunEnd();" ng-show="flagShow" id="flagEnd" type="button" class="btn btn-link" style="outline: none;color:#000;margin-left:139px;margin-top:7px;z-index:2;position: absolute;"><span class="glyphicon glyphicon-remove" style="border: 0px solid transparent;"></span></button> -->
						  	 <!-- <input  data-toggle="dropdown" ng-click="clickInput(employeeEntity.orgName);"  ng-model="employeeEntity.orgName" ng-change="KeyWordQuery(employeeEntity.orgName,'LiNumA');" ng-blur="blurInput();" id="searchContent" name="searchContent" type="text"  style="width:158px;" class="form-control"maxlength="200" />  
							 <ul ng-show="LiNumA" class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs" style="position: absolute;display: block;margin-left:142px;margin-top:-1px;z-index:5">
						           <li class="lable-lablecss" ng-repeat="RentInfo in KeyWordList" title="{{RentInfo.name}}" 
						               role="menuitem" tabindex="-1" ng-click="InputShow(RentInfo.name,'employeeEntity','orgName','LiNumA',RentInfo.orgLevel,RentInfo.currOrgId,'changeOrgId',RentInfo.code,'code');" >
						         	  <lable style="margin-left:5px;">{{RentInfo.infoTitleA}}</lable>
						           </li>
							 </ul>  -->  
							 <div class="col-xs-4" >
								<div class="input-group" ng-show="!userInfo.proId && userInfo.orgLevel!=3">
									<input ng-model="proQryBean.name" type="text" class="form-control" style="height: 22px; border-right: 0px; background-color: #fff;" readonly="readonly">
									<span class="input-group-btn" style="padding-top: 8px;">
										<button class="btn btn-default" type="button" style="width: 30px; border-left: 0px; background-color: #fff;" ng-click="openEmployerModel()">…</button>
									</span>
								</div>
								<input ng-show="userInfo.proId || userInfo.orgLevel==3" ng-model="proQryBean.nameInput" type="text" class="form-control" style="height: 22px; background-color: #fff;" readonly="readonly">
							</div>
				        <div class="col-xs-4" style="margin-top:2px;" ng-show = "userInfo.orgLevel_show!=3">
						     <input type="checkbox"  style="position: absolute;z-index:3;margin-top:7px;margin-top:10px;"ng-model="employeeEntity.isInclude">
						     <label contenteditable="false" class="control-label " style="text-align: left;margin-left:20px;position: absolute;z-index:2">包含下级单位</label> 
					    </div> 
				    </div> 
				    
			 		<div class="col-xs-2" style="margin-top:-17px;">
						<button ng-click="cleanDateFunEndNew('_fuzzyData','purId','formParm','fuzzyData');" ng-show="flagShow_fuzzyData" id="flagEnd" type="button" class="btn btn-link" style="outline: none;color:#000;margin-left:222px;margin-top:7px;z-index:2;position: absolute;"><span class="glyphicon glyphicon-remove" style="border: 0px solid transparent;"></span></button>
						<input style="width:119%;padding:0px -13px 0px 20px;" id="purId" class="form-control" ng-model="formParm.fuzzyData" placeholder="查询 员工姓名、注册手机号码" 
						ng-click="clickInputNew(formParm.fuzzyData,'_fuzzyData');" ng-change="changeProFunNew(formParm.fuzzyData,'a','_fuzzyData');" ng-blur="blurInputNew('_fuzzyData');">
						<input type="text"  style="display:none"/>
					</div>
					 
					<div class="col-xs-4" ng-if="proListCopy.length > 10" style="margin-top:-19px;">
						<label contenteditable="false" class="col-xs-2 control-label">所属项目：</label>
						<input type="hidden" ng-model="parentOrgPage"> 
				        <div class="form-group" style="margin-top:8px;">
				            <div class="col-xs-2">
					        	<select class="form-control select-hover" ng-mouseover="overFun();" ng-mouseleave="leaveFun();"  ng-click="openProSelect('addTest','proListCopy');" ng-change="openProSelectChange();"  id="addTest" ng-model="employeeEntity.proId"   style="margin-top:15px;margin-left:-10px;width:200%;margin-top:-2px;position: absolute;z-index:3;"  >
				                    <option value="">全部</option>
				                    <option value="{{p.currOrgId}}" ng-repeat="p in proListCopy"  title="{{p.name}}">{{p.nameCopy}}</option> 
								</select>
							</div> 
					   </div>
				    </div> 
				    
				    <div class="col-xs-4" ng-if="proListCopy.length &lt;= 10" style="margin-top:-19px;">
				    	<label contenteditable="false" class="col-xs-2 control-label">所属项目：</label>
						 <input type="hidden" ng-model="parentOrgPage"> 
				        <div class="form-group" style="margin-top:8px;">
				            <div class="col-xs-2">
					        	<select class="form-control select-hover"   id="addTest" ng-model="employeeEntity.proId"   style="margin-top:15px;margin-left:-10px;width:200%;margin-top:-2px;position: absolute;z-index:3;"  >
				                    <option value="">全部</option>
				                    <option value="{{p.currOrgId}}" ng-repeat="p in proListCopy"  title="{{p.name}}">{{p.nameCopy}}</option> 
								</select>
							</div> 
					   </div>
					   
				    </div> 
			</div>
			
			<div class="form-group">
			  <div class="col-xs-3 col-xs-offset-9" style="margin-top:-25px;">
						<input type="button" id="searchBtnId" style="margin-left: 11%;" class="btn btn-primary" value="查询"  ng-click="queryTemPartyList(1,'click_');"/>
				   </div> 
		    </div>
			
			<table class="table table-hover" style="z-index:3;margin:10px 0px 0px 8%;width: 79%;">
				<tbody>
					<tr class="success">
						<th style="white-space: nowrap; text-align: center;"></th>
						<th style="white-space: nowrap; text-align: center;width: 1%;">序号</th>
						<th style="white-space: nowrap; text-align: center;">登录用户名</th>
						<th style="white-space: nowrap; text-align: center;">员工姓名</th>
						<th style="white-space: nowrap; text-align: center;">员工编号</th>
						<th style="white-space: nowrap; text-align: center;">注册手机号码</th>
						<th style="white-space: nowrap; text-align: center;">注册电子邮箱</th>
						<th style="white-space: nowrap; text-align: center;">所属单位</th>
						<th style="white-space: nowrap; text-align: center;">所属项目</th>
						<th style="white-space: nowrap; text-align: center;">最后更新时间</th>
						<th style="white-space: nowrap; text-align: center;">状态</th>
					</tr>
				</tbody>
				<tbody>
				 	<tr  ng-repeat="entity in entityList" style="text-align: center;" ng-click="check(entity,$index+1);" ng-dblclick="openCheckDetail(1);">
					<!-- 	<td>
							<input style="margin-left:-15px;margin-top:1px;" type="radio" name="onlyOne" ng-click="chooseEmployee(entity.partyId,entity.state)" ng-checked="radioTrIndex==$index+1">
							<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
						</td> -->
						<td>
							<input style="margin: 2px -17px 0 0px;" type="radio" name="onlyOne" ng-click="chooseEmployee(entity.partyId,entity.state)" ng-checked="radioTrIndex==$index+1"/>
						</td>
						<td>
							<p align="left" style="margin: 0px -9px -2px 19px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
						</td>
						<td style="text-align: center;" title="{{entity.loginId}}">{{entity.loginIdCopy}}</td>
						<td style="text-align: center;" title="{{entity.name}}">{{entity.nameCopy}}</td>
						<td style="text-align: center;" title="{{entity.code}}">{{entity.codeCopy}}</td>
						<td style="text-align: center;" title="{{entity.phoneNo}}">{{entity.phoneNoCopy}}</td>
						<td style="text-align: center;" title="{{entity.mail}}">{{entity.mailCopy}}</td>
						<td style="text-align: center;" title="{{entity.orgName}}">{{entity.orgNameCopy}}</td>
						<td style="text-align: center;" title="{{entity.proName}}">{{entity.proNameCopy}}</td>
						<td style="text-align: center;" title="{{entity.updateTime}}">{{entity.updateTime}}</td>
						<td style="text-align: center;" title="{{entity.loginIdCopy}}">{{ct.codeTranslate(entity.state,"PERSON_STATE")}}</td>
					</tr>
				</tbody>
			</table>
	 		<div style="margin-left: 3.3%;;margin-top:-0.5%;">
				<div  style="text-align: right; float: right;height: 1px" ng-show="btnShow_">
					<tm-pagination conf="paginationConf" style="margin-left: -35%;" ></tm-pagination>
				</div>
				<label></label>
				<div style="margin-left: 4.9%;">
					<button ng-show="btnShow_"  type="button" class="btn btn-primary" ng-click="openCheckDetail(1)">查看</button>
					<button  id="nb123"  type="button" ng-disabled="flagAdd_show" class="btn btn-primary" ng-click="openAddEmployee()">添加</button>
					<button ng-show="btnShow_" ng-disabled="enterpriseState=='1'"  type="button" class="btn btn-primary" ng-click="openUpdEmployee()">修改</button>
					<button ng-show="btnShow_" type="button" class="btn btn-primary" ng-click="openCheckDetail(4)">删除</button>
				</div>
			</div> 
		</div>
	</form>
	<div ng-include src="'./EmployeeInformationMaintain/EmployeeInformationMaintainModel.jsp'"></div>
	<div ng-include src="'./EmployeeInformationMaintain/EmployeeInformationMaintainAdd.jsp'"></div> 
	<div ng-include src="'./EmployeeInformationMaintain/EmployeeInformationMaintainDetail.jsp'"></div> 
	<div ng-include src="'./EmployeeInformationMaintain/EmployeeInformationMaintainUpdate.jsp'"></div> 
	<div ng-include src="'./EmployeeInformationMaintain/EmployeeInformationMaintainState.jsp'"></div> 
	
	
				          	
				          		
				          	
				      
				          	
				          	
				          	
				          		
	
	
</body>