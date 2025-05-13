# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get 'results/', to: 'results#index'
  get 'agreements/:id', to: 'agreements#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
