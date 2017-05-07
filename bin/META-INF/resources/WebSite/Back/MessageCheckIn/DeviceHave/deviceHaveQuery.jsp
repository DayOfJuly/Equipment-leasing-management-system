<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="DeviceQueryId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 80%;margin-top:13%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">租赁费登记-出租方</h4>
				<button type="button" style="margin-top: -25px;float:right;" class="btn btn-link"  data-dismiss="modal" aria-hidden="true" ng-click="closeAddModal();"><span style="margin-left:-30px" class="glyphicon glyphicon-remove " ></span></button>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 10px;">
					<div class="form-group">
						<label contenteditable="false" class="col-xs-1 control-label">设备编号：</label>
						<div class="col-xs-2" style="margin-top:7px;">
							<span title="{{trValues.amount}}">{{trValues.amountA}}</span>
						</div>
						<label contenteditable="false" class="col-xs-1 control-label">设备名称：</label>
						<div class="col-xs-2" style="margin-top:7px;">
							<span title="{{trValues.equipmentName}}">{{trValues.equipmentNameA}}</span>
						</div>
						<label contenteditable="false" class="col-xs-1 control-label">品牌：</label>
						<div class="col-xs-2" style="margin-top:7px;">
							<span title="{{trValues.brandName}}">{{trValues.brandNameA}}</span>
						</div>
					</div>
					<div class="form-group">
						<table class="table table-striped table-hover" style="width: 98%;margin-left:15px;">
							<thead>
								<tr class="success">
									<th style="text-align:center;width: 50px;white-space: nowrap;">序号</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">使用单位</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">起止日期</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租赁单价(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租期单位</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租期数量</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">结算金额(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">进出场费/安拆费(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">扣除金额(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">备注</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="mess in showArrayList"   style="text-align:center;">
									<td style="text-align:center;" >
										<p class="copyP" style="margin-top:0px;">{{$index+1}}</p>
									</td>					
			                        <td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.depName}}">{{mess.depNameA}}</td>
			                        <td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.startEndDate}}">{{mess.startEndDateA}}</td>
			                        <td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.rent}}">{{mess.rent}}</td>
									<td style="text-align:center;width: 95px;" maxlength="17" >{{ct.codeTranslate(mess.rentType,"TENANCY_UNIT")}}</td><!-- 租期单位 -->
									<td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.rentCount}}">{{mess.rentCount}}</td>
									<td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.amount}}">{{mess.amount}}</td>
									<td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.cost}}">{{mess.cost}}</td>
									<td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.deductCost}}">{{mess.deductCost}}</td>
									<td style="text-align:center;width: 80px;" maxlength="17" title="{{mess.note}}">{{mess.noteA}}</td>
								</tr>
							</tbody>
						</table>
						<h4>租赁费登记-承租方</h4>
						<table class="table table-striped table-hover" style="width: 98%;margin-left:15px;">
							<thead >
								<tr class="success">
									<th style="text-align:center;width: 30px;white-space: nowrap;">序号</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">使用单位</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">起止日期</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租赁单价(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租期单位</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租期数量</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">结算金额(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">进出场费/安拆费(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">扣除金额(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">备注</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="users in userRentInfos"  style="text-align:center;" >
									<td style="text-align:center;width: 30px;" ng-if="users.rentType!=null">
									<p class="copyP" style="margin-top:0px;text-align:center;">{{$index+1}}</p>									</td>					
			                        <td title="{{users.equAtOrgName}}" style="text-align:center;width: 80px;">{{users.equAtOrgNameA}}</td><!-- 使用单位 -->
			                        <td title="{{users.startEndDate}}" style="text-align:center;width: 80px;">{{users.startEndDateA}}</td><!-- 起止日期 -->
			                        <td title="{{users.rent}}" style="text-align:center;width: 80px;">{{users.rent}}</td><!-- 租赁单价 -->
									<td  style="text-align:center;width: 80px;">
										<span ng-if="users.rentType==1">月</span>
										<span ng-if="users.rentType==2">天</span>
										<span ng-if="users.rentType==3">台班</span>
										<span ng-if="users.rentType==4">小时</span>
									</td>
									<td title="{{users.rentCount}}" style="text-align:center;width: 80px;">{{users.rentCount}}</td><!-- 租期数量 -->
									<td title="{{users.amount}}" style="text-align:center;width: 80px;">{{users.amount}}</td>
									<td title="{{users.cost}}" style="text-align:center;width: 80px;">{{users.cost}}</td>
									<td title="{{users.deductCost}}" style="text-align:center;width: 80px;">{{users.deductCost}}</td>
									<td title="{{users.note}}" style="text-align:center;width: 80px;">{{users.noteA}}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer">	 
					<input style="float: right;margin-top:-10px" type="button" class="btn  btn_Under btn-default" value="返回" data-dismiss="modal"/>
			   </div> 
		   </div>
		<!-- /.modal-content -->
		</div>
	</div>
	<!-- /.modal -->
</div>

<script type="text/javascript">
	$('.form_date').datetimepicker({
		language : 'zh-CN',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		minView : 2,
		forceParse : 0
	});
</script>