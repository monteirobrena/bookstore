Rails.application.routes.draw do
  resources :publishing_houses, path: '/publishing-houses'

  resources :books, only: [:index, :show] do
    post :webhook, on: :collection
  end

  resources :authors, only: [:index, :show] do
    post :webhook, on: :collection
  end
  
  get '*unmatched_route', to: 'application#route_not_found'
end
