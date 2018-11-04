class Location < ApplicationRecord
  scope :by_date, -> (date) {where("created_at::DATE = ?", date)}
end
