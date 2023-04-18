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

  # resources: user do
# 	resources: foods
#   get "#{users_foods_path}/shoping-list", to: foods#shoping_list
# 	resources: recipies
	
# end
# get “/public-recipies”, to: “recipies#public”

# root: to 'recipies#public'
end
