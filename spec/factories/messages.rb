# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  app_token   :string
#  chat_number :integer
#  number      :integer
#  sender      :string
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_messages_on_app_token_and_chat_number  (app_token,chat_number)
#
# Foreign Keys
#
#  fk_rails_5aeb3c63fc  (["app_token", "chat_number"] => chats.["app_token", "number"])
#
FactoryBot.define do
  factory :message do
    chat { create(:chat) }
    text { "dummy text!" }
    sender { "dummy_sender" }
  end
end
