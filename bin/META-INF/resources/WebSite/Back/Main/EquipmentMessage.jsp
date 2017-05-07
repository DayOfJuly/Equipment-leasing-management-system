<%@page contentType="text/html; charset=UTF-8" session="true" pageEncoding="UTF-8" %>
<style>
 .font-title{
      font-size: 14px;
      font-weight:bold;
      text-align:right;
 }
  .font-content{
      font-size: 14px;
      text-align:left;
 }
</style>
<div class="modal fade" id="equipmentMessage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 1000px;">
		<div class="modal-content">
		
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel" style="font-weight:800">
					设备基本信息
					<span class="pull-right" data-dismiss="modal" style="font-weight: bold; cursor: pointer;">x</span>
            	</h4>
            </div>			
		
			<div class="modal-body" style="padding: 3px;">			
				<div class="mar_t15" align="center">
					<table width="98%" border="0" cellspacing="0" cellpadding="0" class="gwafdg">
						<tr>
							<td class="font-title">局级单位：</td>
							<td class="font-content" colspan="3"  style="text-align:left;" ng-bind="equipmentBean.bureauOrgPartyName"></td>
							<td  class="font-title">子公司名称：</td>
							<td class="font-content"  ng-bind="equipmentBean.sonOrgName"></td>				
						</tr>
						<tr>
							<td  class="font-title">项目名称：</td>
							<td  class="font-content"  colspan="5"  ng-bind="equipmentBean.proOrgName"></td>
						</tr>	
						<tr>
							<td  class="font-title">设备编号：</td>
							<td  class="font-content"  ng-bind="equipmentBean.equNo"></td>
							<td  class="font-title">资产编号：</td>
							<td  class="font-content"  ng-bind="equipmentBean.asset"></td>	
							<td  class="font-title">&nbsp;&nbsp;设备名称：</td>
							<td  class="font-content"  ng-bind="equipmentBean.equName"></td>											
						</tr>
						<tr>
							<td colspan="6" align="center">
								<table width="93%" border="0" cellspacing="0" cellpadding="0" class="gwafdg">
									<tr>
										<td  class="font-title"  width="12%">生产厂家：</td>
										<td  class="font-content"  width="24%" ng-bind="equipmentBean.manufacturerName"></td>
										<td   class="font-title"  width="12%" >品牌：</td>
										<td  class="font-content"  width="12%" ng-bind="equipmentBean.brandName"></td>	
										<td   class="font-title"  width="12%">型号：</td>
										<td  class="font-content"  width="12%" ng-bind="equipmentBean.models"></td>
										<td   class="font-title"  width="12%">规格：</td>
										<td  class="font-content"  width="12%" ng-bind="equipmentBean.specifications"></td>																					
									</tr>								
								</table>
							</td>
						</tr>	
						<tr>
							<td  class="font-title">设备原值：</td>
							<td  class="font-content"  >{{equipmentBean.equipmentCost}}万元</td>
							<td  class="font-title">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;功率（KW）：</td>
							<td  class="font-content"  ng-bind="equipmentBean.power"></td>		
							<td  class="font-title">&nbsp;&nbsp;出厂编号：</td>
							<td  class="font-content"  ng-bind="equipmentBean.facortyNo"></td>										
						</tr>
						<tr>
							<td  class="font-title">出厂日期：</td>
							<td  class="font-content"  ng-bind="equipmentBean.productionDate"></td>
							<td  class="font-title">购置日期：</td>
							<td  class="font-content"  ng-bind="equipmentBean.purchaseDate"></td>
							<td  class="font-title" >&nbsp;&nbsp;牌照号码：</td>
							<td  class="font-content"  ng-bind="equipmentBean.licenseNo"></td>								
						</tr>	
						<tr>
							<td  class="font-title">技术状况：</td>
							<td  class="font-content"  ng-bind="ct.codeTranslate(equipmentBean.technicalStatus, 'TECHNOLOGY_STATE')"></td>
							<td  class="font-title">动力种类：</td>
							<td  class="font-content"  colspan="3" ng-bind="ct.codeTranslate(equipmentBean.powerType, 'POWER_TYPE')"></td>				
						</tr>																							
					</table>
				</div>			
			
			    <!-- bootstrap style -->
<!-- 				<div class="form-horizontal mar_t15"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">局级单位：</label> -->
<!-- 						<div class="col-xs-5 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.bureauOrgPartyName"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">子公司名称：</label> -->
<!-- 						<div class="col-xs-3 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.sonOrgName"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="form-group" > -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">项目名称：</label> -->
<!-- 						<div class="col-xs-10 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.proOrgName"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="form-group" > -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">设备编号：</label> -->
<!-- 						<div class="col-xs-2 div_Modify"> -->
<!-- 							<p class="form-control-static" ng-bind="equipmentBean.equNo"></p> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">资产编号：</label> -->
<!-- 						<div class="col-xs-1 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.asset"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 34px;">设备名称：</label> -->
<!-- 						<div class="col-xs-3 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.equName"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="form-group" > -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">生产厂家：</label> -->
<!-- 						<div class="col-xs-2 div_Modify" title="{{equipmentBean.manufacturerName}}"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.manufacturerNameCopy"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">品牌：</label> -->
<!-- 						<div class="col-xs-1 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.brandName"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-1 control-label" style="margin-left: 5px;">型号：</label> -->
<!-- 						<div class="col-xs-1 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.models"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-1 control-label">规格：</label> -->
<!-- 						<div class="col-xs-1 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.specifications"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="form-group" > -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">设备原值：</label> -->
<!-- 						<div class="col-xs-2 div_Modify"> -->
<!-- 							<p class="form-control-static">{{equipmentBean.equipmentCost}}万元</p> -->
							
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">功率（KW）：</label> -->
<!-- 						<div class="col-xs-1 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.power"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 34px;">出厂编号：</label> -->
<!-- 						<div class="col-xs-3 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.facortyNo"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="form-group" > -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">出厂日期：</label> -->
<!-- 						<div class="col-xs-2 div_Modify"> -->
<!-- 							<p class="form-control-static" ng-bind="equipmentBean.productionDate"></p> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">购置日期：</label> -->
<!-- 						<div class="col-xs-1 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.purchaseDate"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 34px;">牌照号码：</label> -->
<!-- 						<div class="col-xs-3 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="equipmentBean.licenseNo"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="form-group" > -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">技术状况：</label> -->
<!-- 						<div class="col-xs-2 div_Modify"> -->
<!-- 							<p class="form-control-static" ng-bind="ct.codeTranslate(equipmentBean.technicalStatus, 'TECHNOLOGY_STATE')"></p> -->
<!-- 						</div> -->
<!-- 						<label contenteditable="false" class="col-xs-2 control-label">动力种类：</label> -->
<!-- 						<div class="col-xs-5 div_Modify"> -->
<!-- 							<div class="form-inline"> -->
<!-- 								<p class="form-control-static" ng-bind="ct.codeTranslate(equipmentBean.powerType, 'POWER_TYPE')"></p> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
	        </div>
	        
			<div class="modal-footer">
			    <a class="iehi_d right close_openwin" ng-click="addModelCancel();" data-dismiss="modal" >取消</a>
			</div>
			
		</div>
	</div>
</div>