class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    query = params['query']
    @activities = current_user.activities
    @activities = @activities.where('lower(name) LIKE ?', "%#{query.downcase}%") if query
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
    @row_partial = 'layouts/editable_row'
    @locals = {item: @activity, attributes: [:name]}

    respond_to do |format|
      format.html {redirect_to 'index'}
      if @activity.save
        @message = "Added #{@activity.name}"
        format.js { render_updated_table(@activity, :add) }
      else
        format.js { render_updated_table(@activity, :error) }
      end
    end
  end

  def update
    @activity.update(activity_params)
    @message = "Updated #{@activity.name}"
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
