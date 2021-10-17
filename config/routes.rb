Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/player/create', to: 'player#create'
  post '/login/create', to: 'login#create'
  get '/player/test', to: 'player#test'
  get '/position/get', to: 'position#get'
end
