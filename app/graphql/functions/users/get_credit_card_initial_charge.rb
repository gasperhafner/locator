class Functions::Users::GetCreditCardInitialCharge < Functions::Base
  argument :serviceCountry, Types::ServiceCountryEnumType
  type types.Float

  def call(obj, args, ctx)
    user = ctx[:current_user]
    user_service_country_code = user_service_country_code(user, args)
    ServiceCountry.find_by(code: user_service_country_code).stripe_initial_charge
  end
end
