FactoryBot.define do
  factory :message do
    chat { create(:chat) }
    text { "dummy text!" }
    sender { "dummy_sender" }
  end
end
