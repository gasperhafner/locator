class Functions::Users::SignIn < GraphQL::Function
  argument :auth, !Types::EmailAuthProviderInput

  # defines inline return type for the mutation
  type Types::UserSignUpInType

  def call(_obj, args, _ctx)
    auth = args[:auth]

    user = User.where('lower(email) = ?', args[:email].downcase).first

    raise Exceptions::WrongPwdOrUsernameException unless user&.authenticate(auth[:password])
    raise Exceptions::NotActivatedException unless user.confirmed_at.present?

    token = Knock::AuthToken.new(payload: {sub: user.id}).token

    OpenStruct.new({
                     user: user,
                     token: token
                   })
  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end
