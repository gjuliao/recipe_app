Rails.application.routes.draw do
  devise_for :users
  root "recipes#public"

  resources :users do
    resources :recipes do
      resources :recipe_foods
    end
    get 'shoping-list', to: 'foods#shoping_list'
    resources :foods do
    end
  end
  
  get 'public-recipes', to: 'recipes#public'

end
