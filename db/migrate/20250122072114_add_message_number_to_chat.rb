class AddMessageNumberToChat < ActiveRecord::Migration[7.2]
  def change
    add_column :chats, :message_number, :integer
  end
end
