Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Define routes for Recipes
  resources :recipes do
    resources :foods, only: [:new, :create], controller: 'recipe_foods' # Nested route for adding food to a recipe
    member do
      patch 'toggle_public', to: 'recipes#toggle_public' # Route for toggling recipe public/private status
    end
  end

  # Define routes for Foods
  resources :foods
  # resources :foods, only: [:index, :new, :create, :delete]

end
