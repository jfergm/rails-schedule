
class AppointmentCode
  def self.generate(client_id:, user_id:, location_id:, scheduled_at:)
    letters = ("A".."Z").to_a
    constant_num = 17

    padded_client = self.pad_num(num: client_id)
    padded_user = self.pad_num(num: user_id)
    padded_location = self.pad_num(num: location_id)

    timestamp_arr = scheduled_at.strftime("%Y%m%d%H%M")[-4, 4].split("")

    total_sum = self.sum_arr(padded_client) +
                self.sum_arr(padded_user) +
                self.sum_arr(padded_location) +
                self.sum_arr(timestamp_arr)

    code = self.pad_num(num: total_sum * constant_num, length: 6)

    code.push(letters[total_sum % letters.length])

    "#{scheduled_at.strftime('%y%m%d%H%M')}-#{code.join}"
  end

  private

  def self.pad_num(num:, length: 5)
    num_s = num.to_s

    if num_s.length >= length
      num_s
    end

    res = Array.new(length) { 0 }

    num_s.split("").each_with_index do |c, i|
      res[i - num_s.length] = c
    end

    res
  end

  def self.sum_arr(arr)
    arr.reduce(0) { |acc, curr| acc + curr.to_i }
  end
end
