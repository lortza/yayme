# frozen_string_literal: true

Rails.application.routes.draw do
  root 'accomplishments#index'

  devise_for :users, skip: [:registrations] # this 'skip' prevents people from creating new acconuts

  resources :accomplishment_types, only: [:index, :new, :show, :create, :edit, :update, :destroy]
  resources :accomplishments, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :raise_prep, only: [:index]

  get '/word_cloud', to: 'reports#word_cloud'
  get '/new_years_eve', to: 'reports#new_years_eve'
end
