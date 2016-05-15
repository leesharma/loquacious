Rails.application.routes.draw do
  # Authentication
  get '/sign_up',   to: 'users#new',        as: 'sign_up'
  post '/sign_up',  to: 'users#create',     as: 'users'
  get '/login',     to: 'sessions#new',     as: 'login'
  post '/login',    to: 'sessions#create',  as: 'sessions'
  delete '/logout', to: 'sessions#destroy', as: 'log_out'

  post '/:room/join', to: 'chat_room_memberships#create', as: 'join'
  get '/rooms',       to: 'chat_rooms#new',               as: 'new_chat_room'
  resources :chat_rooms, only: :create

  post '/dashboard(/:room)', to: 'messages#create', as: 'messages'
  get '/dashboard/global',   to: redirect('/dashboard')
  get '/dashboard(/:room)',  to: 'chat_rooms#index',  as: 'dashboard'

  root to: 'static_pages#home'
end
