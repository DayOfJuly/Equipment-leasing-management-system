<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal）-->
<div class="modal fade" id="rentCheckQueryId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;margin-top: 180px">
		<div class="modal-content" style="word-break: break-all">
			<div class="modal-header">
				<h4 class="modal-title">发布结果登记<button type="button"  style="margin-left: 800px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button></h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" >
					<div class="form-group" style="margin-top: -10px;">
						<label contenteditable="false" class="col-sm-2 control-label">设备编号：</label>
						<div class="col-sm-4">
							<h5 style="font-family: Microsoft YaHei!important;">{{userInfo.code}}-{{queryPublishList.equNo}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">资产编号：</label>
						<div class="col-sm-4">
							<h5 style="font-family: Microsoft YaHei!important;">{{queryPublishList.asset}}</h5>
						</div>
					</div>
					<div class="form-group"  >
						<label contenteditable="false" class="col-sm-2 control-label">设备名称：</label>
						<div class="col-sm-4">
							<h5 style="font-family: Microsoft YaHei!important;"><span>{{queryPublishList.equipmentName}}</span></h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">品牌：</label>
						<div class="col-sm-4">
							<h5 style="font-family: Microsoft YaHei!important;"><span>{{queryPublishList.brandName}}</span></h5>
						</div>
					</div>
					<div class="form-group"  style="margin-top: -20px;">
					 	<label contenteditable="false" class="col-xs-2 control-label">流程状态：</label>
						<div class="col-xs-2" id="div_2" ng-model="queryPublishList.state" style="margin-top: 8px">
							<span ng-show="queryPublishList.state==2">未成交</span>
						    <span ng-show="queryPublishList.state==1">已成交</span>
						</div>
						<label contenteditable="false" class="col-xs-4 control-label"style="margin-left:153px;">业务状态：</label>
						<div class="col-xs-2" id="div_2" ng-model="queryPublishList.busState" style="margin-top: 8px">
							<span ng-show="queryPublishList.busState==1">自用</span>
							<span ng-show="queryPublishList.busState==2">调拨</span>
							<span ng-show="queryPublishList.busState==3">局内租</span>
							<span ng-show="queryPublishList.busState==4">外局租</span>
							<span ng-show="queryPublishList.busState==5">外租</span>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备成交单位：</label>
						<div class="col-sm-4">
							<h5 style="font-family: Microsoft YaHei!important;">{{queryPublishList.depName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">发布日期：</label>
						<div class="col-sm-4">
							<h5 style="font-family: Microsoft YaHei!important;">{{queryPublishList.releaseDate}}</h5>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">备注：</label>
						<div class="col-sm-8" style="margin-top: 8px;font-family: Microsoft YaHei!important;" >
							{{queryPublishList.note}}
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer" >	
				<div >
					<input type="button"  class="btn btn_Under btn-default" value="返回" style="margin-top: -20px" data-dismiss="modal"/>
				</div> 
			</div> 
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
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