<% if @params[:action] == 'add' %>
# Show the newly added activity
$('#<%=@params[:name]%>-list').append('
  <%= link_to tag_list_path(tag_list: {action: 'remove', tag: @params[:tag], name: @params[:name]}), method: :post, class: "btn btn-primary", data: {tag: @params[:tag]}, remote: true do %>
  <span class="glyphicon glyphicon-remove"></span>
  <%= @params[:tag] %>
  <% end %>
')
# Update the form
$('#<%=@params[:name]%>-list').append('<%= hidden_field_tag "tags[#{@params[:list].size}]", @params[:tag], data: {tag: @params[:tag]} %>')
$('#<%=@params[:name]%>-form').append('<%= hidden_field_tag "tag_list[list][#{@params[:list].size}]", @params[:tag], data: {tag: @params[:tag]} %>')

<% elsif @params[:action] == 'remove' %>
# Remove the key display
$('#<%=@params[:name]%>-list').find('a[data-tag="<%=@params[:tag]%>"]').each (i,obj) ->
  $(obj).remove()

# Remove the key form elements
$('#<%=@params[:name]%>-list').find('input[data-tag="<%=@params[:tag]%>"]').each (i,obj) ->
  $(obj).remove()

# Don't remove it from the form so we can keep incrementing our count
<% end %>
