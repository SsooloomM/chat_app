class AppsController < ApplicationController
    def index
        apps = App.all
        render json: apps.map(&:serialize), stauts: 200
    end

    def create
        app = params.require(:app).permit(:name)
        name = app[:name]
        unless App.exists?(name: name)
            app = App.create(name: name)
            render json: {token: app.token}, stauts: 200
        else
            render json: {
                error_code: 'A001',
                error_message: I18n.t('app.name_already_exists', name: name)
            }, stauts: 406
        end
    end

    def destroy
        params.permit!
        begin
            app = App.find_by!(token: params[:token])
            app.destroy
            render json: {}, status: 200
        rescue ActiveRecord::RecordNotFound
            render json: {
                error_code: 'A002',
                error_message: I18n.t('app.app_not_exists')
            }
        end
    end
end
