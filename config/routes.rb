Rails.application.routes.draw do
  resources :quotes
  root 'quotes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'browse',   to: 'quotes#index'
  get 'latest',   to: 'quotes#latest'
  get 'random',   to: 'quotes#random'
  get 'random1',  to: 'quotes#random1'
  get 'search',   to: 'quotes#search'
  get 'top',      to: 'quotes#top'

  resources :quotes do
    member do
      get :downvote
      post :downvote
      get :upvote
      post :upvote
      get :flag
      post :flag
    end
  end

end