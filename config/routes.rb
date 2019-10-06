Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, :controllers => {registrations: "registrations", sessions: "sessions"}

  get 'users/index'
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
