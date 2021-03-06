<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#checkCode {background: url(/media/images/vcode.png);
	font-family: Arial;
	color: blue;
	font-size: 25px;
	cursor: pointer;
	text-align: center;
	vertical-align: middle;}

 body {
	font-family: "Microsoft YaHei"!important;
	 font-size: 12px; 
	line-height: 1.42857143;
	color: #333;
	background-color: #fff
}

</style>
<div class="container">
<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
	<div class="navbar-inner">
		<div class="container">
			<div class="navbar-header text-center col-xs-12">
				<h4>
					<a href=""><small><span class="glyphicon glyphicon-chevron-left pull-left" onclick="window.location.href='/WebSite/Mobile/Index.jsp#/'" style="color: #fff"></span></small></a>
					<span style="color:white;">出租发布</span>
				</h4>
			</div>
		</div>
	</div>
</div>
	<div class="row clearfix" style="margin-top:50px">
		<div class="col-md-12 column" >
			<img  src="/media/images/default.png" style="width: 100%" />
			<span ><button type="button" class="btn  btn-sm" style="margin-top: -83%;width: 100px;margin-left: 37%;background: #0057b4;" ng-click="GetPic(); " ><span style="color: #fff">*点击上传图片</span></button></span>
		</div>
		<div class="col-md-12 column" >
			<p style="color: red;font-size: 10px">上传图片，信息效果提高60%；上传图片的数量，最多不超过5张,只允许上传BMP、GIF、JPG、JPEG格式文件，图片大小不能超过2M，小于5K。	</p>
		</div>
		<!-- <div class="col-md-12 column" >
			<p><span style="color: red;font-size: 10px" >*</span>设备选择:<span><a href="/WebSite/Mobile/Index.jsp#/Infopubpublish"><button type="button" class="btn btn-default btn-sm" style="margin-left: 10px;width: 80px"  ng-click="InfopubPublishFun(userInfo);">选择设备</button></span></a></p> 
		         <input type="hidden" class="form-control" name="equipmentId" ng-model="formParms.equipmentId" required>
		
		</div> -->
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label" style="margin-top:15px;"><span style="color: red;font-size: 10px;margin-top:10px;">*</span>设备选择:</label>
			</div>
			
			<div class="col-xs-9">
				 <input type="hidden" class="form-control" name="equipmentId" ng-model="formParms.equipmentId" required>
				<input type="button" class="btn  btn-primary btn-sm" style="margin-top: 10px;width: 80px;background: #0057b4;color:#fff;"  ng-click="InfopubPublishFun(userInfo);" value="选择设备">
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="col-md-12 column" ng-hide="InfopubList.equNo==null">
			<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:10px;">&nbsp;</span>设备信息:</label> 
		</div>
		<div class="col-md-12 column" ng-hide="InfopubList.equNo==null">
				<table class="table table-bordered" style="font-size: 13px">
				<thead>
				</thead>
				<tbody>
					<tr>
						<td>
							设备编号：
						</td>
						<td>
							{{InfopubList.equNo}}
						</td>
					</tr>
					<tr>
					<tr>
						<td>
							设备名称：
						</td>
						<td>
							{{InfopubList.equName}}
						</td>
					</tr>
					<tr>
						<td>
							品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：
						</td>
						<td>
							{{InfopubList.brandName}}
						</td>
					</tr>
					<tr>
						<td>
							型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：
						</td>
						<td>
							{{InfopubList.models}}
						</td>
					</tr>
					<tr>
						<td>
							规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：
						</td>
						<td>
							{{InfopubList.specifications}}
						</td>
					</tr>
					<tr>
						<td>
							功&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;率：
						</td>
						<td>
							{{InfopubList.power}}
						</td>
					</tr>
					<tr>
						<td>
							技术状况：
						</td>
						<td>
							<span ng-show="InfopubList.technicalStatus ==1">一类</span>
							<span ng-show="InfopubList.technicalStatus ==2">二类</span>
							<span ng-show="InfopubList.technicalStatus ==3">三类</span>
							<span ng-show="InfopubList.technicalStatus =='一类'">一类</span>
							<span ng-show="InfopubList.technicalStatus =='二类'">二类</span>
							<span ng-show="InfopubList.technicalStatus =='三类'">三类</span>
						</td>
					</tr>
					<tr>
						<td>
							生产厂家：
						</td>
						<td>
							{{InfopubList.manufacturerName}}
						</td>
					</tr>
					<tr>
						<td>
							出场日期：
						</td>
						<td>
							{{InfopubList.productionDate}}
						</td>
					</tr>
				</tbody>
			</table>
			<hr style="margin-top: -5px">
		</div>
		
		<div class="form-group">
		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:3px;">*</span>价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:</label>
			</div>
			
			<div class="col-xs-4">
				<input type="text" ng-model="formParms.price" style="margin-top: -8px" class="form-control" id="exampleInputEmail1" />
			</div>
			<div class="col-xs-4">
				<select id="priceTypeId"    class="form-control" ng-model="formParms.priceType"
                        		 style="z-index:3;margin-top: -8px" >
                            <option value="1" ng-selected="true">元/月</option>
                            <option value="2">元/天</option>
                            <option value="3">元/小时</option>
                        </select>
                      
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">
		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:3px;">*</span>最短租期:</label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" class="form-control" id="exampleInputEmail1" style="margin-top: -8px" ng-model="formParms.shortestLease" ng-disabled="zuQi"/>
			</div>
			<div class="col-xs-3">
				<label class="checkbox-inline" ><input  type="checkbox"  ng-model="tmp.reason2" ng-click="zuQiClick(tmp.reason2);">不限</label> 
                      
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">
		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:3px;">*</span>信息标题:</label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" class="form-control" id="exampleInputEmail1" style="margin-top: -8px" ng-model="formParms.infoTitle" />
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:3px;">*</span>详细信息:</label>
			</div>
			 <a  ng-click="openInfopubdescription(formParms);" style="text-decoration : none ">
			<div class="col-xs-9">
				<span style="color:gray;" ng-show="formParm.description=='请输入详细信息'">{{formParm.description}}</span><span style="color:black;" ng-show="formParm.description!=='请输入详细信息'">{{formParm.description}}</span><span><small><span class="glyphicon glyphicon-chevron-right pull-right"></span>
			</div>
			</a>
		</div>
		<hr style="margin-top: 60px">
		<p style="font-size: 18px">联系方式：</p>
		<hr  style="height:1px;border:none;border-top:1px solid #000000;margin-top: -5px"></hr>
		
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:10px;">*</span>联系单位:</label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" class="form-control" id="exampleInputEmail1" style="margin-top: -8px" ng-model="userInfo.orgName" />
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:10px;">*</span>所在城市:</label>
			</div>
			<a ng-click="goToAreaPage(1,'/WebSite/Mobile/Index.jsp#/Infopubprovinces',formParms);" style="text-decoration : none ">
			<div class="col-xs-9">
			<span style="margin-left:14%;">{{formPar.areaObj.saveParm}}</span>
								<small>
									<span class="glyphicon glyphicon-chevron-right pull-right"></span>
								</small>				
			</div>
			</a>
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:10px;">*</span>详细地址:</label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" ng-model="formParms.contactAddress" class="form-control" id="exampleInputEmail1" style="margin-top: -8px;"/>
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:10px;">*</span>联&nbsp;&nbsp;系&nbsp;人:</label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" ng-model="formParms.contactPerson" class="form-control" id="exampleInputEmail1" style="margin-top: -8px;"/>
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:10px;">*</span>联系电话:</label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" class="form-control" id="exampleInputEmail1" ng-model="formParms.contactPhone" style="margin-top: -8px;"/>
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:10px;">&nbsp;</span>Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:</label>
			</div>
			
			<div class="col-xs-6">
				<input type="text" class="form-control" id="exampleInputEmail1" ng-model="formParms.qqNo" style="margin-top: -8px;"/>
			</div>
			
		</div>
		<hr style="margin-top: 60px">
		<div class="form-group">
		
			<div class="col-xs-3">
				<label contenteditable="false" class="control-label"><span style="color: red;font-size: 10px;margin-top:3px;">*</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码:</label>
			</div>
			
			<div class="col-xs-4">
				<input type="text" class="form-control" id="exampleInputEmail1" style="margin-top: -8px;" ng-model="formParms.inputCode" />
			</div>
			<div class="col-xs-4">
				<div class="code" id="checkCode" ng-init="GetVercode()" ng-click="GetVercode()" style="margin-top: -8px"></div>			
                      
			</div>
			
		</div>
		<hr style="margin-top: 60px">
			<!-- <div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">*</span>价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:<span><input type="text" ng-model="formParms.price" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>			
					<select id="priceTypeId"    class="form-control" ng-model="formParms.priceType"
	                        		 style="width:25%;z-index:3;color: #555;float: right;margin-top: -8.5%;margin-right: 10%" >
	                            <option value="1" ng-selected="true">元/月</option>
	                            <option value="2">元/天</option>
	                            <option value="3">元/小时</option>
	                        </select>	
					</p> 
					
			</div>
		    <div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">*</span>最短租期:<span><input type="text" class="form-control" id="exampleInputEmail1" ng-model="formParms.shortestLease" style="width:40%;float: right;margin-top: -5px;margin-right:40%" ng-disabled="zuQi"/></span>
					<p style="float: right;margin-top: -8%;margin-right: 35%"> 天</p>
					<label class="checkbox-inline" style="margin-top: -16%;
	    				margin-left: 70%;"><input  type="checkbox" ng-model="tmp.reason2" ng-click="zuQiClick(tmp.reason2);">不限</label> 
					</p>	
					<hr style="margin-top: -5%">
			</div>
			<div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">*</span>信息标题:<span><input type="text" class="form-control" id="exampleInputEmail1" ng-model="formParms.infoTitle" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
					</p>	
					<hr>			
			</div>
			<div class="col-md-12 column" >	
			        <a  ng-click="openInfopubdescription(formParms);" style="text-decoration : none ">
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
					<p><span style="color: red;font-size: 10px float: left">*</span>联系单位:<span><input type="text" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%" ng-model="userInfo.orgName" /></span>				
					</p>	
					<hr>			
			</div>
			<div class="col-md-12 column" >	
					<a  ng-click="goToAreaPage(1,'/WebSite/Mobile/Index.jsp#/Infopubprovinces',formParms);" style="text-decoration : none ">href="/WebSite/Mobile/Index.jsp#/Infopubprovinces"
						<div>
							<p>
								<span style="color: red;font-size: 10px float: left">*</span>
								<span style="color:black">所在城市:</span><span style="margin-left:14%;">{{formPar.areaObj.saveParm}}</span>
								<small>
									<span class="glyphicon glyphicon-chevron-right pull-right"></span>
								</small>				
							</p>
						</div>	
					</a><hr>
			</div>
			<div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">&nbsp;</span>详细地址:<span><input type="text" ng-model="formParms.contactAddress" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
					</p>	
					<hr>			
			</div>
			<div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">*</span>联&nbsp;&nbsp;系&nbsp;人:<span><input type="text" ng-model="formParms.contactPerson" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
					</p>	
					<hr>			
			</div>
			<div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">*</span>联系电话:<span><input type="text" class="form-control" id="exampleInputEmail1" ng-model="formParms.contactPhone" style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
					</p>	
					<hr>			
			</div>
			<div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">&nbsp;&nbsp;</span>Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q:<span><input type="text" class="form-control" id="exampleInputEmail1" ng-model="formParms.qqNo"  style="width:40%;float: right;margin-top: -5px;margin-right:40%"/></span>				
					</p>	
					<hr>			
			</div>
			<div class="col-md-12 column" >		
					<p><span style="color: red;font-size: 10px float: left">*</span>验&nbsp;&nbsp;证&nbsp;&nbsp;码:<span><input type="text" class="form-control" id="exampleInputEmail1" style="width:40%;float: right;margin-top: -5px;margin-right:40%" ng-model="formParms.inputCode"/>				
						<div class="code" id="checkCode" ng-init="GetVercode()" ng-click="GetVercode()" style="width: 30%;float: right;margin-top: -9%"></div>			
					</span>				
					</p>	
					<hr>			
			</div> -->
		<div class="col-md-12 column" align="center" style="padding-bottom: 10%">		
			<span><input type="button" class="btn  btn-sm" style="margin-left: 10px;width: 30%;background-color: #f48a00;color: white;" ng-click="add(formParms);" value="发布信息"></span><span><input type="button" class="btn  btn-sm" style="margin-left: 10px;width: 30%;background-color: #f48a00;color: white;" onclick="window.location.href='/WebSite/Mobile/Index.jsp#/'" value="返回"></span>				
		    
		</div>
	</div>
</div>
<div class="modal fade" id="getPic" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" ng-init="queryallequiData()">
    Default panel contents
    <div class="modal-dialog" style="margin-top:10%;width: 100%;">
        <div class="modal-content">
            <div class="modal-header">
            	<h4>选择图片<button type="button" class="btn btn-link  "  style="float: right;" data-dismiss="modal"><span  class="glyphicon glyphicon-remove " ></span></h4>
            </div>
            <div class="modal-body">
            	       		
             <a href="" ng-click="openWeb();">打开app</a>    		
             
            </div>
       		<div class="modal-footer " >
                <input type="button"  style="margin-right: 30px;"  class="btn btn-default" value="关闭" >
            </div>
       	</div>
    </div>
</div> 