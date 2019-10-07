Rails.application.routes.draw do

  devise_for :users, :controllers => {registrations: "registrations", sessions: "sessions"}

  get 'users/index'
  post 'post', to: 'posts#create' 
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end
  root 'static_pages#home'
end
