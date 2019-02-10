Rails.application.routes.draw do
  resources :categories
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'topics#index'
  resources :topics do
    resources :comments, :only => [:edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
