class Functions::Users::ConfirmAccount < Functions::Base
  argument :token, !types.String

  type types.Boolean

  def call(obj, args, ctx)
    user = User.find_by(confirmation_token: args[:token])

    raise Exceptions::WrongTokenException.new unless user
    raise Exceptions::AlreadyConfirmedException.new if user.confirmed_at

    user.update_columns(
      confirmed_at: Time.current,
      confirmation_token: nil
    )

    true

  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end


