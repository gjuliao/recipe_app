Rails.application.routes.draw do
  devise_for :users
  root "recipes#public"

  resources :users do
    resources :recipes
    get 'shoping-list', to: 'foods#shoping_list'
    resources :foods do
      resources :recipe_foods
    end
  end
  
  get 'public-recipes', to: 'recipes#public'

end
