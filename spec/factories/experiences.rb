# Factory for Experience model
FactoryBot.define do
  factory :experience do
    company { Faker::Company.name }
    role { Faker::Job.title }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    start_date { Faker::Date.between(from: 5.years.ago, to: 2.years.ago) }
    end_date { Faker::Date.between(from: 1.year.ago, to: Date.current) }
    location { "#{Faker::Address.city}, #{Faker::Address.country}" }
    association :user

    trait :current do
      end_date { nil }
      start_date { Faker::Date.between(from: 1.year.ago, to: 3.months.ago) }
    end
  end
end
