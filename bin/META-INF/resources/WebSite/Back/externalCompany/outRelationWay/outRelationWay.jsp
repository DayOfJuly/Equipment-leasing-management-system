<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>联系方式维护</title>

    <style type="text/css">
        .code {
            background: url(../../../media/images/vcode.png);
            font-family: Arial;
            color: blue;
            cursor: pointer;
            text-align: center;
            vertical-align: middle;

        }

        a {
            text-decoration: none;
            color: #288bc4;
        }

        a:hover {
            text-decoration: underline;
        }
        #relationWay{
            margin:0 0 0px;
        }
        
        
        .Infopub_a1:link {
			text-decoration: none;
		}
		.Infopub_a1:visited {
			text-decoration: none;
		}
		.Infopub_a1:hover {
			text-decoration: none;
		}
		.Infopub_a1:active {
			text-decoration: none;
		}
		.container {width: 1500px !important;}
		
		.form-horizontal .control-label {
		padding-top: 7px;
		margin-bottom: 0;
		text-align: right;
		min-width : 0px;
	}
	
.page-list .pagination {float:left;}
.page-list .pagination span {cursor: pointer;}
.page-list .pagination .separate span{cursor: default; border-top:none;border-bottom:none;}
.page-list .pagination .separate span:hover {background: none;}
.page-list .page-total {float:left; margin: 25px 20px;}
.page-list .page-total input, .page-list .page-total select{height: 26px; border: 1px solid #ddd;}
.page-list .page-total input {width: 40px; padding-left:3px;}
.page-list .page-total select {width: 50px;}
	
    </style>
</head>
<body  class="container">
	<ol class="breadcrumb">
			<li style="font-size: 13px">您的位置：后台管理</li>
			<li style="font-size: 13px">外部企业用户</li>
			<li style="font-size: 13px">联系方式维护</li>
	</ol>
	<p style="color:red;  margin-top: -12px;">温馨提示：您所维护的联系式，可以在前台进行信息发布时，缺省显示。</p>
	<form action="" style="width: 95%" novalidate name="InfoAddForm" autocomplete="off">
	    <div class="form-horizontal" style="margin-top: 5px;">
	  
	        <div class="form-group" style="  margin-top: -6px;">
			         <label class=" control-label " style="width:30%;">发布单位：<span>{{sysUserInfo.orgName}}</span></label>
		     </div> 
	         <div style="overflow: auto;">
 	         	<table class="table table-striped table-hover" style="width:70%;margin-left: 12%;">
	         		<thead>
	         			<tr class="success">
	         				<th style="white-space: nowrap; text-align: center;width:1%"></th>
	         				<th style="white-space: nowrap; text-align: center;width: 4%;">序号</th>
	         				<th style="white-space: nowrap; text-align: center;width:15%">联系单位</th>
	         				<th style="white-space: nowrap; text-align: center;width:21%">所在城市</th>
	         				<th style="white-space: nowrap; text-align: center;">详细地址</th>
	         				<th style="white-space: nowrap; text-align: center;">联系人</th>
	         				<th style="white-space: nowrap; text-align: center;">联系电话</th>
	         				<th style="white-space: nowrap; text-align: center;">QQ</th>
	         				<th style="white-space: nowrap; text-align: center;"></th>
	         			</tr>
	         		</thead>
	         		<tbody>
	         			<tr ng-repeat=" q in queryAllList" style="text-align: center;" ng-click="equipSelect(this);">
	         				<!-- <td>
	         				    <input style="margin-left:-15px;margin-top:1px;" type="radio"  ng-checked="selectFlag==$index"/>
	         					<p class="copyP" style="margin-left:13px;margin-top:-15px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p>
	         				</td> -->
	         				<td>
								<input style="margin: 2px -53px 0 -19px;" type="radio" ng-checked="selectFlag==$index" />
							</td>
							<td>
								<p align="left" style="margin: 0px -9px -2px 25px;">{{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</p> 
							</td>
	         				<td style="text-align: center;" title="{{q.partyName}}">{{q.partyName_Copy}}</td>
	         				<td style="text-align: center;" title="{{q.onProvince}}-{{q.onCity}}-{{q.onDistrict}}">{{q.onProvince_Copy}}-{{q.onCity_Copy}}-{{q.onDistrict_Copy}}</td>
	         				<td style="text-align: center;" title="{{q.address}}">{{q.address_Copy}}</td>
	         				<td style="text-align: center;" title="{{q.name}}">{{q.name}}</td>
	         				<td style="text-align: center;" title="{{q.tel}}">{{q.tel}}</td>
	         				<td style="text-align: center;" title="{{q.qq}}">{{q.qq}}</td>
	         				<td style="white-space: nowrap; text-align: center;" ng-if="q.defConFlag == 1"><a style="text-decoration:none;">默认联系方式</a></td>
	         				<td style="white-space: nowrap; text-align: center;" ng-if="q.defConFlag == 0"></td>
	         			</tr>
	         		</tbody>
	         	</table> 
	         	
	         </div>
		    <div class="form-horizontal" style="margin-top: 10px;">
				<ul>
					<div class="form-group " style="margin-top: -1%;">
						<div class="col-xs-3" style="margin-left: 8%;width: 100%;">
							<input type="button" class="btn btn-primary" value="添加" ng-click="openAddModal()">
							<input type="button" ng-if="queryAllList.length != 0" class="btn btn-primary" value="修改" ng-click="openUpdModal()">
							<input type="button" ng-if="queryAllList.length != 0" class="btn btn-primary" value="删除" ng-click="openDelModal()">
							<tm-pagination conf="paginationConf" style="margin-left: 36.6%;margin-top: -3.5%;"></tm-pagination>
						</div>
						<!-- <div class="col-xs-9" style="text-align:right;margin-left: -15.1%;margin-top: -2px;">
							<tm-pagination conf="paginationConf" style="margin-left:350px;"></tm-pagination>
						</div> -->
					</div>
				</ul>
			</div>
	  		</div>
		</form>
		
		 <div ng-include src="'./externalCompany/outRelationWay/outRelationWayAdd.jsp'" ></div>
	</body>
</html>

