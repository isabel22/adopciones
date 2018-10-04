# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    uid '101018882939'
    first_name 'Joe'
    last_name 'Doe'
    birthdate { 30.years.ago }
    email 'joe.doe+test0@gmail.com'
    address 'Torstraße 102, 10119 Berlin'
    home_phone '+4901701010111'
    animal_id { FactoryBot.create(:animal).id }
    country 'Germany'
    other_pets false
    all_agree true
    type_of_home 'apartment'
    own_home false
    place_to_be 'inside the apartment'
    place_to_sleep 'my bed'
    has_garden true
    can_escape false
    puppy false
    family_members '5'
    job_position 'Teacher'
    job_address 'CA Blah 123, Berlin, Germany'
    job_phone '+49 01709191281'
    signature 'JD'
    status 'pending'
  end
end
