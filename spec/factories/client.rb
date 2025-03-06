FactoryBot.define do
  factory :client do
    sequence (:email) { |n| "client#{n}_email@email.com" }
    name { "client" }
    phone_number { "1234567890" }
    last_name { "lastname" }
  end
end
