class PainPointsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pain_point, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  include PainPointsHelper

  def index
    @filter = params[:filter] || {}
    @group = params[:group]

    # Get actual DateTime objects from strings
    @filter[:min_date] = str_to_date(@filter[:min_date]) if(@filter[:min_date])
    @filter[:max_date] = str_to_date(@filter[:max_date]) if(@filter[:max_date])

    @pain_points = current_user.pain_points.includes(:activity).filter(@filter)
    @pain_points_paginated = @pain_points.order(date: :desc).page(params[:page]).per(10)
    @activities = @filter[:activity] ? @filter[:activity][:name] || [] : []
    @locations = @filter[:location] ? @filter[:location][:name] || [] : []

    min_point = current_user.pain_points.order(date: :asc).first
    max_point = current_user.pain_points.order(date: :asc).last

    # Give some padding just because <= doesn't seem to be equal...
    @filter[:min_date] ||= min_point ? min_point.date - 1.minute : DateTime.now
    @filter[:max_date] ||= max_point ? max_point.date + 1.minute : DateTime.now

    respond_to do |format|
      format.html { }
      format.js { }
    end
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

    respond_to do |format|
      format.html do
        if @pain_point.errors.any?
          render :edit
          #redirect_to edit_pain_point_path(@pain_point)
          return
        else
          flash[:success] = 'Updated PainPoint'
          redirect_to pain_points_path
          return
        end
      end
    end

    #respond_with(@pain_point)
    #respond_with(@pain_point, location: pain_points_path)
  end

  def destroy
    @pain_point.destroy
    respond_with(@pain_point)
  end

  def cleanup_data
    remove_duplicates Activity
    remove_duplicates Location
    redirect_to pain_points_path
  end

  def tag_list
    @params = params[:tag_list]
    @params[:list] ||= []
    @class = @params[:name] ? @params[:name].capitalize.constantize : nil
    # Check that the item actually exists
    @object = @class.where(name: @params[:tag]).first if @class
    # Don't add duplicate tags
    @object = nil if(@params[:list].map{|v| v}.include?(@params[:tag]))
  end

  private

    # Merge activities and locations that only differ in whitespace
    # TODO: Also look for case-insensitive matches
    def remove_duplicates(classname)
      duplicates = []
      symbol = classname.to_s.downcase.to_sym
      # Strip out all the white space
      classname.all.each{|a| a.update_attribute :name, a.name.strip}
      # Now look for duplicates
      classname.all.each{|a| duplicates += classname.where("name ILIKE '#{a.name.strip}'").where.not(id: a.id).map{|a| a.name.strip.upcase}.uniq}

      # Loop through each duplicate and replace with first instance
      duplicates.uniq.each do |dname|
        al = classname.where("name ILIKE '#{dname}'").to_a
        next if al.size == 0
        master = al.delete(al.first)

        # Replace existing references to duplicates with master
        al.each do |act|
          ppl = PainPoint.where(symbol => act)
          ppl.each{|pp| pp.update_attribute(:activity, master)}
          act.destroy
        end
      end
    end

    def set_pain_point
      @pain_point = PainPoint.find(params[:id])
    end

    def pain_point_params
      pl = params.require(:pain_point).permit(:user_id, :magnitude, :notes, :location_id, :date, :activity, :location)
      pl['activity'] = Activity.find_or_create_by(name: params[:activity].strip, user: current_user)
      pl['location'] = Location.find_or_create_by(name: params[:location].strip)
      return pl
    end

end
