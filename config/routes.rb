Rails.application.routes.draw do
  root to: "monthly_items#index"

  resources :monthly_items do
    resources :items
  end
end
