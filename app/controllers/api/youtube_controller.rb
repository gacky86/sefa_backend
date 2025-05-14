class Api::YoutubeController < ApplicationController
  # protect_from_forgery with: :null_session # API用にCSRF無効化（必要に応じて）
  def search_by_keyword
    service = Youtube.new(
      keyword: params[:keyword],
      max_results: params[:max_results]
    )
    result = service.search_by_keyword
    render json: { result: result }
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def fetch_channel_thumbnail
    service = Youtube.new(channel_id: params[:channel_id])
    result = service.fetch_channel_info
    render json: { result: result }
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
