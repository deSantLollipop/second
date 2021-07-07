Rails.application.routes.draw do

  root 'posts#index', as: 'home'

  get 'admin/posts', to: 'admin/posts#index', as: 'tools'

  get 'about' => 'pages#about', as: 'about'


  get 'worker/:id' => 'admin/posts#worker', as: 'worker'
  post 'worker/:id' => 'admin/posts#worker', as: 'worker_post'

  get 'worker_status/:id' => 'admin/posts#worker_status', as: 'worker_status'
  post 'worker_status/:id' => 'admin/posts#worker_status', as: 'worker_status_post'

  get 'pdf/:id' => 'admin/posts#pdf', as: 'pdf'

  get 'download/:pdf_name' => 'admin/posts#download', as: 'download'
  post 'download/' => 'admin/posts#download', as: 'download_post'


  resources :posts do
    resources :comments
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :admin do
    resources :posts do
      resources :comments
    end
  end

  namespace :api do
    namespace :v1 do
      resources :posts do
        resources :comments
        end
    end
  end


end
