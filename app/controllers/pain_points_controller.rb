class PainPointsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pain_point, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pain_points = filter current_user.pain_points.order(:date).includes(:activity)
    respond_with(@pain_points)
  end

  def show
    respond_with(@pain_point)
  end

  def new
    @pain_point = PainPoint.new
    respond_with(@pain_point)
  end

  def edit
  end

  def create
    @pain_point = PainPoint.new(pain_point_params)
    @pain_point.user = current_user
    if @pain_point.save
      flash[:success] = 'Added new PainPoint'
    end

    respond_with(@pain_point, location: pain_points_path)
  end

  def update
    @pain_point.update(pain_point_params)
    respond_with(@pain_point)
  end

  def destroy
    @pain_point.destroy
    respond_with(@pain_point)
  end

  private
    def set_pain_point
      @pain_point = PainPoint.find(params[:id])
    end

    def pain_point_params
      pl = params.require(:pain_point).permit(:user_id, :magnitude, :notes, :location_id, :date, :activity, :location)
      pl['activity'] = Activity.find_or_create_by(name: pl[:activity])
      pl['location'] = Location.find_or_create_by(name: pl[:location])
      return pl
    end

end
