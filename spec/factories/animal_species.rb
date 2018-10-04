# frozen_string_literal: true

FactoryBot.define do
  factory :animal_specy do
    sequence(:name) { |n| "Dog #{n}" }
  end
end
