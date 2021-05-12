Rails.application.routes.draw do

  root 'posts#index', as: 'home'

  get 'admin/posts', to: 'admin/posts#index', as: 'tools'

  get 'about' => 'pages#about', as: 'about'

  post 'worker/:id' => 'admin/posts#worker', as: 'worker'
  get 'worker/:id' => 'admin/posts#worker', as: 'worker_get'

  resources :posts do
    resources :comments
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :admin do
    resources :posts do
      resources :comments
    end
  end



end
