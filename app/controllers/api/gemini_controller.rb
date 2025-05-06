# app/controllers/api/gemini_controller.rb
module Api
  class GeminiController < ApplicationController
    protect_from_forgery with: :null_session # API用にCSRF無効化（必要に応じて）

    def check_boolean
      service = Gemini::Flash::GenerateContent::Boolean.new(
        system_instruction: params[:system_instruction],
        text: params[:text]
      )
      result = service.run
      render json: { result: result }
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
