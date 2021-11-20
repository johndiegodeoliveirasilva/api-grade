FactoryBot.define do
  factory :grade do
    title { Faker::Games::ElderScrolls.creature }
    time_start { DateTime.current }
    time_end { DateTime.current + 1.day }
  end

  trait :without_time_start do
    time_start { nil }
  end

  trait :past_time_start do
    time_start { DateTime.current - 350.days}
  end
end
