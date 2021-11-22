Rails.application.routes.draw do
  devise_for :users, skip: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'users' do
        get '/login', to: 'users#login'
      end
      scope 'meals' do
        get '/', to: 'meals#index'
        get '/show/:id', to: 'meals#show'
        post 'create', to: 'meals#create'
        patch 'update/:id', to: 'meals#update'
        delete 'delete/:id', to: 'meals#delete'
      end
    end
  end
end
