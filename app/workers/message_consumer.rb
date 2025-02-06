class MessageConsumer
    MESSAGES_QUEUE = "messages"

    def self.start
        consumers_count = ENV["MESSAGE_CONSUMERS_COUNT"].to_i || 1
        consumers_count.times do |i|
            Thread.new do
                channel = RabbitMQ.channel
                queue = channel.queue(MESSAGES_QUEUE, durable: true)
                consumer_tag = "#{queue.name}_consumer_#{i}"
                queue.subscribe(manual_ack: true, consumer_tag: consumer_tag) do |delivery_info, properties, payload|
                    message = JSON.parse payload
                    c = Chat.find_by(app_token: message["app_token"], number: message["chat_number"])
                    m = c.messages.create(text: message["text"], sender: message["sender"], number: message["number"])
                    channel.ack(delivery_info.delivery_tag)
                end
            end
        end
    end
end
