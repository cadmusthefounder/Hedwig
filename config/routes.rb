Rails.application.routes.draw do
  root                      'static_pages#home'
  get 'about'           =>  'static_pages#about'
  get 'faq'             =>  'static_pages#faq'
  get 'terms_of_use'    =>  'static_pages#terms_of_use'
  get 'privacy_policy'  =>  'static_pages#privacy_policy'

  get '/update_profile', to: 'users#edit', as: :update_profile
  patch '/update_profile', to: 'users#update'
  put '/update_profile', to: 'users#update'
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
