# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :registrations, only: :create
      resources :sessions, only: :create

      resources :feeds, only: %i[create index destroy]
      resources :posts, only: :index
    end
  end
end
