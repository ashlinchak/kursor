Kursor::Application.routes.draw do



  mount Ckeditor::Engine => '/ckeditor'

  resources :students
  resources :search
  resources :feedback
  resources :tags
  resources :info
  resources :wiki
  resources :events


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

  match 'feedback' => 'feedback#new', :as => 'feedback', :via => :get
  match 'feedback' => 'feedback#create', :as => 'feedback', :via => :post

  resources :dashboard, :only => [:index]

  resources :news, :only => [:index, :show]

  resources :postings, :path => 'posts'

  resources :users, :path => 'u', :except => [ :destroy] do
    resources :postings
  end
  match '/signup' => 'users#new', :as => :signup
  match '/my_profile' => 'profiles#my_profile', :as => :my_profile
  #match '/my_profile/edit' => 'profiles#edit',  :as => :edit_profile

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

  namespace :admin do
    resources :user_transfers
    resources :categories do
      post 'sort', :on => :collection
    end
    resources :tutor_categories do
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
