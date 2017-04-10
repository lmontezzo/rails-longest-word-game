Rails.application.routes.draw do
  get 'plays/game'

  get 'plays/score'

  get 'plays/game2'

  get 'game', to: 'plays#game'
  get 'game2', to: 'plays#game2'
  get 'score', to: 'plays#score'
  post '/score', to: 'plays#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
