# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.random-password').click ->
    username = $('input[name=current_user]').val()
    date = new Date()
    time = date.getTime()
    $('input#user_password, input#user_password_confirmation').val( time )