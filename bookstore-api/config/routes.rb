Rails.application.routes.draw do
  resources :books
  resources :publishing_houses, path: '/publishing-houses'

  resources :authors, only: [:index, :show] do
    post :webhook, on: :collection
  end
end
