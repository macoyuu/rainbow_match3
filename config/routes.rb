Rails.application.routes.draw do
  devise_for :users
  
  root to: 'users#index'
  resources :users, only: [:index, :edit, :show, :update] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:index, :show, :create]
  end
  
end
