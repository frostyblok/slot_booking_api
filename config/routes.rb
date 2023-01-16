Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :schedules, only: :create do
    get :list_time_slots, on: :collection
  end
end
