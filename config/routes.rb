Rails.application.routes.draw do
  # pwa routes
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"
  devise_for :users, :controllers => {registrations: "registrations"}

  get 'users/index'
  resources :posts
  resources :comments
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root 'static_pages#home'
end
