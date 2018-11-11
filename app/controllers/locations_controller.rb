class LocationsController < ApplicationController
  before_action :authenticate!, only: [:index]
  layout :resolve_layout

  def index
    @date = params[:date].present? ? Date.iso8601(params[:date]) : Date.today
    @locations = current_user.locations.by_date(@date)
  end

  def live
    redirect unless params[:stream_token].present?
    user = User.find_by(stream_token: params[:stream_token])
    redirect unless user.present?
  end

  private

  def redirect
    redirect_to root_path, alert: "Non valid stream token!"
  end

  def resolve_layout
    action_name == "live" ? "live" : "application"
  end
end
