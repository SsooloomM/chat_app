class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.string :app_token
      t.integer :chat_number
      t.integer :number
      t.text :text
      t.string :sender

      t.timestamps
    end

    add_foreign_key :messages, :chats, column: [ :app_token, :chat_number ], primary_key: [ :app_token, :number ]

    add_index :messages, [ :app_token, :chat_number ]
  end
end
