Rails.application.routes.draw do
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :prospect_forms, controller: 'prospects', only: [:index, :show, :new, :create]

  resources :etablissements, only: [:index, :show, :new, :create]
  get 'initiate_database', to: 'etablissements#initiate_database', as: 'initiate_database'

  get 'success', to: 'prospects#success', as: 'success'
  get 'mentions-légales', to: 'pages#mentions_légales', as: 'mentions'
  get 'contact', to: 'pages#contact', as: 'contact'
end
