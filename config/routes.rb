Website::Application.routes.draw do
	resources :documents


	get "search/search"

	get "sitemap", to: "sitemap#index"
	get "robots.txt", to: "sitemap#robots"

	# kind of unnecessary...
	# Completely necessary for production error handling to work!!!
	get "error", to: "error#index" 

	resources :events

	get "permissions/create"
	get "permissions/destroy"

	resources :todos do
		get "complete", :on => :member
		get "uncomplete", :on => :member
		post "assign", :on => :member
		post "unassign", :on => :member
	end
	resources :comments
	resources :forums
	resources :photos do
		get "mass", :on => :collection
	end
	resources :albums
	resources :pages
	resources :users
	resources :permissions
	resources :sessions
	resources :posts
	resources :groups do
		get "join", :on => :member
		get "unjoin", :on => :member
	end

	get "sessions/new"
	get "welcome/index"
	get "log_in", to: "sessions#new", :as => "log_in"
	get "log_out", to: "sessions#destroy", :as => "log_out"
	get "sign_up", to: "users#new", :as => "sign_up"
	# get "groups", to: "groups#new", :as => "groups"
	# get "users", to: "users#index", :as => "users"
	get "search", to: "search#search", :as => "search"

	get '/pages/*titles', to: "pages#show"
	get '/tags/:tag', to: "tags#show"

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
	root :to => 'welcome#index'

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id))(.:format)'

	# error
	get "*path", to: "error#index"
end
