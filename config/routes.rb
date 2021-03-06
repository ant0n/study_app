require 'sidekiq/web'

Rails.application.routes.draw do
  get 'searches/index'

  get 'searches/show'

  authenticate :user, lambda {|u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  root to: 'questions#index'

  devise_for :users

  concern :commentable do
    resources :comments, except: [:show, :index]
  end

  resources :questions, concerns: :commentable do
    post :subscribe,   on: :member
    post :unsubscribe, on: :member
    resources :answers,
              except:   [:index, :show, :new],
              concerns: :commentable,
              shallow:  true do

      post 'set_best', on: :member
    end
  end

  resources :searches, only: [:index]
  post 'searches/index', to: 'searches#show'

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end
      resources :questions do
        resources :answers, only: [:index, :show, :create]
      end
    end
  end

  post 'vote_up/:object/:id',   to: 'votes#vote_up',   as: 'vote_up'
  post 'vote_down/:object/:id', to: 'votes#vote_down', as: 'vote_down'
  #resources :answers, only: [], concerns: :votable

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
