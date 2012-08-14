// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-ru
//= require twitter/bootstrap
//= require ckeditor/init
//= require jqcloud
//= require ios-checkboxes
//= require jquery-star-rating
//= require_tree .

$(document).ready(function(){


//  IPhone
    $('.iphone_check_box').iphoneStyle({
        checkedLabel: 'Есть',
        uncheckedLabel: 'Нет'
    });

// Rating

    $('input.rating_star').rating({
        required: true,
        callback: function(value, link){
            var url = $('form.rating_form').attr( 'action' );
            $('form.rating_form').fadeOut();
            $.post(url, { value: value }, function(data) {
                $('form.rating_form').html(data).fadeIn();
            });
            $('input.rating_star').rating('readOnly', true);
        }
    });

    $('input.read_only_star').rating({
            readOnly: true
    });

// LazyLoad // Image Smart Loading
    $('img').show().lazyload({
        effect: 'fadeIn',
        easingType: 'easeInOutQuart',
        effectspeed: 1000
    });

// Scroll To Top Button
    $().UItoTop({
      easingType: 'easeOutQuart'
    });
//

// FlexSlider

    $(window).load(function() {
        $('.flexslider').flexslider({
            animation: "fade",              //String: Select your animation type, "fade" or "slide"
            easing: "swing",               //{NEW} String: Determines the easing method used in jQuery transitions. jQuery easing plugin is supported!
            direction: "horizontal",        //String: Select the sliding direction, "horizontal" or "vertical"
            reverse: false,                 //{NEW} Boolean: Reverse the animation direction
            animationLoop: true,             //Boolean: Should the animation loop? If false, directionNav will received "disable" classes at either end
            smoothHeight: true,            //{NEW} Boolean: Allow height of the slider to animate smoothly in horizontal mode
            startAt: 0,                     //Integer: The slide that the slider should start on. Array notation (0 = first slide)
            slideshow: true,                //Boolean: Animate slider automatically
            slideshowSpeed: 10000,           //Integer: Set the speed of the slideshow cycling, in milliseconds
            animationSpeed: 600,            //Integer: Set the speed of animations, in milliseconds
            initDelay: 10000,                   //{NEW} Integer: Set an initialization delay, in milliseconds
            randomize: false,               //Boolean: Randomize slide order

// Usability features
            pauseOnAction: true,            //Boolean: Pause the slideshow when interacting with control elements, highly recommended.
            pauseOnHover: true,            //Boolean: Pause the slideshow when hovering over slider, then resume when no longer hovering
            useCSS: true,                   //{NEW} Boolean: Slider will use CSS3 transitions if available
            touch: true,                    //{NEW} Boolean: Allow touch swipe navigation of the slider on touch-enabled devices
            video: false,                   //{NEW} Boolean: If using video in the slider, will prevent CSS3 3D Transforms to avoid graphical glitches

// Primary Controls
            controlNav: true,               //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
            directionNav: true,             //Boolean: Create navigation for previous/next navigation? (true/false)
            prevText: "Пред.",           //String: Set the text for the "previous" directionNav item
            nextText: "След.",               //String: Set the text for the "next" directionNav item

// Secondary Navigation
            keyboard: true,                 //Boolean: Allow slider navigating via keyboard left/right keys
            multipleKeyboard: false,        //{NEW} Boolean: Allow keyboard navigation to affect multiple sliders. Default behavior cuts out keyboard navigation with more than one slider present.
            mousewheel: false,              //{UPDATED} Boolean: Requires jquery.mousewheel.js (https://github.com/brandonaaron/jquery-mousewheel) - Allows slider navigating via mousewheel
            pausePlay: false,               //Boolean: Create pause/play dynamic element
            pauseText: 'Пауза',             //String: Set the text for the "pause" pausePlay item
            playText: 'Пуск',               //String: Set the text for the "play" pausePlay item

// Special properties
            controlsContainer: "",          //{UPDATED} Selector: USE CLASS SELECTOR. Declare which container the navigation elements should be appended too. Default container is the FlexSlider element. Example use would be ".flexslider-container". Property is ignored if given element is not found.
            manualControls: ".flexslider-controls .item",             //Selector: Declare custom control navigation. Examples would be ".flex-control-nav li" or "#tabs-nav li img", etc. The number of elements in your controlNav should match the number of slides/tabs.
            sync: "",                       //{NEW} Selector: Mirror the actions performed on this slider with another slider. Use with care.
            asNavFor: "",                   //{NEW} Selector: Internal property exposed for turning the slider into a thumbnail navigation for another slider

// Carousel Options
            itemWidth: 0,                   //{NEW} Integer: Box-model width of individual carousel items, including horizontal borders and padding.
            itemMargin: 0,                  //{NEW} Integer: Margin between carousel items.
            minItems: 0,                    //{NEW} Integer: Minimum number of carousel items that should be visible. Items will resize fluidly when below this.
            maxItems: 0,                    //{NEW} Integer: Maxmimum number of carousel items that should be visible. Items will resize fluidly when above this limit.
            move: 0,                        //{NEW} Integer: Number of carousel items that should move on animation. If 0, slider will move all visible items.

        });
    });

// Gmaps show in tab fix
    $('#mapTab').on('shown', function (e) { google.maps.event.trigger(map, 'resize');})

// UI
    $('.datepicker').datepicker({
        changeYear: true,
        changeMonth: true,
        yearRange: "-70y:-14y"
    });

// Add caption to image from alt text in posting
  $('#postings #show .body img').jcaption({
      //Element to wrap the image and caption in
      wrapperElement: 'div',
      //Class for wrapper element
      wrapperClass: 'caption',
      //Caption Element
      captionElement: 'span',
      //Attribute of image to use as caption source
      imageAttr: 'alt',
      //If true, it checks to make sure there is caption copy before running on each image
      requireText: false,
      //Should inline style be copied from img element to wrapper
      copyStyle: true,
      //Strip inline style from image
      removeStyle: false,
      //Strip align attribute from image
      removeAlign: true,
      //Assign the value of the image's align attribute as a class to the wrapper
      copyAlignmentToClass: false,
      //Assign the value of the image's float value as a class to the wrapper
      copyFloatToClass: true,
      //Assign a width to the wrapper that matches the image
      autoWidth: true,
      //Animate on hover over the image
      animate: false,
      //Show Animation
      show: {opacity: 'show'},
      showDuration: 200,
      //Hide Animation
      hide: {opacity: 'hide'},
      hideDuration: 200
  });

  // JCloud

//    var word_array = [
//        {text: "Lorem", weight: 15},
//        {text: "Ipsum", weight: 9, link: "http://jquery.com/"},
//        {text: "Dolor", weight: 6, html: {title: "I can haz any html attribute"}},
//        {text: "Sit", weight: 7},
//        {text: "Amet", weight: 5}
//        // ...as many words as you want
//    ];
//
//
//    $("#tagCloudContainer").jQCloud(
//        word_array,
//        {
//            width: 140,
//            heigh: 200
//
//        }
//    );

  // Mosaic Caption Slider

    $('.bar').mosaic({
        animation : 'slide',
        animateEasing: 'easeInOutQuad',
        speed: 600,
        opacity : 0.8
      });

  // News Tabs Slider
    $('#coda-slider-1').codaSlider({
        dynamicArrows: false,
        autoSlide: true,
        dynamicTabsAlign: 'center',
        dynamicTabsPosition: 'bottom',
        slideEaseDuration: 2500
    });


  $('html').removeClass('no-js');


  //$('.provider-categories select').bind('click change keyup blur', function(){
    //show_categories(this);
  //});
  //show_categories($('.provider-categories select'));

  //$('input.category-sub-parent').each(function(){
    //show_sub_categories(this);
  //});

  //$('.category-sub-parent').change(function(){
    //show_sub_categories(this);
  //});


  $('.select-city').bind('click change keyup blur load', function(){
    if ( $(this).val() == '' ){
      $('.custom-city').show();
    } else {
      $('.custom-city').hide().val('');
    }

  });

  $('.sortable').sortable({
    axis : 'y',
    items : 'tr',
    containment : 'parent',
    handle: '.drag-handle',
    update : function(event, ui){
      var self = this;
      var sortedItems = $(self).sortable('serialize', { key: 'sorted-item[]' })
      console.log(sortedItems);
      $.ajax({
        url : '/admin/'+ $(ui.item).attr('class') +'s/sort',
        type: 'post',
        dataType: 'script',
        data : sortedItems
      });
    }
  });




});



//function show_categories(parent) {
  //var category = $("#child-of-" + $(parent).val());
  //$('.provider-category').removeClass('active');
  //category.addClass('active');
//}

//function show_sub_categories(parent){
  //var category_id = $(parent).val();
  //if ( $(parent).is('input:checked') ) {
    //$('#sub-children-of-' + category_id).slideDown();
  //} else {
    //$('#sub-children-of-' + category_id).slideUp();
  //}
//}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
//  $(link).closest("fieldset").fadeOut();
  $(link).closest(".control-group").fadeOut();
}

function remove_fieldset(link) {
  $(link).prev("input[type=hidden]").val("1");
//  $(link).closest("fieldset").fadeOut();
  $(link).closest("fieldset").fadeOut();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
    $('.iphone_check_box').iphoneStyle({
        checkedLabel: 'Есть',
        uncheckedLabel: 'Нет'
    });
}



