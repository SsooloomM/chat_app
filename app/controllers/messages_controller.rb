class MessagesController < ApplicationController
    before_action :prepare_chat

    def index
        render json: { messages: @chat.messages.as_json }, status: 200
    end

    def create
        new_message = params.require(:message).permit(:text, :sender)
        message = @chat.messages.new(new_message)
        begin
            redis_key = "chat:#{@chat.app_token}:#{@chat.number}"
            last_message_number = REDIS.get(redis_key)

            if last_message_number.blank?
                @chat.with_lock do
                    message_number = @chat.message_sequence + 1
                    REDIS.set(redis_key, message_number)
                end
            else
                message_number = last_message_number.to_i + 1
                REDIS.set(redis_key, message_number)
            end
            message.number = message_number
            MessagePublisher.publish("messages", message)
            render json: {
                message: message.as_json
            }
        rescue Exception => e
            render json: e
        end
    end

    def destroy
        number = params[:number]
        begin
            message = @chat.messages.find_by!(number: number)
            message.destroy
            render json: {}, status: 200
        rescue ActiveRecord::RecordNotFound
            render json: {
                error_code: "M001",
                error_message: I18n.t("message.message_not_exists", number: number, chat_number: @chat.number, app_token: @chat.app_token)
            }
        end
    end

    def search
        text = params[:text]
        render json: Message.search(text, @chat.app_token, @chat.number)
    end

    private
    def prepare_chat
        token = params[:app_token]
        chat_number = params[:chat_number]
        begin
            @chat = Chat.find_by!(app_token: token, number: chat_number)
        rescue ActiveRecord::RecordNotFound
            render json: {
                error_code: "C001",
                error_message: I18n.t("chat.chat_not_exists", number: chat_number, token: token)
            }
        end
    end
end
