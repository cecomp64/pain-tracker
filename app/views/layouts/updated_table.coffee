<% if @action == :delete %>
$('#<%=@item.id%>').remove
<% elsif @action == :add && @row_partial%>
$('#editable_table').append('<%= render @row_partial%>')
<% else %>
$('#<%=@item.id%>').find('td').each (i, obj)->
  $(obj).addClass('updated-row')
<% end %>
