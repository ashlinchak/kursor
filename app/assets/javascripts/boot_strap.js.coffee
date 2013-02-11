jQuery ->

  $(".collapse").collapse()

  $("a[rel=popover]").popover({
    trigger: 'hover'
  })

  $("#popover").popover()

  $("a[rel=tooltip]").tooltip()

  $(".collapse").collapse({ toggle: true })

  $('#register-dialog').modal({
    keyboard: true,
    show: false
  })

  $(".tooltip").tooltip()

  $('.nav-tabs').button()

  $('.typeahead').typeahead()



