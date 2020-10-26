 Rails.application.routes.draw do
  resources :contributions do
   member do
      put 'points'
    end
 end
 
  root 'contributions#index'
end
