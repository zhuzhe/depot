ActionController::Routing::Routes.draw do |map|
  map.resources :daily_reports

  map.resource :openid,:member=>{:complete=>:get}
  map.resources :comments

  map.resources :users,:new=>{:customer=>:get}

  map.resources :line_items

  map.resources :orders

  map.resources :categories

  map.resources :products,:collection=>{:search=>:post,:latest=>:get}
 map.resources :products do |product|
   product.resources :comments
 end
  map.resources :categories do |category|
    category.resources :products
  end

  map.resource :session
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.register '/register',:controller=>"users",:action=>'register'
  map.home '/home',:controller=>"store",:action=>"index"
  map.income '/income',:controller=>'daily_reports',:action=>'every_mouth_income'
   map.root :home

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
    map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end