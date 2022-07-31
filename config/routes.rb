Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql#execute"
  end
  post "/graphql", to: "graphql#execute"

  root to: 'main#index'
  get 'about', to: 'about#index'
  get 'home', to:'home#new'
  post 'home', to:'home#create'
  get 'information', to:'information#index'


end
