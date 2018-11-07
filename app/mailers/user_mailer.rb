class UserMailer < ApplicationMailer
  default from: "no-reply@poisci.ga"
  default "Message-ID" => "#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@poisci.ga"

  def confirmation(user)
    @url = "https://poisci.ga/confirmation?token=#{user.confirmation_token}"
    mail(to: user.email, subject: 'poisci.ga email verification')
  end
end
