
FactoryBot.define do
  factory :animal_specy do
    sequence(:name) {|n| "Dog #{n}" }
  end
end
