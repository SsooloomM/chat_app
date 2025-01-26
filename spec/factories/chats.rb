# == Schema Information
#
# Table name: chats
#
#  id               :bigint           not null, primary key
#  app_token        :string
#  message_count    :integer          default(0)
#  message_sequence :integer          default(0)
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_chats_on_app_token_and_number  (app_token,number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_08c3435968  (app_token => apps.token)
#
FactoryBot.define do
  factory :chat do
    app { create(:app) }
  end
end
