# Factory for BlogPost model
FactoryBot.define do
  factory :blog_post do
    title { Faker::Lorem.sentence(word_count: 5) }
    content { Faker::Lorem.paragraphs(number: 5).join("\n\n") }
    excerpt { Faker::Lorem.paragraph }
    published { false }
    published_at { nil }
    association :user

    trait :published do
      published { true }
      published_at { Faker::Time.between(from: 1.month.ago, to: Time.current) }
    end

    trait :with_tags do
      tags { "ruby, rails, programming" }
    end
  end
end
