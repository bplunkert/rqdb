Rails.application.routes.draw do
devise_for :users, controllers: { registrations: 'users/registrations' }
scope "/admin" do
  resources :users
end

  root to: 'quotes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'admin',        to: 'admin#index'
  get 'browse',       to: 'quotes#index'
  get 'flagged',      to: 'admin#flagged'
  get 'latest',       to: 'quotes#latest'
  get 'random',       to: 'quotes#random'
  get 'random1',      to: 'quotes#random1'
  get 'search',       to: 'quotes#search'
  get 'submitted',    to: 'admin#submitted'
  get 'top',          to: 'quotes#top'

  resources :quotes do
    member do
      get :downvote
      post :downvote
      get :upvote
      post :upvote
      get :flag
      post :flag
      get :unflag
      post :unflag
      get :approve
      post :approve
    end
  end

end
