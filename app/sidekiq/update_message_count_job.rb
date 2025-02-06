class UpdateMessageCountJob
    include Sidekiq::Job

    def perform(*args)
      Chat.find_each do |chat|
        chat.update(message_count: Message.where(app_token: chat.app_token, chat_number: chat.number).count)
      end
    end
end
