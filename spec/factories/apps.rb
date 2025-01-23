FactoryBot.define do
  factory :app do
    sequence(:name) { |n| "app_#{n}" }
  end
end
