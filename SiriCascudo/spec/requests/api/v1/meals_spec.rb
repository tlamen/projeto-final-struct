require 'rails_helper'

RSpec.describe "Api::V1::Meals", type: :request do

  describe "GET #index" do
    context "requesting index" do
      it "" do
        get "/api/v1/meals/index"
        expect(response).to have_http_status(:ok) 
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "GET #show/:id" do
    it "valid id" do
      meal = create(:meal, name: "testin")
      get "/api/v1/meals/show/#{meal.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(6)
    end
    
    it "invalid id" do
      get "/api/v1/meals/show/-1"
      expect(response).to have_http_status(:not_found)
    end
  end
  


  describe "POST #create" do 
    let(:params) do {
      name: "hamburguer de siri",
      description: "bem gostoso",
      price: 10.0,
      category_id: create(:category).id
      }
    end

    
    context "adm post with valid params" do
      before do
        adm = create(:user, :admin)
        post "/api/v1/meals/create", 
          params: { meal: params }, 
          headers: {
            'X-User-Token': adm.authentication_token,
            'X-User-Email': adm.email}
      end

      it "returns succesful response" do
        expect(response).to have_http_status(:created)
      end

      it "creates the meal" do
        new_meal = Meal.find_by(name: "hamburguer de siri")
        expect(new_meal).not_to be_nil
      end
    end


    context "user post with valid params" do
      before do
        user = create(:user)
        post "/api/v1/meals/create", 
          params: { meal: params }, 
          headers: {
            'X-User-Token': user.authentication_token,
            'X-User-Email': user.email}
      end

      it "returns unauthorized response" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  


  describe "PATCH #update" do
    let(:params) do {
      name: "hamburguer de siri",
      description: "bem gostoso",
      price: 10.0,
      category_id: create(:category).id
      }
    end


    context "admin patch with valid params" do
      before do
        adm = create(:user, :admin)
        @meal = create(:meal)
        patch "/api/v1/meals/update/#{@meal.id}", params: { meal: params }, 
        headers: {
          'X-User-Token': adm.authentication_token,
          'X-User-Email': adm.email}
      end

      it "returns ok status" do
        expect(response).to have_http_status(:ok)
      end
      it "returns json with updated meal" do
        expect((JSON.parse(response.body)).length).to eq(6)
        expect(JSON.parse(response.body)["id"]).to be @meal.id
        expect(JSON.parse(response.body)).not_to be @meal
      end
    end
    

    context "user patch with valid params" do
      before do
        user = create(:user)
        meal = create(:meal)
        patch "/api/v1/meals/update/#{meal.id}", params: { meal: params }, 
        headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email}
      end

      it "returns unauthorized status" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end



  describe "DELETE #delete" do
    context "valid delete by admin" do
      before do
        adm = create(:user, :admin)
        meal = create(:meal)
        delete "/api/v1/meals/delete/#{meal.id}", headers: {
          'X-User-Token': adm.authentication_token,
          'X-User-Email': adm.email}
      end

      it "returns status deleted" do
        expect(response).to have_http_status(:ok)
      end
      it "returns json with deleted meal" do
        expect(JSON.parse(response.body)).not_to be_nil
        expect( (JSON.parse(response.body)).length ).to eq(6)
      end
      it "removes meal from db" do
        meal = build(:meal)
        get "/api/v1/meals/show/#{meal.id}"
        expect(response).to have_http_status(:not_found)
      end
    end


    context "invalid delete by admin" do
      before do
        adm = create(:user, :admin)
        delete "/api/v1/meals/delete/-1", headers: {
          'X-User-Token': adm.authentication_token,
          'X-User-Email': adm.email}
      end

      it {expect(response).to have_http_status(:not_found)}
    end
    

    context "valid delete by non-admin" do
      before do
        user = create(:user)
        meal = create(:meal)
        delete "/api/v1/meals/delete/#{meal.id}", headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email}
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

end