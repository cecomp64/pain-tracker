require 'upload_helper'

class StaticPagesController < ApplicationController
  def home
    @pain_points = current_user.pain_points
    @charts = {days: 7, weeks: 4, months: 12}

    respond_to do |format|
        format.html { render :home}
    end
  end

  def upload
    file = params[:file]
    user = User.find_by(id: params[:user_id]) || current_user

    if(file.nil?)
      flash[:error] = 'No file provided to upload'
      redirect_to root_path
      return
    end

    # Try to upload pain points in spreadsheet
    all_pain_points = UploadHelper.pain_points_csv(file.path, user)

    if(all_pain_points.is_a?(Hash))
      flash[:error] = all_pain_points[:errors].join('.  ')
      redirect_to pain_points_path
      return
    end

    @pain_points = all_pain_points.select{|pp| !pp.errors.any?}
    @errors = all_pain_points.select{|pp| pp.errors.any?}
    if(@errors.size > 0)
      flash[:error] = @errors.map{|pp| "#{pp.date} - #{pp.errors.full_messages.join('.  ')}"}.join('  ')
    end

    render 'pain_points/index'
  end
end
