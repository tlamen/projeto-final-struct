require 'rails_helper'

RSpec.describe "Api::V1::Meals", type: :request do

  describe "GET #index" do
    it {get '/api/v1/meals'; expect(response).to have_http_status(:ok)}
  end

  describe "GET #show/:id" do
    it "valid id" do
      meal = create(:meal, name: "testin")
      get "/api/v1/meals/show/#{meal.id}"
      expect(response).to have_http_status(:ok)
    end
    
    it "invalid id" do
      get "/api/v1/meals/show/-1"
      expect(response).to have_http_status(:not_found)
    end
  end
  
  describe "POST #create" do
    valid_params = { }
    it "user is admin" do
      adm = create(:user, :admin)
      post '/api/v1/meals/create', params
    end
    
    it "user isn't admin" do
      
    end
    
  end
  
end
