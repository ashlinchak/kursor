jQuery ->
  $('input.category-sub-parent').each ->
    show_sub_categories(@)
    $(@).bind 'change', ->
      show_sub_categories(@)

  $('.provider-categories select').bind('click change keyup blur', ->
    show_categories(@)
  )
  show_categories($('.provider-categories select'))

  # search form

  cities = $('#search_city_id').html()

#  $('#search_city_id').empty()

  $('#search_region_id').change ->
    region = $('#search_region_id :selected').text()
    escaped_region = region.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cities).filter("optgroup[label='#{escaped_region}']").html()
    if options
      $('#search_city_id').html(options)
      $('#search_city_id').prepend('<option value="">выберите город</option>')
      $('#search_city_id').parent().show()

    else
#      $('#search_city_id').html(cities)
#      $('#search_city_id').prepend('<option value="">выберите город</option>')
#      $('#search_city_id').parent().show()
      $('#search_city_id').empty()


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



