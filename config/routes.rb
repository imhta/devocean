Rails.application.routes.draw do
  # pwa routes
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"
  get '/privacy-policy' => 'static_pages#privacy'
  devise_for :users, :controllers => {registrations: "registrations", omniauth_callbacks: 'omni_auth'}

  get 'users/index'
  get 'friends', to: 'friendships#index'
  get 'notifications', to: 'notifications#index'
  resources :posts, except: [:new, :edit, :update]
  resources :comments, except: [:new, :edit, :update, :show, :destory]
  resources :likes, except: [:edit, :update, :show, :new]
  resources :friendships
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root 'static_pages#home'
end
