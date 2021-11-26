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

    scope 'users' do
        get 'login', to: 'users#login'
        post 'create', to: 'users#register'
        get 'logout', to: 'users#logout'
        get 'show', to: 'users#show'
        patch 'update', to: 'users#update'
        delete 'delete', to: 'users#delete'
    end

    namespace 'api' do
        namespace 'v1' do
            namespace 'categories' do
                get 'index', to: 'categories#index'
                get 'show/:id', to: 'categories#show'
                post 'create', to: 'categories#create'
                patch 'update/:id', to: 'categories#update'
                delete 'delete/:id', to: 'categories#delete'
            end
        end
    end

    namespace 'api' do
        namespace 'v1' do
            namespace 'favorites' do
                get 'index', to: 'favorites#index'
                get 'show/:id', to: 'favorites#show'
                post 'create', to: 'favorites#create'
                patch 'update/:id', to: 'favorites#update'
                delete 'delete/:id', to: 'favorites#delete'
            end
        end
    end

     # Handling auth_failure
    get 'authentication_failure', to: 'application#authentication_failure'
    delete 'authentication_failure', to: 'application#authentication_failure'
    patch 'authentication_failure', to: 'application#authentication_failure'
end