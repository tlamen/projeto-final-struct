class Api::V1::MealsController < ApplicationController
    acts_as_token_authentication_handler_for User, only: [:create, :update, :delete], fallback_to_devise: false

    def index
        meals = Meal.all
        render json: meals, status: 200
    end

    def show
        meal = Meal.find(params[:id])
        render json: meal, status: 200
    rescue StandardError
        head(404)
    end

    def create
        if current_user.is_admin
            meal = Meal.create(meal_params)
            meal.save!
            render json: meal, status: 201
        else
            render json: {message: "not admin"},status: :unauthorized
        end
    rescue StandardError => e
        render json: {message: e.message}, status: :unprocessable_entity
    end

    def update
        if current_user.is_admin
            meal = Meal.find(params[:id])
            meal.update!(meal_params)
            render json: meal, status: 200
        else
            render json: {message: "not admin"},status: :unauthorized
        end
    rescue StandardError => e
        render json: {message: e.message}, stauts: :unprocessable_entity
    end

    def delete
        if current_user
            if current_user.is_admin
                meal = Meal.find(params[:id])
                meal.destroy!
                render json: meal, status: 200
            else
                render json: {message: "not admin"}, status: :unauthorized
            end
        else
            render json: {message: "an error has occurred"}, status: :bad_request
        end
       
    rescue StandardError
        head(:not_found)
    end

    # Private methods
    private
    
    def meal_params
        params.require(:meal).permit(
            :name,
            :category_id,
            :description,
            :price,
            :picture
        )
    end
end
