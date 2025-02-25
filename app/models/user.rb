class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :appointments
end
