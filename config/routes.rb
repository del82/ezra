Ezra::Application.routes.draw do





  match '/users/manage/save', to: 'users#manage_save'
  match '/users/manage/:id', to: 'users#manage'
  match '/users/:id/recent', to: 'users#recent'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :targets
  resources :features
  resources :hits
  match '/hits/:id/save_clip', to: 'hits#save_clip'
  match '/hits/listen/:clip', to: 'hits#listen'
  resources :activities, only: [:index]
  resources :statics, only: [:show]

  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

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
