<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
h4, .h4, h5, .h5, h6, .h6 {
    margin-top: 10px;
    margin-bottom: -10px;
}
</style>
<div class="container">
	<div class="navbar navbar-default navbar-fixed-top" style="background-color: #CC0001; padding:5px;">
		<div class="navbar-inner" style="height: 39px">
			<div class="container">
				<div class="navbar-header text-center col-xs-12">
					<h4>
						<a href="/WebSite/Mobile/Index.jsp#/Infopub"><small><span class="glyphicon glyphicon-chevron-left pull-left" style="color: #fff"></span></small></a>
						<span style="color: #fff">设备选择</span>
						<button type="button" class="btn  btn-sm" style="margin-left: 85%;margin-top:-10%;width: 80px;background: #0057b4;color:#fff;"  ng-click="Confirm();" >确定</button>
					</h4>				
				</div>
			</div>
		</div>
    </div>
    <div class="col-md-12 column" style="margin-top:20%">
			<p style="font-size: 18px">设备信息:</p> <a href="/WebSite/Mobile/Index.jsp#/Screeningequipment"><p style="float: right;margin-top: -8%"" > <span class="glyphicon glyphicon-filter"></span></a></p>
    </div>
    <div class="col-md-12 column" >
			<table class="table table-bordered" style="font-size: 13px" >
				<thead>
				</thead>
				<tbody>
					<tr ng-repeat="equ in allequiList" name="radioEquName"  ng-click="Select(equ,$index);">
						<td href="javascript:void(0);" >
							<p><input type="radio"  ng-checked="radioTrIndex==$index"/><span style="font-size: 16px;margin-top: -5px">{{equ.equName}}</span></p>
						    <p style="margin-left: 1%">品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌:{{equ.brandName}}</p>
						    <p style="margin-left: 1%">型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:{{equ.models}}</p>
						    <p style="margin-left: 1%">规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;格:{{equ.specifications}}</p>
						    <p style="float: right;"><a href="/WebSite/Mobile/Index.jsp#/InfopubpublishDetail/{{equ}}">详细信息>>>></a></p>
						</td>
					</tr>
				</tbody>
			</table>
    </div>
</div>
