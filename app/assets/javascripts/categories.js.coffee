jQuery ->
  $('.provider-categories select').bind('click change keyup blur', ->
    show_sub_categories(@)
  )

  $('.provider-categories select').bind('click change keyup blur', ->
    show_categories(@)
  )
  show_categories($('.provider-categories select'))

  $('input.category-sub-parent').each ->
    show_sub_categories(@)

  $('.category-sub-parent').change ->
    show_sub_categories(@)

show_categories = (parent) ->
  category = $("#child-of-" + $(parent).val())
  $('.provider-category').removeClass('active')
  category.addClass('active')


show_sub_categories = (parent) ->
  category_id = $(parent).val()
  if ( $(parent).is('input:checked') )
    $('#sub-children-of-' + category_id).slideDown()
  else
    $('#sub-children-of-' + category_id).slideUp()

#function show_categories(parent) {
  #var category = $("#child-of-" + $(parent).val());
  #$('.provider-category').removeClass('active');
  #category.addClass('active');
#}


#function show_sub_categories(parent){
  #var category_id = $(parent).val();
  #if ( $(parent).is('input:checked') ) {
    #$('#sub-children-of-' + category_id).slideDown();
  #} else {
    #$('#sub-children-of-' + category_id).slideUp();
  #}
#}
