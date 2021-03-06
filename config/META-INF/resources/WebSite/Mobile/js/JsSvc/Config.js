var app = angular.module('Config', []);

/**
 * 注意：服务的路径本地开发和测试不一样的，如果修改了这个文件，提交一定要提交对应的服务地址，切记切记！！！
 * 
 * 本地可以使用：http://localhost:8080 或者 http://127.0.0.1:8080 或者 http://192.168.0.138:8080
 * 
 * 测试应该使用：http://124.205.89.213:8080 或者 http://192.168.0.236:8080 或者 http://192.168.0.10:8080
 * 
 */
//var servicePath = "http://192.168.0.199:8080";
var servicePath = "http://124.205.89.215:8086";

//不使用虚拟机时，使用这个地址，外网能访问
/*var servicePath = "http://124.205.89.213:8080";*/

//目前使用虚拟机时，使用这个地址，外网不能访问
/*var servicePath = "http://192.168.0.10:8080";*/

/*var servicePath_test = "http://192.168.0.10:8080";*/

var servicePath_test = "http://124.205.89.215:8086";
//var servicePath_test = "http://192.168.0.185:8080";
//为了测试，目前有关图片上传的功能全部都是使用测试服务器的地址，即使是本地开发也是使用测试服务器的地址
app.constant('PicUrl',servicePath_test+"/Picture");

/**
 * test URL,not use 
 */
app.constant('unifyTestUrl',servicePath+"/TestTable?Action=All");
app.constant('unifyTestUrl1',servicePath+"/Test");



/**不需要后台过滤的请求资源++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

//发布信息，这个资源地址中集中了许多不需过滤的方法
app.constant('PublishedUrl',servicePath+"/Issue");
//角色，暂时未使用
app.constant('roleUrl',servicePath+'/Sys/Role');

//地区
app.constant('regionUrl',servicePath+'/Party/Region');
//文件上下传
app.constant('fileUrl',servicePath+'/Upload');
//权限功能
app.constant('authorityUrl',servicePath+'/Sys/Func');
//系统用户登录
app.constant('sysUserUrl',servicePath+'/Sys/User');
//系统用户注册
app.constant('sysUserRegUrl',servicePath+'/BG/Party/MobileUserReg');

//出租 求租 出售 求购信息查询
app.constant('IssuInfoUrl',servicePath+"/Issue")
//搜索跳转
app.constant('searchUrl',servicePath+"/WebSite/Front/Main/");



/**需要后台过滤的请求资源，针对信息审核系统+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
//审核信息
app.constant('BusAuditUrl',servicePath+"/AUDIT/BusAuditInfo");



/**需要后台过滤的请求资源+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
//企业
app.constant('entUrl',servicePath+'/BG/Party/Ent');
//项目
app.constant('proUrl',servicePath+'/BG/Party/Pro');
//员工信息
app.constant('perUrl',servicePath+'/BG/Party/Per');
//外部员工信息
app.constant('perOutUrl',servicePath+'/BG/Party/Provider');
//设备资源
app.constant('EquipmentUrl',servicePath+"/BG/Equipment");
//设备信息
app.constant('CategoryUrl',servicePath+"/BG/Category");

app.constant('NonLoginCategoryUrl',servicePath+"/Category");
//我想交易的信息
app.constant('BusDealInfoUrl',servicePath+"/BG/BusDealInfo");
//我已发布的信息
app.constant('BusPublishInfoUrl',servicePath+"/BG/BusPublishInfo");
//联系方式维护
app.constant('PartyConTactInfoUrl',servicePath+"/BG/Party/ContactInfo");
//折旧费登记
app.constant('DepreciationHistUrl',servicePath+"/BG/DepreciationHist");
//发布结果登记
app.constant('BusPublishHistUrl',servicePath+"/BG/BusPublishHist");
//租赁费登记——拥有者
app.constant('RentHistOwnerInfoUrl',servicePath+"/BG/RentHistOwner");
//租赁费登记——使用者
app.constant('RentHistUserInfoUrl',servicePath+"/BG/RentHistUser");
//出租
app.constant('RentUrl',servicePath+"/BG/Rent");
//出售
app.constant('SaleUrl',servicePath+"/BG/Sale");
//求租
app.constant('DemandRentUrl',servicePath+"/BG/DemandRent");
//求购
app.constant('DemandSaleUrl',servicePath+"/BG/DemandSale");