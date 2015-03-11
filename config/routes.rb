Rails.application.routes.draw do
  
  root to: 'welcome#index'
  get 'about' => 'welcome#about'
  
  resources :charges, only: [:new, :create]
  resources :wikis
  
  get 'memberships/downgrade' => 'memberships#downgrade', as: :downgrade

  devise_for :users
    
end