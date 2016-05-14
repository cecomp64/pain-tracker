class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_updated_table(item, action = :add)
    @item = item
    @action = action
    render 'layouts/updated_table'
  end
end
