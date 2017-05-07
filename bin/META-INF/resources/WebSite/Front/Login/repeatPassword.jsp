<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="js" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../Include/Head.jsp" />
<title>修改密码</title>
<style>
.container {width: 1500px !important;}  

.form-horizontal .control-label {
padding-top: 7px;
margin-bottom: 0;
text-align: right;
min-width : 0px;
}

</style>

</head>
<body class="container">
	<ol class="breadcrumb">
		<li style="font-size: 13px">您的位置：后台管理</li>
		<li style="font-size: 13px">修改密码</li>
	</ol>
	<form action="" style="width: 95%">
		<div class="form-horizontal" style="margin-top: 10px;">
			<div class="form-group">
			 	 <label contenteditable="false" class="col-xs-3  control-label" >请输入旧密码：</label>
			     <div style="float:left;">
				  	 <input type="text"  class="form-control" />  
			     </div>
			     <div class="col-xs-2">
			     	 <p class="form-control-static" style="color: red;">*</p>
			     </div>  
			</div>
			
			<div class="form-group">
			 	 <label contenteditable="false" class="col-xs-3  control-label" >请输入新密码：</label>
			     <div style="float:left;">
				  	 <input type="text"  class="form-control" />  
			     </div>
			     <div class="col-xs-2">
			     	 <p class="form-control-static" style="color: red;">*</p>
			     </div> 
			</div>
			
			<div class="form-group">
			 	 <label contenteditable="false" class="col-xs-3  control-label" >请确认密码：</label>
			     <div style="float:left;">
				  	 <input type="text"  class="form-control" />  
			      </div>
			      <div class="col-xs-2">
			     	 <p class="form-control-static" style="color: red;">*</p>
			      </div>  
			</div>
			
		    <div style="margin-left: 370px;">
			   <div>
				   <button  type="button" class="btn btn-primary" >保存</button>
				   <a  type="button" class="btn btn-primary" href="./Login.jsp">返回</a>
			   </div>
		   </div> 
		</div>
	</form>
</body>