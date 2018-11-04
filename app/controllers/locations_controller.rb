class LocationsController < ApplicationController
  before_action :authenticate!

  def index
    @date = params[:date].present? ? Date.iso8601(params[:date]) : Date.today
    @locations = current_user.locations.by_date(@date)
  end
end
