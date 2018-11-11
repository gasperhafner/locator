class Api::V1::LocationsController < Api::V1::BaseController
  before_action :find_user

  def create
    location =
      @user.locations.create!(
        latitude: params[:lat],
        longitude: params[:lon],
        speed: params[:speed],
        time: params[:time],
        provider: params[:provider],
        battery: params[:battery]
      )

    stream_location(params[:lat], params[:lon]) if @user.stream_location?

    render json: location, status: :ok
  end

  def current
    last_location = @user.locations.last

    unless last_location.present?
      render json: {last_location: "unkown"}, status: :ok
      return
    end

    city =
      @user.cities.get_by_location(
        last_location.latitude,
        last_location.longitude
      )

    render json: {last_location: city.name}, status: :ok
  end

  private

  def stream_location(latitude, longitude)
    ActionCable.server.broadcast "locations_#{@user.stream_token}",
                                 latitude: latitude,
                                 longitude: longitude
  end

  def find_user
    raise ApiExceptions::GpsTokenError::MissingGpsTokenError unless request.headers['GPS-token'].present?

    gps_token = request.headers['GPS-token'].split(":").last
    @user = User.find_by(gps_token: gps_token)

    raise ApiExceptions::GpsTokenError::WrongGpsTokenError unless @user
  end
end
