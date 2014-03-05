#= require active_admin/base
$(document).ready ->
  $('a[disabled=disabled]').click (event)->
    event.preventDefault()
    return
  # Загрузка доступных этажей для здания (Создание нового помещения)
  $('#room_building').change ->
    $.ajax '/admin/levels/building_levels',
      type: 'GET'
      dataType: 'json'
      data: {
        'building_id': this.value
      }
      success: (data, status, xhr) ->
        $("#room_level_id").children().remove()
        for k,v of data
          $("#room_level_id").append $("<option value=#{v}>#{k}</option>")