Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get '/videogames', to: 'homes#index'
get '/videogames/new', to: 'homes#index'

  namespace :api do
    namespace :v1 do
      resources :videogames, only: [:index, :create]
    end
  end
end

