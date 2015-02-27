Rails.application.routes.draw do

  devise_for :users
  # welcome routes
  root to: 'welcome#index'
  get 'about' => 'welcome#about'
  
end