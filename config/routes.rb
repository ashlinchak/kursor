Kursor::Application.routes.draw do

  get '/auth/:provider/callback'   => "authentications#create"
  post '/auth/:provider/callback'  => 'authentications#create'

  devise_for  :users,
              :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" },
              :skip => [:sessions]

  as :user do
    get '/login'   => "devise/sessions#new",       :as => :new_user_session
    post '/login'  => 'devise/sessions#create',    :as => :user_session
    delete '/logout'  => 'devise/sessions#destroy',   :as => :destroy_user_session
    get "/register"   => "devise/registrations#new",   :as => :new_user_registration
  end

  mount Ckeditor::Engine => '/ckeditor'

  resources :students
  resources :search, :only => [:index]
  resources :feedback
  resources :tags
  resources :info
  resources :wiki
  resources :events
  resources :authentications


  match '/home' => "home#index"
  match '/admin' => "admin/dashboard#index"

  match 'feedback' => 'feedback#new', :as => 'feedback', :via => :get
  match 'feedback' => 'feedback#create', :as => 'feedback', :via => :post

  resources :dashboard, :only => [:index]

  resources :news, :only => [:index, :show]

  resources :postings, :path => 'posts'

  resources :users, :path => 'u', :except => [ :destroy] do
    resources :postings
  end

  match '/my_profile' => 'profiles#my_profile', :as => :my_profile

  resources :profiles

  resources :providers, :path => 'provs'  do
    resources :students, :only => [] do
      collection do
        get 'join'
        get 'leave'
      end
    end
    resources :votes do
      collection do
        post 'vote'
      end
    end
    resources :provider_requests
    resources :events
  end

  resources :tutors, :path => 'tutors' do
    resources :students, :only => [] do
      collection do
        get 'join'
        get 'leave'
      end
    end
    resources :votes do
      collection do
        post 'vote'
      end
    end
    resources :postings
    resources :events
  end

  resources :categories, :path => 'c', :only => [:index, :show]
  resources :tutor_categories, :path => 't', :only => [:index, :show]
  resources :posting_categories, :path => 'p', :only => [:index, :show]
  resources :event_categories, :path => 'e', :only => [:index, :show]

  namespace :admin do
    resources :filials
    resources :user_transfers
    resources :categories do
      post 'sort', :on => :collection
    end
    resources :tutor_categories do
      post 'sort', :on => :collection
    end
    resources :event_categories do
      post 'sort', :on => :collection
    end
    resources :info
    resources :wiki
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
        get :destroy_filials
      end
      get 'export', :on => :collection
    end
    resources :tutors do
      member do
        get :approve
        get :decline
      end
      get 'export', :on => :collection
    end
    resources :posting_categories do
      post 'sort', :on => :collection
    end
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
    resources :promotions
  end

  root :to => 'home#index'

end
