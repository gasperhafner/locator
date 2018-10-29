class Functions::Users::SignInWithMagicLink < Functions::Base
  argument :token, !types.String

  type Types::UserSignUpInType

  def call(obj, args, ctx)
    user = User.find_by(magic_link_token: args[:token])

    raise Exceptions::WrongTokenException unless user
    raise Exceptions::WrongTokenExpiredException unless user.magic_link_token_expiration >= Time.current

    user.update_columns(
      magic_link_token: nil,
      magic_link_token_expiration: nil
    )

    token = Knock::AuthToken.new(payload: {sub: user.id}).token

    OpenStruct.new(
      user: user,
      token: token
    )

  rescue Exceptions::WrongTokenException => e
    GraphqlErrors::WrongTokenError.new
  rescue Exceptions::WrongTokenExpiredException => e
    GraphqlErrors::WrongTokenExpiredError.new
  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end


