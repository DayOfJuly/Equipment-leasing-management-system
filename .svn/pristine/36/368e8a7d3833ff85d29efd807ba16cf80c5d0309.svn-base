/**
 * 定义拦截器模块，拦截前端的请求，然后获取cookie看其中是否有用户的信息，如果没有则认为此用户没有登录，跳转到登录页面
 */
var app = angular.module("filterModule", ['ngResource']);
/**
 * 定义拦截器工厂
 */
app.factory('userInterceptor',function($q) {
	var userInterceptor = {
		'request':function(config){
			/**
			 *针对IE浏览器发送请求的特点，为请求添加一个随机数，让IE认为每次请求都是一个新的请求
			 */
			if(config.params)
			{
				config.params.randomTemp = Math.ceil(Math.random()*1000000);
			}
			else
			{
				config.url = config.url + "?randomTemp=" + Math.ceil(Math.random()*1000000);
			}
			return config;
			},
		'requestError':function(config){
			return config;
			},
		'response':function(response){
			return response;
			},
		'responseError':function(responseErr){
			if(530==responseErr.status)
   			{
				window.location.href="/WebSite/Mobile/General/Login/Login.jsp";
			}
			return $q.reject(responseErr);
			}
		};
	return userInterceptor;
	});
//将自定义拦截器放入拦截器栈
app.config(function($httpProvider) {
    $httpProvider.interceptors.push('userInterceptor');
});
