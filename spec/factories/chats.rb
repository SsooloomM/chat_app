FactoryBot.define do
  factory :chat do
    app { create(:app) }
  end
end
