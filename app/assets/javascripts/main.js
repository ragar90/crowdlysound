$(document).ready(function(){
	resizeBackground();
	var pre = ('animation');
	pre.replace(/([A-Z])/g, function(str,m1){ return '-' + m1.toLowerCase(); }).replace(/^ms-/,'-ms-');

	for(var i=0;i< $('ul#music_notes li').length;i++) {
	    var x = $('ul#music_notes li')[i];
	  $(x).css(pre,'music 3s '+i+'00ms  ease-in-out both infinite');
	  $(x).addClass("element_"+i)
	}
});

$(window).resize(function(){
	resizeBackground();
})

function resizeBackground(){
	width_page = $(window).width();
	heigth_page = $(window).height();
	if (width_page < 980) {
		width_page:980
	};
	$("div.landing_page_master").css({
		height: heigth_page
	})
	$("div.landing_page_master").css({
		height: heigth_page,
		width: width_page
	})
}