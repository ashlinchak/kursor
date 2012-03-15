jQuery ->
  $('input.category-sub-parent').each ->
    show_sub_categories(@)
    $(@).bind 'change', ->
      show_sub_categories(@)

  $('.provider-categories select').bind('click change keyup blur', ->
    show_categories(@)
  )
  show_categories($('.provider-categories select'))

show_categories = (parent) ->
  category = $('#child-of-' + $(parent).val())
  #$('.provider-category').removeClass('active')
  #category.addClass('active')
  $('.provider-category').hide()
  category.show()


show_sub_categories = (parent) ->
  category_id = $(parent).val()
  if ( $(parent).is('input:checked') )
    $('#sub-children-of-' + category_id).slideDown()
  else
    $('#sub-children-of-' + category_id).find(':checkbox:checked').prop('checked', false);
    $('#sub-children-of-' + category_id).slideUp()
