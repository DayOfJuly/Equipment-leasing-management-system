<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
h4, .h4, h5, .h5, h6, .h6 {
    margin-top: 10px;
    margin-bottom: -10px;
}
</style>
<div class="container">
	<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
		<div class="navbar-inner" style="height: 39px">
			<div class="container">
				<div class="navbar-header text-center col-xs-12">
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/DemandInfoPubSale"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff"></span></small></a>
						<span style="color: #fff;">设备选择</span>
						<button type="button" class="btn  btn-sm" style="margin-left: 85%;margin-top:-13%;width: 80px;background: #0057b4;color:#fff;" ng-click="selectSubmit(equipment_obj,this,inputModel)">确定</button>
					</h4>				
				</div>
			</div>
		</div>
    </div>
    <!-- <div class="col-md-12 column" style="margin-top:20%">
			<p style="font-size: 18px">设备信息:<input type="text" class="form-control" id="exampleInputEmail1" style="width:60%;margin-left:21%;height:30px;margin-top: -25px" ng-model="inputModel.parm"/></p> <a href="/WebSite/Mobile/Index.jsp#/DemandInfopubSaleScreening"><p style="float: right;margin-top: -8%"" > <span class="glyphicon glyphicon-filter"></span></a></p>
    </div> -->
    <div class="form-group" style="margin-top:19%">
    <div class="col-xs-4" >
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:3px;">*</span><span>设备信息:</span></label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" ng-model="inputModel.parm" style="margin-top: -8px" class="form-control" id="exampleInputEmail1" />
			</div>
			<div class="col-xs-1">
				<a href="/WebSite/Mobile/Index.jsp#/DemandInfopubSaleScreening"><p style="float: right;margin-top: -8%"" > <span class="glyphicon glyphicon-filter"></span></a>
                      
			</div>
			</div>
    <div class="col-md-12 column" style="margin-top: 27%">
			<table class="table table-bordered" style="font-size: 13px">
				<thead>
				</thead>
				<tbody>
					<tr ng-repeat="t in categoryList" ng-click="Select(t,$index);">
						<td>
							<p><input type="radio" name="radio" ng-checked="radioTrIndex==$index"/><span style="font-size: 16px;margin-top: -5px;margin-left: 10%">{{t.equCategory.equipmentCategoryName}}————{{t.equName.equipmentName}}</span></p>
						</td>
					</tr>
				</tbody>
			</table>
    </div>
</div>
<!-- 出租信息-请选择或填写：品牌、型号、规格（Modal） -->
<div class="modal fade" id="ChoeDemandShopModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" ng-init="queryallequiData()">
    <!-- Default panel contents -->
    <div class="modal-dialog" style="margin-top:10%;width: 95%;">
        <div class="modal-content">
            <div class="modal-header">
            	<h4>请选择或填写：品牌、型号、规格<button type="button" class="btn btn-link  "  style="" data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></h4>
            </div>
            <div class="modal-body">
            	<div>
            		<!-- 当前设备名称  -->
            		<label contenteditable="false" class=" control-label" style="margin-top:10px;width:120px;margin-left:10px;"><h4>当前设备名称:</h4></label>
            		<div style="margin-top:-35px;margin-left:130px;">
            			<p style="margin-top:15px;">{{inputModel.parm}}</p>
            		</div>
            		<!-- 品牌  -->
					<label contenteditable="false" class=" control-label" style="margin-top:30px;width:88px;margin-left:10px;">品牌</label>
					<div ng-show="brandSelectShow">
						<select name="state"  class="form-control select-hover" 
								ng-options="rec.id as rec.name for rec in queryEquBrandList" ng-model="selectList.brandS" 
								style="margin-top:-35px;margin-left:50px;width:200px;position:absolute;z-index:99;" id="state"
						        ng-change="brandChange(selectList.brandS);">
						        <option value=""">请选择</option>
						</select>
					</div>
					<div ng-show="brandSelectShow">
						<input type="text" maxlength="20" ng-model="selectList.brandI" class="form-control" style="margin-top:-30px;margin-left:50px;width:200px;height:25px;" placeholder="请输入品牌名称">
						<a href="" style="text-decoration: none;float: right;margin-top:-20px;" value="" ng-click="addManual('Brand');">手动添加</a>
					</div>
					<div ng-show="brandInputShow">
						<input type="text" maxlength="20" ng-model="selectList.brandI" class="form-control" style="margin-top:-30px;margin-left:50px;width:200px;" placeholder="请输入品牌名称">
						<a ng-click="addSelect('Brand');" href="" style="text-decoration: none;float: right;margin-top:-23px;margin-right:28px;">重选</a>
					</div>
					<!-- 型号  -->
					<label contenteditable="false" class=" control-label" style="margin-top:30px;width:88px;margin-left:10px;">型号</label>
					<div ng-show="modelSelectShow">
						<select name="state" id="state"  ng-model="selectList.modelS"
								ng-options="rec.id as rec.name for rec in queryEquModelList"
								style="margin-top:-30px;margin-left:50px;width:200px;position:absolute;z-index:90;"
						         class="form-control select-hover" ng-change="modelChange(selectList.modelS);">
							<option value=""">请选择</option>
						</select>
					</div>
					<div ng-show="modelSelectShow">	
						<input  type="text"  maxlength="20" ng-model="selectList.modelI" class="form-control" style="margin-top:-30px;margin-left:50px;width:200px;" placeholder="请输入型号">
						<a ng-click="addManual('Model');" href="" style="text-decoration: none;float: right;margin-top:-23px;">手动添加</a>
					</div>
					<div ng-show="modelInputShow">	
						<input  type="text"  maxlength="20" ng-model="selectList.modelI" class="form-control" style="margin-top:-30px;margin-left:50px;width:200px;" placeholder="请输入型号">
						<a ng-click="addSelect('Model');" href="" style="text-decoration: none;float: right;margin-top:-23px;margin-right:28px;">重选</a>
					</div>
					<!-- 规格  -->
					<label contenteditable="false" class=" control-label" style="margin-top:30px;width:88px;margin-left:10px;">规格</label>
					<div ng-show="standardSelectShow">
						<select name="state" id="state"  ng-model="selectList.standardS"
								ng-options="rec.id as rec.name for rec in queryEquStandardList"
								style="margin-top:-30px;margin-left:50px;width:200px;position:absolute;z-index:80;"
						        class="form-control select-hover" ng-change="standardChange(selectList.standardS);">
							<option value=""">请选择</option>
						</select>
					</div>
					<div ng-show="standardSelectShow">	
						<input  type="text" maxlength="20" ng-model="selectList.satndardI" class="form-control" style="margin-top:-30px;margin-left:50px;width:200px;" placeholder="请输入规格">
						<a ng-click="addManual('Standard');" href="" style="text-decoration: none;float: right;margin-top:-23px;">手动添加</a>
					</div>
					<div ng-show="standardInputShow">	
						<input  type="text"  maxlength="20" ng-model="selectList.satndardI" class="form-control" style="margin-top:-30px;margin-left:50px;width:200px;" placeholder="请输入规格">
						<a ng-click="addSelect('Standard');" href="" style="text-decoration: none;float: right;margin-top:-23px;margin-right:28px;">重选</a>
					</div>
				</div>
       		</div>
       		<div class="modal-footer " >
                <input type="button" class="btn btn-primary" value="确定" ng-click="addModelSubimt();">
                <input type="button"  style="margin-right: 30px;"  class="btn btn-default" value="关闭" >
            </div>
       	</div>
    </div>
</div>
