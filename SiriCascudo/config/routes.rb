Rails.application.routes.draw do
  devise_for :users, skip: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'meals' do
        get '/', to: 'meals#index'
        get '/show/:id', to: 'meals#show'
        post 'create', to: 'meals#create'
        patch 'update/:id', to: 'meals#update'
        delete 'delete/:id', to: 'meals#delete'
      end
    end
  end

  get '/login', to: 'users#login'
  post '/create', to: 'users#register'
  scope 'profile' do
    get '/', to: 'users#show'
    delete '/delete', to: 'users#delete'
    patch 'update', to: 'users#update'
  end

  # Handling auth_failure
  get 'authentication_failure', to: 'application#authentication_failure'
  delete 'authentication_failure', to: 'application#authentication_failure'
  patch 'authentication_failure', to: 'application#authentication_failure'
end
