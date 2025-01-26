class CreateApps < ActiveRecord::Migration[7.2]
  def change
    create_table :apps do |t|
      t.string :token
      t.string :name
      t.integer :chat_sequence, default: 0
      t.integer :chat_count, default: 0

      t.timestamps
    end

    add_index :apps, :token, unique: true
  end
end
