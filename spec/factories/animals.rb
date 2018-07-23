
FactoryBot.define do
  factory :animal do
    sequence(:name) {|n| "Firulais #{n}" }
    gender "Male"
    animal_breeds_id {FactoryBot.create(:animal_breed).id}
  end
end
