		/**
		 * 获取所有cookie
		 */
		var getAllCookie=function ()
		{
		    var allcookie = document.cookie;
		    return unescape(allcookie);
		};
		/**
		 * 添加cookie
		 * @param cookieName
		 * @param cookieValue
		 * @param cookieSaveDays
		 * @param cookieSavePath
		 */
		var addCookie = function (cookieName,cookieValue,cookieSaveDays,cookieSavePath)
		{ 
			var name = escape(cookieName);
		    var value = escape(cookieValue);
		    var expires = new Date();
			expires.setTime(expires.getTime() + cookieSaveDays * 3600000 * 24);
		    //cookieSavePath=/，表示cookie能在整个网站下使用，cookieSavePath=/temp，表示cookie只能在temp目录下使用
			cookieSavePath = cookieSavePath == "" ? "" : ";cookieSavePath=" + cookieSavePath;
			var _expires = (typeof cookieSaveDays) == "string" ? "" : ";expires=" + expires.toUTCString();
			document.cookie = name + "=" + value + _expires + cookieSavePath;
		};
		/**
		 * 根据cookieName获取cookieValue
		 */
		var getCookieValue = function (cookieName)
		{
			var name = escape(cookieName);
		    var allcookies =getAllCookie();       
			name += "=";
		    var pos = allcookies.indexOf(name);    
		    if (pos != -1)
		    {
				var start = pos + name.length;
		        var end = allcookies.indexOf(";",start);
		        if (end == -1) end = allcookies.length;
		        var value = allcookies.substring(start,end);
		        return unescape(value);
			}
		    else
		    {
				return "";
			}
		};
		/**
		 * 根据cookieName删除cookie，本质是设置其失效
		 * @param cookieName
		 * @param cookieSavePath
		 */
		var deleteCookie = function (cookieName,cookieSavePath)
		{
		    var name = escape(cookieName);
		    var expires = new Date(0);
			cookieSavePath = cookieSavePath == "" ? "" : ";cookieSavePath=" + cookieSavePath;
			document.cookie = name + "="+ ";expires=" + expires.toUTCString() + cookieSavePath;
		};