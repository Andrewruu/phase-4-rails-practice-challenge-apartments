Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :apartments, only: [:create, :update, :show, :destroy, :index]
  resources :tenants, only: [:create, :update, :show, :destroy, :index]
  resources :leases, only: [:create, :destroy]
  
end
