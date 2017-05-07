/**
 * js实现水印功能
 * @param root
 */
(function (root) {
	root.placeholderFactory=function(){//这里可以用this.placeholderFactory定义
		this.txtColor="#A0A0A0";/*水印文字颜色*/  //这里定义的属性或方法都是唯一的,this.txtColor就是指的下面console.log('11')中的东西
		this.txtColorClick = '#000000';
		//console.log('22',this);
	};
	
	//console.log('11', new placeholderFactory()); 在这里new一个placehoderFactory()相当于在rootplaceholderFactory里面的console.log（'22',this）,this指的就是这个对象
	
	/**
	 * 创建水印
	 * nodes ：需要添加水印的元素
	 */
	placeholderFactory.prototype.createPlaceholder = function(nodes) {
		var _this = this;//这里的this是最大的那一级this就是window
		
		for (var i = 0; i < nodes.length; i++) {//参数是input或者textarea
			var self = nodes[i];
			var ph = self.getAttribute('placeholder');//拿到某一个input或者textarea的placeholder属性
			if (ph) {//如果有水印
				self.onfocus = function() {//输入框或textarea获得焦点的方法
					//console.log('gg',this);这里的this就是input或者textarea这个对象，因为是在这个对象的方法中
					if (this.value == this.getAttribute('placeholder')) {
						this.value = '';
					}
					this.style.color = _this.txtColorClick;

					
				}
				self.onblur = function() {
					if (this.value == '') {
						this.value = this.getAttribute('placeholder');
						this.style.color = _this.txtColor;
					}
				}
				if(self.value == self.getAttribute('placeholder')||self.value==null || self.value==""){//初始化查询输入框或者多行文本框是否有值，没有就赋值为水印的颜色和值
					self.value=ph;
					self.style.color = this.txtColor;
				}else{//有的话就赋值黑色
					self.style.color = this.txtColorClick;
				}
				
			}
		}
	}

})(this);//这里的this为window也可以传别的值类似document等




