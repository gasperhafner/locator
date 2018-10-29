class Functions::Users::SetDefaultCreditCard < Functions::Base
  argument :cardId, !types.String

  type types[Types::CreditCardType]

  def call(obj, args, ctx)
    authenticate(ctx[:current_user])
    user_stripe = ctx[:current_user].stripe_account_by_service_country

    return [] unless user_stripe.present?

    stripe_client = StripeClient.from_user(ctx[:current_user])
    customer = stripe_client.customer.retrieve(user_stripe.token)
    customer.default_source = args["cardId"]
    customer.save

    cards = []

    customer.sources.data.each do |source|
      cards << {
        id: source.id,
        brand: source.brand,
        exp_month: source.exp_month,
        exp_year: source.exp_year,
        last4: source.last4,
        isDefault: source.id == customer.default_source
      }
    end

    JSON.parse(cards.to_json, object_class: OpenStruct)

  rescue Exceptions::AuthenticationException => e
    GraphqlErrors::AuthenticationError.new(message: e.message)
  end
end
