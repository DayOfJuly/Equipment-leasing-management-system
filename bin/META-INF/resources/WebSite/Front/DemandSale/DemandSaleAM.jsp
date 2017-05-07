<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 出租信息新增模态框（Modal） -->
<div class="modal fade" id="rentModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<!-- Default panel contents -->
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				{{titleMsg}}<a style="color: blue">{{titleMsg2}}</a>{{titleMsg3}}
			</div>
			<div class="modal-body">
				<!-- body-start -->
				<div class="form-horizontal">
					<div class="panel panel-default">
						<div class="panel-heading">基本信息</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">信息类型：</label>
						<div class="col-sm-1 ">
							<label class="radio-inline"> <input type="radio"
								name="rentRadio" id="rentRadio" value="1"
								ng-model="formParms.rentRadio" ng-show="judge=='add'">
								求租
							</label>
						</div>
						<div class="col-sm-1 ">
							<label class="radio-inline"> <input type="radio"
								name="rentRadio" id="rentRadio" value="2"
								ng-model="formParms.rentRadio"> 求购
							</label>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">信息标题：</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="newstitle"
								ng-model="formParms.infoTitle" placeholder="请输入信息标题……">
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">面向城市：</label>
						<div class="col-sm-2">
							<select class=" form-control">
								<option value=" ">请选择省份</option>
								<option value="2">辽宁</option>
								<option value="3">河北</option>
							</select>
						</div>
						<div class="col-sm-2">
							<select class=" form-control">
								<option value=" ">请选择城市</option>
								<option value="2">沈阳</option>
								<option value="3">大连</option>
							</select>
						</div>
						<div class="col-sm-2">
							<select class=" form-control">
								<option value=" ">请选择区县</option>
								<option value="2">大东区</option>
								<option value="3">沈河区</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">期望价格：</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="price" name="price"
								ng-model="formParms.price">
						</div>
						<div class="col-sm-2">
							<select class=" form-control">
								<option value="1">元/月</option>
								<option value="2">元/天</option>
								<option value="3">元/小时</option>
							</select>
						</div>

						<label contenteditable="false" class="col-sm-2 control-label">期望押金：</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="price" name="price"
								ng-model="formParms.price">
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">数量：</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="price" name="price"
								ng-model="formParms.price">
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">详细说明：</label>
						<div class="col-sm-9">
							<textarea class="form-control" rows="3"
								ng-model="formParms.detailedDescription" maxlength="1964"></textarea>
							说明：您可以输入<a style="color: red">{{1964-formParms.detailedDescription.length}}</a>个字。温馨提示：输入内容越详细，用户越容易找到此类信息！
						</div>

					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备图片：</label>
						<div id="ng-app" nv-file-drop="" uploader="uploader" class="row">

							<button type="button" class="btn btn-primary"
								onmouseover="this.style.cursor='hand'">上传图片</button>

						</div>
					</div>

					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">申请日期：</label>
						<div class="col-sm-4">
							<input type="text"
								class="form-control input-group date form_date "
								ng-model="formParms.testDate" data-date=""
								data-date-format="yyyy-mm-dd"> <span
								class="input-group-addon" style="display: none"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">联系方式</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">企业名称：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="loanerId"
								name="loanerId" ng-model="formParms.loanerId">
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">所在城市：</label>
						<div class="col-sm-2">
							<select class=" form-control">
								<option value=" ">请选择省份</option>
								<option value="2">辽宁</option>
								<option value="3">河北</option>
							</select>
						</div>
						<div class="col-sm-2">
							<select class=" form-control">
								<option value=" ">请选择城市</option>
								<option value="2">沈阳</option>
								<option value="3">大连</option>
							</select>
						</div>
						<div class="col-sm-2">
							<select class=" form-control">
								<option value=" ">请选择区县</option>
								<option value="2">大东区</option>
								<option value="3">沈河区</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">联系人：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="loanerId" 
								name="loanerId" ng-model="formParms.loanerId">
						</div>
						<div class="col-sm-1"></div>
						<label contenteditable="false" class="col-sm-2 control-label">联系手机：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="loanerId" ng-pattern="/(^[0-9,\-]{7,}$)/" 
								name="loanerId" ng-model="formParms.loanerId">
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">QQ：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="loanerId"
								name="loanerId" ng-model="formParms.loanerId">
						</div>
						<div class="col-sm-1"></div>
						<label contenteditable="false" class="col-sm-2 control-label">电子邮箱：</label>
						<div class="col-sm-3">
							<input type="email" class="form-control" id="loanerId"
								name="loanerId" ng-model="formParms.loanerId" required>
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">固定电话：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="loanerId"
								name="loanerId" ng-model="formParms.loanerId">
						</div>
						<div class="col-sm-1"></div>
						<label contenteditable="false" class="col-sm-2 control-label">联系地址：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="loanerId"
								name="loanerId" ng-model="formParms.loanerId">
						</div>
					</div>
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">验证码：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="loanerId"
								name="loanerId" ng-model="formParms.loanerId">
						</div>
					</div>


				</div>
			</div>
			<div class="modal-footer " class="modal fade" id="rentButton"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<input type="button" class="btn btn-primary" value="出售"
					ng-show="judge=='add'" ng-click="add()"> <input
					type="button" class="btn btn-primary" value="修改"
					ng-show="judge=='upd'" ng-click="upd();"> <input
					type="button" class="btn btn-default" value="返回"
					data-dismiss="modal">
			</div>
		</div>
	</div>
</div>

<!-- /.modal-content -->
<!-- /.modal -->
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

