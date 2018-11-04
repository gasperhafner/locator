class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_USERNAME"]

  def confirmation(user)
    @url = "https://poisci.ga/confirmation?token=#{user.confirmation_token}"
    mail(to: user.email, subject: 'poisci.ga email verification')
  end
end
