require 'rails_helper'

RSpec.describe "Chats", type: :request do
  let(:test_app) { create(:app) }

  describe "GET /app/:app_token/chats" do
    it "list all chats inside an app" do
      chats = []
      5.times do
        chats << create(:chat, app: test_app)
      end
      get app_chats_path(app_token: test_app.token), as: :json
      expect(response).to have_http_status(200)
      expected_response = { chats: Chat.where(app_token: test_app.token).as_json }.to_json
      expect(response.body).to eq(expected_response)
    end
  end

  describe "POST /apps/:app_token/chats"  do
    it "should create an chat in an app" do
      post app_chats_path(app_token: test_app.token)
      chat = test_app.chats.first
      expect(response).to have_http_status(200)
      expect(chat.app_token).to eq(test_app.token)
      expect(chat.number).to eq(1)
      expect(chat.message_count).to eq(0)
      expect(chat.message_sequence).to eq(0)
    end
  end

  describe "DELETE /apps/:app_token/chats/:number" do
    let(:chat) { create(:chat, app: test_app) }
    it "shouldn't find the chat" do
      delete app_chat_path(app_token: test_app.token, number: chat.number)
      expect(response).to have_http_status(200)
      expect(test_app.chats.find_by(number: chat.number)).to be(nil)
    end
  end
end
