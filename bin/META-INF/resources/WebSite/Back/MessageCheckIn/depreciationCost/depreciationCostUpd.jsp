<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="depreciationUpdId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备编号：</label>
						<div class="col-sm-2">
							<p class="form-control-static">回显</p>
						</div>
						<label contenteditable="false" class="col-sm-4 control-label">资产编号：</label>
						<div class="col-sm-2">
							<p class="form-control-static">回显</p>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
						<div class="col-sm-2">
							<p class="form-control-static">回显</p>
						</div>
						<label contenteditable="false" class="col-sm-4 control-label">品牌：</label>
						<div class="col-sm-2">
							<p class="form-control-static">回显</p>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">出厂日期：</label>
						<div class="col-sm-2">
							<p class="form-control-static">回显</p>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">购置日期：</label>
						<div class="col-sm-2">
							<p class="form-control-static">回显</p>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-xs-2 control-label">登记月份：</label>
				 		<div class="col-xs-3" style="float: left; width: 160px; margin-right: -10px;">
							<input ng-click="clickDateFunStart();" ng-blur="cleanFlagFunStart();" id="beginDateId" type="text" ng-init="getBeforeDate();" ng-change="complienStart();" class="form-control input-group date form_date" ng-model="queryData.beginDate"> 
							<button ng-click="cleanDateFunStart();" ng-show="flagStart==true" id="flagStart" type="button" class="btn btn-link" style="color:#000;margin-top:-57px;margin-left:88px;"><span class="glyphicon glyphicon-remove"></span></button>
	 							<span class="input-group-addon" style="display: none" > 
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
						</div> 
						<p class="form-control-static" style="color: red;margin-left: 4px; margin-top:3px;float: left; ">*</p>
						
						<label contenteditable="false" class="col-sm-4 control-label" >折旧费：</label>
						<div class="col-sm-2">
							<input type="text" class="form-control">
							<p class="form-control-static" style="margin-left:150px;margin-top: -35px;">元</p>
						</div>
						<p class="form-control-static" style="color: red;margin-left: -8px; margin-top:3px;float: left; ">*</p>
					</div>
				</div>
			</div>
			<div class="modal-footer" >	
				<div style="text-align: center;">
					<input type="button"  class="btn btn-default" value="保存" data-dismiss="modal"/>
					<input type="button"  class="btn btn-default" value="取消" data-dismiss="modal"/>
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