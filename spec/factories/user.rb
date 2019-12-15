FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@emp.com" }
    password { '123456' }
  end
end
