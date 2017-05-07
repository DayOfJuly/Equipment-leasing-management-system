var app = angular.module('unifyModule', ['ngResource','Config','filterModule']);

/**
 * 测试接口
 */
app.service('unifyTestSvc', function($resource,unifyTestUrl) {
	var actions = {
			unifydo:{method:'POST', params: {}},
  	};
 	return $resource(unifyTestUrl, {}, actions);	
});

/**
 * 测试接口1
 */
app.service('unifyTestSvc1', function($resource,unifyTestUrl1) {
	var actions = {
			unifydo:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
  	};
 	return $resource(unifyTestUrl1+"/:urlPath"+"/:parm", {}, actions);	
});

/*机械设备分类资源*/
app.service('category', function($resource,CategoryUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			unifydoHM:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(CategoryUrl+"/:urlPath"+"/:parm", {}, actions);	
});

app.service('nonLoginCategory', function($resource,NonLoginCategoryUrl) {
	var actions = {
		unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"},isArray:true}
  	};
 	return $resource(NonLoginCategoryUrl+"/:urlPath"+"/:parm", {}, actions);	
});

/*我想交易的信息*/
app.service('busDealInfo', function($resource,BusDealInfoUrl) {
	var actions = {
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(BusDealInfoUrl+"/:urlPath"+"/:parm", {}, actions);	
});

/*我已发布的信息*/
app.service('busPublishInfo', function($resource,BusPublishInfoUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(BusPublishInfoUrl+"/:urlPath"+"/:parm", {}, actions);	
});

/*折旧费登记*/
app.service('depreciationHist', function($resource,DepreciationHistUrl) {
	var actions = {
		post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
	};
	return $resource(DepreciationHistUrl+"/:urlPath"+"/:parm", {}, actions);
});

/*发布结果登记*/
app.service('busPublishHist', function($resource,BusPublishHistUrl) {
	var actions = {
		unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
		put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
		post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
	};
	return $resource(BusPublishHistUrl+"/:urlPath"+"/:parm", {}, actions);
});

/*设备资源管理*/
app.service('equipment', function($resource,EquipmentUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(EquipmentUrl+"/:urlPath"+"/:parm", {}, actions);	
});
/*出租 出售 求租 求购*/
app.service('IssuSvc', function($resource,IssuInfoUrl) {
	var actions = {
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(IssuInfoUrl+"/:urlPath"+"/:parm", {}, actions);	
});
/*出租信息*/
app.service('rentSvc', function($resource,RentUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(RentUrl+"/:urlPath"+"/:parm", {}, actions);	
});
/*出售信息*/
app.service('SaleSvc', function($resource,SaleUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(SaleUrl+"/:urlPath"+"/:parm", {}, actions);	
});
/*求租信息*/
app.service('DemandRentSvc', function($resource,DemandRentUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(DemandRentUrl+"/:urlPath"+"/:parm", {}, actions);	
});
/*求购信息*/
app.service('DemandSaleSvc', function($resource,DemandSaleUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(DemandSaleUrl+"/:urlPath"+"/:parm", {}, actions);	
});
/*已发布信息*/
app.service('published', function($resource,PublishedUrl) {
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			getEquNames:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"},isArray:true},
			getResources:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			unifydoHM:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			addViewCount:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}}
  	};
 	return $resource(PublishedUrl+"/:urlPath"+"/:parm", {}, actions);	
});
/*图片信息*/
app.service('PicSvc', function($resource,PicUrl) {
	var actions = {
		unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
		put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
		post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
		del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
	};
	return $resource(PicUrl+"/:urlPath"+"/:parm", {}, actions);
});

/**
 * party统一接口*/
app.service('personSvc', function($resource,perUrl) {
	var actions = {
			queryPersonList:{method:'POST',params:{}},//查询人员列表
			queryPerson:{method:'GET',params:{id:'@id'}},//查询人员列表有id
			addPersonDetail:{method:'PUT',params:{}},//添加员工信息没id
			updatePerson:{method:'POST',params:{id:'@id'}},//更新管理员信息
			oPerson:{method:'DELETE',params:{id:'@id',state:'@state'}},//启用停用管理员账户
			updatePersons:{method:'POST',params:{id:'@id'}},//更新管理员信息
			checkCode:{method:'GET',params:{}},//检查是否存在员工id
			deletePersonPic:{method:'DELETE',params:{urlPath:'@urlPath',id:'@id',upLoadId:'@upLoadId'}}//删除员工关联图片
  	};
 	return $resource(perUrl+"/:urlPath/:id/:state/:upLoadId", {}, actions);	
});

/**
 * party统一接口*/
app.service('personOutSvc', function($resource,perOutUrl) {
	var actions = {
			queryPersonList:{method:'POST',params:{}},//查询人员列表
			queryPerson:{method:'GET',params:{id:'@id'}},//查询人员列表有id
			addPersonDetail:{method:'PUT',params:{}},//添加员工信息没id
			updatePerson:{method:'POST',params:{id:'@id'}},//更新管理员信息
			oPerson:{method:'DELETE',params:{id:'@id',state:'@state'}},//启用停用管理员账户
			updatePersons:{method:'POST',params:{id:'@id'}},//更新管理员信息
			checkCode:{method:'GET',params:{}},//检查是否存在员工id
			deletePersonPic:{method:'DELETE',params:{urlPath:'@urlPath',id:'@id',upLoadId:'@upLoadId'}}//删除员工关联图片
  	};
 	return $resource(perOutUrl+"/:urlPath/:id/:state/:upLoadId", {}, actions);	
});

app.service('personMsgSvc', function($resource,perUrl) {
	var actions = {
			getAdministratorDetail:{method:'POST',params:{}},//根据登录名查询管理员信息
			getUserDetail:{method:'GET',params:{}}//根据登录名获取员工信息
  	};
 	return $resource(perUrl+"/Msg", {}, actions);	
});

/**
 * 企业统一接口
 */
app.service('entSvc', function($resource,entUrl) {
	var actions = {
			queryPartyInstallDetail:{method:'GET',params:{id:"@id"}},//查询企业设置信息
			queryPartyInstallList:{method:'POST',params:{}},//查询企业设置列表
			addPartyInstallDetail:{method:'PUT',params:{}},//添企业设置信息
			updatePartyInstallDetail:{method:'POST',params:{id:"@id"}},//更新企业设置信息
			deletePartyInstallDetail:{method:'DELETE',params:{id:'@id'}}//删除企业设置信息
  	};
 	return $resource(entUrl+"/:id", {}, actions);	
});

/**
 * pro统一接口
 */
app.service('proSvc', function($resource,proUrl) {
	var actions = {
			queryPartyInstallDetail:{method:'GET',params:{id:"@id"}},//查询企业设置信息
			queryPartyInstallList:{method:'POST',params:{}},//查询企业设置列表
			addPartyInstallDetail:{method:'PUT',params:{}},//添企业设置信息
			updatePartyInstallDetail:{method:'POST',params:{id:"@id"}},//更新企业设置信息
			deletePartyInstallDetail:{method:'DELETE',params:{id:'@id'}}//删除企业设置信息
  	};
 	return $resource(proUrl+"/:id", {}, actions);	
});


app.service('entMsgSvc', function($resource,entUrl) {
	var actions = {
			queryPartyList:{method:'POST',params:{},isArray:true},//查询企业列表
			getPartyDetail:{method:'POST',params:{id:"@id"}},//获取企业信息
			updatePartyDetail:{method:'PUT',params:{}}//修改企业状态
  	};
 	return $resource(entUrl+"/Msg/:id", {}, actions);	
});

/**
 * 地区
 */
app.service('regionSvc', function($resource,regionUrl) {
	var actions = {
			queryRegionArea:{method:'POST',params:{},isArray:true},//查询行政地区
			queryRegionAreaA:{method:'POST',params:{},isArray:true},//查询行政地区
			queryRegions:{method:'GET',params:{},isArray:true},//查询所有行政区域
			queryRegionByRegionId2:{method:'GET',params:{id:"@id"}},//查询行政地区
			queryRegionNameByRegionId2:{method:'GET',params:{id:"@id"},isArray:true}//查询行政地区
  	};
 	return $resource(regionUrl+"/:id", {},actions);	
});
	

/**
 * role统一接口
 */
/*app.service('roleSvc', function($resource,roleUrl) {
	var actions = {
			queryRole:{method:'POST',params:{}},//查询角色信息
			getRoleDetail:{method:'GET',params:{ID:"@id"}},
			addRole:{method:'PUT',params:{ID:"@id"}},//添加员工信息
			addRole:{method:'PUT',params:{}},//添加角色信息
			updateRole:{method:'POST',params:{ID:'@id'}},//更新管理员信息
			deleteRole:{method:'DELETE',params:{ID:'@id'}}//删除角色
  	};
 	return $resource(roleUrl+"/:id", {}, actions);	
});*/

//功能权限
app.service('roleSvc', function($resource,roleUrl) {
	var actions = {
			queryRole:{method:'POST',params:{}},//查询角色信息
			getRoleDetail:{method:'GET',params:{ID:"@id"}},
			/*addRole:{method:'PUT',params:{ID:"@id"}},//添加员工信息
*/			addRole:{method:'PUT',params:{}},//添加角色信息
            verifyNameRole:{method:'GET',params:{}},//校验姓名是否存在
            verifyNameUpdRole:{method:'GET',params:{}},//校验姓名是否存在
			updateRole:{method:'POST',params:{ID:'@id'}},//更新管理员信息
			deleteRole:{method:'DELETE',params:{ID:'@id'}}//删除角色
  	};
 	return $resource(roleUrl+"/:id", {}, actions);	
});

//功能权限
app.service('authoritySvc', function($resource,authorityUrl) {
	var actions = {
			queryAuthorities:{method:'POST',params:{}},//查询权限列表
  	};
 	return $resource(authorityUrl, {}, actions);	
});

//系统用户
app.service('sysUserSvc',function($resource,sysUserUrl){
	var actions = {
			loginUser:{method:'GET',params:{}},//用户登录
			loginOut:{method:'GET',params:{}},//用户登出
	};
	return $resource(sysUserUrl, {}, actions);	
});

//用户注册
app.service('sysUserRegSvc',function($resource,sysUserRegUrl){
	var actions = {
			userReg:{method:'PUT',params:{}}//用户注册
	};
	return $resource(sysUserRegUrl, {}, actions);	
});

//审核信息
app.service('busAuditSvc',function($resource,BusAuditUrl){
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			unifydoAll:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
	};
	return $resource(BusAuditUrl+"/:urlPath", {}, actions);	
});

//联系方式维护
app.service('partyConTactSvc',function($resource,PartyConTactInfoUrl){
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			put:{method:'PUT', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
			del:{method:'DELETE', params: {urlPath:"@urlPath",parm:"@parm"}}
	};
	return $resource(PartyConTactInfoUrl+"/:urlPath", {}, actions);	
});

//租赁费登记——拥有者
app.service('RentHistOwnerSvc',function($resource,RentHistOwnerInfoUrl){
	var actions = {
			unifydo:{method:'GET', params: {urlPath:"@urlPath",parm:"@parm"}},
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
	};
	return $resource(RentHistOwnerInfoUrl+"/:urlPath", {}, actions);	
});

//租赁费登记——使用者
app.service('RentHistUserSvc',function($resource,RentHistUserInfoUrl){
	var actions = {
			post:{method:'POST', params: {urlPath:"@urlPath",parm:"@parm"}},
	};
	return $resource(RentHistUserInfoUrl+"/:urlPath", {}, actions);	
});



/**
 * 文件上下传Upload
 */
app.service('uploadSvc', function($resource,fileUrl) {
	var actions = {
			uploadFile:{method:'POST',params:{}}
  	};
 	return $resource(fileUrl+"/Upload", {}, actions);	
});

app.service('uploadSvc', function($resource,fileUrl) {
	var actions = {
			uploadFile:{method:'POST',params:{}}
  	};
 	return $resource(fileUrl+"/Upload", {}, actions);	
});

app.service('downloadSvc', function($resource,entUrl) {
	var actions = {
			downloadFile:{method:'GET',params:{id:"@id"}}
  	};
 	return $resource(entUrl+"/Download/:id", {}, actions);	
});

