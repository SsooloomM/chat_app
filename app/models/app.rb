class App < ApplicationRecord
    # associations
    has_many :chats, foreign_key: :app_token, primary_key: :token, dependent: :destroy

    # validations
    validates :name, :token, presence: true, uniqueness: true
    validates :chat_count, :chat_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    # call backs
    before_validation(on: :create) do
        self.chat_count = 0
        self.chat_number = 0
        self.token = App.generate_unique_token
    end


    # class methods
    def self.generate_unique_token
        loop do
            token = SecureRandom.hex(5)
            break token unless App.where(token: token).exists?
        end
    end

    def serialize
        {
            token: token,
            name: name,
            chat_count: chat_count
        }
    end
end
