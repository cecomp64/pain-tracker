class PainPointsController < ApplicationController
  before_action :set_pain_point, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pain_points = PainPoint.all
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
    @pain_point.save
    respond_with(@pain_point)
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
      params.require(:pain_point).permit(:user_id, :magnitude, :notes, :location_id)
    end
end
