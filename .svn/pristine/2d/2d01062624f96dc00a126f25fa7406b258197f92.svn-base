var timeout         = 1;
var closetimer		= 0;
var ddmenuitem      = 0;

function jsddm_open()
{	jsddm_canceltimer();
	jsddm_close();
	/*if(initShow){
		initShow.removeClass("baidi");
	}*/
	ddmenuitem = $(this).find('ul').eq(0).css('visibility', 'visible');}

function jsddm_close()
{	/*if(initShow){
		initShow.addClass("baidi");
	}*/
	if(ddmenuitem) ddmenuitem.css('visibility', 'hidden');}

function jsddm_timer()
{	
	closetimer = window.setTimeout(jsddm_close, timeout);}

function jsddm_canceltimer()
{	if(closetimer)
	{	window.clearTimeout(closetimer);
		closetimer = null;}}

$(document).ready(function()
{	
	$('#jsddm > li').bind('mouseover', jsddm_open);
	$('#jsddm > li').bind('mouseout',  jsddm_timer);
	/**/
	});

document.onclick = jsddm_close;
function changebg1(menuId){
	var menus=document.getElementById("ihha").getElementsByTagName("li");
	var menus1=document.getElementById("ihha1").getElementsByTagName("ul"); 
	for(i=0;i<menus.length;i++){
		if(menus[i].id==menuId){
			menus[i].className='lanbg';
		}else{
			menus[i].className='';
		}

	}
	
	for(i=0;i<menus1.length;i++){
		if(menus1[i].id==menuId+1){
			menus1[i].style.display='block';
		}else{
			menus1[i].style.display='none';
		}

	}
}
function changebg2(menuId){
	var menus=document.getElementById("tt").getElementsByTagName("li");
	for(i=0;i<menus.length;i++){
		if(menus[i].id==menuId){
			menus[i].className='lefthui';
		}else{
			menus[i].className='';
		}

	}

}
function changebg21(menuId){
	var menus=document.getElementById("ttt").getElementsByTagName("li");
	var menus1=document.getElementById("nirt").getElementsByTagName("ul"); 
	for(i=0;i<menus.length;i++){
		if(menus[i].id==menuId){
			menus[i].className='lefthui';
		}else{
			menus[i].className='';
		}

	}
	
	for(i=0;i<menus1.length;i++){
		if(menus1[i].id==menuId+1){
			menus1[i].style.display='block';
		}else{
			menus1[i].style.display='none';
		}

	}
}
function changebg3(menuId){
	var menus=document.getElementById("jx").getElementsByTagName("li");
	var menus1=document.getElementById("jxsb").getElementsByTagName("ul"); 
	for(i=0;i<menus.length;i++){
		if(menus[i].id==menuId){
			menus[i].className='leftred';
		}else{
			menus[i].className='';
		}

	}
	
	for(i=0;i<menus1.length;i++){
		if(menus1[i].id==menuId+1){
			menus1[i].style.display='block';
		}else{
			menus1[i].style.display='none';
		}

	}
}
function changebg4(menuId){
	var menus=document.getElementById("smcp").getElementsByTagName("li");
	var menus1=document.getElementById("smnr").getElementsByTagName("ul"); 
	for(i=0;i<menus.length;i++){
		if(menus[i].id==menuId){
			menus[i].className='leftchen_a';
		}else{
			menus[i].className='';
		}

	}
	
	for(i=0;i<menus1.length;i++){
		if(menus1[i].id==menuId+1){
			menus1[i].style.display='block';
		}else{
			menus1[i].style.display='none';
		}

	}
}