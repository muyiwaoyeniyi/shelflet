Shelflet::Application.routes.draw do
    
  root to: 'static_pages#home'  
  match '/about',   to: 'static_pages#about'
  match '/storeowners',   to: 'static_pages#storeowners'
  match 'contact' => 'messages#new', :as => 'contact', :via => :get
  match 'contact' => 'messages#create', :as => 'contact', :via => :post
  match '/terms',   to: 'static_pages#terms'
  match '/privacy',   to: 'static_pages#privacy'
  match '/howitworks', to: 'static_pages#howitworks'
  match '/faqs', to: 'static_pages#faqs'


  
  #match 'oauth2callback' => 'documents#set_google_drive_token' # user return to this after login  
  #match 'list_google_doc'  => 'documents#list_google_docs', :as => :list_google_doc #for listing the google docs
  #match 'download_google_doc'  => 'documents#download_google_docs', :as => :download_google_doc #downlo
  


  devise_for :users, :path_names => { sign_in: "login", sign_out: "logout", sign_up: "signup" }, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
      get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  match '/list',   to: 'user_books#new'
  resources :user_books #do
     #resources :user_book_photos, :only => [:index]  
  #end  
  
  resources :user_book_photos, :only => [:index] 
  resources :users

  resources :books, :only => [:index]
  resources :categories, :only => [:index]
  resources :google_books_api, :only => [:index]    #need to secure this at some point
  resources :static_pages, :only => [:index]        #for list page google book controller..need something that returns quickly...see JS
  resources :messages, :only => [:new, :create]     #for contact use page
  
  match "/*other", to: 'static_pages#to_404'      #all non-existent routes go to 404
 




#  root :to => "home#index"
#
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
