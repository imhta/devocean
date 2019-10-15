# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    user { nil }
    friend { nil }
    status { 1 }
  end
end
