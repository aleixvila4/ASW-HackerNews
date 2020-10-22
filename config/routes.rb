 Rails.application.routes.draw do
  resources :usuaris
  root 'usuaris#index'
end
