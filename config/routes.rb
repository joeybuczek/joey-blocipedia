Rails.application.routes.draw do

  # welcome routes
  root to: 'welcome#index'
  get 'about' => 'welcome#about'
  
end