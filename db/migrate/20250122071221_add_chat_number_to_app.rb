class AddChatNumberToApp < ActiveRecord::Migration[7.2]
  def change
    add_column :apps, :chat_number, :integer
  end
end
