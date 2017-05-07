<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<!-- 选择使用单位/项目（Modal） -->
<div class="modal fade" id="equAtProjectModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" >
		<div class="modal-content" style="margin-left: -10px;">
			<div class="modal-header">
				<h4 class="modal-title">
					<button type="button" style="margin-left: 565px; outline: none;" class="btn btn-link"  ng-click="closeEquAtProjectModel()">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
				</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					<div class="form-group" style="  margin-top: -20px;">
						<div class="col-xs-3" style="margin-top: 6px; margin-left: 7%;">
				     		<input type="checkbox" ng-model="queryEquAtProject.isCrecOrg" ng-click="clickEquAtOrgOut()" ng-true-value="1" ng-false-value="0" />
				     		<span style="padding-left: 1px;">非中铁单位</span>
						</div>
						<div class="col-xs-5">
							<input class="form-control" type="text" id="equAtProOrgName" name="equAtProOrgName" ng-model="queryEquAtProject.orgName" />
						</div>
						<div>
							<input type="button" class="btn btn-primary" ng-show="queryEquAtProject.displayIsCrecFlag" style="margin-top: 8px; width: 50px;" value="查询" ng-click="clickEquAtProProjects(1)" />
							<input type="button" class="btn btn-primary" ng-show="!queryEquAtProject.displayIsCrecFlag" style="margin-top: 8px; width: 50px;" value="确定" ng-click="modifyEquAtOrgOutModel()" />
						</div>
					</div>

					<div class="form-group"  ng-show="queryEquAtProject.displayIsCrecFlag">
						<div class="col-xs-12" >						
				     		<span>当前位置：<a ng-repeat="p in equAtProjects" ng-click="clickEquAtOrgs(1,p,$index)"><span ng-show="$index!=0">&gt;&gt;</span><span>{{p.name}}</span></a></span>
				     		<span class="pull-right">
				     			<input id="equAtProCheck" name="equAtProCheck" type="checkbox" ng-show="equAtProCheck" ng-model="queryEquAtProject.check" ng-click="clickEquAtProProjects(1)" />
				     			<span ng-show="equAtProCheck" style="padding-left: 1px;">项目</span>
				     		</span>
						</div>
					</div>
					<div class="form-group"  ng-show="queryEquAtProject.displayIsCrecFlag">
						<table class="table table-striped table-borderod" style="text-align: center"> 
							<tr class="success">
								<th style="text-align: center" ng-show="checkTrEquAtOrg">单位名称</th>
								<th style="text-align: center" ng-show="checkTrEquAtPro">项目名称</th>
							</tr>
							<tr style=" background: #fff;" ng-repeat="e in employerList">
								<td nowrap="nowrap" >
									<a ng-click="clickEquAtOrg(1,e)" ng-show="e.orgLevel">{{e.name}}</a>
									<a ng-if="!e.orgLevel" ng-click="clickEquAtProProject(e)">{{e.name}}</a>
								</td>
							</tr>
						</table>
						<div style="margin-top: 5px; text-align: right;" ng-if="employerList.length!=0">
							<tm-pagination conf="paginationConfEquAtProject"  style="margin-right:0px;"></tm-pagination>
						</div>
					</div>
				</div>

				<div style="height: 20px;">
				</div>
			</div>

			<div class="modal-footer" ng-show="queryEquAtProject.displayIsCrecFlag">
				<input type="button" class="btn btn_Under btn-primary" style="margin-top: -20px; width: 50px;" value="确定" ng-click="modifyEquAtProjectModel()"/>
				<input type="button" class="btn btn_Under btn-default" style="margin-top: -20px; width: 50px;" value="取消" ng-click="closeEquAtProjectModel()"/>
			</div>
		</div>
	</div>
</div>
