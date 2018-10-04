# frozen_string_literal: true

FactoryBot.define do
  factory :animal_breed do
    sequence(:name) { |n| "Breed #{n}" }
    animal_specy_id { FactoryBot.create(:animal_specy).id }
  end
end
