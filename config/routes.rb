# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  scope "/admin" do
    resources :users
  end

  root to: 'announcements#index'

  get 'admin',        to: 'admin#index'
  get 'bottom',       to: 'quotes#bottom'  
  get 'browse',       to: 'quotes#index'
  get 'flagged',      to: 'admin#flagged'
  get 'latest',       to: 'quotes#latest'
  get 'random',       to: 'quotes#random'
  get 'random1',      to: 'quotes#random1'
  get 'search',       to: 'quotes#search'
  post '/search',     to: 'search#index'  
  get 'submitted',    to: 'admin#submitted'
  get 'top',          to: 'quotes#top'

  resources :announcements

  resources :quotes do
    member do
      get :downvote
      get :upvote
      get :flag
      get :unflag
      get :approve
      get :search
      post :search
    end
  end

end
