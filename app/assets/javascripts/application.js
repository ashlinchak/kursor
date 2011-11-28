// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){

  // TODO: refactor this method to prevent categories unchecking
  $('.provider-categories input[type=radio]').click(function(){
    var category = $(this).closest('.provider-categories').find('.provider-category');
    category.removeClass('active');
    category.find('.field input:checked').attr('checked', false);
    $(this).closest('.provider-category').addClass('active');
  });

  $('.select-city').bind('click change keyup blur load', function(){
    if ( $(this).val() == '' ){
      $('.custom-city').show();
    } else {
      $('.custom-city').hide();
    }

  });

});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".field").fadeOut();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

