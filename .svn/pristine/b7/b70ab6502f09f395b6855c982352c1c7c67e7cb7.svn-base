<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="js" tagdir="/WEB-INF/tags"%>
<script type="text/javascript" src="/WebSite/Mobile/js/JsLib/chinesepyi.js"></script>
<style type="text/css">
li{list-style-type:none};
ul{float:left};
</style>

<div ng-controller="searchIncludeController" ng-init="InputClick();" >
	<nav class="navbar navbar-default navbar-fixed-top" style="background-color: #cc0001;">
			<div class="container">
				<div class="row" style="padding:5px;color:#fff">
					<div class="text-center col-xs-12">						
						<h4>
							<small><span class="glyphicon glyphicon-chevron-left pull-left" ng-mouseup="goBackIndexPageFun();"  style="color:#fff"></span></small>
							<span ng-show="title" >搜索</span>
		 					<span ng-show="infotitle">设备名称</span>
						</h4>
					</div>
				</div>
			</div>
	</nav>

	<div class="container" style="margin-top:70px;">
		<div class="row" ng-show="title">
			<div class="col-xs-4" style="margin-left:10px; z-index:999;margin-top: 5px" >
				<div class="col-xs-12" style="z-index:11;">
					<span ng-if="myVar_ == true && num_ == 1" ng-click="toggle(num_)" style="margin-top:20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-down"></span></span>
					<span ng-if="revel_ == true && num_ == 1" ng-click="toggle(num_)" style="margin-top: 20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-up"></span></span>
					<span ng-if="myVar_ == true && num_ == 2" ng-click="toggle(num_)" style="margin-top:20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-down"></span></span>
					<span ng-if="revel_ == true && num_ == 2" ng-click="toggle(num_)" style="margin-top: 20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-up"></span></span>
					<span ng-if="myVar_ == true && num_ == 3" ng-click="toggle(num_)" style="margin-top:20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-down"></span></span>
					<span ng-if="revel_ == true && num_ == 3" ng-click="toggle(num_)" style="margin-top: 20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-up"></span></span>
					<span ng-if="myVar_ == true && num_ == 4" ng-click="toggle(num_)" style="margin-top:20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-down"></span></span>
					<span ng-if="revel_ == true && num_ == 4" ng-click="toggle(num_)" style="margin-top: 20px">{{typeName_.name}}<span class="glyphicon glyphicon-chevron-up"></span></span>
				</div> 
					<div class="container-autocomplete" style="float:left;width:100%;">
						<ul ng-if="revel_==true" class="dropdown-menu_" role="menu" aria-labelledby="dropdownMenu1" id="parentOrgs" style="position:absolute; display:block; margin-left:5%; margin-top:6%;">
							<li class="lable-lablecss" role="menuitem" tabindex="-1">
								<a href="javascript:void(0);" ng-click="changeSelectValueFun(1);"><span>出租</span></a>
								<a href="javascript:void(0);" ng-click="changeSelectValueFun(2);"><span>出售</span></a>
								<a href="javascript:void(0);" ng-click="changeSelectValueFun(3);"><span>求租</span></a>
								<a href="javascript:void(0);" ng-click="changeSelectValueFun(4);"><span>求购</span></a>
							</li>
						</ul>
					</div>
			</div>
			
			<div class="col-xs-12" style="z-index:10;margin-top: 0%">
				<div class="ihhass container" >
					<div class="row">
				   	    <div class="col-xs-12"><!-- text-indent:70px; --><!-- data-toggle="dropdown" -->
				   	    	<input style="padding:5px 10px 1px 55px; margin-left:0; margin-top:-28px;; z-index:100;border: 2px #0057b4 solid" 
				   	    		ng-model="searBean.infoTitleBean" type="text" id="searchContent" name="searchContent" 
				   	    		class="form-control-noWidth col-xs-9" select="setSelected(x);" list-items="suggestions" 
				   	    		close="suggestionPicked()" selection-made="selectionMade" placeholder="请输入关键词检索" 
				   	    		index="selected" maxlength="200" ng-change="KeyWordQuery(searBean.infoTitleBean);" 
				   	    		ng-keyup="inputKeyupTemp($event);" />
				   	    	<div class="col-xs-3" style="top: -28px;">
				   	    		<span class="btn btn-default btn-sm" type="button" ng-mouseup="queryInfoLink(searBean.infoTitleBean,queryData.infoType);" style="background-color: #017cfe;color:#fff">搜索</span>
							</div>
						</div>
						<p class="logo_search logo_search_aa col-xs-8">
							<span id="clearFlag" class="glyphicon glyphicon-remove" style="position:absolute; margin-left:-30px; margin-top:8px; display:none;" ng-click="clearInput();"></span>
							<input type="text" focus-me focus-when="{{selectionMade}}" style="display:none;"/>
							<input type="hidden" id="searchType" name="searchType" />
						</p>
					</div>
				</div>
			</div>
		</div>
			<div class="row" ng-show="infotitle">
				<div class="col-xs-12" style="z-index:10;margin-top: 5%">
					<div class="ihhass container" >
						<div class="row">
					   	    <div class="col-xs-12"><!-- text-indent:70px; --><!-- data-toggle="dropdown" -->
					   	    	<input style="padding:5px 10px 1px 55px; margin-left:0; margin-top:-28px;; z-index:100;border: 2px #0057b4 solid" 
					   	    		ng-model="searBean.infoTitleBean" type="text" id="searchContent" name="searchContent" 
					   	    		class="form-control-noWidth col-xs-9" select="setSelected(x);" list-items="suggestions" 
					   	    		close="suggestionPicked()" selection-made="selectionMade" placeholder="请输入关键词检索" 
					   	    		index="selected" maxlength="200" ng-change="KeyWordQuery(searBean.infoTitleBean);" 
					   	    		ng-keyup="inputKeyupTemp($event);" />
					   	    	<div class="col-xs-3" style="top: -28px;">
					   	    		<span class="btn btn-default btn-sm" type="button" ng-mouseup="queryInfoLink(searBean.infoTitleBean,queryData.infoType);" style="background-color: #017cfe;color:#fff">搜索</span>
								</div>
							</div>
							<p class="logo_search logo_search_aa col-xs-8">
								<span id="clearFlag" class="glyphicon glyphicon-remove" style="position:absolute; margin-left:-30px; margin-top:8px; display:none;" ng-click="clearInput();"></span>
								<input type="text" focus-me focus-when="{{selectionMade}}" style="display:none;"/>
								<input type="hidden" id="searchType" name="searchType" />
							</p>
						</div>
					</div>
				</div>
			</div>
		<div class="clear"></div>
		<div class="row">
				<div id="parentOrgs1"  style="display: none;" >
					<div class="input_xl" ng-show="LiNumA" id="parentOrgs" class="list-unstyled col-xs-12">
						<ul ng-repeat="RentInfo in KeyWordList |orderBy:'-rankLocation'" class="col-xs-12">
							<li  style="list-style-type:none;" ng-mouseup="queryInfoLink(RentInfo.infoTitle,queryData.infoType);"  class="col-xs-12"><!-- ng-keyup="myKeyup($event)" -->
								<!-- <a id="keyWords{{$index}}" title="{{RentInfo.infoTitle}}"  class="ss_link1" style="float:left; width:200px;" href="javascript:void(0);">{{RentInfo.infoTitleA}}</a> -->
								<div class="col-xs-12">
									<a style="color:black;">
										<span>{{RentInfo.infoTitleA}}</span>
									 	<div style="float:right;">
											<font ng-show="$index==0" ng-bind="RentInfo.flagMsg">&nbsp;</font>&nbsp;
											<font ng-show="RentInfo.flagMsg == null || RentInfo.flagMsg == '' || $index != 0">约{{RentInfo.itCount}}个设备</font>
										</div> 
									</a>
									<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
								</div>
							</li>
						</ul>
					</div>
					<div class="input_xl"   class="list-unstyled col-xs-12"  ng-show="LiNum" >
						<ul ng-repeat="r in KeyWordList " class="col-xs-12">
							<li  style="list-style-type:none;"   class="col-xs-12 active" ng-mouseup="queryInfoLink(r.equipmentName,queryData.infoType);">
								<div class="col-xs-12">
									<span class="active">{{r.equipmentName}}</span>
									<hr style="height:5px;border:none;border-top:2px double #CFCFCF"/>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div  style="display: none;">
				</div>
				<div ng-show="title">
					<div id="parentOrgs2"  style="display: none;" >
						<div class="input_xl" ng-if="LiNumB && showMsg.msg == ''" id="parentOrgs">
							<span class="ihha_zjss" style="margin-left: 29px;font-size:24px">历史搜索：</span>
							<span class="ihha_qk" >
				           		<a ng-mouseover="DelAllOver();" class="ihha_qk" ng-mouseout="DelAllOut();"  ng-click="DelAll();">
				           			<span id="delAllAId"></span>
									<span id="delAllBId"  style="margin-left:35%;color:#a8a8a8;" class="glyphicon glyphicon-trash"></span>
								</a>
							</span>
							<ul>
								<li ng-repeat="RentInfoB in KeyWordListB" ng-mouseup="queryInfoLink(RentInfoB.infoTitleB,queryData.infoType);"  style="list-style-type:none;">
									<button class="btn btn-default btn-sm "  style="float:left; width:40%;margin: 10px 10px 8px 10px;border-radius: 20px;"  ng-bind="RentInfoB.infoTitleC"></button>
								</li>
			 				</ul>
				           <div class="clear"></div>
				         </div>
		        	 </div>
				     <div class="input_xl" ng-if="showMsg.msg == '暂无搜索历史'" id="parentOrgs" >
								<span class="ihha_zjss" style="margin-left: 29px;font-size:24px">历史搜索：</span>
								<ul >
									<li style="list-style-type:none;">
										<p style="margin-left: 26%;">暂无搜索历史</p>
									</li>
				 				</ul>
				           <div class="clear"></div>
				    </div>
			    </div>
		     </div>
		</div>	
		<div ng-show="title" style="margin-bottom:0%;">
		 	<div class="row" style="background-color:#F6F6F6;margin-top: 30%;"  ng-if="LiNumB && showMsg.msg == ''">
				<h3 style="margin-left: 44px;">热搜</h3>
				<div ng-repeat="linkValue in linkValueList" style="margin-left: 48px;" >
					<div class="col-xs-4" style="margin-top: 12px;">
						<input type="button" class="btn btn-default btn-sm" style="border-radius: 20px;" ng-bind="linkValue.equipmentName" value="{{linkValue.equipmentName}}"  ng-mouseup="queryInfoLink(linkValue.equipmentName,queryData.infoType);"> 
					</div>
				</div>
			</div>
		
			<div class="row" style="background-color:#F6F6F6;margin-top: 30%;margin-right:0px"  ng-if="showMsg.msg == '暂无搜索历史'">
				<h3 style="margin-left: 44px;">热搜</h3>
				<div ng-repeat="linkValue in linkValueList" style="margin-left: 40px;" >
					<div class="col-xs-4" style="margin-top: 12px;">
						<input type="button" class="btn btn-default btn-sm" style="border-radius: 20px;" ng-bind="linkValue.equipmentName" value="{{linkValue.equipmentName}}"  ng-mouseup="queryInfoLink(linkValue.equipmentName,queryData.infoType);"> 
					</div>
				</div>
			</div>
		</div>	
		</div>
				<div class="col-xs-12" ng-show="infotitle">
					<div >
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListA" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListB" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListC" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListD" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListE" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListF" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListG" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListH" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListI" class="active" ><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListJ" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListK" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListL" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListM" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListN" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListO" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListP" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListQ" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListR" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListS" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListT" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListU" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListV" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListW" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListX" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListY" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
						<ul style="margin-left:-5%">
							<li ng-repeat="a in deviceNameValueListZ" class="active"><a href="" ng-click="clickEquipment(a.equipmentName,queryData.infoType);">{{a.equipmentName}}</a></li>
						</ul>
					</div>
				</div>
