var app=angular.module('loginApp',['ngResource','unifyModule','ngMessages']);
app.controller('loginController',function($scope,sysUserSvc){
	
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
	
    /* 验证用户名密码加跳转页面方法 */
    $scope.sysUser={};
    $scope.login = function(obj){
    	if( $scope.sysUser.userName==null|| $scope.sysUser.userName==""){
			 $.messager.popup("请输入用户名");
			 return;
		}
		if( $scope.sysUser.password==null|| $scope.sysUser.password==""){
			 $.messager.popup("请输入密码");
			 return;
		}

        if( $scope.sysUser.VerificationCode && ($scope.sysUser.VerificationCode.toUpperCase()!=document.getElementById("checkCode").innerHTML.toUpperCase())) {
            $scope.showFlag = 'inputCodeErr';
            $.messager.popup("请输入正确的验证码");
            return;
        }else if($scope.sysUser.VerificationCode =="" || $scope.sysUser.VerificationCode==null){
        	$.messager.popup("请输入验证码");
        	return;
        }

        function success(rec){
        	if(rec.loginId!=null){
        		window.location.href="/WebSite/Mobile/Index.jsp";/* 原页面展示主页 */
        		}
        	else{
        		$.messager.popup("用户名或密码错误，请新输入！！");
        		$scope.sysUser.userName = null;
        		$scope.sysUser.password = null;
        		$scope.showFlag = null;
        		$("#userName").focus();
        		}
        	}

        function error(rec){
        	if(rec){
        		$.messager.popup( rec.data.message);
        		return;
        		}
        	}	 

        sysUserSvc.loginUser({userName:$scope.sysUser.userName,password:$scope.sysUser.password,Action:'Login'},success,error);
		};

	/*登陆按钮是否禁用*/
	$scope.auditForm = function(){
		//	验证码输入正确校验
		if($scope.formParms.inputCode && ($scope.formParms.inputCode.toUpperCase()!=document.getElementById("checkCode").innerHTML.toUpperCase())){
			$scope.showFlag = 'inputCodeErr';
			$.messager.popup("请输入正确的验证码");
			return;
			}  
		};
	});
