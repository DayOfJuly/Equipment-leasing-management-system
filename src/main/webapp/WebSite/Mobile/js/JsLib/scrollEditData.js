/** 滑动删除数据 (引用了jquery.mobile-1.4.5.js , jquery.mobile-1.4.5.css)
 * var sdf = new scrollEditFactory(); 创建对象
 * sdf.clickItem=function(){...}; 编写点击一行数据的具体函数 
 * sdf.deleteData=function(){...}; 编写删除数据的具体函数 
 * sdf.scrollListener(); 开启滑动删除监听
 * @param root
 * @param doc
 */
(function(root,doc){
	
	root.scrollEditFactory=function(){
		this.point;
	};
	
	scrollEditFactory.prototype.scrollListener=function(obj){
		var _this = this;
		$('.swipe-delete li > a')
		.on('touchstart', function(e) {
            $('.swipe-delete li > a').css('left', '0px'); // close em all
            $(e.currentTarget).addClass('open');
            _this.point = e.originalEvent.targetTouches[0].pageX; // anchor point
        })
        .on('touchmove', function(e) {
            var change = e.originalEvent.targetTouches[0].pageX - _this.point;
            change = Math.min(Math.max(-100, change), 0); // restrict to -100px left, 0px right
            if(change < -10){
            	e.currentTarget.style.left = -136 + 'px';
            }else{
            	e.currentTarget.style.left = 0 + 'px';
            }
        })
        .on('touchend', function(e) {
        	e.currentTarget.style.left = 0 + 'px';
        	_this.clickItem.call(obj);//点击事件接口
        });
		
		$('li .delete-btn').on('touchend', function(e) {
			_this.deleteData.call(obj);//删除事件接口
	    });
		$('li .edit-btn').on('touchend', function(e) {
			_this.editData.call(obj);//编辑事件接口
	    });
		
	};
	
	
})(window,document);
