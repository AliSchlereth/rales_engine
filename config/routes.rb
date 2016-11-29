Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get '/invoices/find', to: "search#show"
      resources :invoices, only: [:index, :show]
    end
  end

end
