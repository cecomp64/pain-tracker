class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @activities = current_user.activities
    respond_with(@activities)
  end

  def show
    respond_with(@activity)
  end

  def new
    @activity = Activity.new
    respond_with(@activity)
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    @activity.save
    @row_partial = 'activities/index_row'
    respond_to do |format|
      format.html {redirect_to 'index'}
      format.js { render_updated_table(@activity, :add) }
    end
  end

  def update
    @activity.update(activity_params)
    respond_to do |format|
      format.html {render 'index'}
      format.js { render_updated_table(@activity, :update) }
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html {render 'index'}
      format.js { render_updated_table(@activity, :delete) }
    end
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:name)
    end
end
