class Functions::Users::IsEmailTaken < GraphQL::Function
  argument :email, !types.String

  type types.Boolean

  def call(obj, args, ctx)
    user = User.by_email(args[:email])

    user && !user.can_be_overwritten?
  end
end
