Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :goals, only: [:create, :new]
  end
  
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:create, :new]
end
