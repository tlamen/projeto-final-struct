FactoryBot.define do
  sequence :cat_names do |n|
    "categoria #{n}"
  end
  factory :category do
    name { generate(:cat_names) }
  end
end
