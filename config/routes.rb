Rails.application.routes.draw do
  root 'todos#index'
  resources :todos, only: [:index, :create, :destroy] do
    member do
      post 'complete'
      post 'uncomplete'
      delete 'destroy_completed'
    end
  end
end
