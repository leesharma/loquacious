Rails.application.routes.draw do
  get 'sessions/new'

  get '/sign_up', to: 'users#new', as: 'sign_up'
  post '/sign_up', to: 'users#create', as: 'users'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'sessions'
  delete '/logout', to: 'sessions#destroy', as: 'log_out'

  root to: 'static_pages#home'
end
