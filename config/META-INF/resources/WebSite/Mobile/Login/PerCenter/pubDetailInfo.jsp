<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div ng-controller=" pubDetailController" class="container">
	
	<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
		<div class="navbar-inner">
			<div class="container">
				<div class="row">
					<div class="text-center col-xs-12">						
						<h4 style="font-size:18px">
							<a href="/WebSite/Mobile/Index.jsp#/alreadyPublishedInfor">
								<small><span class="glyphicon glyphicon-chevron-left pull-left" style="color:#fff;"></span></small>
							</a>
							<span style="color:#fff;">已发布的信息</span>
							<a href="">
<!-- 								<small><span class="glyphicon glyphicon-search pull-right" ></span></small> -->
							</a>
						</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
	
    <div class="col-xs-12 column" style="margin-top:20%" >
			<table class="table table-bordered " style="font-size: 13px;" border="0">
				<thead>
				</thead>
				<tbody>
					<tr>
						<td class="col-xs-5">
							信息类型：
						</td>
						<td class="col-xs-8">
							<span ng-show="equList.dataType ==1">出租</span>
							<span ng-show="equList.dataType ==2">出售</span>
							<span ng-show="equList.dataType ==3">求租</span>
							<span ng-show="equList.dataType ==4">求购</span>
						</td>
					</tr>
					<tr>
						<td>
							信息标题：
						</td>
						<td>
							{{equList.infoTitle}}
						</td>
					</tr>
					<tr>
						<td>
							联系人：
						</td>
						<td>
							{{equList.contactPerson}}
						</td>
					</tr>
					<tr>
						<td>
							联系电话：
						</td>
						<td>
							{{equList.contactPhone}}
						</td>
					</tr>
					<tr>
						<td>
							发布日期：
						</td>
						<td>
							{{equList.releaseDate|limitTo:10}}
						</td>
					</tr>
					<tr>
						<td>
							发布状态：
						</td>
						<td>
							{{equList.dataStateDesc}} 
						</td>
					</tr>
					<tr>
						<td>
							设备状态：
						</td>
						<td>
							<span ng-show="equList.equState ==1">已成交</span>
							<span ng-show="equList.equState ==2">未成交</span>
							<span ng-show="equList.technicalStatus !=1 || equList.technicalStatus!=2">—</span>
						</td>
					</tr>
				</tbody>
			</table>
    </div>
</div>
</html>