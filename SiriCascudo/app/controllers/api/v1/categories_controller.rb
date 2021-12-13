class Api::V1::CategoriesController < ApplicationController
    acts_as_token_authentication_handler_for User, only: [:create, :update, :delete], fallback_to_devise: false

    def index
        categories = Category.all
        render json: categories, status: 200
    end
    
    def show
        category = Category.find(params[:id])
        category_json = category.to_json(
            :include => {:meals => {only: [:id, :name, :description, :price, :category_id, :picture_url]}},
            except: [:created_at, :updated_at]
        )
        render json: category_json, status: 200
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
        if current_user
            if current_user.is_admin
                category = Category.find(params[:id])
                category.destroy!
                render json: category, status: :ok
            else
                render json: {message: "not admin"}, status: :unauthorized
            end
        else
            render json: {message: "an error has occurred"}, status: :bad_request
        end
    rescue StandardError
        head(:not_found)        
    end

    def update
        if current_user.is_admin
            category = Category.find(params[:id])
            category.update!(category_params)
            render json: category, status: :ok
        else
            render json: {message: "not admin"}, status: :unauthorized
        end
    rescue StandardError => e
        render json: {message: e.class}, status: :unprocessable_entity
    end

    #private methods
    private

    def category_params
        params.require(:category).permit(
            :name
        )
    end
end
