 Rails.application.routes.draw do
  resources :contributions do
   member do
      put 'points'
    end
 end
  get 'contributions_NewIndex', to: 'contributions#indexNew'
  root 'contributions#index'
end
