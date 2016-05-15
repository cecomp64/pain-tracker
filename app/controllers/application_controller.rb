class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_updated_table(options={})
    @item = options[:item]
    @action = options[:action]
    @locals ||= {item: @item, attributes: [:name]}
    render 'layouts/updated_table'
  end

  # filter
  #
  # Use the input active record query, and append a filter to it based on the filters present in params
  def filter(query)
    filters = params['filter']
    return query if filters.nil?
    filtered_query = query
    filters.each do |field, value|
      parsed_value = value == '' ? nil : value
      filtered_query = filtered_query.where(field => parsed_value)
    end

    @filters = filters
    return filtered_query
  end
end
