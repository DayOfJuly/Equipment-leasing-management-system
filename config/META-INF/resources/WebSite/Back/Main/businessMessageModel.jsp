<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal）-->
<div class="modal fade" id="businessMessageModel" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 979px;margin-top: 180px">
		<div class="modal-content" style="word-break: break-all">
			<div class="modal-header">
				<h4 class="modal-title">交易信息
				<button type="button"  style="float:right;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<div class="row clearfix">
				<div class="column" style="width:95%;margin:3px 1px 2px 25px">
					<div class="tabbable" id="tabs-240462">
						<ul class="nav nav-tabs">
							<li class="active">
								 <a href="#panel-450122" data-toggle="tab">响应情况</a>
							</li>
							<li ng-show="equState==1 || equState==3">
								 <a href="#panel-712054" class="modal-title" data-toggle="tab">发布结果登记</a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="panel-450122">
								<table style="width:100%; border:0;cellspacing:0;cellpadding:0;"  class="tab_hj table-hover">
							        <tr >
										<th>序号</th>
										<th>登录账号</th>
										<th>单位名称</th>
										<th>联系人姓名</th>
										<th>联系人电话</th>
									</tr>
							        <tr ng-repeat="b in businessList">
										<td>{{$index+1+(paginationConfb.currentPage-1)*paginationConfb.itemsPerPage}}</td>
										<td style="width:69px" title="单位名称:{{b.orgName}},    联系人:{{b.personName}},    电话:{{b.mobile}}"><span style="color:#4068DE">{{b.loginId}}</span></td>
										<td style="width:371px" ng-bind="b.depName"></td>
										<td style="width:371px" ng-bind="b.linkName"></td>
										<td style="width:89px" ng-bind="b.linkPhone"></td>
									</tr>
						      </table>
						    <div style="float: right;">
								<tm-paginations conf="paginationConfb"  style="margin-right:0px; " ></tm-paginations>
							</div>
						      
							</div>
							<div class="tab-pane" id="panel-712054">
								<div class="modal-body">
									<div class="form-horizontal" >
										<div class="form-group" style="margin-top: -10px;">
											<label contenteditable="false" class="col-sm-2 control-label">设备编号：</label>
											<div class="col-sm-4" style="margin-top: 8px">
												<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.equNo}}</h5>
											</div>
											<label contenteditable="false" class="col-sm-2 control-label">资产编号：</label>
											<div class="col-sm-4" style="margin-top: 8px">
												<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.asset}}</h5>
											</div>
										</div>
										<div class="form-group"  >
											<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
											<div class="col-sm-4" style="margin-top: 8px">
												<h5 style="font-family: Microsoft YaHei!important;"><span>{{addPublishList.equipmentName}}</span></h5>
											</div>
											<label contenteditable="false" class="col-sm-2 control-label">品牌：</label>
											<div class="col-sm-4" style="margin-top: 8px">
												<h5 style="font-family: Microsoft YaHei!important;"><span>{{addPublishList.brandName}}</span></h5>
											</div>
										</div>
										<div class="form-group" >
										 	<label contenteditable="false" class="col-xs-2 control-label">交易状态：</label>
											<div class="col-xs-2" id="div_2"  style="margin-top: 8px">
											{{ct.codeTranslate(addPublishList.state,"STATE_EQU_STATE")}}
											</div>
											<label ng-show="equState!=3" contenteditable="false" class="col-xs-4 control-label"style="margin-left:0px;">成交单位类型：</label>
											<div ng-show="equState!=3" class="col-xs-2" id="div_2" style="margin-top: 8px">
												{{ct.codeTranslate(addPublishList.busState,"TYPE_EQU_STATE")}}
											</div>
										</div>
										<div class="form-group">
											<label ng-show="equState!=3" contenteditable="false" class="col-sm-2 control-label">设备成交单位：</label>
											<div ng-show="equState!=3" class="col-sm-4" style="margin-top: 8px">
												<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.depName}}</h5>
											</div>
											<label contenteditable="false" class="col-sm-2 control-label">发布日期：</label>
											<div class="col-sm-4" style="margin-top: 8px">
												<h5 style="font-family: Microsoft YaHei!important;">{{addPublishList.releaseDate}}</h5>
											</div>
										</div>
										<div class="form-group" ng-show="equState!=3">
											<label contenteditable="false" class="col-sm-2 control-label">预估金额：</label>
											<div class="col-sm-8" style="margin-top: 8px;font-family: Microsoft YaHei!important;" >
												{{ct.formatCurrency(addPublishList.forecastSum)}}万元
											</div>
										</div>
										<div class="form-group">
											<label contenteditable="false" class="col-sm-2 control-label">备注：</label>
											<div class="col-sm-8" style="margin-top: 8px;font-family: Microsoft YaHei!important;" >
												{{addPublishList.note}}
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal-footer" >	
				<div style="margin-top: 15px">
					<input type="button"  class="btn btn_Under btn-default" value="返回" style="margin-top: -20px" data-dismiss="modal"/>
				</div> 
			</div> 
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
</div>
