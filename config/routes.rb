Rails.application.routes.draw do
  
  root to: 'welcome#index'
  get 'about' => 'welcome#about'
  
  resources :charges, only: [:new, :create]
  resources :wikis
  resources :collaborators
  
  get 'memberships/downgrade' => 'memberships#downgrade', as: :downgrade
  get '/transfer_owner', to: 'wikis#transfer_owner', as: :transfer_owner

  devise_for :users
    
end