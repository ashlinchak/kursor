Kursor::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  resources :students

  namespace :admin do
    resources :user_transfers
    resources :categories
    resources :tutor_categories
    resources :info
    resources :news
    resources :notifications
    resources :postings do
      member do
        get :approve
        get :decline
      end
    end
    resources :providers do
      member do
        get :approve
        get :decline
      end
    end
    resources :tutors do
      member do
        get :approve
        get :decline
      end
    end
    resources :posting_categories
    resources :users
    resources :custom_fields do
      post 'sort', :on => :collection
    end
    resources :tutor_custom_fields do
      post 'sort', :on => :collection
    end
    resources :custom_flags do
      post 'sort', :on => :collection
    end
    resources :cities
  end

  resources :search
  resources :feedback
  resources :tags
  resources :info

  match '/login' => 'sessions#new',      :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  resources :sessions, :only => :create

  resources :activations, :only => [:new, :create] do
    get 'perform', :on => :member
  end

  match '/home' => "home#index"
  match '/admin' => "admin/dashboard#index"

  match 'request' => 'provider_request#new', :as => 'request', :via => :get
  match 'request' => 'provider_request#create', :as => 'request', :via => :post

  resources :dashboard, :only => [:index]

  resources :news, :only => [:index, :show]

  resources :postings do
    resources :comments
  end

  resources :users, :except => [ :edit, :destroy] do
    resources :postings
    resources :schedule
  end
  match '/signup' => 'users#new', :as => :signup
  match '/my_profile' => 'users#my_profile', :as => :my_profile
  match '/my_profile/edit' => 'users#edit',  :as => :edit_profile

  resources :providers do
    resources :students, :only => [] do
      collection do
        get 'join'
        get 'leave'
      end
    end
  end

  resources :tutors do
    resources :students, :only => [] do
      collection do
        get 'join'
        get 'leave'
      end
    end
  end

  resources :categories, :only => [:index, :show]
  resources :tutor_categories, :only => [:index, :show]
  resources :posting_categories, :only => [:index, :show]

  root :to => 'home#index'


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
  # match ':controller(/:action(/:id(.:format)))'
end
