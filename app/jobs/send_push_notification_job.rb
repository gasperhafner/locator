class SendPushNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    last_location = Location.last

    city =
      City.get_by_location(
        last_location.latitude,
        last_location.longitude
      )

    return unless city

    if PushLog.last.city.id != city.id
      response =
        pushbullet_client.create(
          {
            body: "",
            email: "taty.pegla@gmail.com",
            title: "Moja trenutna lokacija: #{city.name}",
            url: "https://maps.google.com/?q=#{last_location.latitude},#{last_location.longitude}",
            type: "link"
          }
        )

      PushLog.create!(
        sender: response["sender_email"],
        receiver: response["receiver_email"],
        title: response["title"],
        url: response["url"],
        city: city
      )
    end
  end

  private

  def pushbullet_client
    Api::Pushbullet::Push.new(access_token: ENV.fetch("BULLETPUSH_TOKEN"))
  end
end
