Rails.application.routes.draw do
  root 'static_pages#home'
  #get 'static_pages/home'
  # root 'application#hello'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  # get 'users/new'
  # get 'users/show'
  resources :users
end
