Rails.application.routes.draw do
  root 'topics#index'
  resources :topics do
    resources :comments, :only => [:create, :destory]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
