/**
 * IE9下防止刷新后title变化
 */
var originalTitle = document.title.split("#")[0];
document.attachEvent('onpropertychange', function (evt) {
    evt = evt || window.event;
    if(evt.propertyName === 'title' && document.title !== originalTitle) {
    	if(document.title.indexOf("#")>=0){
	        setTimeout(function () {
	           document.title = document.title.split("#")[0];
	        }, 1);
    	}
    }
});