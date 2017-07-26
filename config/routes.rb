Rails.application.routes.draw do
  resources :trip_comments
  resources :group_comments
  resources :trips
  resources :groups
  resources :calendars
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  get 'users/:id' => 'users#show'
  get '/redirect', to: 'calendar#redirect', as: 'redirect'
  get '/callback', to: 'calendar#callback', as: 'callback'
end
