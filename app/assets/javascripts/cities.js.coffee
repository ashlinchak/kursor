jQuery ->

  cities = $('select[id$=_city_id]').html()

  $('#region_id').change ->
    region = $('#region_id :selected').text()
    escaped_region = region.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cities).filter("optgroup[label='#{escaped_region}']").html()
    if options
      $('select[id$=_city_id]').html(options)
      $('select[id$=_city_id]').parent().show()
    else
      $('select[id$=_city_id]').html(cities)
      $('select[id$=_city_id]').parent().show()
