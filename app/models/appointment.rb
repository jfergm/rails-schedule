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

  scope :between, ->(start_date:, end_date:) { where("scheduled_at between ? AND ?", start_date, end_date) }
  scope :today, -> { between(start_date: Time.current.strftime("%Y-%m-%d 00:00:00"), end_date: Time.current.strftime("%Y-%m-%d 23:59:59")) }
  scope :past, -> { where("scheduled_at < ?", Time.current.strftime("%Y-%m-%d 00:00:00")) }
  scope :upcoming, -> { where("scheduled_at > ?", Time.current.strftime("%Y-%m-%d 23:59:59")) }

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
