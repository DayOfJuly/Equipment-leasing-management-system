<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
a:active {color: #FF00FF}
</style>
<div class="navbar navbar-default navbar-fixed-top" style="border-bottom:1px solid #ddd; background-color:#cc0001;color:#fff">
	<div class="navbar-inner">
		<div class="container">
			<div class="row">
				<div class="text-center col-xs-12">						
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/viewRentList/1">
							<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff"></span></small>
						</a>
						筛选
					</h4>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container" na-app="screenApp" ng-controller="screenController" style="margin-top:70px;">
	<div class="row " style="margin-bottom:30%" >
		<div class="col-md-12 column">
			<ul class="list-unstyled">
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
				<li>
				类型
				<a href=""><small style="float:right;margin-right: 0px" ng-click="toggle(2)">
					<div ng-show="myVar"><span id="valShow" >
						<span ng-if="dataType==1" >出租</span>
						<span ng-if="dataType==2" >出售</span>
						<span ng-if="dataType==3">求租</span>
						<span ng-if="dataType==4">求购</span>
					
					</span><span class="glyphicon glyphicon-chevron-down"></span></div>
					<div ng-show="revel"><span ></span><span class="glyphicon glyphicon-chevron-up"></span></div>
					</small>
				</a>
				</li>
				
					<div class="container" style="margin-top:30px;" ng-show="revel">
						<ul class="media-list">
								<li style="padding:5px"><a href=""  ng-click="toggle(1)"><div>出租</div></a></li>
								<li style="padding:5px"><a href=""  ng-click="toggle(2)"><div>出售</div></a></li>
								<li style="padding:5px"><a href=""  ng-click="toggle(3)"><div>求租</div></a></li>
								<li style="padding:5px"><a href=""  ng-click="toggle(4)"><div>求购</div></a></li>
						</ul>
					</div>
				
				
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
				<li>
				所在城市
				<a href="" ng-click="selectAtCity(this);"><small style="float:right;margin-right: 0px"><span ng-show="city==1">不限</span><span ng-show="city==2">{{atCity}}</span> <span class="glyphicon glyphicon-chevron-right"></span></small></a>
				</li>
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
				<li>
				品牌
				<a href="" ng-click="selectBrand(this);"><small style="float:right;margin-right: 0px"><span ng-show="brandShow==1">不限</span><span ng-show="brandShow==2">{{brandNames[0]}}<span ng-if="brandNames[1]">,{{brandNames[1]}},</span>{{brandNames[2]}}</span><span class="glyphicon glyphicon-chevron-right"></span></small></a>
				</li>
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
				<li>
				设备名称
				<a href="" ng-mouseup="gotoQueryPageFun(this);"><small style="float:right;margin-right: 0px"><span ></span>{{equName_}} <span class="glyphicon glyphicon-chevron-right"></span></small></a>
				</li>
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
				</ul>
				价格区间
				<div class="col-sm-12" >
				<div class="form-group ">
							<div class="col-xs-4" style="margin-left:-20px">
								<input type="text" class="form-control" ng-model="minPrice" id="minPrice"  ng-blur="checkPrice(true,minPrice);" maxlength="10"  style="float:lfet">
							</div>
							<div class="col-xs-1" style="margin-left:-20px">~</div>
							<div class="col-xs-4" style="margin-left:-10px">
								<input type="text" class="form-control" ng-model="maxPrice" id="maxPrice" maxlength="10"  ng-blur="checkPrice(false,maxPrice)">
							</div>	
							<div ng-show="facility">
								<select id="priceTypeId"    class="form-control" 
		                        		 style="width:30%;z-index:3;color: #555;float: right;" >
		                            <option value="1" ng-selected="true">元/月</option>
		                            <option value="2">元/天</option>
		                            <option value="3">元/小时</option>
		                        </select>
                            </div>
						</div>
					</div>
		</div>
	</div>
	<nav class="navbar navbar-default navbar-fixed-bottom">
		<div class="navbar-inner">
			<div class="container">
						<input type="button" class="navbar-brand col-xs-5 text-center" style="width:50%;background-color: #017cfe;color:#fff" value="清空" ng-click="empty(this);"> 
						<input type="button" class="navbar-brand col-xs-5 text-center" style="width:50%;background-color: #017cfe;color:#fff" value="确定" ng-click="confirm(this);"> 
			</div>
		</div>
	</nav>
</div>
