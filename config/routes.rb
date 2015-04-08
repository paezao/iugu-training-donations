Rails.application.routes.draw do
  root 'donation#index'

  post '/', to: 'donation#donate', as: 'donate'
  post '/callback', to: 'donation#callback', as: 'callback'

  get '/thank_you', to: 'donation#thank_you', as: 'thank_you'

  get '/signup', to: 'user#signup'
  post '/signup', to: 'user#register', as: 'user_register'
end
