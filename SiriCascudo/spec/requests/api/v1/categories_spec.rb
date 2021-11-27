require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  describe "GET #index" do
    context "normal request" do
      before do
        create(:category)
        get '/api/v1/categories/index'
      end
      
      it { expect(response).to have_http_status(:ok) }

      it { expect( (JSON.parse(response.body).first).length ).to eq(2)  }
    end
  end
  


  describe "GET #show" do
    context "normal request" do
      before do
        cat = create(:category)
        get "/api/v1/categories/show/#{cat.id}"
      end

      it { expect(response).to have_http_status(:ok) }
      
      # Contains meals
      it { expect( (JSON.parse(response.body)).length ).to eq(3)  }
    end


    context "invalid request" do
      it "should return status not found" do
        get "/api/v1/categories/show/-1"
        expect(response).to have_http_status(:not_found)  
      end
    end
  end
  


  describe "POST #create" do
    let(:valid_params) { {name: "teste"} }
  
    context "admin post with valid params" do
      before do
        adm = create(:user, :admin)
        post '/api/v1/categories/create', 
          params: { category: valid_params },
          headers: {'X-User-Token': adm.authentication_token, 'X-User-Email': adm.email}
      end
      
      it { expect(response).to have_http_status(:created)  }

      it { expect( (JSON.parse(response.body)).length ).to eq(2) }
    end

    
    context "admin posting with invalid params" do
      before do
        adm = create(:user, :admin)
        post '/api/v1/categories/create', 
          params: { category: {name: ""} },
          headers: {'X-User-Token': adm.authentication_token, 'X-User-Email': adm.email}
      end
      
      it { expect(response).to have_http_status(:unprocessable_entity)  }
    end
    

    context "non-admin post with valid params" do
      before do
        user = create(:user)
        post '/api/v1/categories/create', 
          params: { category: valid_params },
          headers: {'X-User-Token': user.authentication_token, 'X-User-Email': user.email}
      end
      
      it { expect(response).to have_http_status(:unauthorized)  }
    end
  end



  describe "PATCH #update" do
    let(:valid_params) { {name: "teste"} }

    context "admin patch with valid_params" do
      before do
        adm = create(:user, :admin)
        @cat = create(:category)
        patch "/api/v1/categories/update/#{@cat.id}", 
          params: { category: valid_params },
          headers: {'X-User-Token': adm.authentication_token, 'X-User-Email': adm.email}
      end

      it { expect(response).to have_http_status(:ok)  }
      
      it { expect( (JSON.parse(response.body)).length ).to eq(2) }

      it { expect( JSON.parse(response.body)["id"] ).to be @cat.id }

      it { expect( JSON.parse(response.body)["name"] ).not_to be @cat.name }
    end


    context "admin patch invalid id with valid_params" do
      before do
        adm = create(:user, :admin)
        patch "/api/v1/categories/update/-1", 
          params: { category: valid_params },
          headers: {'X-User-Token': adm.authentication_token, 'X-User-Email': adm.email}
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end


    context "non-admin patch with valid_params" do
      before do
        user = create(:user)
        cat = create(:category)
        patch "/api/v1/categories/update/#{cat.id}", 
          params: { category: valid_params },
          headers: {'X-User-Token': user.authentication_token, 'X-User-Email': user.email}
      end

      it { expect(response).to have_http_status(:unauthorized)  }
    end
  end



  describe "DELETE #delete" do
    context "admin valid delete" do
      before do
        adm = create(:user, :admin)
        @cat = create(:category)
        delete "/api/v1/categories/delete/#{@cat.id}", 
          headers: {'X-User-Token': adm.authentication_token, 'X-User-Email': adm.email}
      end
      
      it { expect(response).to have_http_status(:ok) }

      it { expect(JSON.parse(response.body).length).to eq(2) }

      it { expect(JSON.parse(response.body)["id"]).to eq(@cat.id) }

      it "should have deleted it" do
        get "/api/v1/categories/show/#{@cat.id}"
        expect(response).to have_http_status(:not_found) 
      end
    end


    context "admin invalid delete" do
      before do
        adm = create(:user, :admin)
        delete "/api/v1/categories/delete/-1", 
        headers: {'X-User-Token': adm.authentication_token, 'X-User-Email': adm.email}
      end

      it { expect(response).to have_http_status(:bad_request) }
    end


    context "non-admin valid category_id delete" do
      before do
        user = create(:user)
        @cat = create(:category)
        delete "/api/v1/categories/delete/#{@cat.id}", 
          headers: {'X-User-Token': user.authentication_token, 'X-User-Email': user.email}
      end
      
      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(JSON.parse(response.body).length).to eq(1) }
    end
  end
end
