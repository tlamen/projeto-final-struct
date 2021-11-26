class UsersController < ApplicationController
    acts_as_token_authentication_handler_for User, only: %i[show delete update logout], fallback_to_devise: false

    def register
        user = User.create(create_user_params)
        user.save!
        render json: user, status: :created
    rescue StandardError => e
        render json: {message: e.message}, status: :unprocessable_entity
    end

    def login
        user = User.find_by!(email: params[:email])
        if user.valid_password?(params[:password])
            render json: user
        else
            head(:unauthorized)
        end
    rescue StandardError => e
        render json: { message: e.message }, status: :not_found
    end
    
    def show
        if current_user
            render json: current_user, status: :ok
        else
            head(:bad_request)
        end
    end

    def delete
        current_user.destroy!
        render json: {message: "conta deletada"} ,status: :ok
    rescue StandardError
        head(:bad_request)
    end

    def update
        current_user.update!(update_user_params)
        render json: current_user
    rescue StandardError => e
        render json: {message: e.message}, status: :bad_request
    end

    def logout
        current_user.update! authentication_token: nil
        render json: {message: "Deslogado em todos os aparelhos"}, status: :ok
    rescue StandardError => e
        render json: {message: e.message}, status: :bad_request
    end

    private

    def create_user_params
        params.require(:user).permit(
            :email,
            :name,
            :password,
            :password_confirmation
        )
    end

    def update_user_params
        params.require(:user).permit(
            :name,
            :password,
            :password_confirmation,
            :profile_picture
        )
    end
end
