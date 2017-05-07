// JavaScript Document

$(document).ready(function(){

	// 弹出框
	$("#hq").click(function(){ 
		$("body,html").animate({scrollTop:0},300);
		$("#fade,#openwin2").show();
	});
	$(".close_openwin").click(function(){ 
		$("body,html").animate({scrollTop:0},300);
		$("#fade,#openwin,#openwin2,#openwin3,#openwin4,#download").hide();
	}); 


	
});
	