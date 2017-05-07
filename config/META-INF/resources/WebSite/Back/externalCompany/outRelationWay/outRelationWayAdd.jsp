<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 添加、修改-模态框（Modal） -->
<div class="modal fade" id="outRelationWayAdd" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 950px;margin-top:8%;">
		<div class="modal-content">
<!-- 			<div class="modal-header">
				<div class="col-xs-3"><h4 class="modal-title">{{titleMsg}}</h4></div>
				<div class="col-xs-9 text-right"><button type="button" class="btn btn-link text-right" data-dismiss="modal" ><span  class="glyphicon glyphicon-remove " ></span></button></div>
				<br><br>
			</div>
			<div class="modal-body"> -->
			<div class="modal-header">
				<h4 class="modal-title">{{titleMsg}}</h4>
			</div>
			<button type="button"  style="margin-left: 899px;margin-top:-46px;outline: none;" class="btn btn-link  "  data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></button>
			<div class="modal-body" style="margin-top: -41px;">
		      <form name="InfoAddForm" action="" method="post" id="form" enctype="application/x-www-form-urlencoded">
			   <div class="form-horizontal" style="margin-top: 30px;">
				 <div class="form-group" style="margin-top: -5.7%;">
				         <label contenteditable="false" class="col-xs-2  control-label"  style="  margin-top: -2px;margin-left: 36px;">发布单位：</label>
				         <div class="col-xs-3" style="margin-top:7px;"><span >{{userInfo.orgName}}</span></div>
			     </div>
			     
			      <div class="form-group">     
						<label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 36px;margin-top: -0.7%;">联系单位 ：</label>
						<div class="col-xs-3" >
						      <input type="text" class="form-control" required name="unitName" style="margin-top: 1%;" ng-model="formParms.partyName" maxlength="30" >
						</div>
						 <p class="" style="color: red;  margin-left: -5px;  margin-top: 4px;float: left; ">*</p>
				         <div class="col-xs-2 " ng-messages="InfoAddForm.unitName.$error" ng-show="showFlag == 'unitName'">
				             <p class="form-control-static" style="color:red;  margin-left: -5px;margin-top: 2%;" ng-message="required"> 请输入联系单位</p>
				         </div> 
				  </div>
				  
			       <div class="form-group">
			          <label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 31px;width: 133px;margin-top: -1.8%;">设备所在城市 ：</label>
    				  <div class="col-xs-2"><!--formParms.proName_ -->
						<select id="province" name="SelectProvince" ng-model="recPro.proModel" class="form-control select-hover" required
                   		    ng-options="recPro.name as recPro.name for recPro in areaList" ng-change="changePro(recPro);" 
                     	     style="position: absolute;z-index:2;margin-top: -5%;">  														
                       		<option value="">请选择省份</option>  
                   		</select>
	                 </div>
	                 <div class="col-xs-2"><!-- formParms.citName_ -->  																		
                        <select id="city" name="SelectCity" ng-model="recCit.recModel" class="form-control select-hover" id="city"
               				ng-options="recCit.name as recCit.name for recCit in pList" ng-change="changeCity(recCit);" required
               				 style="position: absolute;z-index:2;margin-top: -5%;">   
                       		<option value="">请选择城市</option>  
                   		</select>
	                 </div>
	                 <div class="col-xs-2"><!-- formParms.disName_  -->  																		 
                   		<select class="form-control select-hover" id="district" name="SelectCounty" ng-model="recDis.disModel" id="district"
               			    ng-options="recDis.name as recDis.name for recDis in cList" ng-selected="recDis.name == formParms.disName_" ng-change="changeDis(recDis)" required
               			    style="position: absolute;z-index:2;margin-top: -5%;"> 
                       		<option value="">请选择区县</option>  
                   		</select>
                  	  </div>
			          
			          <p class="" style="color: red;  margin-left: 24px;margin-top: -5px;float: left; ">*</p> 
			          
			          <div class="col-xs-12">
			              <div class="col-xs-12" ng-messages="InfoAddForm.SelectProvince.$error" ng-show="showFlag == 'SelectProvince'" style="padding-left:160px;">
			                  <p class="form-control-static" style="color:red;  margin-left: 488px;  margin-top: -32.1px;" ng-message="required">请选择所在省份</p>
			              </div>
			              <div class="col-xs-12" ng-messages="InfoAddForm.SelectCity.$error" ng-show="showFlag == 'SelectCity'" style="padding-left:320px;">
			                  <p class="form-control-static" style="color:red;  margin-left: 329px;  margin-top: -33.1px;" ng-message="required">请选择所在城市</p>
			              </div>
			              <div class="col-xs-12" ng-messages="InfoAddForm.SelectCounty.$error" ng-show="showFlag == 'SelectCounty'" style="padding-left:490px;">
			                  <p class="form-control-static" style="color:red;  margin-left: 158px;  margin-top: -33.1px;" ng-message="required">请选择所在区县</p>
			              </div>
			         </div> 
			      </div>
			      
				  <div class="form-group">     
						<label contenteditable="false" class="col-xs-2 control-label" style="  margin-left: 36px;margin-top: -1.9%;">详细地址 ：</label>
						<div class="col-xs-3" >
						      <input type="text" class="form-control" style="margin-top: -4%;"  ng-model="formParms.address" maxlength="50" >
						</div>
				  </div>
			      
			      <div class="form-group">
			            <label contenteditable="false" class="col-xs-2 control-label" style="  margin-left: 36px;margin-top: -0.4%;">联系人：</label>
				        <div class="col-xs-3">
				            <input type="text" class="form-control" autocomplete="off" name="contactPerson" style="margin-top: 2.6%;"  ng-model="formParms.name" required maxlength="10">
				        </div>
			            <p class="" style="color: red;margin-left: 20px;  margin-left: -5px;margin-top: 8px;float: left; ">*</p>
				        <div class="col-xs-2">
				            <div class="col-xs-12" ng-messages="InfoAddForm.contactPerson.$error" ng-show="showFlag == 'contactPerson'">
				                <p class="form-control-static" style="color:red;margin-left: -20px;  margin-top: 5px;" ng-message="required"> 请输入联系人</p>
				            </div>
				        </div>
			  	   </div>
			   
				   <div class="form-group">
				         <label contenteditable="false" class="col-xs-2 control-label" style="margin-left: 36px;margin-top: -1.9%;"> 联系电话 ：</label>
				         <div class="col-xs-3">
				             <input type="text" class="form-control" autocomplete="off" ng-model="formParms.tel" style="margin-top: -4%;" name="tel" required maxlength="17" ng-pattern="/(^[0-9,\-]{7,}$)/"  ><!-- /(\d{17})|^(\d{3})-(\d{8})-(\d{4})$/ -->
				         </div>
				         <p class="" style="color: red;  margin-left: -5px;margin-top: -5px;float: left; ">*</p>
				         <div class="col-xs-2 " ng-messages="InfoAddForm.tel.$error" ng-show="showFlag == 'tel'">
				             <p class="form-control-static" style="color:red;  margin-top: -9px;  margin-left: -6px;" ng-message="required"> 请输入联系电话</p>
				             <p class="form-control-static" style="color:red;margin-top: -9px;  margin-left: -6px;" ng-message="pattern"> 请输入正确的联系电话</p>
				         </div> 
				   </div>
			   
				   <div class="form-group">
				      <label contenteditable="false" class="col-xs-2 control-label" style="  margin-left: 36px;margin-top: -1.8%;">QQ：</label>
				      <div class="col-xs-3" >
				           <input type="text" ng-pattern="/^[0-9]*$/" autocomplete="off" class="form-control" style="margin-top: -4%;" name="qqNo" ng-model="formParms.qq" maxlength="15">
				      </div>
				      <div class="col-xs-2 " ng-messages="InfoAddForm.qqNo.$error" ng-show="showFlag == 'qqNo'">
				           <p class="form-control-static" style="color:red;  margin-top: -1px;  margin-left: -3px;" ng-message="pattern">请输入正确的QQ号码</p>
				      </div> 
				      <div class="col-xs-1"></div>
				  </div>   
				  
				  <div class="form-group" style="  margin-top: 0px;  margin-left: -19px;">
					  <input type="checkbox" ng-model="formParms.flag_" style="margin-left:220px;"/>&nbsp;&nbsp;设置为默认联系方式
				  </div>   
			   
				  <div class="form-group">
					  <div style="text-align: center;">
					      <input type="button" ng-if="btnValue.name=='保存'" style="margin-top: -1%;" class="btn btn_Under btn-primary" value="{{btnValue.name}}" ng-click="add(InfoAddForm)">
					      <input type="button" ng-if="btnValue.name=='修改'" style="margin-top: -1%;" class="btn btn_Under btn-primary" value="{{btnValue.name}}" ng-click="upd(InfoAddForm)">
					  </div>
				 </div>  
				   
				     
				</div>
				</form>
			</div>
		</div>
	</div>
</div>
