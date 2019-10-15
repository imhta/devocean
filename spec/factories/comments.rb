# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    association :user
    association :post

    trait :invalid do
      body { '' }
    end
  end
end
