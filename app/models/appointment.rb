class Appointment < ApplicationRecord
  enum :status, [ :scheduled, :finished, :cancelled ], default: :scheduled

  belongs_to :user
  belongs_to :client
  belongs_to :location

  validates :user, :client, :location, :scheduled_at, presence: true
  validates :code, uniqueness: true

  validates_uniqueness_of :client, scope: :scheduled_at, message: "Client already with an appointment in the scheduled date"
  validates_uniqueness_of :user, scope: :scheduled_at, message: "User already with an appointment in the scheduled date"

  before_validation :set_code

  scope :between, ->(start_date:, end_date:) do
    where("scheduled_at between :start_date AND :end_date", start_date: start_date, end_date: end_date)
  end
  scope :today, -> { between(start_date: Time.now.beginning_of_day, end_date: Time.now.end_of_day) }
  scope :past, -> { where("scheduled_at < ?", Time.now.beginning_of_day) }
  scope :upcoming, -> { where("scheduled_at > ?", Time.now.end_of_day) }

  private
  def set_code
    if !user.present? || !client.present? || !location.present? || !scheduled_at.present?
      errors.add(:code, "could'nt generate code")
      return
    end
    if code == nil
      self.code = AppointmentCode.generate(user_id: user.id, client_id: client.id,  location_id: location.id, scheduled_at: scheduled_at)
    end
  end
end
