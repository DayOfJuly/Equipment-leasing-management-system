/**
 * 复用获取屏幕分辨率-100
 */
 var screenWidth = {width:(window.screen.availWidth-100)+"px"};/* 获取当年电脑分辨率宽度-100 */
    
$(".container").css(screenWidth);/* 赋值给使用了.container的css */