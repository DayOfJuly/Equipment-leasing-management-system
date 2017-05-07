var app=angular.module('userRegApp',['ngResource','unifyModule','ngMessages']);
app.controller('userRegController',function($scope,sysUserRegSvc){
	
	var url = location.search;// jsp后面的参数 ：?id=432&infoType=1
	var theRequest = new Object();
	if (url.indexOf("?") != -1) {// 如果有？ 
		var str = url.substr(1);// 去掉？ ：id=432&infoType=1
		strs = str.split("&");// 去掉& ：["id=432", "infoType=1"] 
		for (var i = 0; i < strs.length; i++) {
			var ss = strs[i].split("=");
			theRequest[ss[0]] = (ss[1]);
		}
	}

    $scope.sysUser={};
	if (theRequest.messageStrs) {
		var Str = theRequest.messageStrs.split("~|~");
		$scope.sysUser = {};
		$scope.sysUser.userName = Str[0];
		$scope.sysUser.password = Str[1];
		$scope.sysUser.confPassword = Str[2];
		$scope.sysUser.phone = Str[3];
		$scope.sysUser.VerificationCode = Str[4];
		if(Str[5]=="true"){
			$scope.sysUser.checkBox=true;
		}else{
			$scope.sysUser.checkBox=false;
		}
	};
	
	/*
	 * 验证码
	 */
    $scope.GetVercode = function createCode() {
    	var code = "";
        var codeLength = 4; //验证码的长度
        var checkCode = document.getElementById("checkCode");
        var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                /** 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',**/
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，可以用中文
        for (var i = 0; i < codeLength; i++) {
            var charNum = Math.floor(Math.random() * 26);
            code += codeChars[charNum];

        }
        if (checkCode) {
            checkCode.className = "code";
            checkCode.innerHTML = code;
        }
    }
	
    /* 注册加跳转页面方法 */
    $scope.login = function(obj){
    	if( $scope.sysUser.userName==null|| $scope.sysUser.userName==""){
			 $.messager.popup("请输入用户名");
			 return;
		}
		if( $scope.sysUser.password==null|| $scope.sysUser.password==""){
			 $.messager.popup("请输入密码");
			 return;
		}
		if( $scope.sysUser.confPassword==null|| $scope.sysUser.confPassword==""){
			 $.messager.popup("请重新输入密码");
			 return;
		}
		if($scope.sysUser.password != $scope.sysUser.confPassword){
			 $.messager.popup("两次密码不一致");
			 return;
		}
        if( $scope.sysUser.VerificationCode && ($scope.sysUser.VerificationCode.toUpperCase()!=document.getElementById("checkCode").innerHTML.toUpperCase())) {
            $scope.showFlag = 'inputCodeErr';
            $.messager.popup("请输入正确的验证码");
            return;
        }else if($scope.sysUser.VerificationCode =="" || $scope.sysUser.VerificationCode==null){
        	$.messager.popup("请输入验证码");
        	return;
        }else if($scope.sysUser.checkBox!=true){
        	return;
        }

        function success(rec){
        	$.messager.popup("恭喜您注册成功");
        	$.messager.popup("正在为您跳转登录页面");
        	alert(00000000000);
//        	if(rec.loginId!=null){
//        		window.location.href="/WebSite/Mobile/General/Login/Login.jsp";/* 原页面展示主页 */
//        		}
//        	else{
//        		$.messager.popup("用户名或密码错误，请新输入！！");
//        		$scope.sysUser.userName = null;
//        		$scope.sysUser.password = null;
//        		$scope.showFlag = null;
//        		$("#userName").focus();
//        		}
        	}

        function error(rec){
        	if(rec){
        		$.messager.popup( rec.data.message);
        		return;
        		}
        	}	 

        sysUserRegSvc.userReg({loginId:$scope.sysUser.userName,pwd:$scope.sysUser.password,confPwd:$scope.sysUser.confPassword,mobile:$scope.sysUser.phone},success,error);
	};

	/*验证码*/
	$scope.auditForm = function(){
		//	验证码输入正确校验
		if($scope.formParms.inputCode && ($scope.formParms.inputCode.toUpperCase()!=document.getElementById("checkCode").innerHTML.toUpperCase())){
			$scope.showFlag = 'inputCodeErr';
			$.messager.popup("请输入正确的验证码");
			return;
		}  
	};
	
	/*信息同步*/
	$scope.messageSync = function(){
		var messageStr = "";
		messageStr = messageStr + ($scope.sysUser.userName ? $scope.sysUser.userName : "") + "~|~";
		messageStr = messageStr + ($scope.sysUser.password ? $scope.sysUser.password : "") + "~|~";
		messageStr = messageStr + ($scope.sysUser.confPassword ? $scope.sysUser.confPassword : "") + "~|~";
		messageStr = messageStr + ($scope.sysUser.phone  ? $scope.sysUser.phone : "") + "~|~";
		messageStr = messageStr + ($scope.sysUser.VerificationCode  ? $scope.sysUser.VerificationCode : "") + "~|~";
		messageStr = messageStr + ($scope.sysUser.checkBox  ? $scope.sysUser.checkBox : "") + "~|~";
		var urlStr = "/WebSite/Mobile/General/UserReg/agreement.jsp?messageStr="+messageStr;
//		return;
		window.location.href = urlStr;
	};
	
});
