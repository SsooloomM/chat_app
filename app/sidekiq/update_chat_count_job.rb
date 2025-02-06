class UpdateChatCountJob
  include Sidekiq::Job

  def perform(*args)
    App.find_each do |app|
      app.update(chat_count: Chat.where(app_token: app.token).count)
    end
  end
end
