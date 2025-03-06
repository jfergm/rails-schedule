FactoryBot.define do
  factory :user do
    sequence (:email) { |n| "user#{n}_email@email.com" }
    password { "password" }
    name { "user" }
    last_name { "lastname" }
  end
end
