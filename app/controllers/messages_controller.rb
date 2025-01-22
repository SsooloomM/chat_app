class MessagesController < ApplicationController
    before_action :prepare_chat

    def index
        render json: { messages: @chat.messages.map(&:serialize) }, status: 200
    end

    def create
        puts params
        new_message = params.require(:message).permit(:text, :sender)
        message = @chat.messages.new(new_message)
        if message.save
            render json: {message_number: message.number}, status: 200
        else
            render json: {
                error_code: "M001",
                error_message: I18n.t('message.message_not_complete'),
                errors: message.errors.messages
            }, status: 406
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
                error_code: 'M001',
                error_message: I18n.t('message.message_not_exists', number: number, chat_number: @chat.number, app_token: @chat.app_token)
            } 
        end
    end

    private
    def prepare_chat
        token = params[:app_token]
        chat_number = params[:chat_number]
        begin
            @chat = Chat.find_by!(app_token: token, number: chat_number)
        rescue ActiveRecord::RecordNotFound
            render json: {
                error_code: 'C001',
                error_message: I18n.t('chat.chat_not_exists', number: chat_number, token: token)
            } 
        end
    end
end
