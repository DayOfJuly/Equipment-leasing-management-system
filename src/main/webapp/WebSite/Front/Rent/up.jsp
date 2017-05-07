<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<title>Uploads only images (with canvas preview)</title>

<script type="text/javascript" src="../../js/jsdemo/unifySvc.js"></script>
<script type="text/javascript" src="../../js/jsdemo/Config.js"></script>
<script type="text/javascript" src="../../media/js/pagination.js"></script>
<link rel="stylesheet" href="../../js/jsdemo/bootstrap.min.css" />
<script type="text/javascript" src="../../js/jsdemo/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="../../js/jsdemo/bootstrap.min.js"></script>
<script type="text/javascript" src="../../js/jsdemo/angular.min.js"></script>
<script type="text/javascript" src="../../js/jsdemo/angular-file-upload.js"></script>
<script type="text/javascript" src="../../js/jsdemo/controllers.js"></script>
<script type="text/javascript" src="../../js/jsdemo/directives.js"></script>
<style>
#uploadImg {
	font-size: 12px;
	overflow: hidden;
	position: absolute
}

#file {
	position: absolute;
	z-index: 100;
	margin-left: -180px;
	font-size: 60px;
	opacity: 0;
	filter: alpha(opacity = 0);
	margin-top: -5px;
}
</style>
</head>

<!-- Example: nv-file-drop="" uploader="{Object}" options="{Object}" filters="{String}" -->
<body>
	<div id="ng-app" ng-app="app" ng-controller="AppController"
		nv-file-drop="" uploader="uploader" class="row">

		<div class="col-md-1">


			<!-- Example: nv-file-select="" uploader="{Object}" options="{Object}" filters="{String}" -->
			<input type="file" id="file" nv-file-select="" uploader="uploader"
				size="1" multiple />
			<button type="button" class="btn btn-primary"
				onmouseover="this.style.cursor='hand'">上传图片</button>
			<br />
			<p>Queue length: {{ uploader.queue.length }} </p>
		</div>


		<div class="col-md-8" style="margin-bottom: 40px">
			<div ng-repeat="item in uploader.queue" class="col-md-2">
				<!--<strong>{{ item.file.name }}</strong>-->
				<!-- Image preview -->
				<!--auto height-->
				<!--<div ng-thumb="{ file: item.file, width: 100 }"></div>-->
				<!--auto width-->
				<div ng-show="uploader.isHTML5"
					ng-thumb="{ file: item._file, height: 100,width:100 }"></div>
				<button type="button" class="btn btn-success btn-xs"
					ng-click="item.upload()"
					ng-disabled="item.isReady || item.isUploading || item.isSuccess">
					单个上传</button>
				<!--<button type="button" class="btn btn-warning btn-xs" ng-click="item.cancel()" ng-disabled="!item.isUploading">-->
				<!--<span class="glyphicon glyphicon-ban-circle"></span> Cancel-->
				<!--</button>-->
				<button type="button" class="btn btn-danger btn-xs"
					ng-click="item.remove()">删除</button>
				<!--fixed width and height -->
				<!--<div ng-thumb="{ file: item.file, width: 100, height: 100 }"></div>-->
			</div>
		 
			<span ng-if=" uploader.queue.length>=1">
				<div class="col-md-10">
					<div class="progress" style="">
						<div class="progress-bar" role="progressbar"
							ng-style="{ 'width': uploader.progress + '%' }">{{uploader.progress}}</div>
					</div>
					<button type="button" class="btn btn-success btn-s"
						ng-click="uploader.uploadAll()"
						ng-disabled="!uploader.getNotUploadedItems().length">
						Upload all</button>
					<button type="button" class="btn btn-warning btn-s"
						ng-click="uploader.cancelAll()"
						ng-disabled="!uploader.isUploading">Cancel all</button>
					<button type="button" class="btn btn-danger btn-s"
						ng-click="uploader.clearQueue()"
						ng-disabled="!uploader.queue.length">Remove all</button>
				</div>
			</span>

		</div>

	</div>

	</div>

</body>
</html>
