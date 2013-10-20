$slideshow = {
    context: false,
    tabs: false,
    timeout: 7500,      // time before next slide appears (in ms)
    slideSpeed: 3000,   // time it takes to slide in each slide (in ms)
    tabSpeed: 2000,      // time it takes to slide in each slide (in ms) when clicking through tabs
    fx: 'scrollLeft',   // the slide effect to use
	indexStarting:0,
    
    init: function(id,index) {
	
		if (typeof index != 'undefined') {
			this.indexStarting = index;
		}
		
        // set the context to help speed up selectors/improve performance
        this.context = $(id);
        
        // set tabs to current hard coded navigation items
        this.tabs = $('ul.slides-nav li', this.context);
        
        // remove hard coded navigation items from DOM 
        // because they aren't hooked up to jQuery cycle
        this.tabs.remove();
        
        // prepare slideshow and jQuery cycle tabs
        this.prepareSlideshow();
    },
    
    prepareSlideshow: function() {
        // initialise the jquery cycle plugin -
        // for information on the options set below go to: 
        // http://malsup.com/jquery/cycle/options.html
        $("div.navigator",$slideshow.context).show();

		var nextArrow = $('a.arrow.arrow_right',$slideshow.context),
			prevArrow = $('a.arrow.arrow_left',$slideshow.context),
			ulWidth = $slideshow.tabs.length*15,
			centerContext = $slideshow.context.width() / 2,
			op = (centerContext - (ulWidth/2))-25;
			
		$('a.sliderArrow.sliderNext','#homeSlider,#productSlider').css({right:op});
		$('a.sliderArrow.sliderPrev','#homeSlider,#productSlider').css({left:op});		
		
		
        $('div.slides > ul', $slideshow.context).cycle({
            fx: $slideshow.fx,
            timeout: $slideshow.timeout,
            speed: $slideshow.slideSpeed,
            fastOnEvent: $slideshow.tabSpeed,
            pager: $('ul.slides-nav', $slideshow.context),
            pagerAnchorBuilder: $slideshow.prepareTabs,
            before: $slideshow.activateTab,
            pauseOnPagerHover: true,
            pause: true,
			next: nextArrow, 
			prev: prevArrow,
			startingSlide: $slideshow.indexStarting,
            stop: true
        //});
        }).cycle('pause');
		
		$ulCont = $('ul.slides-nav', $slideshow.context);		
		$ulCont.css({width:(ulWidth),height:12});
		
		$('a.sliderArrow',$slideshow.context).click(function(){
			$('div.slides > ul', $slideshow.context).cycle('pause');
		})
		  
    },
    
    prepareTabs: function(i, slide) {
        // return markup from hardcoded tabs for use as jQuery cycle tabs
        // (attaches necessary jQuery cycle events to tabs)
        return $slideshow.tabs.eq(i);
    },

    activateTab: function(currentSlide, nextSlide) {
        // get the active tab
        var activeTab = $('a[href="#' + nextSlide.id + '"]', $slideshow.context);
        
        // if there is an active tab
        if(activeTab.length) {
            // remove active styling from all other tabs
            $slideshow.tabs.removeClass('on');
            
            // add active styling to active button
            activeTab.parent().addClass('on');
        }            
    }            
};


$(function() {
    // add a 'js' class to the body
    $('body').addClass('js');
    
    // initialise the slideshow when the DOM is ready    
});  