class Functions::Users::CreateMagicLinkToken < Functions::Base
  argument :email, !types.String

  type types.Boolean

  def call(obj, args, ctx)
    user = User.where('lower(email) = ?', args[:email].downcase).first

    raise Exceptions::UserNotFoundException.new unless user

    user.regenerate_magic_link_token
    user.magic_link_token_expiration = Time.current + User::MAGIC_LINK_TOKEN_EXPIRATION
    user.save!

    url = "#{ctx[:controller].request.base_url}/magic_link?token=#{user.magic_link_token}"
    UserMailer.magic_link_token_email(user, url).deliver_later

    true
  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end


