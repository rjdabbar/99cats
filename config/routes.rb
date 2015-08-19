Rails.application.routes.draw do
  resource :session
  resources :cats
  resources :users, only: [:new, :create]
  resources :cat_rental_requests do
    member do
      post 'approve'
      post 'deny'
    end
  end


end
