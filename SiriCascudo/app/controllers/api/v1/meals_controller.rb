class Api::V1::MealsController < ApplicationController
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
        meal = Meal.create(meal_params)
        meal.save!
        render json: meal, status: 201

    rescue StandardError
        head(:unprocessable_entity)
    end

    def update
        meal = Meal.find(params[:id])
        meal.update!(meal_params)
        render json: meal, status: 200
    rescue StandardError
        head(:unprocessable_entity)
    end

    def delete
        meal = Meal.find(params[:id])
        meal.destroy!
        render json: meal, status: 200
    rescue StandardError
        head(:bad_request)
    end

    # Private methods

    def meal_params
        params.require(:meal).permit(
            :name,
            :category_id,
            :description,
            :price
        )
    end
end
