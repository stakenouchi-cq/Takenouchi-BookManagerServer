Rails.application.routes.draw do
  resources :books
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/sign_up', to: 'users#sign_up'
  post '/login', to: 'users#login'
  post '/books', to: 'books#create'
end
