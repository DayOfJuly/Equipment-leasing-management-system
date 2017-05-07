<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<script type="text/javascript">
			function oneCollapse(){
				$('#collapseOne').collapse('toggle');
				$('#collapseTwo').collapse('toggle');
			}	
	</script>
<div class="container">
	<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
		<div class="navbar-inner" style="height: 39px">
			<div class="container">
				<div class="navbar-header text-center col-xs-12">
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/DemandInfopublish"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff;margin-top: 5px"></span></small></a>
					<span style="color: #fff">筛选</span>
					</h4>	
					
				</div>
			</div>
		</div>
    </div>
<!--     <div class="col-md-12 column" style="margin-top:25%">
	      <div class="panel-group" id="accordion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="javascript:void(0)" onClick="oneCollapse();">
          	设备分类<span style="float: right;">{{equ_List.class_}}</span>
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">
      <a  href="" ng-click="queryClassify(rec);" ng-repeat="rec in categorySelectList"> <p >{{rec.equipmentCategoryName}}</p>
                               <p hidden="true">{{rec.equCategoryId}}</p>
      </a>
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" 
           href="javascript:void(0)" onClick="oneCollapse();">
                            设备名称<span style="float: right;">{{equ.Name}}</span>
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
       		<a  href="" ng-click="saveValueOfEquList(rec)" ng-repeat="rec in equList"> <p >{{rec.equipmentName}}</p></a>
      </div>
    </div>
  </div>
 </div>
  
    </div> -->
    <div class="col-md-12 column" style="margin-top:25%">
			<ul class="list-unstyled">
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
				<li>
				<a href="">设备分类
				<small style="float:right;margin-right: 0px">
					<span ng-show="myVar1" ng-click="toggle1(2)">{{equ_List.class_}} <span class="glyphicon glyphicon-chevron-down"></span></span> 
					<span ng-show="revel1" ng-click="toggle1(2)">{{equ_List.class_}} <span class="glyphicon glyphicon-chevron-up"></span></span>
					</small>
				</a>
				</li>
				
					<div class="container" style="" ng-show="revel1">
						<ul class="media-list">
						        <li ><a href="" ng-click="queryClassify(rec);" ><div>请选择</div></a></li>
								<li ><a href="" ng-click="queryClassify(rec);" ng-repeat="rec in categorySelectList"><div>{{rec.equipmentCategoryName}}</div></a></li>
						</ul>
					</div>
				
				
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
			</ul>
			<ul class="list-unstyled">
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
				<li>
				<a href="">设备名称
				<small style="float:right;margin-right: 0px">
					<span ng-show="myVar2" ng-click="toggle1(3)"> {{equ.Name}}<span class="glyphicon glyphicon-chevron-down"></span></span> 
					<span ng-show="revel2" ng-click="toggle1(3)">{{equ.Name}} <span class="glyphicon glyphicon-chevron-up"></span></span>
					</small>
				</a>
				</li>
				
					<div class="container" style="" ng-show="revel2">
						<ul class="media-list">
								<li > <a  href="" ng-click="saveValueOfEquList(rec)" ng-repeat="rec in equList"> <div>{{rec.equipmentName}}</div></a></li>
						</ul>
					</div>
				
				
				<hr style="height:1px;border:none;border-top:1px double #CFCFCF"/>
			</ul>
		</div>
    <div class="col-md-12 column" align="center" style="margin-top: 30%">		
			<span><button type="button" class="btn  btn-sm" style="margin-left: 10px;width: 30%;background: #0057b4;color:#fff;" ng-click="DubCofim();" >确认</button></span><span><button type="button" class="btn  btn-sm" style="margin-left: 10px;width: 30%;background: #0057b4;color:#fff;" ng-click="ClearInput();">清空</button></span>				
	</div>
</div>

