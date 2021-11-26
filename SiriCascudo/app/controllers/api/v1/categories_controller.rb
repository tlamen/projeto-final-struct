class Api::v1::CategoriesController < ApplicationController
    acts_as_token_authentication_handler_for User, only: [:create, :update, :delete]

    def index
        categories = Category.all
        render json: categories, status: 200
    end
    
    def show
        category = Category.find(params[:id])
        render json: category, status: 200
    rescue StandardError
        head(404)
    end

    def create
        if current_user.is_admin
            category = Category.create(category_params)
            category.save!
            render json: category, status: 201
        else
            render json: {message: "not admin"},status: :unauthorized
        end
    rescue StandardError => e
        render json: {message: e.message}, status: :unprocessable_entity    
    end

    def delete
        if current_user.is_admin
            category = Category.create(category_params)
            category.destroy!
            render json: category, status: 201
        else
            render json: {message: "not admin"}, status: :unauthorized
    rescue StandardError
        head(:bad_request)        
    end

    def update
        if current_user.is_admin
            category = Category.create(category_params)
            category.update!(category_params)
            render json: category, status: 201
        else
            render json: {message: "not admin"}, status: :unauthorized
    rescue StandardError
        head(:unprocessable_entity)
    end

    #private methods
    private

    def category_params
        params.require(:category).permit(
            :name
        )
end