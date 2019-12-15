FactoryBot.define do
  factory :feed do
    sequence(:url) { |n| "feed_url#{n}" }
  end
end
