
FactoryBot.define do
  factory :animal do
    sequence(:name) {|n| "Firulais #{n}" }
    gender         'Male'
  end
end
