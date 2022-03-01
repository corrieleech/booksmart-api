Rails.application.routes.draw do
  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/clubs" => "clubs#index"
  post "/clubs" => "clubs#create"
  get "/clubs/:id" => "clubs#show"
  patch "/clubs/:id" => "clubs#update"

  post "/sessions" => "sessions#create"
 
end
