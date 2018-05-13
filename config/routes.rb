Rails.application.routes.draw do
  resources :quotes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: :index, controller: 'quotes'
  get 'browse', to: :index, controller: 'quotes'
  get 'latest', to: :latest, controller: 'quotes'
  get 'random', to: :random, controller: 'quotes'

end