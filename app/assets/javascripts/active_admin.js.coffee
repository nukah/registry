#= require active_admin/base
$(document).ready ->
  $('a[disabled=disabled]').click (event)->
    event.preventDefault()
    return
  return