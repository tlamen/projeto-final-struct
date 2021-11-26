FactoryBot.define do
  factory :favorite do
    user { association :user }
    meal { association :meal }
  end
end
