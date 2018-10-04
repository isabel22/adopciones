# frozen_string_literal: true

FactoryBot.define do
  factory :animal do
    sequence(:name) { |n| "Firulais #{n}" }
    gender 'male'
    birthdate_rescuedate Date.today
    rescued true
    adopted false
    profile_picture 'http://abc.com/abc.png'
    animal_breeds_id { FactoryBot.create(:animal_breed).id }
  end
end
