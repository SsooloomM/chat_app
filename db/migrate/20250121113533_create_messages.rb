class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.integer :chat_number
      t.string :app_token
      t.integer :number
      t.string :text
      t.string :sender

      t.timestamps
    end
  end
end
