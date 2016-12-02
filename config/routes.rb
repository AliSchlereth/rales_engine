Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      get '/merchants/random', to: "merchants/random#show"
      get '/merchants/most_revenue', to: "merchants/most_revenue#index"
      get '/merchants/most_items', to: "merchants/most_items#index"
      get '/merchants/revenue', to: "merchants/revenue#index"

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
      get '/items/most_revenue', to: "items/most_revenue#index"
      get '/items/most_items', to: "items/most_items#index"

      get '/invoice_items/find', to: "invoice_items/search#show"
      get '/invoice_items/find_all', to: "invoice_items/search#index"
      get '/invoice_items/random', to: "invoice_items/random#show"

      resources :merchants, only: [:index, :show] do
        # collection do
        #   # get '/merchants/find', to: "merchants/search#show"
        #   get 'find', to: 'merchants/search#show'
        # end
        #
        # member do
        #   get 'items', to: 'merchants/items#index' #api/v1/merchants/17/items
        #   get 'invoices', to: 'merchants/invoices#index'
        # end
        resources :items, only: [:index], controller: "merchants/items"
        resources :invoices, only: [:index], controller: "merchants/invoices"
        get '/revenue', to: 'merchants/revenue#show'
        get '/favorite_customer', to: 'merchants/favorite_customer#show'
        get '/customers_with_pending_invoices', to: 'merchants/customers_with_pending_invoices#index'
      end

      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index], controller: "invoices/transactions"
        resources :invoice_items, only: [:index], controller: "invoices/invoice_items"
        resources :items, only: [:index], controller: "invoices/items"
        get '/customer', to: 'invoices/customers#show'
        get '/merchant', to: 'invoices/merchants#show'
      end

      resources :items, only: [:index, :show] do
        get '/merchant', to: "items/merchants#show"
        resources :invoice_items, only: [:index], controller: "items/invoice_items"
        get '/best_day', to: "items/best_day#show"
      end

      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: "invoice_items/invoices#show"
      end

      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index], controller: "customers/invoices"
        resources :transactions, only: [:index], controller: "customers/transactions"
        get '/favorite_merchant', to: 'customers/merchants#show'
      end

      resources :transactions, only: [:index, :show] do
        get '/invoice', to: "transactions/invoices#show"
      end

      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: "invoice_items/invoices#show"
        get '/item', to: "invoice_items/items#show"
      end

    end
  end

end
