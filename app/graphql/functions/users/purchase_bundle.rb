class Functions::Users::PurchaseBundle < Functions::Base
  argument :bundleId, !types.Int
  argument :cardId, types.String

  type Types::UserBundleType

  def call(obj, args, ctx)
    authenticate(ctx[:current_user])

    Commands::Bundles::Purchase.run(
      ctx[:controller].current_user,
      bundle_id: args[:bundleId],
      card_id: args[:cardId],
      source: ctx[:controller].request.headers["x-source"],
      platform: ctx[:controller].request.headers["x-platform"],
      controller: ctx[:controller] # needed for URL helpers
    )

  rescue Exceptions::StripeChargeException => e
    GraphqlErrors::StripeChargeException.new
  rescue Exceptions::AuthenticationException => e
    GraphqlErrors::AuthenticationError.new(message: e.message)
  rescue => e
    Rails.logger.tagged("BUNDLE PURCHASE") do |logger|
      logger.error("#{e.message}\n#{e.backtrace}")
    end
    GraphQL::ExecutionError.new("An error occurred: #{e.message}")
  end

end
