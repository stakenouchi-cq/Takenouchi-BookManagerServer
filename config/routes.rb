Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/sign_up', to: 'users#sign_up'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/books', to: 'books#create'
  get '/books', to: 'books#index'
  put '/books/:id', to: 'books#update'
end
