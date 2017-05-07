<!DOCTYPE html>
<html lang="en">
<head>
<title>设备参数维护</title>

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
<body class="container">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">基础管理</li>
		<li style="font-size: 13px">设备参数维护</li>
	</ol>
	<!-- 设备参数维护 -->
			<div class="form-group" style="margin-top:10px">
				<div class="col-xs-5"  style="margin-left:15%;float:left">
					<label style="width:18%" class="col-xs-3 control-label">设备分类：</label>
		            <div class="col-xs-2">
			        	<select class="sel_a marr15 span230" name="PayerAcNo" ng-model="equCategoryBean.equCategoryId">
						<option value="">全部</option>
						<option value="{{rec.equCategoryId}}" ng-repeat="rec in categorySelectList" >{{rec.equipmentCategoryName}}</option>
				</select>
					</div> 
			    </div> 
			    <div class="col-xs-5" style="float:left;margin-left: 37%;margin-top: -23px">
					<label style="width:18%" class="col-xs-2 control-label">设备名称：</label>
		            <div class="col-xs-3" style="margin-top:-8px">
		            	<input type="text" class="form-control" ng-model="name"/>
					</div> 
					 <div>
			    		<button  type="button" class="btn btn-primary" ng-click="queryCategoryData(1)">查询</button>
			   		 </div> 
			    </div>
			</div>
			
			<div  style="margin: 70px 10px 10px 0px;margin-left:15%">
				<table class="table table-hover" style="width:80%;margin-top:10px">
					<thead>
						<tr class="success">
							<th style="text-align:center;width:8%">序号</th>
							<th style="text-align:center;width:23%">设备类别号</th>
							<th style="text-align:center;width:23%">设备分类</th>
							<th style="text-align:center;width:23%">设备名称</th>
							<!-- <th style="text-align:center;width:23%">操作</th> -->
						</tr>
					</thead>
					<tbody>
						<tr style="text-align:center;" ng-repeat="c in categoryList" ng-click="Select(c,$index);">
							<td style="text-align:center;">
								<input style="margin: 2px -23px 0 0px;" type="radio" ng-checked="radioTrIndex==$index"/>
								<span style="float:right; margin-left: 0px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</span>
							</td>
							<td style="text-align:center;" ng-bind="c.equName.equipmentNo"></td>
							<td style="text-align:center;" ng-bind="c.equCategory.equipmentCategoryName"></td>
							<td style="text-align:center;" ng-bind="c.equName.equipmentName"></td>
							<!-- <td style="text-align:center;">
								<a href="javascript:void(0);" ng-click="openCategoryUpdModal(c);" >修改</a>
								<a href="javascript:void(0);" ng-click="delCategory(c);" >删除</a>
							</td> -->
						</tr>
					</tbody>
				</table>
				<div style="margin-left: 10px;margin-top:-30px;" >
					<div style="margin-left: -0.5%;margin-top: 3%;">
						<button  type="button" class="btn btn_ btn-primary" ng-click="openAddModal(categoryList);">添加</button>
					</div>
					<label></label>
					<div style="margin-top: -5%;margin-left: -0.4%;" ng-show="page==1">
						 <tm-pagination conf="paginationConf" style="margin-left:500px;" ></tm-pagination>
					</div>
				</div>
			</div>
</body>
</html>

<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="categoryParameter" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 550px;margin-top:13%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">设备参数添加</h4>
			</div>
			<button type="button"  style="margin-left: 500px;margin-top:-48px;outline: none;" class="btn btn-link "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="margin-top:-50px;">
				<!-- 分类添加 -->
				<form action="" novalidate name="categoryForm" autocomplete="off">
				<label contenteditable="false" class="col-xs-12 control-label" style="margin-top: 3px;">当前设备名称：<span ng-bind="equipmentName"></span></label>
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 30px;">
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">生产厂家：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<select class="form-control select-hover" style="width:193%" ng-model="addBusList.manufactruerId">
										<option value="">请选择</option>
										<option value="{{p.parameterId}}" ng-repeat="p in productionList" >{{p.name}}</option>
									</select>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="margin-top: 4px;">
										<p class="form-control-static" style="color:red;  margin-left: -11px;  margin-top: 9px;">&nbsp;&nbsp;*</p>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">品牌：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<select class="form-control select-hover" style="width:193%" ng-model="addBusList.brandId">
										<option value="">请选择</option>
	                     				<option value="{{b.parameterId}}" ng-repeat="b in brandList" >{{b.name}}</option>
									</select>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="margin-top: 4px;">
										<p class="form-control-static" style="color:red;  margin-left: -11px;  margin-top: 9px;">&nbsp;&nbsp;*</p>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">型号：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<select ng-show="typeSelectShow==1" class="form-control select-hover" style="width:193%" style="width:193%" ng-model="typeList.parameterId">
										<option value="">请选择</option>
	                     				<option value="{{t.parameterId}}" ng-repeat="t in typeList" >{{t.name}}</option>
									</select>
									<div ng-show="typeInputShow==1">
										<input type="text" maxlength="20" ng-model="modelName" class="form-control" style="margin-top:8px" placeholder="请输入型号"> 
									</div>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="margin-top: 10px;width:10px">
										<span class="form-control-static" style="color:red;  margin-left: -11px;width:10px;  margin-top: 8px;">&nbsp;&nbsp;*</span>
								</div>
								<div ng-show="typeSelectShow==1">
									<a ng-click="addManual('type');" href="" style="text-decoration: none; float: left;margin-top:8px">手动添加</a>
								</div>
								<div ng-show="typeInputShow==1">
									<a ng-click="addSelect('type');" href="" style="text-decoration: none; float: left;margin-top:8px">重选</a>
								</div>
							</div>
						</div>
							<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">规格：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<select ng-show="modelSelectShow==1" class="form-control select-hover" style="width:193%" ng-model="standardList.parameterId">
										<option value="" selected="selected">请选择</option>
	                     				<option value="{{s.parameterId}}" ng-repeat="s in standardList" >{{s.name}}</option>
									</select>
									<div ng-show="modelInputShow==1">
										<input type="text" maxlength="20" ng-model="standardName" class="form-control" style="margin-top:8px" placeholder="请输入型号"> 
									</div>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="margin-top: 10px;width:10px">
										<span class="form-control-static" style="color:red;  margin-left: -11px;width:10px;  margin-top: 8px;">&nbsp;&nbsp;*</span>
								</div>
								<div ng-show="modelSelectShow==1">
									<a ng-click="addManual('standard');" href="" style="text-decoration: none; float: left;margin-top:8px">手动添加</a>
								</div>
								<div ng-show="modelInputShow==1">
									<a ng-click="addSelect('standard');" href="" style="text-decoration: none; float: left;margin-top:8px">重选</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer" style="  margin-top: 9px;">
				<input type="button" class="btn btn_Under btn-primary" style="  margin-top: -20px;" value="保存" ng-click="addCategory(categoryList);"/>
				<input type="button" class="btn btn_Under btn-default" style="  margin-top: -20px;" value="取消" ng-click="closeWindow()"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>


