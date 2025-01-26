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
require 'rails_helper'

RSpec.describe App, type: :model do
  describe "initial values" do
    let (:app) { create(:app) }

    it "should start with no chats" do
      expect(app.chat_count).to eq(0)
    end

    it "should start with counting chats from 0" do
      expect(app.chat_sequence).to eq(0)
    end
  end

  describe "creating chats increase the number" do
    let (:app) { create(:app) }

    it "the #chat_sequence by one" do
      chat = create(:chat, app: app)
      expect(app.chat_sequence).to eq(1)
    end

    it "should increase even when delete chats" do
      expect(app.chat_sequence).to eq(0)
      chat1 = create(:chat, app: app)
      expect(app.chat_sequence).to eq(1)
      chat2 = create(:chat, app: app)
      expect(app.chat_sequence).to eq(2)
      chat2.destroy
      expect(app.chat_sequence).to eq(2)
      chat3 = create(:chat, app: app)
      expect(app.chat_sequence).to eq(3)
    end
  end
end
