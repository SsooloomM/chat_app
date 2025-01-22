class Message < ApplicationRecord
    # associations
    belongs_to :chat, :foreign_key => [:app_token, :chat_number], :primary_key => [:app_token, :number]

    # validations
    validates :number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :number, uniqueness: { scope: [:app_token, :chat_number] }
    validates :text, :sender, presence: true

    # call backs
    before_validation(on: :create) do
        if chat.present?
            Message.transaction do
                chat.with_lock do
                    chat.message_number += 1
                    self.number = chat.message_number
                    chat.save
                end
            end
        end
    end

    def serialize
        {
            number: self.number,
            text: self.text,
            sender: self.sender
        }
    end

end
