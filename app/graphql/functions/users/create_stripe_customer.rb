class Functions::Users::CreateStripeCustomer < Functions::Base
  argument :token, !types.String
  argument :isDefault, types.Boolean

  type types[Types::CreditCardType]


  def call(obj, args, ctx)
    authenticate(ctx[:current_user])
    Commands::Users::CreateStripeCustomer.run(
      ctx[:current_user],
      token: args[:token],
      is_default: args[:isDefault]
    )
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    GraphqlErrors::StripeError.new(message: "An error occurred on Stripe: #{e.message}")
  rescue Exceptions::AuthenticationException => e
    GraphqlErrors::AuthenticationError.new(message: e.message)
  end
end
