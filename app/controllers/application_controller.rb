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
end
