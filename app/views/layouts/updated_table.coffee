# Clear any errors

<% if @action == :delete %>
$('#<%=@item.id%>').remove()
<% elsif @action == :add && @row_partial%>
$('#editable_table').append('<%= j render partial: @row_partial, locals: @locals%>')
<% end %>

# Highlight the updated rows
<% if @action == :add || @action == :update %>
$('#<%=@item.id%>').find('td').each (i, obj)->
  $(obj).addClass('updated-row')
<% end %>

# Show any errors
<% if (@action == :error) %>
$('#errors').html('<%= j render(partial: 'layouts/error', locals: {errors: @item.errors})%>')
<% else %>
$('#errors').html('<%= j render(partial: 'layouts/success', locals: {message: @message})%>')
<% end %>
