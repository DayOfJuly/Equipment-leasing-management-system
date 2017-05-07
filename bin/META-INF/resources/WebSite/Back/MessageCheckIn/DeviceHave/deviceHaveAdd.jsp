<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="DeviceAddId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 80%;margin-top:13%">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">租赁费登记-出租方</h4>
				<button type="button" style="margin-top: -25px;float:right;" class="btn btn-link"  data-dismiss="modal" aria-hidden="true" ng-click="closeAddModal();"><span style="margin-left:-30px" class="glyphicon glyphicon-remove " ></span></button>
			</div>
			<div class="modal-body">
			  <form name="emForm" action="" method="post" id="form" enctype="application/x-www-form-urlencoded">
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
									<th style="text-align:center;width:1px;white-space: nowrap;"></th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">序号</th>
									<th style="text-align:center;width: 50px;white-space: nowrap;">使用单位</th>
									<th style="text-align:center;width: 50px;white-space: nowrap;">起止日期</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租赁单价(元)</th>
									<th style="text-align:center;width: 30px;white-space: nowrap;">租期单位</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">租期数量</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">结算金额(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">进出场费/安拆费(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">扣除金额(元)</th>
									<th style="text-align:center;width: 80px;white-space: nowrap;">备注</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="mess in messList"  style="text-align:center;" ng-click="checkLine(this);">
								<!-- 	<td>
										<input type="radio" style="margin-left:-15px;margin-top:1px;" name="onlyOne" ng-checked="checkIndex.place==$index"/>&nbsp;
										<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1}}</p>
									</td> -->
									<td>
										<input style="margin: 2px -44px 0 0px;" type="radio" name="onlyOne"  ng-checked="checkIndex.place==$index"/>&nbsp;
									</td>
									<td>
										<p align="left" style="margin: 0px -9px -2px 27px;">{{$index+1}}</p> 
									</td>
			                        <td><input type="text" class="form-control" maxlength="30" ng-model="mess.depName" title="{{mess.depName}}" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px"></td><!-- 使用单位 -->
			                        <td><input type="text" class="form-control" maxlength="50" ng-model="mess.startEndDate" title="{{mess.startEndDate}}" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px"></td><!-- 起止日期 -->
			                        <td><input type="text" class="form-control" maxlength="18" ng-model="mess.rent" title="{{mess.rent}}" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px"
			                         ng-change="formatMoney('messList','rent',2,$index);"></td><!-- 租赁单价 -->
									<td>
										<select name="state" id="state{{$index}}" 
									        ng-model="mess.rentType" ng-mouseover="changeZIndex($index,messList.length);"    class="form-control select-hover" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px" >
									        <option   ng-repeat="s in sysCodeCon.TENANCY_UNIT" data-ng-bind="s.name_" ng-selected="{{s.id_==mess.rentType}}">{{s.id_}}</option>
										</select><!-- 租赁单位 -->
									</td>
									<td>
										<input type="text" name="rentCount{{$index}}" class="form-control" maxlength="15" ng-model="mess.rentCount" title="{{mess.rentCount}}"  ng-change="formatMoneyNum('messList','rentCount',5,$index);" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px">
									</td>
									<td><input type="text" class="form-control" maxlength="17" ng-model="mess.amount" title="{{mess.amount}}" ng-change="formatMoney('messList','amount',2,$index);"style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px" ></td>
									<td><input type="text" class="form-control" maxlength="17" ng-model="mess.cost" title="{{mess.cost}}"  ng-change="formatMoney('messList','cost',2,$index);" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px"></td>
									<td><input type="text" class="form-control" maxlength="17" ng-model="mess.deductCost" title="{{mess.deductCost}}"  ng-change="formatMoney('messList','deductCost',2,$index);" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px"></td>
									<td><input type="text" class="form-control" maxlength="30" ng-model="mess.note" title="{{mess.note}}" style="margin-top:0px;margin-bottom:0px;height:17px;font-size:11px"></td>
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
									<th style="text-align:center;width: 30px;white-space: nowrap;">租期单位</th>
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
										<p class="copyP" style="margin-top:0px;text-align:center;">{{$index+1}}</p>
									</td>					
			                        <td title="{{users.equAtOrgName}}" style="text-align:center;width: 80px;">{{users.equAtOrgNameA}}</td><!-- 使用单位 -->
			                        <td title="{{users.startEndDate}}" style="text-align:center;width: 80px;">{{users.startEndDateA}}</td><!-- 起止日期 -->
			                        <td title="{{users.rent}}" style="text-align:center;width: 80px;">{{users.rent|limitTo:6}}</td><!-- 租赁单价 -->
									<td  style="text-align:center;width: 30px;">
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
					<input style="float: right;margin-top:-10px;" type="button" class="btn btn_Under btn-default" value="取消" data-dismiss="modal" ng-click="cancel()"/>
					<input style="float: right;margin-top:-10px;margin-right:5px;" type="button" class="btn btn_Under btn-primary" value="删除"  ng-click="del();" ng-disabled="add"/>
					<input style="float: right;margin-top:-10px" type="button" class="btn btn_Under btn-primary" value="保存"  ng-click="saveMess(emForm);cancel();" ng-disabled="add" />
					<input style="float: right;margin-top:-10px" type="button" class="btn btn_Under btn-primary" value="新增"  ng-click="addRow();cancel();"/>
					
			   </div> 
			 </form>
		   </div>
		<!-- /.modal-content -->
		</div>
	</div>
	<!-- /.modal -->
</div>

