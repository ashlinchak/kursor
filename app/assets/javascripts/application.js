// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap

//= require jquery.markitup
//= require sets/default/set
//= require_tree .

  $(document).ready(function(){

  $('html').removeClass('no-js');


  $("textarea.show_editor").markItUp(mySettings);

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
  $(link).closest("fieldset").fadeOut();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}