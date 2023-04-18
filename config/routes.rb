Rails.application.routes.draw do
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
