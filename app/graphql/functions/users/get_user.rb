class Functions::Users::GetUser < Functions::Base
  type Types::UserType

  def call(obj, args, ctx)
    authenticate(ctx[:current_user])
    ctx[:current_user]

  rescue Exceptions::AuthenticationException => e
    GraphqlErrors::AuthenticationError.new(message: e.message)
  end
end
