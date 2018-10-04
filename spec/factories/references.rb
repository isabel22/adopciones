# frozen_string_literal: true

FactoryBot.define do
  factory :reference do
    sequence(:full_name) { |n| "Joe Doe #{n}" }
    phone { '51234567' }
  end
end
