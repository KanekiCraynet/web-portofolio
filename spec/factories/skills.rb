# Factory for Skill model
FactoryBot.define do
  factory :skill do
    name { Faker::ProgrammingLanguage.name }
    category { %w[Frontend Backend DevOps Database Tools].sample }
    proficiency { rand(1..5) }
    association :user

    trait :frontend do
      category { "Frontend" }
      name { %w[React Vue Angular TypeScript].sample }
    end

    trait :backend do
      category { "Backend" }
      name { %w[Ruby Python Node.js Go].sample }
    end

    trait :expert do
      proficiency { 5 }
    end
  end
end
