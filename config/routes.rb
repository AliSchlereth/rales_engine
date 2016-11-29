Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      get '/invoices/find', to: "invoices/search#show"
      get '/invoices/find_all', to: "invoices/search#index"
      get 'invoices/random', to: "invoices/random#show"
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end

end
