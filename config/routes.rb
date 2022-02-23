Rails.application.routes.draw do
  root "lists#index"
  resources :lists do
    resources :tasks, module: "lists" do
      member do
        post 'status'
      end
    end
  end
end
