Rails.application.routes.draw do

  devise_for :users, :controllers => {registrations: "registrations", sessions: "sessions"}

  get 'users/index'
  authenticated :user do
    root to: 'home#index', as: 'feed'
  end
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
