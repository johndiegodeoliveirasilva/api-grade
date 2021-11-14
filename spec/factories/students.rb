FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    email { Faker::Internet.free_email }
    year { Faker::Date.between(from: '1996-01-23', to: '2020-09-25').strftime('%d-%m-%Y') } 
  end

  trait :without_email do
    email { nil }
  end
end