Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'player/login', to: 'player#login'
  post 'player/register', to: 'player#register'
  get 'player/logout/:id', to: 'player#logout'
  get 'player/current', to: 'player#show'
  put 'player/:id', to: 'player#update'
  put 'player/:id/password', to: 'player#update_password'
  put 'player/:id/image', to: 'player#update_image'
  get 'player/:id/getGame', to: 'player#getGame'
  post 'player/:id/setUno', to: 'player#setUno'

  post 'game', to: 'game#create'
  post 'move', to: 'game#move'

  get 'player/:id/getCard', to: 'card#getCard'
  get 'player/:id/getDeck', to: 'card#getPlayerDeck'
end
