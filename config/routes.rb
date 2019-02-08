# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'signup', to: 'pages#signup'

  get 'user/:id' => 'pages#show'

  resources :posts, :users

  resources :posts do
    resources :comments
  end
end
