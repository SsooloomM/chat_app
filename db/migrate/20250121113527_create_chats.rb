class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.string :app_token
      t.integer :number
      t.integer :message_count, default: 0
      t.integer :message_sequence, default: 0

      t.timestamps
    end

    add_foreign_key :chats, :apps, column: :app_token, primary_key: :token
    add_index :chats, [:app_token, :number], unique: true

  end
end
