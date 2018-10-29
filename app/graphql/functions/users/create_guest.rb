class Functions::Users::CreateGuest < GraphQL::Function
  argument :serviceCountry, !Types::ServiceCountryEnumType
  argument :email, !types.String
  argument :firstName, types.String
  argument :lastName, types.String
  argument :phone, types.String

  type Types::UserSignUpInType

  def call(obj, args, ctx)
    user = User.by_email(args[:email])

    if user && !user.can_be_overwritten?
      return GraphqlErrors::Users::EmailAlreadyExistsError.new 
    end

    user.destroy! if user

    user = User.create!(
      email:           args[:email],
      first_name:      args[:firstName],
      last_name:       args[:lastName],
      phone:           args[:phone],
      guest:           true,
      source:          ctx[:controller].request.headers.fetch("x-source", ""),
      platform:        ctx[:controller].request.headers.fetch("x-platform", ""),
      service_country: ServiceCountry.by_code(args[:serviceCountry])
    )

    token = Knock::AuthToken.new(payload: {sub: user.id}).token

    OpenStruct.new(user: user, token: token)
  end

  attr_accessor :obj_field
end
