# Factory for Message model
FactoryBot.define do
  factory :message do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    subject { Faker::Lorem.sentence(word_count: 4) }
    body { Faker::Lorem.paragraph(sentence_count: 3) }
    read { false }

    trait :read do
      read { true }
      read_at { Time.current }
    end
  end
end
