class Client < ApplicationRecord
  validates :name, :email, :phone_number, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
