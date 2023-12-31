Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :families, only: [:index, :show, :edit, :update] do
    resources :children, only: [:show, :new, :create, :edit, :update]
    resources :groups, only: [:new, :create, :edit, :update]
  end
  resources :children, only: [:destroy]
  resources :groups, only: [:index, :show, :destroy] do
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
    resources :families_groups, only: [:new, :create, :destroy]
    resources :plannings, only: [:new, :create]
    resources :events do
      member do
        post 'register', to: 'events#register'
      end
      resources :events_families, only: :destroy
    end
  end
  resources :families_groups, only: [:destroy] do
    member do
      patch 'accept'
      patch 'refuse'
    end
  end
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  # resources :events
end
