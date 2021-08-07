Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'homes#index'
  resources :contacts, only: %i[index create]
end
