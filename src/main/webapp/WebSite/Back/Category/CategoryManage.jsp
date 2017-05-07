<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>分类设备维护</title>

<script type="text/javascript">

</script>
<style>
.container {width: 1500px !important;}
.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
}
.form-group {
      margin: 0;
}
label {
  display: inline-block;
  max-width: 100%;
  margin-bottom: 0px;
  font-weight: 700;
}

.div_Modify{
padding-left: 0px;
}



.page-list .pagination {float:left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float:left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left:3px;}
.page-list .page-total select {width: 50px;}

</style>
</head>

<body  class="container">
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">基础管理</li>
		<li style="font-size: 13px">分类设备维护</li>
	</ol>
<div class="form-group">
	<!-- 类别维护 -->
	<div class="col-xs-6 form-inline">
		<form action="" style="width: 95%" autocomplete="off">
			<div class="form-group col-xs-12 form-inline" style="  margin-top: -13px;">
				<label contenteditable="false" class="col-xs-6 control-label" style="    margin-left: -2%;">类别维护</label>
			</div>
			<div class="form-group col-xs-12 form-inline" style="  margin: 3px 0px 0px 0px;">
				<table class="table table-hover" ng-init="queryCategoryData()" style="width:80%">
					<thead>
						<tr class="success">
						 	<th style="text-align:center;"></th>
							<th style="text-align:center;width:8%" colspan="2">序号</th>
							<th style="text-align:center;width:36%">类别号</th>
							<th style="text-align:center;width:35%">类别名称</th>
							<th style="text-align:center;width:34%">操作</th>
						</tr>
					</thead>
					<tbody>
						<tr style="text-align:center;" ng-repeat="c in categoryList" ng-click="check(c,$index+1)">
						<!-- 	<td>
								<input type="radio" name="id" style="margin-left:-15px;margin-top:1px;" ng-click="queryEquipmentData(c,1)" ng-checked="radioTrIndex==$index+1"/>
								<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
							</td> -->
							
							<td>
								<input style="margin: 2px -23px 0 0px;" type="radio" ng-click="queryEquipmentData(c,1)" ng-checked="radioTrIndex==$index+1"/>
							</td>
							<td>
								<p align="left" style="margin: 0px -9px -2px 25px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
							</td>
							
							<td><!-- <p style="margin-left:-73px;margin-top:10px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> --></td>
							<td style="text-align: center;" title="{{c.equipmentCategoryNo}}">{{c.equipmentCategoryNoCopy}}</td>
							<td style="text-align: center;" title="{{c.equipmentCategoryName}}">{{c.equipmentCategoryNameCopy}}</td>
							<td>
								<a href="javascript:void(0);" ng-click="openCategoryUpdModal(c);" ng-if="userInfo.orgLevel == 1">修改</a>
								<a href="javascript:void(0);" ng-click="delCategory(c);"ng-if="userInfo.orgLevel == 1">删除</a>
								<!-- <input type="button" class="btn btn-link " value="修改" style="margin-top:0px;padding:0px;" ng-click="openCategoryUpdModal(c);" ng-if="userInfo.orgLevel == 1"> 
								<input type="button" class="btn btn-link " value="删除" style="margin-top:0px;padding:0px;" ng-click="delCategory(c);" ng-if="userInfo.orgLevel == 1"> -->
							</td>
						</tr>
					</tbody>
				</table>
				<div class="form-group" style="margin-top: -0.2%;">
				    <!-- 分页 -->
				    <div class="col-xs-2" style="margin-top:1px;margin-left:-11px;" ng-if="userInfo.orgLevel == 1">
					 	<input type="button" class="btn btn-primary" value="添加" style="margin-left: -5%;" contenteditable="true" ng-click="openCategoryAddModal();"/><!-- 测试没问题 -->
					</div>
					<div class="col-xs-12" style="margin-top:-29px;margin-left:6%;font-size:11px;" ng-if="pagingFlag == 2">
						<tm-pagination conf="paginationConf" ></tm-pagination>
					</div>
					<div class="col-xs-12" style="margin-top:-45px;margin-left:6%;font-size:11px;" ng-if="pagingFlag == 1">
						<tm-pagination conf="paginationConf" ></tm-pagination>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- 设备维护 -->
	<div  class="col-xs-6 form-inline" style="margin-top: -13px;margin-left: -14%;">
		<form action="" style="width: 95%">
			<div class="form-group col-xs-12 form-inline">
				<label contenteditable="false" class="col-xs-6 control-label" style=" ">设备维护</label>
			</div>
			<div class="form-group col-xs-12" style="  margin: 3px 0px 0px 0px;">
				 <table class="table table-striped table-hover" style="">
					<thead>
						<tr class="success">
							<th style="text-align:center;">序号</th>
							<th style="text-align:center;">设备分类号</th>
                            <th style="text-align:center;">名称排序</th>							
							<th style="text-align:center;">设备名称</th>
							<th style="text-align:center;">计量单位</th>
							<th style="text-align:center;">操作 </th>
						</tr>
					</thead>
					
					<tbody>
						<tr style="text-align:center;" ng-repeat="e in equipmentList" ng-click="checkValueFun(this);">
							<td>
								<p align="left" style="margin: 0px -9px -2px 25px;">{{$index+1+(paginationConfA.currentPage-1)*paginationConfA.itemsPerPage}}</p> 
							</td>
							<!-- <td>{{$index+1+(paginationConfA.currentPage-1)*paginationConfA.itemsPerPage}}</td> -->
							<td title="{{e.equipmentNo}}">{{e.equipmentNoCopy}}</td>
							<td>{{$index+1+(paginationConfA.currentPage-1)*paginationConfA.itemsPerPage}}</td>
							<td title="{{e.equipmentName}}">{{e.equipmentNameCopy}}</td>
							<td>{{ct.codeTranslate(e.second,"UNIT_NAME")}}</td>
							<td>
								<a href="javascript:void(0);" ng-click="openEquipmentUpdModal(e,'upd');" ng-if="userInfo.orgLevel == 1">修改</a>
								<a href="javascript:void(0);" ng-click="delEquipment(e);" ng-if="userInfo.orgLevel == 1">删除</a>
							<!--<input type="button" class="btn btn-link btn-xs" value="修改" ng-click="openEquipmentUpdModal(e,'upd');" ng-if="userInfo.orgLevel == 1"> 
								<input type="button" class="btn btn-link btn-xs" value="删除" ng-click="delEquipment(e);" ng-if="userInfo.orgLevel == 1">  -->
							</td>
						</tr>
					</tbody>					
				 </table>
				 
				 <div class="col-xs-2" style="margin-top:-4px;margin-left:-11px;" ng-if="equipmentList.length==''">
						<input ng-show="showTime==true" type="button" class="btn btn-primary" value="添加" style="margin-left:-7%" contenteditable="true" ng-click="openEquipmentAddModal('add');" ng-if="userInfo.orgLevel == 1"/>					
				 </div>
				 
			     <div class="form-group text-left" style="margin-top: 1%;">
				    <div class="col-xs-2 text-left" style="margin-top:-1px;margin-left:-11px;top: -6px;" ng-if="equipmentList.length!=''">
						<input ng-show="showTime==true" type="button" class="btn btn-primary" value="添加" style="margin-left:-7%" contenteditable="true" ng-click="openEquipmentAddModal('add');" ng-if="userInfo.orgLevel == 1"/>					
					</div>
					<!-- <div class="col-xs-12"  style="margin-top:-40px;margin-left:50px;">
						<tm-pagination conf="paginationConfA"  ></tm-pagination>
					</div> -->
				<!-- 	<div class="col-xs-12" ng-if="equipmentList.length!=''" style="margin-top:-50px;margin-left:50px;font-size:11px;">
						<tm-pagination conf="paginationConfA"  ></tm-pagination>
					</div> -->
					<div class="col-xs-12" ng-if="equipmentList.length!='' && pagingFlag == 1" style="margin-top:-35px;margin-left: 31.8%;font-size:11px;">
						<tm-pagination conf="paginationConfA"></tm-pagination>
					</div>
					<div class="col-xs-12" ng-if="equipmentList.length!='' && pagingFlag == 2" style="margin-top:-35px;margin-left: 31.8%;font-size:11px;" >
						<tm-pagination conf="paginationConfA" ></tm-pagination>
					</div> 
				</div> 
			</div>
		</form>
	</div>
	<div ng-include src="'./Category/CategoryManageAdd-Modify.jsp'" ></div>
</div>
</body>
</html>