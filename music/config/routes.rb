Rails.application.routes.draw do
  resources :users, only: [:new, :show, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:new, :index]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: [:new, :index]
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]

  root 'bands#index'
end
