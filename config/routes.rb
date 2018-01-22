Rails.application.routes.draw do
  get 'landing/main'

  root 'landing#main'
end
