class ApplicationController < ActionController::API
    def authentication_failure
        render json: { message: "Esteja logado para isso"}, status: :unauthorized
    end
end
