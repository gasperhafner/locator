class SendPushNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.where.not(pushbullet_token: nil).each do |user|
      @last_location = user.locations.last

      @city =
        user.cities.get_by_location(
          @last_location.latitude,
          @last_location.longitude
        )

      next unless @city

      if user.push_logs.any?
        send_push_notifications(user) if user.push_logs.last.city.id != @city.id
      else
        send_push_notifications(user)
      end
    end
  end

  private

  def send_push_notifications(user)
    pushbullet_client =
      pushbullet_client(user.pushbullet_token)

    user.recipient.split(",").each do |recipient|
      response =
        pushbullet_client.create(
          {
            body: "",
            email: recipient,
            title: "My current location: #{@city.name}",
            url: "https://maps.google.com/?q=#{@last_location.latitude},#{@last_location.longitude}",
            type: "link"
          }
        )

      user.push_logs.create!(
        sender: response["sender_email"],
        receiver: response["receiver_email"],
        title: response["title"],
        url: response["url"],
        city: @city
      )
    end
  end

  def pushbullet_client(access_token)
    Api::Pushbullet::Push.new(access_token: access_token)
  end
end
