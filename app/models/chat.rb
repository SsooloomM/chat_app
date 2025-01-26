# == Schema Information
#
# Table name: chats
#
#  id               :bigint           not null, primary key
#  app_token        :string
#  message_count    :integer          default(0)
#  message_sequence :integer          default(0)
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_chats_on_app_token_and_number  (app_token,number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_08c3435968  (app_token => apps.token)
#
class Chat < ApplicationRecord
    # associations
    belongs_to :app, foreign_key: :app_token, primary_key: :token

    has_many :messages, dependent: :destroy,
        foreign_key: [ :app_token, :chat_number ], primary_key: [ :app_token, :number ]

    # validations
    validates :message_count, :number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :number, uniqueness: { scope: :app_token }


    # callbacks
    before_validation(on: :create) do
        if app.present?
            app.with_lock do
                app.chat_sequence += 1
                self.number = app.chat_sequence
                app.save
            end
        end
    end

    # serialization
    def as_json(options={})
        super(only: [:number, :message_count])
    end
end
