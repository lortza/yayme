# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'

  devise_for :users, skip: [:registrations] # this 'skip' prevents people from freating new acconuts

  resources :aisles, only: [:index, :new, :create, :edit, :update, :destroy]
end
