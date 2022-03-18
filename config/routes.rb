Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "welcome#index"

   resources :users do
    get :toys, on: :member
  end
  resources :sessions

  resources :toys

end
