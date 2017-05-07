<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="DeviceUpdId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4>{{titleMsg}}<button type="button" style="margin-left: 760px"  class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备来源分类：</label>
						<div class="col-sm-4 form-inline" >
							<select id="brandSelect" class="form-control"  onmouseover="size=7;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:5">
								<option value="1">长城</option>
							</select>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">设备来源说明：</label>
						<div class="col-sm-4 form-inline">
							<input type="text" class="form-control" ng-model="formParms.projectName"/>
						</div>
					</div>

					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备状态：</label>
						<div class="col-sm-4 form-inline" >
							<select id="brandSelect" class="form-control"  onmouseover="size=7;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:5">
								<option value="1">长城</option>
							</select>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">业务状态：</label>
						<div class="col-sm-4 form-inline" >
							<select id="brandSelect" class="form-control"  onmouseover="size=7;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:5">
								<option value="1">长城</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备所在单位：</label>
						<div class="col-sm-4 form-inline">
							<input type="text" class="form-control" ng-model="formParms.projectName"/>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">详细地址：</label>
					    <div class="col-sm-1 form-inline">
							<input class="form-control" type="text" />
					    </div>
					</div>
					
					<div class="form-group">
							<label contenteditable="false" class="col-xs-2 control-label">所在城市：</label>
							<div class="col-xs-2">
								<select onmouseover="size=5;" onmouseout="size=1;" ng-click="size=1;"
									id="province" name="province" class="form-control" ng-model="recPro.regionId" 
									ng-options="recP.regionId as recP.name for recP in areaList" ng-change="changePro(this);" >  														
	                        		<option value="">请选择省份</option>  
	                    		</select>
                    		</div>
                    		<div class="col-xs-2">  																		
	                    		<select onmouseover="size=5;" onmouseout="size=1;" ng-click="size=1;"
	                    			class="form-control" id="city" name="city" ng-model="recC.regionId" 
	                    			ng-options="recC.regionId as recC.name for recC in pList" ng-change="changeCity(this);" >  
	                        		<option value="">请选择城市</option>  
	                    		</select>
                    		</div>
                    		<div class="col-xs-2">  																		 
	                    		<select onmouseover="size=5;" onmouseout="size=1;" ng-click="size=1;"
	                    			class="form-control" id="district" name="district" ng-model="recD.regionId" 
	                    			ng-options="recD.regionId as recD.name for recD in cList" ng-change="changeDis(this)" >  
	                        		<option value="">请选择区县</option>  
	                    		</select>
                    		</div>
                    		<div ng-show="showFlag == 'province'">
								<p class="form-control-static" style="color:red;">请选择所在省份</p>
							</div>
                    		<div ng-show="showFlag == 'city'">
								<p class="form-control-static" style="color:red;">请选择所在城市</p>
							</div>
                    		<div ng-show="showFlag == 'district'">
								<p class="form-control-static" style="color:red;">请选择所在区县</p>
							</div>
							
					</div>
					
					<div class="form-group">
						
						<label contenteditable="false" class="col-sm-2 control-label">保管人：</label>
						<div class="col-sm-4 form-inline">
							<input type="text" class="form-control" />
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">联系电话：</label>
						<div class="col-sm-4 form-inline">
							<input type="text" class="form-control" ng-pattern="/(^[0-9,\-]{7,}$)/" />
						</div>
					</div>
					
					
					
					<div class="form-group">
					<label contenteditable="false" class="col-xs-2 control-label">进场日期：</label>
			 		<div class="col-xs-3" style="float: left; width: 160px; margin-right: -10px;">
						<input ng-click="clickDateFunStart();" ng-blur="cleanFlagFunStart();" id="beginDateId" type="text" ng-init="getBeforeDate();" ng-change="complienStart();" class="form-control input-group date form_date" ng-model="queryData.beginDate"> 
						<button ng-click="cleanDateFunStart();" ng-show="flagStart==true" id="flagStart" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button>
 							<span class="input-group-addon" style="display: none" > 
								<span class="glyphicon glyphicon-calendar">
								</span>
							</span>
					</div> 
				
					
					<!-- <span style="float: left;">-</span> -->
					<label contenteditable="false" class="col-xs-4 control-label" style="margin-left:5px;">出场日期：</label>
					<div class="col-xs-3" style="float: left; width: 160px; ">
						<input ng-click="clickDateFunEnd();" ng-blur="cleanFlagFunEnd();" id="endDateId" type="text" ng-init="getNowDateStr();"  ng-change="complienEnd();" class="form-control input-group date form_date" ng-model="queryData.endDate"><!-- 触发事件 --> 
						<button ng-click="cleanDateFunEnd();" ng-show="flagEnd==true" id="flagEnd" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button>
 						<span class="input-group-addon" style="display: none">
							<span class="glyphicon glyphicon-calendar">
							</span>
						</span>
					</div>
					</div>
				
				
					<div class="form-group" >
						<label contenteditable="false" class="col-sm-2 control-label">租赁方式：</label>
						<div class="col-sm-4 form-inline" style="text-align: left;">
							<select id="brandSelect" class="form-control"  onmouseover="size=7;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:5">
								<option value="1">月租</option>
								<option value="2">时租</option>
								<option value="3">工作量</option>
							</select>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">租赁单价：</label>
						<div class="col-sm-4 form-inline" style="text-align: left;">
							<input type="text" class="form-control" ng-model="formParms.projectName"/>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label" style="margin-top:10px;">结算方式：</label>
						<div class="col-sm-4 form-inline" style="text-align: left;">
							<select id="brandSelect" class="form-control"  onmouseover="size=7;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:5">
								<option value="1">长城</option>
							</select>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">合同编号：</label>
						<div class="col-sm-4 form-inline" style="text-align: left;">
							<input type="text" class="form-control" ng-model="formParms.projectName"/>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label">详细描述：</label>
						<div class="col-xs-10">
							<textarea class="form-control" name="textareaName" rows="3" ng-model="Admin.note" maxlength="60" placeholder="请输入字符在60个以内"></textarea>
		                </div>
						
					</div>
			</div>
			
		    	
				
			<div class="modal-footer">	 
				<input type="button" class="btn btn-primary" value="保存"  ng-click="add();"/>
				<input type="button" class="btn btn-default" value="取消" data-dismiss="modal"/>
		   </div> 
		</div>
		<!-- /.modal-content -->
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