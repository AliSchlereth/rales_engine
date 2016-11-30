Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      get '/merchants/random', to: "merchants/random#show"
      get '/invoices/find', to: "invoices/search#show"
      get '/invoices/find_all', to: "invoices/search#index"
      get '/invoices/random', to: "invoices/random#show"
      get '/customers/find', to: "customers/search#show"
      get '/customers/find_all', to: "customers/search#index"
      get '/customers/random', to: "customers/random#show"
      get '/transactions/find', to: "transactions/search#show"
      get '/transactions/find_all', to: "transactions/search#index"
      get '/transactions/random', to: "transactions/random#show"
      get '/items/find', to: "items/search#show"
      get '/items/find_all', to: "items/search#index"
      get '/items/random', to: "items/random#show"
      get '/invoice_items/find', to: "invoice_items/search#show"
      get '/invoice_items/find_all', to: "invoice_items/search#index"
      get '/invoice_items/random', to: "invoice_items/random#show"
      
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "merchants/items"
        resources :invoices, only: [:index], controller: "merchants/invoices"
      end
      
      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index], controller: "invoices/transactions"
      end
      
      resources :items, only: [:index, :show] do
        get '/merchant', to: "items/merchants#show"
        resources :invoice_items, only: [:index], controller: "items/invoice_items"
      end
      
      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: "invoice_items/invoices#show"
      end
      
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index], controller: "customers/invoices"
        resources :transactions, only: [:index], controller: "customers/transactions"
      end
      
      resources :transactions, only: [:index, :show] do
        get '/invoice', to: "transactions/invoices#show" 
      end
      
      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: "invoice_items/invoices#show"
        get '/item', to: "invoice_items/items#show"
      end
      
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end

end
