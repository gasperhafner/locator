class Functions::Users::PurchasedBundles < Functions::Base
  argument :serviceCountry, Types::ServiceCountryEnumType

  type types[Types::UserBundleType]

  def call(obj, args, ctx)
    authenticate(ctx[:current_user])

    ctx[:current_user].user_bundles
      .joins(:bundle)
      .merge(Bundle.by_service_country_id(ctx[:current_user].service_country.id))

  rescue Exceptions::AuthenticationException => e
    GraphqlErrors::AuthenticationError.new(message: e.message)
  end
end
