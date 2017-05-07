<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container">
	<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
		<div class="navbar-inner" style="height: 39px">
			<div class="container">
				<div class="navbar-header text-center col-xs-12">
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/InfopubSalepublish"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff"></span></small></a>
						<span style="color: #fff">设备信息</span>					
					</h4>				
				</div>
			</div>
		</div>
    </div>
    <div class="col-md-12 column" style="margin-top:20%" >
			<p style="font-size: 18px">设备信息:</p> 
			<table class="table table-bordered" style="font-size: 13px" >
				<thead>
				</thead>
				<tbody>
					<tr>
						<td>
							设备编号：
						</td>
						<td>
							{{equList.orgCode}}-{{equList.equNo}}
						</td>
					</tr>
					<tr>
						<td>
							设备名称：
						</td>
						<td>
							{{equList.equName}}
						</td>
					</tr>
					<tr>
						<td>
							品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：
						</td>
						<td>
							{{equList.brandName}}
						</td>
					</tr>
					<tr>
						<td>
							型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：
						</td>
						<td>
							{{equList.models}}
						</td>
					</tr>
					<tr>
						<td>
							规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格：
						</td>
						<td>
							{{equList.specifications}}
						</td>
					</tr>
					<tr>
						<td>
							功&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;率：
						</td>
						<td>
							{{equList.power}}
						</td>
					</tr>
					<tr>
						<td>
							技术状况：
						</td>
						<td>
							<span ng-show="equList.technicalStatus ==1">一类</span>
							<span ng-show="equList.technicalStatus ==2">二类</span>
							<span ng-show="equList.technicalStatus ==3">三类</span>
						</td>
					</tr>
					<tr>
						<td>
							生产厂家：
						</td>
						<td>
							{{equList.manufacturerName}}
						</td>
					</tr>
					<tr>
						<td>
							出场日期：
						</td>
						<td>
							{{equList.productionDate}}
						</td>
					</tr>
				</tbody>
			</table>
    </div>
    <div class="col-md-12 column" style="margin-top:20%" align="center">
       <span><a href="/WebSite/Mobile/Index.jsp#/InfopubSalepublish"><button type="button" class="btn btn-default btn-sm" style="margin-left: 10px;width: 30%">返回</button></span>
    </div>
</div>
