class Path < ApplicationRecord
  belongs_to :user

  has_many :path_cities, dependent: :destroy
  has_many :cities, through: :path_cities
end
