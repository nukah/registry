# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".panel-heading").click ->
    $(this).parent().children(".panel-body").toggle()
    checkbox = $(this).find("input")[0]
    checkbox.checked = !checkbox.checked

  # $(".controls button").click (ev) ->
  #   ev.preventDefault()

  $(".controls button[id=submit]").click (ev) ->

  $(".controls button[id=cancel]").click (ev) ->
    $("form[role=form]")[0].reset()