class LocationsController < ApplicationController
  before_action :authenticate!, only: [:index]
  layout :resolve_layout

  def index
    @date = params[:date].present? ? Date.iso8601(params[:date]) : Date.today
    @locations = current_user.locations.by_date(@date)
  end

  def live
    @latitude = params[:latitude].present? ? params[:latitude] : 46.167124
    @longitude = params[:longitude].present? ? params[:longitude] : 14.306264
  end

  private

  def resolve_layout
    action_name == "live" ? "live" : "application"
  end
end
