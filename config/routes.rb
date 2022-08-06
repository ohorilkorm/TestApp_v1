Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql#execute' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  root to: 'main#index'
  get 'about', to: 'about#index'
  get 'home', to: 'home#new'
  post 'home', to: 'home#create'
  get 'information', to: 'information#index'
end
