$(document).ready(function(){
	resizeBackground();
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