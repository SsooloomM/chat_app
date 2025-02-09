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
class Message < ApplicationRecord
    # associations
    belongs_to :chat, foreign_key: [ :app_token, :chat_number ], primary_key: [ :app_token, :number ]

    # validations
    validates :number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :number, uniqueness: { scope: [ :app_token, :chat_number ] }
    validates :text, :sender, presence: true

    # callbacks
    before_validation(on: :create) do
        if chat.present?
            chat.with_lock do
                chat.message_sequence += 1
                self.number = chat.message_sequence
                chat.save
            end
        end
    end

    
    # elasticsearch
    include Searchable

    mapping do
        indexes :app_token, type: :text
        indexes :chat_number, type: :text
        indexes :text, type: :text
    end
    
    def self.search(partial_text, token, chat_number)
        __elasticsearch__.search(
            query: {
                query_string: {
                    query: "app_token:#{token} AND chat_number:#{chat_number} AND text:*#{partial_text}*"
                }
            }
        ).records
    end

    after_commit do
        __elasticsearch__.index_document
    end

    # serialization
    def as_json(options = {})
        super(only: [ :number, :sender, :text, :app_token, :chat_number ])
    end
end
