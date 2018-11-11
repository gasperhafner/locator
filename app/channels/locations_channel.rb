class LocationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "locations_#{params[:stream_token]}"
  end
end

