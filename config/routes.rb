Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      get '/merchants/random', to: "merchants/random#show"
      get '/invoices/find', to: "invoices/search#show"
      get '/invoices/find_all', to: "invoices/search#index"
      get '/customers/find', to: "customers/search#show"
      get '/customers/find_all', to: "customers/search#index"
      get '/customers/random', to: "customers/random#show"
      get '/transactions/find', to: "transactions/search#show"
      get '/transactions/find_all', to: "transactions/search#index"
      get '/transactions/random', to: "transactions/random#show"
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end

end
