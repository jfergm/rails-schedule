class Location < ApplicationRecord
  validates :name, :address, :postal_code, :city, :state, presence: true
  validates_uniqueness_of :address, scope: [ :postal_code ]

  has_many :appointments
end
