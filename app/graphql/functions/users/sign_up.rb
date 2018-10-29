class Functions::Users::SignUp < GraphQL::Function
  argument :firstName, types.String
  argument :lastName, types.String
  argument :auth, !Types::EmailAuthProviderInput

  # defines inline return type for the mutation
  type Types::UserSignUpInType

  def call(obj, args, ctx)

    user_param = {
        first_name: args[:firstName],
        last_name: args[:lastName],
        email: args[:auth][:email],
    }

    if args[:auth][:password].present?
      user_param[:password] = args[:auth][:password]
    end

    user = User.create!(
        user_param
    )

    #todo enable confirmation account when needed
    #url = "#{ctx[:controller].request.base_url}/confirm?token=#{user.confirmation_token}"
    #UserMailer.confirmation_email(user, url).deliver_now

    token = Knock::AuthToken.new(payload: {sub: user.id}).token

    OpenStruct.new({
                       user: user,
                       token: token
                   })
  end
end
