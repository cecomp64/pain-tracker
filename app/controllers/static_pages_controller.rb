class StaticPagesController < ApplicationController
  def home
    @pain_points = current_user.pain_points
    @num_days = 7
    @num_weeks = 4
    @num_months = 12
    respond_to do |format|
        format.html { render :home}
    end
  end
end
