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
class App < ApplicationRecord
    # associations
    has_many :chats, foreign_key: :app_token, primary_key: :token, dependent: :destroy

    # validations
    validates :name, :token, presence: true, uniqueness: true
    validates :chat_count, :chat_sequence, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    # callbacks
    after_initialize do
        self.token = App.generate_unique_token if new_record?
    end


    # class methods
    def self.generate_unique_token
        loop do
            token = SecureRandom.hex(5)
            break token unless App.where(token: token).exists?
        end
    end

    # serialization
    def as_json(options = {})
        super(only: [ :token, :name, :chat_count ])
    end
end
