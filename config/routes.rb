Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :cats
  resources :users, only: [:new, :create]
  resources :cat_rental_requests do
    member do
      post 'approve'
      post 'deny'
    end
  end


end
