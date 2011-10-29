# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".tipsy_tooltip").twipsy()
  # move footer to bottom if page is too short
  body_height = $("body").height()
  window_height = $(window).height()
  wrapper = $("body div.wrapper")
  if window_height > body_height
    diff = window_height - body_height
    wrapper.height wrapper.height + diff
    console.log "increased wrapper by ", diff
  
