Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/reset' => 'main#reset'
  post '/event' => 'account#event'
  get '/balance' => 'account#balance'
end
