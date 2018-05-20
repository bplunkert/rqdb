Rails.application.routes.draw do
<<<<<<< HEAD
  resources :quotes
  root 'quotes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'browse',   to: 'quotes#index'
  get 'latest',   to: 'quotes#latest'
  get 'random',   to: 'quotes#random'
  get 'random1',  to: 'quotes#random1'
  get 'search',   to: 'quotes#search'
  get 'top',      to: 'quotes#top'
=======
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
>>>>>>> admin

  resources :quotes do
    member do
      get :downvote
      post :downvote
      get :upvote
      post :upvote
      get :flag
      post :flag
<<<<<<< HEAD
    end
  end

end
=======
      get :unflag
      post :unflag
      get :approve
      post :approve
    end
  end

end
>>>>>>> admin
