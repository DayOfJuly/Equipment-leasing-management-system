<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 出租信息新增模态框（Modal） -->
<div class="modal fade" id="ChoEquModalId" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" ng-init="queryallequiData()">
    <!-- Default panel contents -->
    <div class="modal-dialog" style="width: 95%;">
        <div class="modal-content">
            <div class="modal-header">
            	<h4>设备信息</h4>
            </div>
            <div class="modal-body">
                <!-- 所属单位  -->
				<div class="col-xs-12" style="margin-bottom:10px; margin-top: 10px;" id="areaId">
					<label contenteditable="false" class="col-xs-1 control-label" style="margin-top:10px;width:78px;">设备名称</label>
					<div class="col-xs-3">
						<input ng-click="applianceClick();" style="margin-left:0px; height: 25px;z-index:33;margin-top:3px;" class="form-control"  type="text" placeholder="一局">
					      <table ng-show="tableShow" class="table table-bordered table-hover" style="background-color:white; width:92%;margin-bottom: 0px;position:absolute;">
	                           <tbody>
		                            <tr>
		                                <th style="text-align: center;background-color: #D4D4D4;">设备编号：</th>
		                                <th style="text-align: center;background-color: #D4D4D4;">设备名称：</th>
		                            </tr>
		                            <tr style="text-align: center;">
		                                <td>土石方机械</td>
		                                <td>履带挖掘机</td>
		                            </tr>
		                            <tr style="text-align: center;">
		                                <td>动力机械</td>
		                                <td>电动空压机</td>
		                            </tr>
		                            <tr style="text-align: center;">
		                                <td>起重机械></td>
		                                <td>随车起重机</td>
		                            </tr>
	                           </tbody>
	                       </table> 
					</div>
					<div class="col-xs-2">
						<input class="btn btn-default" type="button" value="搜索" style="float: right;margin-right: 37px;width: 75px;height: 30px;">
					</div>
				</div>
                <table class="table table-bordered table-hover">
                    <thead>
	                    <tr class="active">
	                        <th style="text-align: center;">选择</th>
	                        <th style="text-align: center;">序号</th>
	                        <th style="text-align: center;">单位名称</th>
	                        <th style="text-align: center;">设备编号</th>
	                        <th style="text-align: center;">设备名称</th>
	                        <th style="text-align: center;">品牌</th>
	                        <th style="text-align: center;">型号</th>
	                        <th style="text-align: center;">规格</th>
	                        <th style="text-align: center;">功率(KW)</th>
	                        <th style="text-align: center;">技术状况</th>
	                        <th style="text-align: center;">生产厂家</th>
	                        <th style="text-align: center;">出厂日期</th>
	                    </tr>
                    </thead>
                    <tbody><!-- t.equipmentId,$index -->
                    	<tr ng-repeat="t in allequiList" ng-click="Select(this);" ng-dblclick="queryequiData();" style="text-align: center;">
	                        <td href="javascript:void(0);"><input type="radio"  ng-checked="radioTrIndex==$index"/></td>
	                        <td>{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
	                        <td>{{t.subsidiaryName}}</td>
	                        <td>{{t.equipmentCategoryTable[0].categoryTable.equipmentNo}}</td>
	                        <td>{{t.equipmentCategoryTable[0].categoryTable.equipmentName}}</td>
	                        <td>{{t.brandName}}</td>
	                        <td>{{t.models}}</td>
	                        <td>{{t.specifications}}</td>
	                        <td>{{t.power}}</td>
	                        <td>{{t.technicalStatus}}</td>
	                        <td>{{t.manufacturer}}</td>
	                        <td>{{t.productionDate}}</td>
	                    </tr>
                    </tbody>
                </table>
                <div style="float: right;margin-bottom: 10px;margin-top: -30px;">
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
                <!-- body-end -->
            </div>
            <br>
            <div class="modal-footer ">
                <input type="button" class="btn btn-primary" value="选择"
                       ng-click="queryequiData();"> <input
                    type="button" class="btn btn-default" value="关闭"
                    data-dismiss="modal">
            </div>
        </div>
    </div>
</div>



