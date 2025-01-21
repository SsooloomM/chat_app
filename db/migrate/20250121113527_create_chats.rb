class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.string :app_token
      t.integer :number
      t.integer :message_count

      t.timestamps
    end
  end
end
