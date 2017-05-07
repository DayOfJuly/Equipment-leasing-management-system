app.controller('brandListController', function($scope,$timeout,busEquParameterSvc,category,SYS_CODE_CON,sysCodeTranslateFactory,$upload,PicUrl) {


	/**
	 * 分页
	*/
	$scope.paginationConf = {
		
		currentPage:1,/*当前页数*/
        totalItems:1,/*数据总数*/
        itemsPerPage: 10,	/*每页显示多少*/
        pagesLength: 10,		/*分页标签数量显示*/
        perPageOptions: [10, 15,20, 30, 40, 50],
		onChange : function(parm1, parm2) {
			$scope.paginationConf.currentPage=parm1;
			$scope.queryCategoryData();
		}
	};
	
	$scope.formParms = {};
	//品牌列表
	$scope.queryCategoryData = function(){
		function qSucc(rec){
			$scope.brandList = rec.content;
			$scope.paginationConf.totalItems = rec.totalElements;/*查询出来的数据总数*/
		}
		function qErr(rec){}
		busEquParameterSvc.unifydo({type:1,status:1,pageNo:$scope.paginationConf.currentPage-1,pageSize:$scope.paginationConf.itemsPerPage},qSucc,qErr);
	}
	
	//保存
	$scope.saveBrandList = function(){
		function qSucc(rec){
			$.messager.popup("添加成功！");
			$scope.name = "";
			PicOne = {};
			$scope.PicList= [];
			$scope.formParms.equipmentPic = null;
			$scope.PListLength = 0;
			$scope.queryCategoryData();
			$("#brandListModel").modal('hide');
		}
		function qErr(rec){
			$.messager.popup("添加失败！");
		}
		
		if(!$scope.name){
			$.messager.popup("请填写品牌名称");
			return;
		}
		busEquParameterSvc.putUnifydo({type:1,name:$scope.name,logoPic:$scope.formParms.equipmentPic,},qSucc,qErr);
	}
	
	
	var PicOne;
	$scope.PListLength = 0;
	$scope.newFileUpLoad=function(){
		$("#fileupload").click();
	};

	$scope.PicList = [];/*初始化$scope.PicList = [];*/
	
	
	$('#fileupload').fileupload({
		
		//url: "/Picture",
	       dataType: 'json',
	       
	       autoUpload: true,
	       
	    add: function (e, data) {
	        data.submit();
	    },
	    done: function (e,res) {
	    	var data=res.result;
	        $scope.PicRealName = data.fileName;
	        
	        if(!$scope.formParms.equipmentPic){//防止出现第一次下载图片出现图片名字为undefind，试图片加载失败
	        	$scope.formParms.equipmentPic = "";
	        }
	        
	        if($scope.PicListD && $scope.PicListD.length>0)
	        {
	        	$scope.formParms.equipmentPic +=","+ data.fileName;
	        }
	        else
	        {
	        	 $scope.formParms.equipmentPic += data.fileName + ",";
	        }
	       
	        $scope.ay = $scope.formParms.equipmentPic.split(',');
	        
	        $scope['PicOneCopy'] = {};
	        
	        var fullname = data.fileName.split('.');  
	         PicOne = {'PicName': fullname[0], 'PicType': fullname[1]};
	     
	        if ($scope.PListLength < 1) {
	        	$scope.$apply(function(){
	        		if($scope.PicListD){
	            		
	        			$scope.PicList.push(PicOne);
	        		}else{
	        			$scope.PicList.push(PicOne);
	        		}
	                if($scope.PicListD){
	                	$scope.PListLength = $scope.PicList.length+$scope.PicListD.length;
	                }else{
	                	$scope.PListLength = $scope.PicList.length;
	                }
	                $scope.PicUrl = PicUrl;
	                $scope.PicAction = "Action=TmpPic";
	        	});
	        } else {
	        	 $.messager.popup("最多上传1张图片");
	        }
	    }
	});
	
	//删除品牌
	$scope.delBrandList = function(parameterId){
		$.messager.confirm("提示", "是否确认删除当前数据？", function() { 
			$scope.delec(parameterId);
			$scope.queryCategoryData();
		});
	}
	
	$scope.delec = function(parameterId){
		
		function qSucc(rec){
			$.messager.popup("删除成功！");
			$scope.queryCategoryData();
		}
		function qErr(rec){
			$.messager.popup("删除失败！");
		}
		busEquParameterSvc.delUnifydo({"urlPath":parameterId},qSucc,qErr);
	}
	
	$scope.openAddModal = function(){
		$('#brandListModel').modal({backdrop: 'static', keyboard: false});
	}
	
	$scope.closeWindow = function(){
		$scope.name = "";
		 PicOne = {};
		 $scope.PicList= [];
		$scope.formParms.equipmentPic = null;
		$scope.PListLength = 0;
		$("#brandListModel").modal('hide');
	}
	
	
});