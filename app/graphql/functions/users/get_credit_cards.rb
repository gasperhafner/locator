class Functions::Users::GetCreditCards < Functions::Base
  argument :serviceCountry, Types::ServiceCountryEnumType
  type types[Types::CreditCardType]

  def call(obj, args, ctx)
    authenticate(ctx[:current_user])
    service_country = ServiceCountry.find_by(code: args["serviceCountry"]) if args['serviceCountry'].present?
    user_stripe = ctx[:current_user].stripe_account_by_service_country(service_country)

    return [] unless user_stripe.present?

    stripe_client = StripeClient.from_user(ctx[:current_user])
    stripe_customer = stripe_client.customer.retrieve(user_stripe.token)

    cards = []

    stripe_customer.sources.data.each do |source|
      cards << {
          id: source.id,
          brand: source.brand,
          exp_month: source.exp_month,
          exp_year: source.exp_year,
          last4: source.last4,
          isDefault: source.id == stripe_customer.default_source
      }
    end

    JSON.parse(cards.to_json, object_class: OpenStruct)

  rescue Exceptions::AuthenticationException => e
    GraphqlErrors::AuthenticationError.new(message: e.message)
  end
end
