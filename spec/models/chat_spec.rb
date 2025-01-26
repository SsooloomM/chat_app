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
require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "initial values" do
    let(:chat) { create(:chat) }

    it "should start with 0 messages" do
      expect(chat.message_count).to eq(0)
    end

    it "should start with message sequence 0" do
      expect(chat.message_sequence).to eq(0)
    end
  end

  describe "creating messages increase the number" do
    let (:chat) { create(:chat) }

    it "the #message_sequence by one" do
      create(:message, chat: chat)
      expect(chat.message_sequence).to eq(1)
    end

    it "should increase even when delete chats" do
      expect(chat.message_sequence).to eq(0)
      create(:message, chat: chat)
      expect(chat.message_sequence).to eq(1)
      message = create(:message, chat: chat)
      expect(chat.message_sequence).to eq(2)
      message.destroy
      expect(chat.message_sequence).to eq(2)
      create(:message, chat: chat)
      expect(chat.message_sequence).to eq(3)
    end
  end
end
