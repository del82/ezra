Ezra::Application.routes.draw do

  devise_for :user
  devise_scope :user do
    get "signin", to: "devise/sessions#new"
  end

  match '/users/manage/save' => 'users#manage_save', :as => :manage_save, :via => :post
  match '/users/manage/:id' => 'users#manage', :as => :manage, :via => :get
  match '/users/:id/recent' => 'users#recent', :as => :recent, :via => :get
  resources :users
  resources :targets
  resources :features
  match '/features/check_feature_uniqueness' => 'features#check_feature_uniqueness', :as => :feature_unique, :via => :post
  resources :hits
  match '/hits/:id/save_clip' => 'hits#save_clip', :as => :save_clip, :via => :post
  match '/hits/listen/:clip' => 'hits#listen', :as => :listen, :via => :get
  resources :activities, only: [:index]
  resources :statics, only: [:show]

  # match '/signin',  to: 'sessions#new'
  # match '/signout', to: 'sessions#destroy', via: :delete

  # static pages
  # match '/about', to: "static_pages#about"
  # match '/people', to: "static_pages#people"
  # match '/publications', to: "static_pages#publications"
  # match '/links', to: "static_pages#links"
  # match '/', to: "static_pages#home"

  match '/:id', to: "statics#show"

  root to: 'statics#show', id: 'home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
