<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 出租信息新增模态框（Modal） -->
<div class="modal fade" id="rentceModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<!-- Default panel contents -->
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				{{titleMsg}}<a style="color: blue">{{titleMsg2}}</a>{{titleMsg3}}
			</div>
			<div class="modal-body">
				<!-- body-start -->
				<table class="table table-bordered">
					<caption>可租售设备信息</caption>
					<thead>
						<tr class="active">
							<th>名称</th>
							<th>城市</th>
							<th>密码</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Tanmay</td>
							<td>Bangalore</td>
							<td>560001</td>
						</tr>
						<tr>
							<td>Sachin</td>
							<td>Mumbai</td>
							<td>400003</td>
						</tr>
						<tr>
							<td>Uma</td>
							<td>Pune</td>
							<td>411027</td>
						</tr>
					</tbody>
				</table>
				<!-- body-end -->
			</div>
			<div class="modal-footer ">
				<input type="button" class="btn btn-primary" value="添加"
					ng-show="judge=='add'" ng-click="add();"> <input
					type="button" class="btn btn-primary" value="修改"
					ng-show="judge=='upd'" ng-click="upd();"> <input
					type="button" class="btn btn-default" value="返回"
					data-dismiss="modal">
			</div>
		</div>
	</div>
</div>



