Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :me, function: Functions::Users::GetUser.new
  field :isEmailTaken, function: Functions::Users::IsEmailTaken.new
  field :address, function: Functions::Addresses::GetAddress.new
  field :addresses, function: Functions::Addresses::GetAll.new
  field :creditCards, function: Functions::Users::GetCreditCards.new
  field :order, function: Functions::Orders::GetOrder.new
  field :orders, function: Functions::Orders::GetOrders.new
  field :priceServices, function: Functions::GetPriceServices.new
  field :priceInfo, function: Functions::GetPriceInfo.new
  field :services, function: Functions::GetServices.new
  field :information, function: Functions::GetInformation.new
  field :creditCardInitialCharge, function: Functions::Users::GetCreditCardInitialCharge.new
  field :stripePublishableKey, function: Functions::GetStripePublishableKey.new
  field :serviceCountries, function: Functions::GetServiceCountries.new
  field :bundles, function: Functions::GetBundles.new
  field :purchasedBundles, function: Functions::Users::PurchasedBundles.new
  field :timeslots_old, function: Functions::GetAvailabilities.new
  field :timeslots, function: Functions::GetTimeslots.new
  field :timeslotsWeb, function: Functions::GetTimeslotsWeb.new
  field :orderTips, function: Functions::Orders::GetTips.new
end
