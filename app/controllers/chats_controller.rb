class ChatsController < ApplicationController
    before_action :prepare_app

    def index
        render json: {
            chats: @app.chats.map(&:serialize)
        }, status: 200
    end

    def create
        chat = @app.chats.create
        render json: {
            chat_number: chat.number
        }, status: 200
    end

    def destroy
        number = params.permit(:number)[:number]
        begin
            chat = @app.chats.find_by!(number: number)
            chat.destroy
            render json: {}, status: 200
        rescue ActiveRecord::RecordNotFound
            render json: {
                error_code: "C001",
                error_message: I18n.t("chat.chat_not_exists", number: number, token: @app.token)
            }
        end
    end

    private

    def prepare_app
        token = params.permit(:app_token)[:app_token]
        begin
            @app = App.find_by!(token: token)
        rescue ActiveRecord::RecordNotFound
            render json: {
                error_code: "A002",
                error_message: I18n.t("app.app_not_exists")
            }
        end
    end
end
