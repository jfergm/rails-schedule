class User < ApplicationRecord
  validates :name, presence: true
  validates :email_address, presence: true
  validates :email_address, uniqueness: { case_sensitive: false  }
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :appointments
  has_many :sessions, dependent: :destroy

  has_secure_password

  def full_name
    "#{self.name} #{self.last_name}"
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  alias_attribute :email, :email_address
end
