<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="js" tagdir="/WEB-INF/tags"%>
<div ng-controller="searchIncludeController">
	<div class="row" style="margin-bottom:20px;margin-top: 5px;">
		<div class="col-xs-3" style="margin-top: 2px;">
			<input type="button" class="btn btn-default btn-sm" value="<"
		 		onclick="window.location.href='Index.jsp'"> 
		</div>
		
		<div class="col-xs-1" style="z-index:1">
			
		</div>
		
		<div class="col-xs-6" style="z-index:0">
<!-- 			<input type="text" id="custNamePre" name="custNamePre" class="form-control" placeholder="请输入关键词检索" onclick=""> -->
<!-- 			<span class="glyphicon glyphicon-user form-control-feedback"></span> -->
<!-- 			<select id="priceTypeId" class="form-control" -->
<!-- 				style="position:absolute; margin-left:1px;margin-top:1px;z-index:100;width:50px;height:32px;border:0px;"> -->
<!-- 				<option value="1" ng-selected="true">出租</option> -->
<!-- 				<option value="2">元/天</option> -->
<!-- 				<option value="3">元/小时</option> -->
<!-- 			</select> -->


			<select class="form-control" mg-model="queryData.infoType" style="text-size:12px; position:absolute; margin-left:1px;margin-top:1px;z-index:100;width:80px;height:32px;border:0px;">
				<option value=1 ng-selected="true" ng-click="selectSearch('chuzu')">出租</option>
				<option value=2 ng-click="selectSearch('sale');">出售</option>
				<option value=3 ng-click="selectSearch('qiuzu');">求租</option>
				<option value=4 ng-click="selectSearch('qiugou');">求购</option>
			</select>
			<input style="text-indent:80px; margin-left:0;margin-top:0;z-index:100" data-toggle="dropdown" ng-model="searBean.infoTitleBean" type="text" id="searchContent" name="searchContent" 
				 class="form-control ng-valid ng-valid-maxlength ng-dirty ng-valid-parse ng-touched" select="setSelected(x)"
				 list-items="suggestions" close="suggestionPicked()" selection-made="selectionMade" placeholder="关键词" 
				 index="selected" maxlength="20" ng-change="KeyWordQuery(searBean.infoTitleBean);" 
				 ng-click="InputClick();" ng-keyup="inputKeyup($event)">
			<span id="clearFlag" class="glyphicon glyphicon-remove form-control-feedback" style="position: absolute;margin-right: 15px;margin-top: -25px; display:none;" ng-click="clearInput();"></span>
			<div id="parentOrgs1"  style="display: none;">
				<div class="input_xl" ng-if="LiNumA" id="parentOrgs" >
					<ul >
						<li ng-repeat="RentInfo in KeyWordList |orderBy:'-rankLocation'" ng-click="SearchInputShow($index,RentInfo.infoTitle);" ng-keyup="myKeyup($event)">
							<a id="keyWords{{$index}}" title="{{RentInfo.infoTitle}}"  class="ss_link1" style="float:left; width:200px;" href="###">{{RentInfo.infoTitleA}}</a>
							<lable style="float:right;">
								<font ng-show="$index==0" ng-bind="RentInfo.flagMsg">&nbsp;</font>&nbsp;
								<font ng-show="RentInfo.flagMsg == null || RentInfo.flagMsg == '' || $index != 0">约{{RentInfo.itCount}}个设备</font>
							</lable>
						</li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>

			<!-- 			<div class="btn-group"> -->
<!-- 				<button type="button" class="glyphicon glyphicon-remove form-control-feedback" -->
<!-- 					data-toggle="dropdown"> -->
<!-- 					出租<span class="caret"></span> -->
<!-- 				</button> -->
<!-- 				<ul class="dropdown-menu" role="menu"> -->
<!-- 					<li><a href="#">功能</a></li> -->
<!-- 					<li><a href="#">另一个功能</a></li> -->
<!-- 					<li><a href="#">其他</a></li> -->
<!-- 					<li class="divider"></li> -->
<!-- 					<li><a href="#">分离的链接</a></li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
		</div>
		
		<div class="col-xs-1" style="margin-top: 2px;">
			<input type="button" class="btn btn-default btn-sm" value="搜索"
		 		onclick=""> 
		</div>
		
<!-- 		<div style=" margin-top:0px; margin-left:0px;" class="col-md-12 column"> -->
<!-- 			<ul class="list-unstyled"> -->
<!-- 				<li > -->
<!-- 					<span class="col-md-2 column"><b>热搜 </b></span> -->
<!-- 					<div class="col-md-3 column"> -->
<!-- 						<input type="button" class="btn btn-default btn-sm" ng-bind="linkValue.equipmentName" value="{{linkValue.equipmentName}}"  ong-click="queryInfoLink(linkValue.equipmentName);">  -->
<!-- 					</div> -->
<!-- 				</li> -->
<!-- 			</ul> -->
	
<!-- 		</div> -->
	</div>

	

<!-- 	<div class="row" style="background-color:#F6F6F6;"> -->
<!-- 		<h3 style="margin-left: 20px;">热搜</h3> -->
<!-- 		<div ng-repeat="a in linkValueList"  > -->
<!-- 			<div class="col-xs-4" style="margin-top: 12px;"> -->
<!-- 				<input type="button" class="btn btn-default btn-sm" ng-bind="a.equipmentName" value="{{a.equipmentName}}"  ong-click="queryInfoLink(a.equipmentName);">  -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<div class="row" style="background-color:#F6F6F6;">
		<h3 style="margin-left: 20px;">热搜</h3>
		<div ng-repeat="linkValue in linkValueList"  >
			<div class="col-xs-4" style="margin-top: 12px;">
				<input type="button" class="btn btn-default btn-sm" ng-bind="linkValue.equipmentName" value="{{linkValue.equipmentName}}"  ng-click="queryInfoLink(linkValue.equipmentName);"> 
			</div>
		</div>
	</div>
</div>