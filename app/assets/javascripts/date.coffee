
load_date_picker = ->
  console.log('Wuuut')
  #date = new Date()
  date = $('#datetimepicker12').data('date')
  console.log('Date: ' + date)

  $('#datetimepicker12').datetimepicker({
    inline: true,
    sideBySide: true,
    defaultDate: date
  })

  # Set initial value
  $('#datetimepicker_value').val(date)

  # Update value when date is changed
  $('#datetimepicker12').on("dp.change", (e) ->
    console.log('Date changed ' + e.date._d)
    $('#datetimepicker_value').val(e.date._d)
  )



$(document).ready(load_date_picker)
$(document).on('page:load', load_date_picker)
