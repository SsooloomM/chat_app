require 'rails_helper'

RSpec.describe App, type: :model do
  describe "initial values" do
    let (:app) { create(:app) }

    it "should start with no chats" do
      expect(app.chat_count).to eq(0)
    end

    it "should start with counting chats from 0" do
      expect(app.chat_number).to eq(0)
    end
  end

  describe "creating chats increase the number" do
    let (:app) { create(:app) }

    it "the #chat_number by one" do
      chat = create(:chat, app: app)
      expect(app.chat_number).to eq(1)
    end

    it "should increase even when delete chats" do
      expect(app.chat_number).to eq(0)
      chat1 = create(:chat, app: app)
      expect(app.chat_number).to eq(1)
      chat2 = create(:chat, app: app)
      expect(app.chat_number).to eq(2)
      chat2.destroy
      expect(app.chat_number).to eq(2)
      chat3 = create(:chat, app: app)
      expect(app.chat_number).to eq(3)
    end
  end
end
