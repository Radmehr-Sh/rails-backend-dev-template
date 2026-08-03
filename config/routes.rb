# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'utilities#health'
  get '/health', to: 'utilities#health'

  namespace :api do
    namespace :v1 do
      ## [DN] Scope routes in these namespaces when possible.

      ## [DN] Example route, action and spec that can be removed
      get 'base/example', to: 'base#example'
    end
  end

  match '*unmatched', to: 'utilities#not_found', via: :all
end
