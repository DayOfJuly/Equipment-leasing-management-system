<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container">
	<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
		<div class="navbar-inner" style="height: 39px">
			<div class="container">
				<div class="navbar-header text-center col-xs-12">
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/InfopubSale"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="margin-top: 5px;color: #fff"></span></small></a>
						 <span style="color: #fff">筛选</span>
					</h4>	
					
				</div>
			</div>
		</div>
    </div>
    <div class="col-md-12 column" style="margin-top:25%" >
        
        <table class="table"  style="text-align: center;">
				<thead>
					<tr>
						<th style="text-align: center;">
							设备分类
						</th>
						<th style="text-align: center;">
							设备名称
						</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="equi in  allequi" ng-click="Screen(equi)">
						<td>
							{{equi.equipmentCategoryName}}
						</td>
						<td>
							{{equi.equName}}
						</td>
					</tr>
				</tbody>
			</table>
		<hr>
    </div>
 
</div>
</html>