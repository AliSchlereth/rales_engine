Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end

end
