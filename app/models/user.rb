class User < ApplicationRecord
  has_secure_password
  has_secure_token :gps_token
  has_secure_token :confirmation_token

  validates :email, presence: true, uniqueness: true

  has_many :paths, dependent: :destroy
  has_many :cities, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :push_logs, dependent: :destroy

  def active?
    active
  end
end
