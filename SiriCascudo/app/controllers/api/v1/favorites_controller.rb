class Api::V1::FavoritesController < ApplicationController
    acts_as_token_authentication_handler_for User, fallback_to_devise: false

    def index
        if current_user
            favorites = Favorite.where(user_id: current_user.id)
            favoriteMeals = []
            for fav in favorites do
                favoriteMeals.push( Meal.find(fav.meal_id) )
            end
            render json: favoriteMeals, status: 200
        else
            head(:bad_request)
        end
    end

    def create
        if current_user
            favorite = favorite_params
            favorite[:user_id] = current_user.id
            favorite = Favorite.create(favorite)
            favorite.save!
            render json: favorite, status: 201
        else
            head(:bad_request)
        end
    rescue StandardError => e    
        render json: {message: e.message}, status: :unprocessable_entity
    end

    def delete
        favorite = Favorite.where(user_id: current_user.id)
        favorite.where(meal_id: params[:id])[0].destroy!
        render json: favorite, status: 200
        
    rescue StandardError => e
        render json: {message: e.message}, status: :bad_request
    end
    

    #private methods
    private

    def favorite_params
        params.require(:favorite).permit(
            :meal_id
        )
    end

end
