FactoryBot.define do
  sequence :emails do |n|
    "email#{n}@teste"
  end

  factory :user do
    email { generate(:emails) }
    name { "Artur" }
    password { "123456" }
    password_confirmation { "123456" }
    
    trait :admin do
      is_admin { true }
    end
  end
end
