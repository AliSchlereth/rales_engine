Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      get '/invoices/find', to: "invoices/search#show"
      get '/invoices/find_all', to: "invoices/search#index"
      get 'invoices/random', to: "invoices/random#show"
      get '/items/find', to: "items/search#show"
      get '/items/find_all', to: "items/search#index"
      get '/items/random', to: "items/random#show"
      get 'invoice_items/find', to: "invoice_items/search#show"
      get 'invoice_items/find_all', to: "invoice_items/search#index"
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end

end
