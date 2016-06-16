
load_date_picker = ->
  $('.datetimepicker').each (i, obj)->
    console.log('Wuuut')
    date = $(obj).data('date')
    console.log('Date: ' + date)

    $(obj).datetimepicker({
      inline: $(obj).data('inline'),
      sideBySide: true,
      defaultDate: date
    })

    # Set initial value
    $(obj).val(date)
    # TODO: Make this more generic
    $('#datetimepicker_value').val(date)

    # Update value when date is changed
    $(obj).on("dp.change", (e) ->
      console.log('Date changed ' + e.date._d)
      $(obj).val(e.date._d)
    )



$(document).ready(load_date_picker)
$(document).on('page:load', load_date_picker)
