/**
 * 滑动到底部加载数据
 * var sf = new scrollFactory(); 创建对象
 * sf.loadData=function(){...}; 编写加载数据的具体函数 
 * sf.scrollListener(); 开启滑动监听
 * @param root
 * @param doc
 */
(function(root,doc){
	
	root.scrollFactory=function(){
		
	};
	
	/**
	 * 监听是否滑动到最底部
	 * @param obj
	 */
	scrollFactory.prototype.scrollListener=function(obj){
		var _this = this;
		$(root).scroll(function(){
			//$(root).scrollTop() 网页被卷去的高
			//$(root).height() 浏览器当前窗口可视区域高度
			//$(doc).height() 浏览器当前窗口文档的高度
			if($(root).scrollTop()+$(root).height()>=$(doc).height()){
				_this.loadData.call(obj);
			}
		});
	};
	
	
})(window,document);
