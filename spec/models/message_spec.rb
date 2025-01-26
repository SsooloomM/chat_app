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
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "message_sequence" do
    let(:chat) { create(:chat) }
    it "should create messages in the righ sequence" do
      message1 = create(:message, chat: chat)
      message2 = create(:message, chat: chat)
      message3 = create(:message, chat: chat)
      message4 = create(:message, chat: chat)

      expect(message1.number).to eq(1)
      expect(message2.number).to eq(2)
      expect(message3.number).to eq(3)
      expect(message4.number).to eq(4)
    end
  end
end
