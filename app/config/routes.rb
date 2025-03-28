Rails.application.routes.draw do
  namespace :api do
    resources :books do
      member do
        # TODO: Implement this endpoint
        # post 'reserve'
      end
    end
  end
end
