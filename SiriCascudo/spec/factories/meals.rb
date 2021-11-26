FactoryBot.define do
  factory :meal do
    name { "Batata frita pequena" }
    description { "Aproximadamente 65 batatas fritas" }
    price { 8.0 }
    category { association :category }
  end
end
