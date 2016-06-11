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

  get 'new_task'        =>  'tasks#new'
  get 'all_tasks'       =>  'tasks#index'
  resources :tasks do
    post 'express_interest', on: :member, as: :task_express_interest
  end
end
