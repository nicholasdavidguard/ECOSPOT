Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :spots do
    member do
      post 'toggle_favorite', to: "spots#toggle_favorite"
      put "like" => 'spots#like'
      put "dislike" => 'spots#dislike'
    end
  end
  root to: 'spots#index'

  get 'myfavorites' => 'spots#filter'
  get "search" => 'spots#search', :as => 'search_page'
  get 'myspots' => 'spots#myspots'

  get '/users/:id', :to => 'spots#user_page', :as => 'user_page'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
