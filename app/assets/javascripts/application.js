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

  $('html').removeClass('no-js');

  $('.provider-categories select').bind('click change keyup blur', function(){
    show_sub_categories(this);
  });
  show_sub_categories($('.provider-categories select'));

  $('.select-city').bind('click change keyup blur load', function(){
    if ( $(this).val() == '' ){
      $('.custom-city').show();
    } else {
      $('.custom-city').hide().val('');
    }

  });

});

function show_sub_categories(parent) {
  var category = $("#child-of-" + $(parent).val());
  $('.provider-category').removeClass('active');
  category.addClass('active');
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").fadeOut();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

