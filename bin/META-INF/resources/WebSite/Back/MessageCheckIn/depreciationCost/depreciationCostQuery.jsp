<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="depreciationQueryId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					 <table class="table table-striped table-hover" >
						<thead>
							<tr class="success">
								<th style="text-align:center;"><span style="margin-left:30px;">序号</span></th>
								<th></th>
								<th style="text-align:center;">设备编号</th>
								<th style="text-align:center;">资产编号</th>
								<th style="text-align:center;">设备名称</th>
								<th style="text-align:center;">品牌</th>
								<th style="text-align:center;">出厂日期</th>
								<th style="text-align:center;">购置日期</th>
								<th style="text-align:center;">登记月份</th>
								<th style="text-align:center;">折旧费</th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="t in examineList" ng-click="selectRow(this)" style="text-align:center;">
								<td ><input style="margin-left:18px;" type="radio" name="id" ng-checked="radio_flag==$index"/>&nbsp;</td>					
								<td><span style="margin-left:-85px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.pageRecord}}</span></td>
		                        <td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
				   </table>
				   
			</div>
	    	
		</div>
		<div class="modal-footer" >	
			<div style="text-align: center;">
				<input type="button"  class="btn btn-default" value="取消" data-dismiss="modal"/>
			</div> 
			<div class="col-xs-12">
				    <pagination-tag conf="paginationConf"></pagination-tag>
			</div>
		</div> 
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<script type="text/javascript">
	$('.form_date').datetimepicker({
		format: 'yyyy-mm-dd',
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