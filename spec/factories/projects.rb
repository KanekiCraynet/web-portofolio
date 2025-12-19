# Factory for Project model
FactoryBot.define do
  factory :project do
    title { Faker::App.name }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    technologies { "Ruby, Rails, PostgreSQL, Tailwind CSS" }
    live_url { Faker::Internet.url }
    github_url { "https://github.com/#{Faker::Internet.username}/#{Faker::App.name.parameterize}" }
    published { false }
    featured { false }
    association :user

    trait :published do
      published { true }
      published_at { Time.current }
    end

    trait :featured do
      featured { true }
      published { true }
    end

    trait :with_image do
      after(:build) do |project|
        project.featured_image.attach(
          io: File.open(Rails.root.join("spec/fixtures/files/project.png")),
          filename: "project.png",
          content_type: "image/png"
        )
      end
    end
  end
end
