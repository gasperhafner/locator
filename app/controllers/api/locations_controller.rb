class Api::LocationsController < ActionController::API

  def create
    location = Location.create!(
      latitude: params[:lat],
      longitude: params[:lon],
      speed: params[:speed],
      time: params[:time],
      provider: params[:provider],
      battery: params[:battery]
    )

    render json: location, status: :ok
  end

  def current
    last_location = Location.last

    city =
      City.get_by_location(
        last_location.latitude,
        last_location.longitude
      )

    render json: {last_location: city.name}, status: :ok
  end

  def push_notification
    SendPushNotificationJob.perform_later
    render json: {}, status: :ok
  end
end
