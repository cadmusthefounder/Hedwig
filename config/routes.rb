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

  get '/tasks/mine', to: 'tasks/current_users#index'

  resources :tasks do
    post 'assign', on: :member

    resources :threads, only: :show do
      post 'create_message', on: :member, as: :create_message
    end
  end

  resources :threads, only: [:create, :show] do
    resources :messages, only: [:index, :create]
  end
end
