FactoryBot.define do
  factory :appointment do
    sequence (:scheduled_at) { |n| n.days.from_now }
    user
    client
    location
  end
end
