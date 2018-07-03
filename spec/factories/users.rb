
FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "foo#{n}@test.com" }
    password         'Asdfasdf1'
  end
end
