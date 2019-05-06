Rails.application.routes.draw do
  get '/' => 'rooms#index'
  get '/rooms' => 'rooms#index'
  get '/rooms/new' => 'rooms#new'
  post '/rooms' => 'rooms#create'
  get '/rooms/:room_code' => 'rooms#show'
  mount ActionCable.server, at: '/cable'
end
