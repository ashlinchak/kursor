jQuery ->

  $(".collapse").collapse()

  $("a[rel=popover]").popover()

  $("#popover").popover()

  $("a[rel=tooltip]").tooltip()

  $(".collapse").collapse({ toggle: true })

  $('#register-dialog').modal({
    keyboard: true,
    show: false
  })

  $(".tooltip").tooltip()

  $('.nav-tabs').button()

  #$('.typeahead').typeahead()

  $(".sign_in_with_provider").popover({
    trigger: 'hover',
    placement: 'top',
    delay: 500
  })


