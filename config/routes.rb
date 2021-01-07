Rails.application.routes.draw do
  root to: "pictures#index"

  resources :pictures do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get :favorite
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
