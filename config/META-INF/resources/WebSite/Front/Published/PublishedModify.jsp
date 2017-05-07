<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="publishedModalId" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" style="margin-top: 30px;">
					<div class="form-group">
						<input type="hidden" ng-model="formParms.id"/>
						<label contenteditable="false" class="col-sm-2 control-label">设备状态：</label>
						<div class="col-sm-4 form-inline">
							<select class="form-control" ng-model="formParms.dataState" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:2">
								<option value="1">使用中</option>
								<option value="2">可出租</option>
								<option value="3">可出售</option>
								<option value="4">可租售</option>
								<option value="5">已出售</option>
								<option value="6">已报废</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<input type="hidden" ng-model="formParms.id"/>
						<label contenteditable="false" class="col-sm-2 control-label">信息类型：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.process.bizName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">信息标题：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.infoTitle}}</h5>
						</div>
					</div>

					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">面向城市：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.FaceRegionName==""?"":formParms.FaceRegionName}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">期望金额：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.expectedAmount}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">期望押金：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.expectedDeposit}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">数量：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.quantity}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">地址：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.contactAddress}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">发布日期：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.updateTime}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">详细说明：</label>
						<div class="col-sm-10 form-inline">
							<p class="form-control-static" rows="3" style="width:85%" readonly>{{formParms.detailedDescription}}</p>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">设备图片：</label>
						<div class="col-sm-2 form-inline" ng-repeat="t in formParms.equipmentPicList">
							<img style="width:100px; height:80px" ng-src="{{PicUrl_Copy}}/{{t.pic}}/{{t.suffix}}" alt="{{t.pic}}.{{t.suffix}}">
						</div>
					</div>
					
					<h3>联系方式</h3>
					<hr>
										
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">企业名称：</label>
						<div class="col-sm-10 form-inline">
							<h5>{{formParms.enterpriseName}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">联系人：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.contactPerson}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">所在城市：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.atRegionName}}</h5>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">固定电话：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.fixedTelephone}}</h5>
						</div>
						<label contenteditable="false" class="col-sm-2 control-label">联系手机：</label>
						<div class="col-sm-4 form-inline">
							<h5>{{formParms.contactPhone}}</h5>
						</div>
					</div>
					
					<h3>登记设备流转信息</h3>
					<hr>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">合同编号：</label>
						<div class="col-sm-10 form-inline">
							<input type="text" class="form-control" ng-model="formParms.code"/>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">供应商：</label>
						<div class="col-sm-10 form-inline">
							<input type="text" class="form-control" ng-model="formParms.originOrg"/>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">价格：</label>
						<div class="col-sm-10 form-inline">
							<input type="text" class="form-control" ng-model="formParms.price" placeholder="请输入整数"/>
							<select class="form-control" ng-model="formParms.priceType" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:4;margin-left:5px;">
								<option value="1">元 /月</option>
								<option value="2">元 /天</option>
								<option value="3">元 /小时</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">原所在城市：</label>
						<div class="col-sm-10 form-inline">
							<select class="form-control" ng-model="formParms.provinceId" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:3;">
								<option value="">请选择省份</option>
								<option value="010">北京市</option>
								<option value="020">天津市</option>
							</select>
							<select class="form-control" ng-model="formParms.cityId" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:3;margin-left:130px;">
								<option value="">请选择城市</option> 
								<option value="010">北京市</option>
								<option value="020">天津市</option>
							</select>
							<select class="form-control" ng-model="formParms.areaId" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:3;margin-left:260px;">
								<option value="">请选择区县</option>
								<option value="0101">通州区</option>
								<option value="0102">顺义区</option>
								<option value="0201">武清区</option>
								<option value="0202">红桥区</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label contenteditable="false" class="col-sm-2 control-label">现所在城市：</label>
						<div class="col-sm-10 form-inline">
							<select class="form-control" ng-model="formParms.presentProvinceId" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:2">
								<option value="">请选择省份</option>
								<option value="010">北京市</option>
								<option value="020">天津市</option>
							</select>
							<select class="form-control" ng-model="formParms.presentCityId" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:2;margin-left:130px;">
								<option value="">请选择城市</option>
								<option value="010">北京市</option>
								<option value="020">天津市</option>
							</select>
							<select class="form-control" ng-model="formParms.presentAreaId" onmouseover="size=6;" onmouseout="size=1;" onclick="size=1;" style="position: absolute;z-index:2;margin-left:260px;">
								<option value="">请选择区县</option>
								<option value="0101">通州区</option>
								<option value="0102">顺义区</option>
								<option value="0201">武清区</option>
								<option value="0202">红桥区</option>
							</select>
						</div>
					</div>
					
				</div>
			</div>
			<div class="modal-footer">
				<input type="button" class="btn btn-primary" value="提交" ng-click="upd();"/>
				<input type="button" class="btn btn-default" value="取消" data-dismiss="modal"/>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>