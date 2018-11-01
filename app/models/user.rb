class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :paths, dependent: :destroy
  has_many :cities, dependent: :destroy
end
