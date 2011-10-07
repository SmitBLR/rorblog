PowerMeMobileBlog::Application.routes.draw do

  get "sessions/new"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/admins/auth/:provider' => 'admins/omniauth_callbacks#passthru'
  end

  devise_for :admins, :controllers => { :sessions => "admins/sessions", :passwords => "admins/passwords" }

  resources :articles do
    resources :comments
  end

  resources :links

  root :to => 'articles#index'

  match ':controller(/:action(/:id(.:format)))'
end