class Api::YoutubeController < ApplicationController
  # protect_from_forgery with: :null_session # API用にCSRF無効化（必要に応じて）
  def search_by_keyword
    print '================'
    print params[:keyword]
    print params[:max_results]
    print '================'
    service = Youtube.new(
      keyword: params[:keyword],
      max_results: params[:max_results]
    )
    result = service.run
    render json: { result: result }
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
