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
//= require jquery-star-rating
//= require_tree .

$(document).ready(function(){

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
      easingType: 'easeInOutQuart'
    });
//


// UI

    $('.datepicker').datepicker({
        changeYear: true,
        changeMonth: true
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
        data : sortedItems//,
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
}



