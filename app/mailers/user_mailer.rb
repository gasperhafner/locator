class UserMailer < ApplicationMailer
  default from: "no-reply@poisci.ga"

  def confirmation(user)
    @url = "https://poisci.ga/confirmation?token=#{user.confirmation_token}"
    mail(to: user.email, subject: 'poisci.ga email verification')
  end
end
