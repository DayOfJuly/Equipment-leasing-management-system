app.controller('AdministratorController', function($scope, personSvc,personMsgSvc) {

		
		
		/**
		 * 定义的对象
		 */
		$scope.Admin = {};
		$scope.queUpdate = {};// 备用
		$scope.queData = {};// 备用
		$scope.user = {
			/* parentOrgId : 3, */
			parentOrgId : $scope.userCookies.orgId,
			parTypeId : 2/* 写死 */
		};// 定义一个用户
		$scope.loser = {};// 接收修改查询未成功之前的对象数据
		
		/**
		 * 验证需要的方法
		 */
		$scope.submitForm = function(isValid) {
			if (isValid) {
				alert('our form is amazing');
			}
		};

		/**
		 * 分页
		 */
		$scope.paginationConf = {
				
			currentPage:1,/*当前页数*/
	        totalItems:1,/*数据总数*/
	        itemsPerPage: 10,	/*每页显示多少*/
	        pagesLength: 10,		/*分页标签数量显示*/
	        perPageOptions: [10, 20, 30, 40, 50],
			
			/*
			 * parm1:当前选择页数 parm2:每页显示多少 屏幕加载运行
			 */
			/**
			 * 屏幕打开时加载多半用于打开时查询
			 */
			 onChange : function(parm1, parm2) {
				$scope.queryPersonLists();
				$scope.paginationConf.currentPage=parm1;
				$scope.radioTrIndex=null;
				if($scope.radioTrIndex==null){
					$scope.updData = {};
				}
			}
		};
		/**
		 * 查询管理员列表（查询）
		 */
		$scope.PersonList = [];
		$scope.queryPersonLists = function(PageNo) {
			if(PageNo){
				$scope.paginationConf.currentPage = 1;
			}
			// 根据服务名.对应方法名
			personSvc.queryPersonList({
				parTypeId : 2,/* 写死 */
				/* currOrgId : 3, */
				currOrgId : $scope.userCookies.orgId,
				pageNo : $scope.paginationConf.currentPage - 1,// 当前页数
				pageSize : $scope.paginationConf.itemsPerPage
			// 每页显示2条
			},
			// 成功
			function(rec) {
			 	if($scope.enterpriseState==1||$scope.enterpriseState==0){/* 如果下面点击过单选按钮，也就说状态有值，没有点击过的时候这个值为underfind不会进入 */
			 		$scope.enterpriseState=rec.content[0].state;/* 把刚才修改过的第一个状态值赋给下面的修改按钮显示的条件对象 */
				} 
				// 把返回值的数组赋值给对象拿到页面遍历
				if(rec.content){
					for (var i = 0; i < rec.content.length; i++) {
						if (rec.content[i].state == 0) {
							$scope.PersonList = rec.content;
							$scope.PersonList[i].stateTemp = "启用";/* temp接收中文状态 */
						} else if (rec.content[i].state == 1) {
							$scope.PersonList = rec.content;
							$scope.PersonList[i].stateTemp = "停用";
						}
					}
				}
				$scope.paginationConf.totalItems = rec.totalElements;// 查询出来的数据总数
			},
			// 失败
			function() {});
		};

		/**
		 * 弹出查看按钮模态框
		 */
		$scope.queAdministrator = function() {
			if ($scope.updData.partyId == null || $scope.updData.partyId == "") {
				$.messager.popup("请选择一条信息！");
			} else {
				personSvc.queryPerson({id : $scope.pid}, function(rec) {
					$scope.updData = rec;
					$('#AdministratorQueModal').modal({backdrop: 'static', keyboard: false});
					//$scope.queryPersonLists();
				}, function() {
					$.messager.popup("查询失败");
				});
			}
		};

		$scope.closeWindow = function(){
			//$scope.updData={};
			$('#AdministratorQueModal').modal('hide');
		};
		
		/**
		 * 弹出创建按钮模态框
		 */
		$scope.addAdministrator = function() {
			// 定义需要用的对象
			$scope.showFlag = {};
			$scope.resultAdd = {};
			$scope.Admin = {};
			$scope.addFlag = null;/* 查询通过标记 */
			// 用对应页面的id打开页面模态框
			$("#AdministratorAddModal").modal({backdrop: 'static', keyboard: false});
			/*$scope.queryPersonLists();*/
		};

		/**
		 * 创建按钮
		 */
		$scope.subAdmin = function(obj) {
			/*
			 * //验证不能为空 if(!$scope.Admin.loginId){ $.messager.popup("请输入登录用户名！");
			 * return; }
			 */
			// 服务名.创建对应的方法
			if($scope.addFlag && $scope.addFlag==true){
				if (obj.$valid) {
					function aSucc(rec) {
						//$scope.updData={};
						$scope.queryPersonLists(1);
						$.messager.popup("添加成功！");
						$("#AdministratorAddModal").modal('hide');
					}
					function aErr(rec) {
						//$scope.updData={};
						$.messager.popup("添加失败！");
						$("#AdministratorAddModal").modal('hide');
					}
				 	personSvc.addPersonDetail({                                                 
						// 创建传入的参数
						parTypeId : 2,// 创建类型
						loginId : $scope.resultAdd.loginId,// 管理员登录名
						name : $scope.resultAdd.perName,// 联系人姓名
						mobile : $scope.resultAdd.mobile,// 移动电话
						email : $scope.resultAdd.email,// 电子邮箱
						orgName : $scope.resultAdd.orgName,// 企业名称
						parentOrgId : $scope.user.parentOrgId,// 上级企业标识
						loginUId : $scope.resultAdd.loginUId,// 登录名
						openId : $scope.resultAdd.openId,
						note : $scope.Admin.note
					}, aSucc, aErr); 
				} else {
					if(!obj.name.$valid){
						$scope.showFlag = 'name';
						return;
					}
					if(!obj.textareaName.$valid) {
						$scope.showFlag = 'textareaName';
						return;
					}
				}
			}else{
				$.messager.popup("请查询登入用户名");
				return;
			}
			
		};

		/**
		 * 创建-查询登录名ID
		 */
		$scope.queryLoginID = function(obj) {
			if (obj.$valid) {
				
				function success(rec) {
					if(rec.email==undefined){
						$.messager.popup("验证不通过，请注册");
						$scope.resultAdd = rec;
						$scope.addFlag = false;
					}else{
						$.messager.popup("验证通过");
						$scope.resultAdd = rec;
						$scope.addFlag = true;/* 通过标记 */
						
					}
					// 把返回的数据赋值给resultAdd对象
					
					// 补充需要的参数
	/*				$scope.resultAdd.loginId = $scope.Admin.loginId;*/
				};
				
				function error(rec) {};
				
				if($scope.updData.loginId){
					$scope.uId = $scope.updData.loginId
				}else{
					$scope.uId = $scope.Admin.loginId
				}
				
				personMsgSvc.getAdministratorDetail({
					loginId : $scope.uId,
					orgId : $scope.userCookies.orgId
				}, success, error);
			} else {
				if (!obj.name.$valid) {
					$scope.showFlag = 'name';
				} else if (!obj.textareaName.$valid) {
					$scope.showFlag = 'textareaName';
				}
				return;
			}
		};

		/**
		 * 修改-查询登录名ID
		 */
		$scope.updData={};
		$scope.queryUpdLoginID = function() {
			function success(rec) {
				// 把修改-查询的返回的数据赋值给queUpdate
				$scope.queUpdate = rec;
				// 把修改-查询返回的数据赋值给updData对应的数据，这样不会覆盖updData之前除了查询结果以外的数据，还可以把改变的数据赋值给updData
				$scope.updData.email = $scope.queUpdate.email;
				$scope.updData.loginId = $scope.queUpdate.loginId;
				$scope.updData.mobile = $scope.queUpdate.mobile;
				$scope.updData.openId = $scope.queUpdate.openId;
				$scope.updData.orgName = $scope.queUpdate.orgName;
				$scope.updData.parentOrgId = $scope.user.parentOrgId;
				$scope.updData.name = $scope.queUpdate.perName;
			}
			function error(rec) {
				$.messager.popup("查询失败！");
				$scope.updData = $scope.loser;// 星期二早上7点半添加
			}
			personMsgSvc.getAdministratorDetail({
				loginId : $scope.updData.loginId
			}, success, error);
		};

		/**
		 * 修改-模态框
		 */
		$scope.updAdmin = function(obj) {
			if (obj.$valid) {
				function uSucc(rec) {
					//$scope.updData={};
					$scope.queryPersonLists();
					$.messager.popup("修改成功！");
					$scope.radioTrIndex=1;
					$scope.paginationConf.currentPage=1;
					$('#AdministratorUpdModal').modal('hide');
				}
				function uErr(rec) {
					//$scope.updData={};
					$scope.queryPersonLists();
					$.messager.popup("修改失败！"+rec.data.message);
					$('#AdministratorUpdModal').modal('hide');
				}
				// 把uId的值赋值给loginUId避免loginUId为空，数据库修改了字段名uId为loginUId
				$scope.updData.loginUId = $scope.updData.uId;
				personSvc.updatePersons({
					id : $scope.updData.partyId
				}, $scope.updData, uSucc, uErr);
			} else {
				if (!obj.name.$valid) {
					$scope.showFlag = 'name';
				} else if (!obj.textareaName.$valid) {
					$scope.showFlag = 'textareaName';
				}
				return;
			}
		};

		$scope.selectRadio = function(obj) {
			$scope.updData = obj;
		};

		/**
		 * 弹出修改-模态框
		 */
		$scope.updAdministrator = function() {
			$scope.showFlag = {};
			if ($scope.updData.partyId == null || $scope.updData.partyId == "") {
				$.messager.popup("请选择一条信息！");
			} else {
				personSvc.queryPerson({
					id : $scope.updData.partyId
				}, function success(data) {
					$scope.updData = data;
					$scope.loser = data;
				}, function error(data) {});
				$('#AdministratorUpdModal').modal({backdrop: 'static', keyboard: false});
				//$scope.queryPersonLists();
			}
		};

		/**
		 * 启用停用-弹出模态框
		 */
		$scope.opstAdministrator = function() {
			if ($scope.updData.partyId == null || $scope.updData.partyId == "") {
				$.messager.popup("请选择一条信息！");
				return;
			}
			
			personSvc.queryPerson({
				id : $scope.updData.partyId
			}, function(rec) {
				$scope.updData = rec;
				// 根据状态选择弹出哪个模态框
				if ($scope.updData.state == 0) {
					$('#AdministratorOpStModal').modal({backdrop: 'static', keyboard: false});
					//$scope.queryPersonLists();
				}

				if ($scope.updData.state == 1) {
					$('#AdministratorOpStModalOne').modal({backdrop: 'static', keyboard: false});
					//$scope.queryPersonLists();
				}
			}, function(){});
		};

		/**
		 * 停用提交
		 */
		$scope.OpStAdmin = function() {
			if (!$scope.updData.partyId) {
				$.messager.popup("请选择一条信息！");
				return;
			}
			personSvc.oPerson({
				id : $scope.updData.partyId,// 管理员id
				state : $scope.updData.state == 0 ? 1 : 0
			// 状态
			}, uSucc, uErr);
			function uSucc(rec) {
				//$scope.updData={};
				$scope.queryPersonLists(1);
				$.messager.popup("停用成功！");
				$scope.radioTrIndex=1;
				$scope.paginationConf.currentPage=1;
				$('#AdministratorOpStModal').modal('hide');
				//$scope.check($scope.copyParams,$scope.copyVarl);
				
			
			}
			function uErr(rec) {
				//$scope.updData={};
				$scope.queryPersonLists(1);
				$.messager.popup("停用失败！");
				$('#AdministratorOpStModal').modal('hide');
			}
		};

		/**
		 * 启用提交
		 */
		$scope.OpStAdminOne = function() {
			if (!$scope.updData.partyId) {
				$.messager.popup("请选择一条信息！");
				return;
			}
			personSvc.oPerson({
				id : $scope.updData.partyId,// 管理员id
				state : $scope.updData.state == 1 ? 0 : 1
			// 状态
			}, uSucc, uErr);
			function uSucc(rec) {
				//$scope.updData={};
				$scope.queryPersonLists(1);
				
				
				//$scope.enterpriseState=$scope.PersonList[0].state;
				
				$.messager.popup("启用成功！");
				$scope.radioTrIndex=1;
				$scope.paginationConf.currentPage=1;
				$('#AdministratorOpStModalOne').modal('hide');
				
			}
			function uErr(rec) {
				//$scope.updData={};
				$scope.queryPersonLists(1);
				$.messager.popup("启用失败！");
				$('#AdministratorOpStModalOne').modal('hide');
			}
		};
		
		
		/**
		 * 删除管理员
		 */
		
		$scope.delAdministrator = function(){
			$.messager.confirm("提示", "是否删除？", function() { 
		
				//删除方法
		    });
		};

		$scope.radioList={};
		//选中订单ID
		//var num = 1;
		$scope.check = function(params,varl){
			
			$scope.pid=params.partyId;
			$scope.radioTrIndex=varl;
			
			$scope.enterpriseState = params.state;/* 下面修改按钮展示的状态 */

			$scope.updData.partyId = params.partyId;
		};
		
		$scope.radioTrIndex = '';
		
		
		
		 $('html').bind('keyup', function(e)
					{
				          //当按下回车的时候
						  if(e.keyCode == 13)
						  {
							   //当焦点为输入框的id的时候
							  if(document.activeElement.id=="addId_"){
								  //把ng-model的数值强制赋给输入框本身的value
								 //$("#purId").val($scope.fuzzyData);
								 //$scope.queryTemPartyList(1);
								  $("#addBtn").click();
								 
							  } 
							  if(document.activeElement.id=="updId_"){
								  //把ng-model的数值强制赋给输入框本身的value
								 //$("#purId").val($scope.fuzzyData);
								 //$scope.queryTemPartyList(1);
								  $("#updBtn_").click();
								 
							  } 
							 
							
						  
						  }
					});
		
	});

