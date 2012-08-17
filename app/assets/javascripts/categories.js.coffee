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
  cities = $('#filter_city_id').html()
  filter_cities_select(cities)

  $('#filter_region_id').change ->
    filter_cities_select(cities)


filter_cities_select = (cities) ->
  region = $('#filter_region_id :selected').text()
  escaped_region = region.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
  options = $(cities).filter("optgroup[label='#{escaped_region}']").html()
  if options
    $('#filter_city_id').html(options)
    $('#filter_city_id').prepend('<option value="">выберите город</option>')

  else
    $('#filter_city_id').html(cities).val('')

show_categories = (parent) ->
  category = $('#child-of-' + $(parent).val())
  $('.provider-category').hide()
  category.show()

show_sub_categories = (parent) ->
  category_id = $(parent).val()
  if ( $(parent).is('input:checked') )
    $('#sub-children-of-' + category_id).slideDown()
  else
    $('#sub-children-of-' + category_id).find(':checkbox:checked').prop('checked', false)
    $('#sub-children-of-' + category_id).slideUp()

