class Functions::Users::ResetPassword < Functions::Base
  argument :token, !types.String
  argument :password, !types.String

  type types.Boolean

  def call(obj, args, ctx)
    user = User.find_by(reset_password_token: args[:token])
    raise Exceptions::WrongTokenException.new unless user

    user.password = args[:password]
    user.regenerate_reset_password_token
    user.save!

  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end
