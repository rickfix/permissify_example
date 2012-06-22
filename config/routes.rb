Permissify::Application.routes.draw do
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
  resource :user_session
  resources :roles
  resources :products
  resources :admin_users
  
  resources :admin do
    resources :admin_users
    resources :users, :controller => :admin_users
  end
  
  resources :dealers do
    resources :users, :controller => :dealer_users
  end
  
  resources :corporations do
    resources :users, :controller => :corporation_users
  end
  
  resources :brands do
    resources :users, :controller => :brand_users
  end
  
  resources :merchants do
    resources :users, :controller => :merchant_users
  end
  
  match ':entity_type/:entity_id/dealers' => "dealers#index", :as => :entity_dealers
  match ':entity_type/:entity_id/dealer/:id' => "dealers#update_dealer", :as => :update_entity_dealer
  
  match ':entity_type/:entity_id/corporations' => "corporations#index", :as => :entity_corporations
  match ':entity_type/:entity_id/corporation/:id' => "corporations#update_corporation", :as => :update_entity_corporation
  
  match ':entity_type/:entity_id/brands' => "brands#index", :as => :entity_brands
  match ':entity_type/:entity_id/brand/:id' => "brands#update_brand", :as => :update_entity_brand
  
  match ':entity_type/:entity_id/merchants' => "merchants#index", :as => :entity_merchants

  match ':entity_type/:entity_id/products' => "entity_products#index", :as => :entity_products
  match ':entity_type/:entity_id/products/:id/:on_or_off' => "entity_products#update", :as => :update_entity_products

  match ':entity_type/:entity_id/egift' => "egift#show", :as => :egift
  match ':entity_type/:entity_id/guest_management' => "guest_management#show", :as => :guest_management

  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'admins' => 'admin_users#index'
  root :to => 'login#new'
end
