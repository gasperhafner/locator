class Functions::Users::ForgotPassword < Functions::Base
  argument :email, !types.String

  type types.Boolean

  def call(obj, args, ctx)
    user = User.where('lower(email) = ?', args[:email].downcase).first

    raise Exceptions::UserNotFoundException.new unless user
    user.regenerate_reset_password_token

    url = "#{ctx[:controller].request.base_url}/resetpwd?token=#{user.reset_password_token}"
    UserMailer.forgot_password(user, url).deliver_later

    true
  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end
