require 'rails_helper'

RSpec.describe "V1::Api::Favorites", type: :request do
    before do
        @user = create(:user)
    end
    
    describe "GET #index" do
        context "valid user requesting" do
            before do
                create(:favorite, user_id: 666)
                get '/api/v1/favorites/index',
                    headers: {'X-User-Token': @user.authentication_token, 'X-User-Email': @user.email}
            end
            
            it { expect(response).to have_http_status(:ok) }
            it { expect(JSON.parse(response.body).length).to eq(1) }
        end


        context "invalid user requesting" do
            it "should have status :bad_request" do
                get '/api/v1/favorites/index', headers: {'X-User-Token': "aaa", 'X-User-Email': "aaa@a"}
                expect(response).to have_http_status(:bad_request) 
            end
        end
    end



    describe "POST #create" do
        context "valid user, valid meal id" do
            before do
                @meal = create(:meal)
                post "/api/v1/favorites/create", 
                    params: {favorite: {meal_id: @meal.id}},
                    headers: {'X-User-Token': @user.authentication_token, 'X-User-Email': @user.email}
            end
            
            it { expect(response).to have_http_status(:created) }

            it { expect(JSON.parse(response.body)["meal_id"]).to eq(@meal.id) }

            it { expect(JSON.parse(response.body)["user_id"]).to eq(@user.id) }
        end


        context "valid user, invalid meal id" do
            before do
                post "/api/v1/favorites/create", 
                    params: {favorite: {meal_id: -1} },
                    headers: {'X-User-Token': @user.authentication_token, 'X-User-Email': @user.email}
            end
            
            it { expect(response).to have_http_status(:unprocessable_entity) }
        end


        context "invalid user, valid meal id" do
            before do
                @meal = create(:meal)
                post "/api/v1/favorites/create", 
                    params: {favorite: {meal_id: @meal.id}},
                    headers: {'X-User-Token': "aa", 'X-User-Email': "aa@aa"}
            end
            
            it { expect(response).to have_http_status(:unauthorized) }
        end
    end



    describe "DELETE #delete" do
        context "valid user, valid meal id" do
            before do
                @favorite = create(:favorite, user_id: 666)
                delete "/api/v1/favorites/delete/#{@favorite.id}",
                    headers: {'X-User-Token': @user.authentication_token, 'X-User-Email': @user.email}
            end
            
            it { expect(response).to have_http_status(:ok) }

            it { expect(JSON.parse(response.body)["id"]).to be @favorite.id }
        
            it "should have been deleted" do
                get '/api/v1/favorites/index',
                    headers: {'X-User-Token': @user.authentication_token, 'X-User-Email': @user.email}
                expect(JSON.parse(response.body).length).to eq(0)
            end
        end
    end
end
