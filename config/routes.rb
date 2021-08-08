Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'homes#index'
  resources :contacts, only: %i[index create]
end
