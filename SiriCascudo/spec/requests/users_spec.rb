require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST #register" do
    it "Criando usuário corretamente" do
      post "/users/create", params: {user: {email: "123@123",name: "Artur", password: "123456", password_confirmation: "123456"}}
      expect(response).to have_http_status(:created)
      expect((JSON.parse(response.body)["profile_picture_url"]).is_a?(String)).to be true
    end

    it "Criando usuário com senha.lenght < 6" do
      post "/users/create", params: {user: {email: "123@13",name: "Artur",
        password: "12345",
        password_confirmation: "12345"}}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "Criando usuário com password_confirmation errado" do
      post "/users/create", params: {user: {email: "23@123",name: "Artur",
        password: "123456",
        password_confirmation: "123123"}}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "Criando usuário sem password_confirmation" do
      post "/users/create", params: {user:{
        email: "aa@ata",
        name: "Artur",
        password: "123456",
        password_confirmation: ""
      }}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "Criando usuário sem email" do
      post "/users/create", params: {user:{
        email: "",
        name: "Artur",
        password: "123456",
        password_confirmation: "123456"
      }}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "Criando usuário sem nome" do
      post "/users/create", params: {user:{
        email: "ata@ata",
        name: "",
        password: "123456",
        password_confirmation: "123456"
      }}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end


  describe "GET #login" do
    it "logando sem preencher campos" do
      get '/users/login'
      expect(response).to have_http_status(:not_found)
    end

    it "logando como user1 com senha correta" do
      user1 = create(:user) 
      get '/users/login', params: { 
        email: user1.email,
        password: "123456"
      }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["authentication_token"].length).to be <=30
    end

    it "logando como user1 com senha incorreta" do
      user1 = create(:user) 
      get '/users/login', params: { 
        email: user1.email,
        password: "abcdef"
      }
      expect(response).to have_http_status(:unauthorized)
    end
  end

    
  describe "GET #show" do
    it "valid user requesting show" do
      user = create(:user)
      get '/users/show', headers: {'X-User-Token': user.authentication_token,'X-User-Email': user.email}
      expect(response).to have_http_status(:ok)

    end

    it 'with invalid user authentication token' do
      user = create(:user)
      get '/users/show', headers: {
        'X-User-Token': 'souotokendomal',
        'X-User-Email': user.email
      }
      expect(response).to have_http_status(:bad_request)
    end

    it "no user requesting show" do
      get '/users/show'
      expect(response).to have_http_status(:bad_request)
    end

    it "invalid email requesting show" do
      user1 = create(:user)
      get '/users/show', params: {email: "a@a", authentication_token: user1.authentication_token}
      expect(response).to have_http_status(:bad_request)
    end
  end


  describe "DEL #delete" do
    it "valid user requesting delete" do
      user = create(:user)
      delete '/users/delete', headers: {'X-User-Token': user.authentication_token,'X-User-Email': user.email}
      expect(response).to have_http_status(:ok)
    end

    it "no user requesting delete" do
      user = create(:user)
      delete '/users/delete', headers: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "invalid user token requesting delete" do
      user = create(:user)
      delete '/users/delete', headers: {'X-User-Token': "aaaaaaaaaaaaa",'X-User-Email': user.email}
      expect(response).to have_http_status(:bad_request)
    end
  end


  describe "PATCH #update" do
    it "valid user requesting only name update" do
      user = create(:user)
      patch '/users/update', 
        params:  {user: {name: "Artur"}}, 
        headers: {'X-User-Token': user.authentication_token,'X-User-Email': user.email}
      expect(response).to have_http_status(:ok)
    end

    it "valid user requesting only password update" do
      user = create(:user)
      patch '/users/update', 
        params:  {user: {password: "aaa123", password_confirmation: "aaa123"}}, 
        headers: {'X-User-Token': user.authentication_token,'X-User-Email': user.email}
      expect(response).to have_http_status(:ok)
    end

    it "no user requesting update" do
      user = create(:user)
      patch '/users/update', headers: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "invalid user token requesting update" do
      user = create(:user)
      patch '/users/update', headers: {'X-User-Token': "aaaaaaaaaaaaa",'X-User-Email': user.email}
      expect(response).to have_http_status(:bad_request)
    end
  end
    

  describe "GET #logout" do
    it "valid user logout" do
      user = create(:user)
      get '/users/logout', headers: {'X-User-Token': user.authentication_token,'X-User-Email': user.email}
      expect(response).to have_http_status(:ok)
    end

    it "invalid user logout" do
      user = create(:user)
      get '/users/logout', headers: {'X-User-Token': "aaa",'X-User-Email': user.email}
      expect(response).to have_http_status(:bad_request)
    end

    it "no user logout" do
      get '/users/logout'
      expect(response).to have_http_status(:bad_request)
    end
  end
  
  
end
