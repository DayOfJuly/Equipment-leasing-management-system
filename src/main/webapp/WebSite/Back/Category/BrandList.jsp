<!DOCTYPE html>
<html lang="en">
<head>
<title>品牌维护</title>

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
	<script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.fileupload.js"></script>
	<script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.fileupload-ui.js"></script>
	<script type="text/javascript" src="../../../media/jqueryFileUpLoad/jquery.fileupload-process.js"></script>
</head>
<body class="container">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- <div ng-include src="'../../../WebSite/Front/Include/TopMenu.jsp'" ></div> -->
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">基础管理</li>
		<li style="font-size: 13px">品牌维护</li>
	</ol>
	<!-- 生产厂家维护 -->
			<div  style="margin: 50px 10px 10px 0px;margin-left:15%">
				<table class="table table-hover" ng-init="queryCategoryData()" style="width:80%;margin-top:10px">
					<thead>
						<tr class="success">
							<th style="text-align:center;width:8%">序号</th>
							<th style="text-align:center;width:23%">品牌名称</th>
							<th style="text-align:center;width:23%">操作</th>
						</tr>
					</thead>
					<tbody>
						<tr style="text-align:center;" ng-repeat="b in brandList">
							<td style="text-align:center;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
							<td style="text-align:center;" ng-bind="b.name">DELL</td>
							<td style="text-align:center;">
								<a href="javascript:void(0);" ng-click="delBrandList(b.parameterId)" >删除</a>
							</td>
						</tr>
					</tbody>
				</table>
				<div style="margin-left: 10px;margin-top:-30px;" >
					<div style="margin-left: -0.5%;margin-top: 3%;">
						<button  type="button" class="btn btn_ btn-primary" ng-click="openAddModal()">添加</button>
					</div>
					<label></label>
					<div style="margin-top: -5%;margin-left: -0.4%;">
						<tm-pagination conf="paginationConf" style="margin-left:500px;" ></tm-pagination>
					</div>
				</div>
			</div>
</body>
</html>

<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="brandListModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 550px;margin-top:13%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">品牌添加</h4>
			</div>
			<button type="button"  style="margin-left: 500px;margin-top:-48px;outline: none;" class="btn btn-link "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="margin-top:-50px;">
				<!-- 分类添加 -->
				<form action="" novalidate name="categoryForm" autocomplete="off">
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 30px;">
						<div class="form-group">
							<label contenteditable="false" style="width:27%" class="col-xs-4 control-label" style="margin-top:3px;">品牌名称：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<input type="text" class="form-control" ng-model="name" style="  margin-top: 6px;" maxlength="30" />
								</div> 
								<div class="col-xs-1 col-xs-offset-2" >
										<p class="form-control-static" style="color:red;  margin-left: -11px;">&nbsp;&nbsp;*</p>
								</div>
							</div>
							<label contenteditable="false" style="width:27%" class="col-xs-4 control-label" style="margin-top:3px;">品牌LOGO：</label>
							<div class="col-xs-8 div_Modify" style="margin-top:5px">
								<div class="col-xs-2 form-inline">
									<input type="hidden" readonly class="inpt_a inpt_o span110" ng-model="formParms.equipmentPic" name="equipmentPic" required >
									<input type="button" class="btn btn-primary" value="点击上传" ng-click="newFileUpLoad();"  style="width: 92px;background: #0057b4;">
									<input id="fileupload" type="file" name="file" data-url="/Picture" multiple style="display:none;" >								
								</div> 
							</div>
						</div>
						<!-- 图片显示   -->
			          	<div class="form-group" >
		                    <label contenteditable="false" class="col-xs-2 control-label"></label>
		
		                   <div ng-repeat="t in PicList" >
		                        <div class="col-xs-2" style="height: 160px;width:30%">
		                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true" ng-click="removePic($index,t);">&times;</button>
		                            <a href="#" class="thumbnail">
		                               <img ng-src="{{PicUrl}}/{{t.PicName}}/{{t.PicType}}?Action=TmpPic" alt="" style="width: 300px;;height: 130px;" onerror="javascript:this.src='/media/images/default.png';"/>                               
		                            </a>
		                        </div>
		                   </div>
			          	</div>
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer" style="  margin-top: 9px;">
				<input type="button" class="btn btn_Under btn-primary" style="  margin-top: -20px;" value="保存" ng-click="saveBrandList();"/>
				<input type="button" class="btn btn_Under btn-default" style="  margin-top: -20px;" value="取消" ng-click="closeWindow()"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>


