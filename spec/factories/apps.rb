# == Schema Information
#
# Table name: apps
#
#  id            :bigint           not null, primary key
#  chat_count    :integer          default(0)
#  chat_sequence :integer          default(0)
#  name          :string
#  token         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_apps_on_token  (token) UNIQUE
#
FactoryBot.define do
  factory :app do
    sequence(:name) { |n| "app_#{n}" }
  end
end
