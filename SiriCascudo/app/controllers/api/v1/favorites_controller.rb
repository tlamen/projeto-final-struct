class Api::V1::MealsController < ApplicationController
    acts_as_token_authentication_handler_for User, only: [:create, :update, :delete]

    def index
        favorites = Favorite.all
        render json: favorites, status: 200
    end

    def show
        favorite = Favorite.find(params[:id])
        render json: favorite, status: 200
    rescue StandardError
        head(404)    
    end

    def create
        favorite = Favorite.create(favorite_params)
        favorite.save!
        render json: favorite, status: 201
    rescue StandardError => e    
        render json: {message: e.message}, status: :unprocessable_entity
    end

    def delete
        favorite = Favorite.find(params[:id])
        favorite.destroy!
        render json: favorite, status: 200
    rescue StandardError
        head(:bad_request)    
    end
    
    def update
        favorite = Favorite.find(params[:id])
        favorite.update!(favorite_params)
        render json: favorite, status: 200
    rescue StandardError
        head(:unprocessable_entity)
    end

    #private methods
    private

    def favorite_params
        params.require(:favorite).permit(
            :user_id,
            :meal_id
        )
    end
end