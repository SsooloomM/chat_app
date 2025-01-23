require 'rails_helper'

RSpec.describe "Apps", type: :request do
  describe "GET /index" do
    it "try index" do
      apps = []
      5.times do
        apps << create(:app)
      end

      get apps_path
      expect(response).to have_http_status(200)
      expect(response.body).to eq(App.all.map(&:serialize).to_json) 
    end
  end

  describe "POST /create" do
    it "should create an app with the right name" do
      name = 'test_app_name'
      body = {
        app: {
          name: name
        }
      }
      post apps_path(body)
      expect(response).to have_http_status(200)
      app = App.first
      expect(app.name).to eq(name)
      expect(app.chat_count).to eq(0)
      expect(app.chat_number).to eq(0)
    end
  end

  describe "DELETE /destroy" do
    let(:a) { create(:app) }
    it "shouldn't find the app" do
      delete app_path(token: a.token)
      expect(response).to have_http_status(200)
      expect(App.find_by(token: a.token)).to be(nil)
    end
  end
end
