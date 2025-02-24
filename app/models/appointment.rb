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

  private
  LETTERS = ("A".."Z").to_a

  def set_code
    if not self.user.present? or not self.client.present? or not self.location.present? or not self.scheduled_at.present?
      errors.add(:code, "could'nt generate code")
      return
    end
    if code == nil
      self.code = generate_code
    end
  end

  def generate_code
    client_normalized_arr = paddNum(num: client.id)
    user_normalized_arr = paddNum(num: user.id)
    location_normalized_arr = paddNum(num: location.id)

    timestamp_data = scheduled_at.strftime("%Y%m%d%H%M")[-4, 4]

    total_sum = sum_arr(client_normalized_arr) + sum_arr(user_normalized_arr) + sum_arr(location_normalized_arr) +
      sum_arr(timestamp_data.split(""))

    code = paddNum(num: total_sum * 17, length: 6)

    code.push(LETTERS[total_sum % LETTERS.length])

    "#{scheduled_at.strftime('%y%m%d%H%M')}-#{code.join}"
  end

  def paddNum(num:, length: 5)
    num_s = num.to_s
    if num_s.length >= length
      return num_s
    end
    res  = Array.new(length) { 0 }

    num_s.split("").each_with_index do |c, i|
      res[i - num_s.length] = c
    end
    res
  end

  def sum_arr(arr)
    arr.reduce(0) { |acc, curr| acc + curr.to_i }
  end
end
