# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@test.com" }
    password         { 'Asdfasdf1.' }
  end

  factory :super_admin, parent: :user do
    after(:create) do |user|
      user.add_role 'super_admin'
    end
  end

  factory :admin, parent: :user do
    after(:create) do |user|
      user.add_role 'admin'
    end
  end

  factory :volunteer, parent: :user do
    after(:create) do |user|
      user.add_role 'volunteer'
    end
  end

  factory :requester, parent: :user do
    after(:create) do |user|
      user.add_role 'requester'
    end
  end
end
