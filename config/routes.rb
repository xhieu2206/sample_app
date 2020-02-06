Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get 'users/new'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users
  resources :microposts, only: [:create, :destroy]
  get '/search_micropost', to: 'microposts#search_for_micropost'
end
