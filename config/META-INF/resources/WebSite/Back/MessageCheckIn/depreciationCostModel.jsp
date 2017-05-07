<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!-- 选择单位/项目（Modal） -->
<div class="modal fade" id="employerModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" >
		<div class="modal-content" style="margin-left: -10px;">
			<div class="modal-header">
				<h4 class="modal-title">
					<button type="button" style="margin-left: 565px; outline: none;" class="btn btn-link"  ng-click="closeEmployerModel()">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
				</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					<div class="form-group" style="  margin-top: -20px;">
						<div class="col-xs-2" style="margin-top: 6px; margin-left: 20%;">
				     		<input id="check" name="check" type="checkbox" ng-show="check" ng-model="queryEmployer.check" ng-click="clickProjects(1)" />
				     		<span ng-show="check" style="padding-left: 1px;">项目</span>
						</div>
						<div class="col-xs-4">
							<input class="form-control" type="text" id="queryEmployerOrgName" name="queryEmployerOrgName" ng-model="queryEmployer.orgName" />
						</div>
						<div class="1">
							<input type="button" class="btn btn-primary" style="margin-top: 8px; width: 50px;" value="查询" ng-click="clickProjects(1)" />
						</div>
					</div>

					<div class="form-group" >
						<div class="col-xs-12" >						
				     		<span>当前位置：<a ng-repeat="p in employers" ng-click="clickEmployers(1,p,$index)"><span ng-show="p.orgFlag!=9">&gt;&gt;</span><span>{{p.name}}</span></a></span>
						</div>
					</div>
					<div class="form-group" >
						<table class="table table-striped table-borderod" style="text-align: center"> 
							<tr class="success">
								<th style="text-align: center" ng-show="checkTrEmployer">单位名称</th>
								<th style="text-align: center" ng-show="checkTrProjects">项目名称</th>
							</tr>
							<tr style=" background: #fff;" ng-repeat="e in employerList">
								<td nowrap="nowrap" >
									<a ng-click="clickEmployer(1,e)" ng-show="e.orgLevel">{{e.name}}</a>
									<a ng-if="!e.orgLevel" ng-click="clickProject(e)">{{e.name}}</a>
								</td>
							</tr>
						</table>
						<div style="margin-top: 5px; text-align: right;" ng-if="employerList.length!=0">
							<tm-pagination conf="paginationConfOrgORProject"  style="margin-right:0px;"></tm-pagination>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal-footer">
				<input type="button" class="btn btn_Under btn-primary" style="margin-top: -20px; width: 50px;" value="确定" ng-click="modifyEmployerModel()"/>
				<input type="button" class="btn btn_Under btn-default" style="margin-top: -20px; width: 50px;" value="取消" ng-click="closeEmployerModel()"/>
			</div>
		</div>
	</div>
</div>
