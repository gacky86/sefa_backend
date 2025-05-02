Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :test, only: %i[index]
      resources :flashcards do
        resources :cards do
          member do
            patch :update_learning_factor
          end
          resources :learning_factors
        end
      end

      get '/flashcards/:id/card_to_learn', to: 'flashcards#fetch_card_to_learn'

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end
  end
end
