# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user { nil }
    post { nil }
    body { 'MyString' }
  end
end
