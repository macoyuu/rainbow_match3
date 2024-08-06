Rails.application.routes.draw do
  devise_for :users
  
  root to: 'users#index'
  resources :users, only: [:index, :edit, :show] do
    resources :likes, only: [:create, :destroy]
  end
  resources :chat_rooms, only: [:index, :show, :create] do
    resources :messages, only: [:index, :create]
  end
end
