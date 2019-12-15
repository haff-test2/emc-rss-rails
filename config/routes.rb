Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :registrations, only: :create
      resources :sessions, only: :create
    end
  end
end
