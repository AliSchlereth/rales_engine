Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get '/invoices/find', to: "invoices/search#show"
      get '/invoices/find_all', to: "invoices/search#index"
      resources :invoices, only: [:index, :show]
    end
  end

end
