FactoryBot.define do
  factory :location do
    sequence (:address) { |n| "Street #{n}" }
    sequence (:city) { |n| "City #{n}" }
    sequence (:state) { |n| "State #{n}" }
    sequence (:postal_code) { |n| "#{n}#{n+1}#{n+2}#{n+3}" }
    name { "Place x" }
    notes { "notes" }
  end
end
