Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login/create', to: 'login#create'
  get '/login/get', to: 'login#get'
  delete '/login/delete', to: 'login#delete'
  post '/player/create', to: 'player#create'
  get '/player/test', to: 'player#test'
  get '/position/get', to: 'position#get'
  get '/difficulty/get', to: 'difficulty#get'
  get '/config/get', to: 'config#get'
  put '/config/put', to: 'config#put'
  post '/score/create', to: 'score#create'
  get '/score/best_global', to: 'score#best_global'
  get '/score/best_personal', to: 'score#best_personal'
  get '/score/recent_personal', to: 'score#recent_personal'
  get '/score/recent_config', to: 'score#recent_config'
end
