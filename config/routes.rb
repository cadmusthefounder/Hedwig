Rails.application.routes.draw do
  root                      'tasks#index'
  get 'home'            =>  'static_pages#home'
  get 'about'           =>  'static_pages#about'
  get 'faq'             =>  'static_pages#faq'
  get 'terms_of_use'    =>  'static_pages#terms_of_use'
  get 'privacy_policy'  =>  'static_pages#privacy_policy'

  resources :users, only: [:index, :show, :edit, :update] do
    resources :reviews, except: [:show, :index]
  end

  resources :sessions, only: [:new, :create]
  delete '/sessions', to: 'sessions#destroy'

  resources :tasks, only: [:index, :new, :create, :show] do
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
  end

  resources :threads, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :transactions, only: :index
  namespace :transactions do
    resources :credit_purchases, only: [:new, :create]
    resources :cash_out_requests, only: [:new, :create]
  end

  namespace :admin do
    resources :transactions, only: [:index, :update]
  end
end
