Rails.application.routes.draw do
  # get 'sessions/new'
  #
  # get 'sessions/create'
  #
  # get 'sessions/destroy'

  # resources :posts
  # resources :users

  root 'posts#index', as: 'home'

  get 'sign_in', to: 'sessions#new'
  delete 'sign_out', to: 'sessions#destroy'

  resources :sessions, only: [:create]

  # namespace :user do
  #   resources :posts
  # end

  resources :users do
    resources :posts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
