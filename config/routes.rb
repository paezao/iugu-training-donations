Rails.application.routes.draw do
  root 'home#index'

  get '/donate', to: 'donation#index', as: 'donation'

  post '/donate', to: 'donation#donate', as: 'donate'
  post '/callback', to: 'donation#callback', as: 'callback'

  get '/thank_you', to: 'donation#thank_you', as: 'thank_you'

  get '/signup', to: 'user#signup'
  post '/signup', to: 'user#register', as: 'user_register'

  get '/login', to: 'user#login_form', as: 'login'
  post '/login', to: 'user#new_session', as: 'new_session'

  get '/logout', to: 'user#do_logout', as: 'logout'
end
