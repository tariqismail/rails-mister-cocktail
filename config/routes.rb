Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Cocktails Routes
  resources :cocktails, only: %i[index show new create] do
    # Nested Doses Routes
    resources :doses, only: %i[new create]
  end
  # Un-nested Doses Routes
  resources :doses, only: :destroy
end
