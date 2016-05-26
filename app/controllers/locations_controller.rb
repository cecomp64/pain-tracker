class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @locations = Location.all
    respond_with(@locations)
  end

  def show
    respond_with(@location)
  end

  def new
    @location = Location.new
    respond_with(@location)
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      format.html {redirect_to 'index'}
      if @location.save
        @message = "Added #{@location.name}"
        format.js { render_updated_table(item: @location, action: :add, row_partial: 'layouts/editable_row') }
      else
        format.js { render_updated_table(item: @location, action: :error) }
      end
    end
  end

  def update
    @location.update(location_params)
    @message = "Updated #{@location.name}"
    respond_to do |format|
      format.html {render 'index'}
      format.js { render_updated_table(item: @location, action: :update) }
    end
  end

  def destroy
    @location.destroy
    respond_with(@location)
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      lp = params.require(:location).permit(:name, :area_id, :x_pos, :y_pos, :z_pos)
      lp[:name] = lp[:name].strip if(lp[:name])
      return lp
    end
end
