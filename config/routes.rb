Rails.application.routes.draw do
  post "/sessions" => "sessions#create"

  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/clubs" => "clubs#index"
  post "/clubs" => "clubs#create"
  get "/clubs/:id" => "clubs#show"
  patch "/clubs/:id" => "clubs#update"

  post "/memberships" => "memberships#create"
  delete "/memberships/:id" => "memberships#destroy"
 
  post "/messages" => "messages#create"
  patch "/messages/:id" => "messages#update"
  delete "/messages/:id" => "messages#destroy"

  get "/books" => "books#index"
end
