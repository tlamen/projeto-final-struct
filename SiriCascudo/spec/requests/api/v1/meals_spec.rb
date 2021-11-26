require 'rails_helper'

RSpec.describe "Api::V1::Meals", type: :request do

  describe "GET #index" do
    before do
      create(:meal)
      get "/api/v1/meals/"
    end

    it {expect(response).to have_http_status(:ok) }

    it "returns with json" do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "returns 1 element" do
      expect(JSON.parse(response.body).size).to eq(1)
    end

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
  
  # Falta descobrir como passar o current_user e como passar a categoria como parâmetro
  describe "POST #create" do 
      let(:params) do {
      name: "hamburguer de siri",
      description: "bem gostoso",
      price: 10.0
      # Categoria
    }
    end

    context "with valid params" do
      before do
        post "/api/v1/meals/create", params: { meal: params }
      end

      # Erro
      it "returns succesful response" do
        expect(response).to have_http_status(:created)
      end

      # Erro
      it "creates the meal" do
        new_meal = Meal.find_by(name: "hamburguer de siri")
        expect(new_meal).not_to be_nil
      end
    end
  end
  
end