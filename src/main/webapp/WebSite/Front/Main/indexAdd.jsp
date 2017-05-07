<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!-- 保险申请-模态框（Modal） -->
<div class="modal fade" id="InsuranceModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{title}}</h4>
			</div>
			<div class="modal-body">
				<form name="queryDetialForm" action="#" method="post"
					id="queryDetialForm" enctype="application/x-www-form-urlencoded">

					<ul id="ulTab" class="nav nav-tabs" style="margin-top: 30px;">
						<li class="active"><a href="#LoanInfo" data-toggle="tab">保险申请信息</a></li>
						<li class=""><a href="#threePartId" data-toggle="tab">三方协议</a></li>
						<li class=""><a href="#upLoadFileId" data-toggle="tab" ng-show="judgeAddUpd=='upd'">上传进件资料</a></li>
					</ul>

					<div id="myTabContent" class="tab-content">
						<!-- 借款申请信息start -->
						<div class="tab-pane fade in active" id="LoanInfo">
							<div class="form-horizontal" style="margin-top: 30px;">
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">委托人：</label>
									<div class="col-sm-4 form-inline">
										<input type="text" class="form-control" readOnly ng-model="saveParms.person"> <input type="button" value="查询" class="btn btn-primary" ng-click="openLoanUser();">
									</div>
								</div>

								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">组织机构代码：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" readOnly ng-model="tempIdNo">
									</div>
								</div>
								<input type="hidden" ng-model="saveParms.prodId">
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">委托人ID：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="loanerId"
											name="loanerId" ng-model="saveParms.loanerId">
									</div>
									<label contenteditable="false" class="col-sm-2 control-label">委托人账号：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id=acNo name="acNo"
											ng-model="saveParms.acNo">
									</div>
								</div>
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">产品名称：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="note" name="note"
											ng-model="saveParms.note">
									</div>
									<label contenteditable="false" class="col-sm-2 control-label">产品代码：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id=code name="code"
											ng-model="saveParms.code">
									</div>
								</div>
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">借款金额：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="amount"
											name="amount" ng-model="saveParms.amount">
									</div>
									<label contenteditable="false" class="col-sm-2 control-label">年化收益利率：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="rate" name="rate"
											ng-model="saveParms.rate">
									</div>
								</div>
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">期限：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="term" name="term"
											ng-model="saveParms.term">
									</div>
									<label contenteditable="false" class="col-sm-2 control-label">起投金额：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="minAmt"
											name="minAmt" ng-model="saveParms.minAmt">
									</div>
								</div>
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">计息日期：</label>
									<div class="col-sm-4">
										<input type="text"
											class="form-control input-group date form_date "
											id="interestDay" name="interestDay"
											ng-model="saveParms.interestDay" data-date=""
											data-date-format="yyyy-mm-dd"> <span
											class="input-group-addon" style="display: none"><span
											class="glyphicon glyphicon-calendar"></span></span>
									</div>
									<label contenteditable="false" class="col-sm-2 control-label">产品状态：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="state"
											name="state" ng-model="saveParms.state">
									</div>
								</div>
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">产品类型：</label>
									<div class="col-sm-4">
										<select class="form-control" id="prodType" name="prodType"
											ng-model="saveParms.prodType">
											<option value="10">等额本金</option>
											<option value="11">等额本息</option>
											<option value="12">一次性还本付息</option>
										</select>
									</div>
									<label contenteditable="false" class="col-sm-2 control-label">产品进度：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="progress"
											name="progress" ng-model="saveParms.progress">
									</div>
								</div>
								<div class="form-group">
									<label contenteditable="false" class="col-sm-2 control-label">剩余可投金额：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="balance" name="balance" readOnly ng-model="saveParms.amount">
									</div>
									<label contenteditable="false" class="col-sm-2 control-label">合同号：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="contractNo"
											name="contractNo" ng-model="saveParms.contractNo">
									</div>
								</div>
								<div class="form-group">
									<div align="center">
										<input type="button" class="btn btn-primary" value="添加" ng-show="judgeAddUpd=='add'" ng-click="addLoanApply();">
										<input type="button" class="btn btn-primary" value="更新" ng-show="judgeAddUpd=='upd'" ng-click="updLoanApply();">
										<input type="button" class="btn btn-primary" value="返回" data-dismiss="modal">
									</div>
								</div>
							</div>
						</div>
						<!-- 借款申请信息end -->

						<!-- 三方start -->
						<div class="tab-pane fade" id="threePartId">
							<div ng-include src="'../../WebSite/Main/ThreePartyAgreement.jsp'"></div>
						</div>
						<!-- 三方end -->

						<!-- 上传进件资料start -->
						<div class="tab-pane fade" id="upLoadFileId">
							<form action="#" method="post">
								<div class="table-responsive">
									<table class="table table-bordered">
										<thead>
											<tr class="success">
												<th style="vertical-align: middle; text-align: center;">序号</th>
												<th style="vertical-align: middle; text-align: center;">档案类别</th>
												<th style="vertical-align: middle; text-align: center;">资料名称</th>
												<th style="vertical-align: middle; text-align: center;">文件展示</th>
												<th style="vertical-align: middle; text-align: center;">最后更新时间</th>
												<th style="vertical-align: middle; text-align: center;">操作&nbsp;&nbsp;
													<a class="btn btn-primary" data-toggle="modal" data-target="#upLoadFileAdd">添加</a>
												</th>
											</tr>
										</thead>

										<tbody>
											<tr>
												<td style="vertical-align: middle; text-align: center;"><span>1</span></td>
												<td style="vertical-align: middle; text-align: center;">
													进件资料
												</td>
												<td style="vertical-align: middle; text-align: center;">马云借款欠条</td>
												<td style="vertical-align: middle; text-align: center;">
													<img src="../../media/images/doc.png" style="margin-left:20px;margin-right:10px;width:40px;float:left;"/>
													<div style="float:left;color:#777;"><h6>欠条</h6></div>
													
												</td>
												<td style="vertical-align: middle; text-align: center;">2015-06-28</td>
												<td style="vertical-align: middle; text-align: center;">
													<!-- <a class="btn btn-primary" data-toggle="modal" data-target="#upLoadFileAdd">更新</a> -->
													<a class="btn btn-primary" data-toggle="modal">删除</a>
													<a class="btn btn-primary" data-toggle="modal" ng-click="openFileDesc(rec);">查看文档</a>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>
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
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>


<!-- 借款申请-上传进件资料-添加-模态框（Modal） -->
<div class="modal fade" id="upLoadFileAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">添加</h4>
			</div>
			<div class="modal-body" style="text-align:center;">
				<form name="form" action="" method="post" id="form" enctype="application/x-www-form-urlencoded">
					<div class="form-group ">
						<label class="col-sm-2 control-label">档案类别：</label> 
						<select name="archivesType" id="archivesType" class="form-control" ng-model="fileData.archType" style="width: 300px;">
							<option value="">请选择</option>
							<option value="0">进件资料</option>
							<option value="1">签约资料</option>
							<option value="2">展期签约资料</option>
						</select>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">资料名称：</label> 
						<input type="text" class="form-control" ng-model="fileData.archName" style="width: 300px;">
					</div>
					<div class="form-group">
				        <label contenteditable="false" class="col-sm-2 control-label">图片/文件上传：</label>
				        <input id="fileUpLoadId" type="file" ng-file-select="onFileSelect($files)" onChange="judgeChange();" style="display:none">
				        <div class="input-group col-sm-4">
			               <input id="fileUpLoadNameId" type="text" class="form-control" ng-model="fileData.clientFileName">
			               <span class="input-group-btn">
			                  <button class="btn btn-primary" type="button" ng-click="upLoadBtn();">
								上传文件
			                  </button>
			               </span>
			            </div>
				    </div>
					<div style="margin-left:-300px;">
						<input class="btn btn-default" type="button" value="提交" ng-click="saveArchives();">
						<input class="btn btn-default" type="button" value="返回" data-dismiss="modal">
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>

<!-- 借款申请-上传进件资料-查看文档-模态框（Modal） -->
<div class="modal fade" id="upLoadFileQuery" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">查看文档</h4>
			</div>
			<div class="modal-body" style="text-align:center;">
				<form name="form" action="" method="post" id="form" enctype="application/x-www-form-urlencoded">
					<div class="margin_left" style="margin-top: 50px;">
						<span id="titleMsg">{{fileDesc.infoFile.clientFileName}}
							上传时间：{{fileDesc.infoFile.recordTime}}</span>
					</div>
					<div>
						<a href=""> 
							<img src="../../media/images/doc.png" title="点击下载" style="margin-top: 10px;"/>
						</a>
					</div>
					<div class="errors"
						style="margin: 10px; margin-left: 500px; color: red; font-size: 14px;"
						id="errormsg"></div>
					<div>
						<input class="btn btn-default" type="button" value="上一个" > 
						<input class="btn btn-default" style="margin-left: 20px;" type="button" value="返回" data-dismiss="modal"> 
						<input class="btn btn-default" style="margin-left: 20px;" type="button" value="下一个" >
					</div>
				</form>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
