require 'api_constraints'

Jupiter::Application.routes.draw do 

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
        resources :shareables, path: '/shareable', only: [:create] 
        devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
        resources :messages, only: [:create, :index, :show] 
    end
    
    post '/mogreet/callback', to: 'callback#mogreet_callback'
    post '/mogreet/response', to: 'callback#handle_mogreet_response'
    post '/twilio/callback', to: 'callback#twilio_callback'
    
    resources :recordings do
      collection do 
        get 'handle' => 'recordings#handle'
      end
      collection do 
        get 'complete' => 'recordings#complete'
      end
    end
  end
  
  scope '/a' do
    
    resources :help_docs
    
    resources :community_feeds, only: [:index] 

    resources :emails

    resources :messages
    
    resources :recordings

    resources :sms_archives

    resources :client_numbers

    resources :users_clients

    resources :recipients

    resources :sms_responses

    devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
    
    resources :shareables

    resources :clients

    resources :clicks do
      collection do 
        get '/' => 'clicks#create'
      end
    end
  
    post '/clicks/default/:id', to:  "clicks#default"

    resources :email_templates
  
    resources :user_profiles
  end
  
  namespace :admin do |admin|
    resources :user_profiles
    resources :clients
    resources :messages
    resources :users
    resources :sms_responses
  end

  get '*short' => 'api/clicks#create', short: /\w{6}/


  root :to => "home#index"
  
  #get '*short', to: 'api::clicks'
  

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
