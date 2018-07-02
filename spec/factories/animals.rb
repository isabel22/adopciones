
FactoryBot.define do
  factory :animal do
    sequence(:name) {|n| "Fido #{n}" }
    gender         'Male'
  end
end
