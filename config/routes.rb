# frozen_string_literal: true

Rails.application.routes.draw do
  root 'accomplishments#index'

  devise_for :users, skip: [:registrations] # this 'skip' prevents people from creating new acconuts

  resources :accomplishment_types, only: [:index, :new, :show, :create, :edit, :update, :destroy]
  resources :accomplishments, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :raise_prep, only: [:index]
end
