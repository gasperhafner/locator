class Functions::Users::Authorize < GraphQL::Function
  argument :serviceCountry, Types::ServiceCountryEnumType
  argument :email, !types.String

  type types.Boolean

  def call(obj, args, ctx)
    user = User.where('lower(email) = ?', args[:email].downcase).first

    if user.nil?
      user = User.create!(
        email: args[:email].downcase,
        source: ctx[:controller].request.headers["x-source"] || '',
        platform: ctx[:controller].request.headers["x-platform"] || ''
      )
    end

    user.regenerate_magic_link_token
    user.magic_link_token_expiration = Time.current + User::MAGIC_LINK_TOKEN_EXPIRATION

    if !user.service_country.present? && args[:serviceCountry].present?
      user.service_country = ServiceCountry.find_by(code: args[:serviceCountry]) || ServiceCountry.find_by(code: "GB")
    end

    user.guest = false
    user.save!

    if ctx[:controller].request.headers["x-source"] == "mobile"
      url = "#{ctx[:controller].request.base_url}/magic_link?token=#{user.magic_link_token}"
      UserMailer.magic_link_token_email(user, url).deliver_later
    end

    if ctx[:controller].request.headers["x-source"] == "web"
      url = "#{Settings.web_app_url}?token=#{user.magic_link_token}"
      UserMailer.web_magic_link_token_email(user, url).deliver_later
    end

  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end
