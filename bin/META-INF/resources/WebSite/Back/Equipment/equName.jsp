<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择设备名称-模态框（Modal） -->
<div class="modal fade" id="equName__" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">
					选择设备
					<button type="button" style="margin-left: 89%; outline: none;" class="btn btn-link" ng-click="closeEquNameModel()" >
						<span class="glyphicon glyphicon-remove "></span>
					</button>
				</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					<div class="form-group" style="margin-top: -32px; margin-left: 22px;">
						<label contenteditable="false" class="col-xs-2 control-label">设备分类：</label>
						<div class="col-xs-3 div_Modify">
							<div class="form-inline">
								<select id="equCategoryId" name="equCategoryId" class="form-control select-hover" ng-model="queryEquName.equCategoryId" 
									ng-options="categoryInfo.equCategoryId as categoryInfo.equipmentCategoryName for categoryInfo in categoryList" style="height: 22px;">
									<option value="">全部</option>
								</select>
							</div>
						</div>

						<label contenteditable="false" class="col-xs-2 control-label">设备名称：</label>
						<div class="col-xs-3 div_Modify">
							<div class="form-inline">
								<input ng-model="queryEquName.equipmentName" type="text" id="equipmentName" name="equipmentName" class="form-control" maxlength="40" style="height: 22px;" />
							</div>
						</div>

						<div class="col-xs-1">
							<button class="btn btn-primary" style="  margin-top: 7px; width: 50px;" ng-click="queryEquNameData(1)">查询</button>
						</div>
					</div>

					<div style="overflow: auto;  margin-top: 7px;  margin-left: 50px;  width: 825px;">
						<table class="table table-striped table-hover">
							<thead>
								<tr class="success">
									<th style="white-space: nowrap; text-align: center;"></th>
									<th style="white-space: nowrap; text-align: center; width: 4%;">序号</th>
									<th style="white-space: nowrap; text-align: center;">设备类别号</th>
									<th style="white-space: nowrap; text-align: center;">设备分类</th>
									<th style="white-space: nowrap; text-align: center;">设备名称</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="t in equNameList" ng-click="equNameSelect(t,$index + 1)" ng-dblclick="openEquNameAddModal(t,$index + 1)" >
									<td><input style="margin: 2px -53px 0 3px;" type="radio"  name="selectEquNameId" ng-checked="selectTableIndex==$index + 1" /></td>
									<td><p align="left" style="margin: 0px -9px -2px 23px;">
										{{$index + 1 + (paginationConfEquClassify.currentPage - 1) * paginationConfEquClassify.itemsPerPage}}
									</p></td>
									<td style="white-space: nowrap; text-align: center;">{{t.equName.equipmentNo}}</td>
									<td style="white-space: nowrap; text-align: center;">{{t.equCategory.equipmentCategoryName}}</td>
									<td style="white-space: nowrap; text-align: center;">{{t.equName.equipmentName}}</td>
							    </tr>
							</tbody>
						</table>
					</div>
					<div class="form-group">
						<div class="col-xs-9 col-xs-offset-3" ng-if="equNameList.length!=0" style="margin: -18px 2px 0 334px;">
							<tm-pagination conf="paginationConfEquClassify"></tm-pagination>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" style="  margin-top: -15px;">
				<input type="button" class="btn btn_Under btn-primary" style="margin-top: -20px; width: 50px;" value="确定" ng-if="equNameList.length!=0" ng-click="openEquNameAddModal()" />
				<input type="button" class="btn btn_Under btn-default" style="margin-top: -20px; width: 50px;" value="取消" ng-click="closeEquNameModel()" />
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<!-- 选择设备参数-模态框（Modal） -->
<div class="modal fade" id="categoryParameter" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 550px; margin-top: 13%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">设备参数添加</h4>
			</div>
			<button type="button" style="margin-left: 500px; margin-top: -48px; outline: none;" class="btn btn-link" ng-click="closeEquNameAddModal">
				<span class="glyphicon glyphicon-remove"></span>
			</button>
			<div class="modal-body" style="margin-top:-50px;">
				<!-- 分类添加 -->
				<form action="" novalidate name="categoryForm" autocomplete="off">
				<label contenteditable="false" class="col-xs-12 control-label" style="margin-top: 3px;">当前设备名称：<span ng-bind="equNameParam.equName"></span></label>
				<div class="tab-pane fade in active">
					<div class="form-horizontal" style="margin-top: 30px;">
						<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">生产厂家：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<select class="form-control select-hover" style="width:193%"  id="manufacturerId" ng-model="equNameParam.manufacturerId">
										<option value="">请选择</option>
										<option value="{{p.parameterId}}" ng-repeat="p in manufacturerList" >{{p.name}}</option>
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
									<select class="form-control select-hover" style="width:193%"  id="brandNo" ng-model="equNameParam.brandNo">
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
									<select ng-show="modelsShow" id="modelsId" class="form-control select-hover" style="width:193%" style="width:193%" ng-model="equNameParam.modelsId">
										<option value="">请选择</option>
	                     				<option value="{{t.parameterId}}" ng-repeat="t in modelsList" >{{t.name}}</option>
									</select>
									<div ng-show="!modelsShow">
										<input type="text" maxlength="20" ng-model="equNameParam.models" class="form-control" style="margin-top:8px" placeholder="{{placeholders.models}}"> 
									</div>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="margin-top: 10px;width:10px">
										<span class="form-control-static" style="color:red;  margin-left: -11px;width:10px;  margin-top: 8px;">&nbsp;&nbsp;*</span>
								</div>
								<div ng-show="modelsShow">
									<a ng-click="addManual('models')" href="" style="text-decoration: none; float: left;margin-top:8px">手动添加</a>
								</div>
								<div ng-show="!modelsShow">
									<a ng-click="addSelect('models')" href="" style="text-decoration: none; float: left;margin-top:8px">重选</a>
								</div>
							</div>
						</div>
							<div class="form-group">
							<label contenteditable="false" class="col-xs-3 control-label" style="margin-top: 3px;">规格：</label>
							<div class="col-xs-8 div_Modify">
								<div class="col-xs-4 form-inline">
									<select ng-show="specificationsShow" id="specificationsId" class="form-control select-hover" style="width:193%" ng-model="equNameParam.specificationsId">
										<option value="">请选择</option>
	                     				<option value="{{s.parameterId}}" ng-repeat="s in specificationsList" >{{s.name}}</option>
									</select>
									<div ng-show="!specificationsShow">
										<input type="text" maxlength="20" ng-model="equNameParam.specifications" class="form-control" style="margin-top:8px" placeholder="{{placeholders.specifications}}"> 
									</div>
								</div> 
								<div class="col-xs-1 col-xs-offset-2" style="margin-top: 10px;width:10px">
										<span class="form-control-static" style="color:red;  margin-left: -11px;width:10px;  margin-top: 8px;">&nbsp;&nbsp;*</span>
								</div>
								<div ng-show="specificationsShow">
									<a ng-click="addManual('specifications')" href="" style="text-decoration: none; float: left;margin-top:8px">手动添加</a>
								</div>
								<div ng-show="!specificationsShow">
									<a ng-click="addSelect('specifications')" href="" style="text-decoration: none; float: left;margin-top:8px">重选</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				</form>
			</div>
			<div class="modal-footer" style="  margin-top: 9px;">
				<input type="button" class="btn btn_Under btn-primary" style="  margin-top: -20px;" value="保存" ng-click="addEquNameInfo()"/>
				<input type="button" class="btn btn_Under btn-default" style="  margin-top: -20px;" value="取消"  ng-click="closeEquNameAddModal()" />
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
