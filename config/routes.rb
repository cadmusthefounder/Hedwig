Rails.application.routes.draw do
  get 'static_pages/home'

  get '/update_profile', to: 'users#edit', as: :update_profile
  patch '/update_profile', to: 'users#update'
  put '/update_profile', to: 'users#update'
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
