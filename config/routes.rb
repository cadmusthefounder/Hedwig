Rails.application.routes.draw do
  root                      'tasks#index'
  get 'home'            =>  'static_pages#home'
  get 'about'           =>  'static_pages#about'
  get 'faq'             =>  'static_pages#faq'
  get 'terms_of_use'    =>  'static_pages#terms_of_use'
  get 'privacy_policy'  =>  'static_pages#privacy_policy'

  get '/update_profile', to: 'users#edit', as: :update_profile
  patch '/update_profile', to: 'users#update'
  put '/update_profile', to: 'users#update'
  resources :sessions
  delete '/sessions', to: 'sessions#destroy'

  resources :tasks do
    member do
      post 'assign'
      post 'accept', to: 'tasks#accept_assignment'
      post 'reject', to: 'tasks#reject_assignment'
      post 'complete', to: 'tasks#complete_task'
    end

    collection do
      get 'mine', to: 'tasks/current_users#index', as: :my
      get 'assigned_to_me', to: 'assigned_tasks/current_users#index'
    end

    resources :threads, only: :show do
      post 'create_message', on: :member, as: :create_message
    end
  end

  resources :threads, only: [:create, :show] do
    resources :messages, only: [:index, :create]
  end

  resources :credit_purchases, only: [:new, :create]
  resources :cash_out_requests, only: [:new, :create]
  resources :transactions, only: :index

  namespace :admin do
    resources :credit_purchases do
      collection do
        get 'all', to: 'credit_purchases#all_index'
        get 'pending', to: 'credit_purchases#pending_index'
        get 'approved', to: 'credit_purchases#approved_index'
      end

      post 'approve', on: :member, to: 'credit_purchases#approve'
    end
  end
end
