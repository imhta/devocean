# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    body { 'MyString' }
    user { nil }
  end
end
