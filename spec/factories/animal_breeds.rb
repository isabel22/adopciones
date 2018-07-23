
FactoryBot.define do
  factory :animal_breed do
    sequence(:name) {|n| "Breed #{n}" }
    animal_species_id { FactoryBot.create(:animal_specy).id }
  end
end
