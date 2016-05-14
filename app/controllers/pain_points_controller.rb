class PainPointsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pain_point, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pain_points = current_user.pain_points
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
    values = pain_point_params
    act_str = values.delete('activity')
    @pain_point = PainPoint.new(values)
    @pain_point.activity = Activity.where(name: act_str).first
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
      params.require(:pain_point).permit(:user_id, :magnitude, :notes, :location_id, :date, :activity)
    end
end
