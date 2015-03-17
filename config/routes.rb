Rails.application.routes.draw do
  root 'donation#index'

  post '/', to: 'donation#donate', as: 'donate'

  get '/thank_you', to: 'donation#thank_you', as: 'thank_you'
end
