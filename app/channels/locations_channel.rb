class LocationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "locations"
  end
end

