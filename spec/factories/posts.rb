# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    body {  Faker::Lorem.paragraph }
    association :user

    trait :invalid do
      body { '' }
    end
  end
end
