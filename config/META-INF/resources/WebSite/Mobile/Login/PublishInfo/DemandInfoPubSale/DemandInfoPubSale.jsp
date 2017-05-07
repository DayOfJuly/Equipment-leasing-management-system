<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#checkCode {background: url(/media/images/vcode.png);
	font-family: Arial;
	color: blue;
	font-size: 25px;
	cursor: pointer;
	text-align: center;
	vertical-align: middle;}
</style>
<div class="container">
<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
	<div class="navbar-inner">
		<div class="container">
			<div class="navbar-header text-center col-xs-12">
				<h4>
					<a href=""><small><span class="glyphicon glyphicon-chevron-left pull-left" onclick="window.location.href='/WebSite/Mobile/Index.jsp#/'" style="color:white;"></span></small></a>
					<span style="color:white;">求购发布</span>
				</h4>
			</div>
		</div>
	</div>
</div>
	<div class="row clearfix" style="margin-top:50px">
	
		<div class="col-md-12 column" style="margin-top:10px">
			<p><span style="color: red;font-size: 10px">*</span>设备选择:<span><a href="/WebSite/Mobile/Index.jsp#/DemandInfopubSalelish"><button type="button" class="btn  btn-sm" style="margin-left: 10px;width: 80px;background: #0057b4;color:#fff;"  >选择设备</button></span></a></p> 
		       <input type="hidden" class="inpt_a inpt_o span110" name="equipmentName" ng-model="selectListSale.equipmentName">
		<hr style="margin-top: -5px">
		</div>
		<div class="col-md-12 column" ng-hide="selectListSale.equipmentName==null">
			<p><span style="color: red;font-size: 10px">*</span>设备信息:</p> 
		</div>
		<div class="col-md-12 column" ng-hide="selectListSale.equipmentName==null">
				<table class="table table-bordered" style="font-size: 13px">
				<thead>
				</thead>
				<tbody>
					<tr>
						<td>
							设备名称：
						</td>
						<td>
							{{selectListSale.equipmentName}}
						</td>
					</tr>
					<tr>
						<td>
							品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：
						</td>
						<td>
							{{selectListSale.manufacturer}}
						</td>
					</tr>
					<tr>
						<td>
							型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：
						</td>
						<td>
							{{selectListSale.modelNumber}}
						</td>
					</tr>
					<tr>
						<td>
							规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：
						</td>
						<td>
							{{selectListSale.specifications}}
						</td>
					</tr>
				</tbody>
			</table>
			<hr style="margin-top: -5px">
		</div>
		<div class="col-md-12 column" >	
		        <a ng-click="goToAreaPage(4,'/WebSite/Mobile/Index.jsp#/Infopubprovinces',formParms);"  style="text-decoration : none "><!-- href="/WebSite/Mobile/Index.jsp#/Infopubprovinces"  -->
			        <div>		
						<p>
							<span style="color: red;font-size: 10px float: left">*</span>
							<span style="color:black">设备使用地点:</span><span style="margin-left:14%;">{{formPar.areaObjDemandSale.saveParm}}</span>
							<small><span class="glyphicon glyphicon-chevron-right pull-right"></span></small>				
						</p>
					</div>
				</a><hr>
		</div>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>详细地址:<span><input type="text" ng-model="formParms.address" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
				</p>	
				<hr>			
		</div>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>购买单价:<span><input type="text" ng-model="formParms.price" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%" placeholder="请输入正整数"/></span>
				<p style="float: right;margin-top: -8%;margin-right: 25%">元</p>
				</p>	
				<hr>
		</div>
	    <div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量:<span><input type="text" ng-model="formParms.quantity"  class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%" placeholder="请输入正整数"/></span>
				<p style="float: right;margin-top: -8%;margin-right: 25%">台</p>
				</p>	
				<hr>
		</div>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>信息标题:<span><input type="text" ng-model="formParms.infoTitle" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%" placeholder="不少于2个字" /></span>				
				</p>	
				<hr>			
		</div>
		<div class="col-md-12 column" >	
		        <a  ng-click="openDemandSaledescription(formParms)"  style="text-decoration : none ">
		        <div>		
				<p><span style="color: red;font-size: 10px float: left">*</span><span style="color:black">详细说明:</span><span style="color:gray;" ng-show="formParm.description=='请输入详细信息'">{{formParm.description}}</span><span style="color:black;" ng-show="formParm.description!=='请输入详细信息'">{{formParm.description}}</span><span><small><span class="glyphicon glyphicon-chevron-right pull-right"></span></small>				
				</p>
				</div>
				</a>
				<hr>	
								
		</div>
		<p style="font-size: 18px">联系方式：</p>
		<hr  style="height:1px;border:none;border-top:1px solid #000000;margin-top: -5px"></hr>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>单位名称:<span><input type="text" class="form-control" ng-model="formParms.enterpriseName" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
				</p>	
				<hr>			
		</div>
		
		<div class="col-md-12 column" >	
				<a ng-click="goToAreaPage_AreaFun('/WebSite/Mobile/Index.jsp#/Infopubprovinces',formParms);"   style="text-decoration : none ">	<!-- href="/WebSite/Mobile/Index.jsp#/DemandInfoPubprovinces" -->
					<div>
						<p>
							<span style="color: red;font-size: 10px float: left">*</span>
							<span style="color:black">所在城市:</span><span style="margin-left:14%;">{{formPar.areaDemand_.saveParm}}</span>
							<small><span class="glyphicon glyphicon-chevron-right pull-right"></span></small>				
						</p>
					</div>	
				</a><hr>	
		</div>
		
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">&nbsp;</span>详细地址:<span><input type="text" class="form-control" ng-model="formParms.contactAddress"  id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
				</p>	
				<hr>			
		</div>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>联&nbsp;&nbsp;系&nbsp;人:<span><input type="text" ng-model="formParms.contactPerson" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
				</p>	
				<hr>			
		</div>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>联系电话:<span><input type="text" class="form-control" ng-model="formParms.contactPhone" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
				</p>	
				<hr>			
		</div>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">&nbsp;&nbsp;</span>Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:<span><input type="text" ng-model="formParms.qqNo" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
				</p>	
				<hr>			
		</div>
		<div class="col-md-12 column" >		
				<p><span style="color: red;font-size: 10px float: left">*</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码:<span><input type="text" ng-model="formParms.inputCode" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/>
				<div class="code" id="checkCode" ng-init="GetVercode()" ng-click="GetVercode()" style="width: 30%;float: right;margin-top: -9%"></div>
				</span>				
				</p>	
				<hr>			
		</div>
		<div class="col-md-12 column" align="center" style="padding-bottom: 10%">		
			<span><button type="button" class="btn  btn-sm" style="margin-left: 10px;width: 30%;background-color: #f48a00;color: white;" ng-click="add()">发布信息</button></span><span><button type="button" class="btn  btn-sm" style="margin-left: 10px;width: 30%;background-color: #f48a00;color: white;" onclick="window.location.href='/WebSite/Mobile/Index.jsp#/'">返回</button></span>				
		</div>
	</div>
</div>
<div>
</html>