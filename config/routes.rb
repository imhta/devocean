Rails.application.routes.draw do
  resources :friend_requests
  # pwa routes
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"
  devise_for :users, :controllers => {registrations: "registrations"}

  get 'users/index'
  resources :posts, except: [:new, :edit, :update]
  resources :comments, except: [:new, :edit, :update, :show, :destory]
  resources :likes, except: [:edit, :update, :show, :new]
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root 'static_pages#home'
end
