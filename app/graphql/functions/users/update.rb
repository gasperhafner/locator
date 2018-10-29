class Functions::Users::Update < Functions::Base
  type Types::UserType

  argument :firstName, types.String
  argument :lastName, types.String
  argument :phone, types.String
  argument :password, types.String
  argument :serviceCountry, Types::ServiceCountryEnumType

  def call(obj, args, ctx)
    user = ctx[:current_user]

    authenticate(user)

    user_attr = args.to_h

    user_attr['source'] = ctx[:controller].request.headers["x-source"] || ''
    user_attr['platform'] = ctx[:controller].request.headers["x-platform"] || ''


    if args[:serviceCountry].present?
      user_attr["service_country"] = ServiceCountry.find_by(code: args[:serviceCountry]) || ServiceCountry.find_by(code: "GB")
    end

    user.update!(
      Util::Hash.underscore_keys(user_attr)
    )

    user
    
  rescue Exceptions::AuthenticationException => e
    GraphqlErrors::AuthenticationError.new(message: e.message)
  rescue => e
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end
end
