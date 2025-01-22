class Chat < ApplicationRecord
    # associations
    belongs_to :app, :foreign_key => :app_token, :primary_key => :token

    has_many :messages, dependent: :destroy,
        :foreign_key => [:app_token, :chat_number], :primary_key => [:app_token, :number]
    
    # validations
    validates :message_count, :number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :number, uniqueness: { scope: :app_token }

    
    # call backs
    before_validation(on: :create) do
        self.message_count = 0
        self.message_number = 0
        if app.present?
            Chat.transaction do
                app.with_lock do
                    app.chat_number += 1
                    self.number = app.chat_number
                    app.save
                end
            end
        end
    end

    def serialize
        {
            number: self.number,
            message_count: self.message_count
        }
    end

end
