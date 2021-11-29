FactoryBot.define do
  sequence :meal_names do |n|
    "meal #{n}"
  end

  factory :meal do
    id { 666 }
    name { generate(:meal_names) }
    description { "Aproximadamente 65 batatas fritas" }
    price { 8.0 }
    category { association :category }
  end
end
