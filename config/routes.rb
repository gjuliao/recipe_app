Rails.application.routes.draw do
  root "articles#index"

  resources :users do
    resources :recipes
    resources :foods do
      resources :recipe_foods
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
