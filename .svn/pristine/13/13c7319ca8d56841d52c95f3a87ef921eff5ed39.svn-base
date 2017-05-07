app.controller('provincesController', function($scope,$route,regionSvc) {

	
	$scope.Nationwide = {};
	$scope.isChack = {};
	if($route.current.params.formParms_ && $route.current.params.formParms_ == '全国'){//如果主页面传过来的参数是全国
		$scope.Nationwide.chk = true;//全国为选中
		$scope.isChack.chk = true;//不可点击的属性
	}else{//传过来的参数不是全国的话
		$scope.Nationwide.chk = false;//全国为选中
		$scope.isChack.chk = false;//不可点击的属性
	}
	
	var goBakeParm ='';//点返回主页面要用的参数
	$scope.checkBoxFun = function(){//点选全国触发的方法
		if($scope.Nationwide.chk == false){//如果复选框为没有选中的状态
			$scope.isChack.chk = false;//那么显示下面展示的值
			goBakeParm ='';//返回值就不为全国因为可以选
		}else{
			goBakeParm ='全国';//如果是为勾选全国的情况
			$scope.isChack.chk = true;//返回值就为全国
		}
	};
	
	$scope.parm_ = '';
	
	$scope.goBackFun = function(url_){//返回主页面的方法
		var parm_s = $route.current.params.parm_;//拿到返回的参数
		
		if($route.current.params.formParms_ && $route.current.params.formParms_ == '全国'){//如果参数是全国那么返回去的参数也是全国
			goBakeParm = '全国';
		}
		window.location.href=url_+parm_s+'/'+goBakeParm;
	};
	
	
	
	
	//初始化查询省的信息
    $scope.initQueryProvincesFun=function(){
    	function aSucc(rec){
			$scope.provinceList=[];
			$scope.provinceList=rec;
		}
		function aErr(rec){}
		
		
		$scope.parm_ = $route.current.params.parm_;//返回主页面使用
		
		
		regionSvc.queryRegionArea({}, aSucc,aErr);//查询省级单位
    };

    //跳转到选择城市页面(参数为点击对象和跳转的路径)
    $scope.toSelectProvincesFun = function(obj,url_){
        $scope.changePro(obj,url_);
    };
    
    
    $scope.choseFlag = {};
    
    if($route.current.params.obj_){
    	$scope.choseFlag.flag = $route.current.params.obj_;
    }else{
    	$scope.choseFlag.flag = '';
    }
    /*
	 *省份
	*/
	$scope.changePro=function(parm,url_){
		
		var proRegionId = "";
		var parms_url = $route.current.params.parm_;//往市传递使用 用于知道从哪个页面来
		if($route.current.params.obj_ && $route.current.params.obj_.length == 1){
			var obj_type = $route.current.params.obj_;//往市传递使用 用于知道是什么类型如出租、出售
		}
		
		for(var i=0;i<$scope.provinceList.length;i++){
			if($scope.provinceList[i].name==parm){
				proRegionId=$scope.provinceList[i].regionId;
				var provincesName = parm;
				if($route.current.params.obj_ && $route.current.params.obj_.length == 1){
					window.location.href= url_+"/"+proRegionId+"/"+provincesName+'/'+parms_url+'/'+obj_type;
				}else{
					window.location.href= url_+"/"+proRegionId+"/"+provincesName+'/'+parms_url;
				}
				break;
			}
		}
	};
	
	
});