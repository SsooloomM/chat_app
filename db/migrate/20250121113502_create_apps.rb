class CreateApps < ActiveRecord::Migration[7.2]
  def change
    create_table :apps do |t|
      t.string :token
      t.string :name
      t.integer :chat_count

      t.timestamps
    end
  end
end
