Rails.application.routes.draw do
  namespace :api do
    post 'gemini/generate_sentence', to: 'gemini#generate_sentence'
    post 'youtube/search_by_keyword', to: 'youtube#search_by_keyword'
    post 'youtube/fetch_channel_thumbnail', to: 'youtube#fetch_channel_thumbnail'
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
      resources :bookmark_videos, only: %i[index create destroy]

      get '/flashcards/:id/card_to_learn', to: 'flashcards#fetch_card_to_learn'
      get '/flashcards/:id/count_todays_cards', to: 'flashcards#fetch_count_todays_cards'
      get '/flashcards/:id/flashcard_proficiency', to: 'flashcards#fetch_flashcard_proficiency'
      get '/flashcards/:flashcard_id/cards/:id/fetch_review_interval', to: 'cards#fetch_review_interval'

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end
  end
end
