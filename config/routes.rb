Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/' => 'articles#home'
      get '/home' => 'articles#home'
      get '/articles' => 'articles#index'
      get '/articles' => 'articles#new'
      post '/articles' => 'articles#create'
      get '/articles/:article_title' => 'articles#lookup'
      get '/articles/user_article/:id' => 'articles#show'
      delete '/articles/:id' => 'articles#destroy'
      get '/contact' => 'articles#contact'

      get '/highlights' => 'highlights#index'
      post '/highlights' => 'highlights#create'
      post '/highlights/extension/:article_title' => 'highlights#api_find_create'
      patch '/highlights/:id' => 'highlights#update'
      delete '/highlights/:id' => 'highlights#destroy'

      get '/signup' => 'users#new'
      post '/users' => 'users#create'
      get '/users/:id' => 'users#show'

      get '/login' => 'sessions#new'
      post '/login' => 'sessions#create'
      get '/logout' => 'sessions#destroy'
    end
  end
end
