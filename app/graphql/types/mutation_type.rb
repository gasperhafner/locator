Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :authorize,            function: Functions::Users::Authorize.new
  field :signInUser,           function: Functions::Users::SignIn.new
  field :createUser,           function: Functions::Users::SignUp.new
  field :updateUser,           function: Functions::Users::Update.new
  field :createMagicLinkToken, function: Functions::Users::CreateMagicLinkToken.new
  field :signInWithMagicLink,  function: Functions::Users::SignInWithMagicLink.new
  field :forgotPassword,       function: Functions::Users::ForgotPassword.new
  field :resetPassword,        function: Functions::Users::ResetPassword.new
  field :confirmAccount,       function: Functions::Users::ConfirmAccount.new
  field :purchaseBundle,       function: Functions::Users::PurchaseBundle.new
  field :createAddress,        function: Functions::Addresses::Create.new
  field :updateAddress,        function: Functions::Addresses::Update.new
  field :deleteAddress,        function: Functions::Addresses::Delete.new
  field :validateAddress,      function: Functions::Addresses::Validate.new
  field :createOrder,          function: Functions::Orders::Create.new
  field :cancelOrder,          function: Functions::Orders::Cancel.new
  field :modifyOrder,          function: Functions::Orders::Modify.new
  field :postOrderReview,      function: Functions::Orders::PostReview.new
  field :createStripeCustomer, function: Functions::Users::CreateStripeCustomer.new
  field :setDefaultCreditCard, function: Functions::Users::SetDefaultCreditCard.new
  field :validatePostCode,     function: Functions::ValidatePostCode.new
  field :isPromoCodeValid,     function: Functions::ValidatePromoCode.new
  field :notify,               function: Functions::Notify.new
  field :createGuestUser,      function: Functions::Users::CreateGuest.new
  field :createRepeatOrder,    function: Functions::RepeatOrders::Create.new
  field :sendMobileAppUrl,     function: Functions::Sms::SendMobileAppUrl.new
end
