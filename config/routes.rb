Rails.application.routes.draw do
  root 'donation#index'

  post '/', to: 'donation#donate', as: 'donate'
end
