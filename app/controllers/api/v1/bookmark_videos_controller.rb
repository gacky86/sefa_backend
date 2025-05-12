class Api::V1::BookmarkVideosController < ApplicationController
  def index
    bookmark_videos = current_api_v1_user.bookmark_videos
    render json: bookmark_videos
  end

  def create
    bookmark_video = BookmarkVideo.new(bookmark_video_params)
    bookmark_video.user = current_api_v1_user
    if bookmark_video.save
      render json: bookmark_video, status: :ok
    else
      render json: { errors: bookmark_video.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    bookmark_video = BookmarkVideo.find(params[:id])
    bookmark_video.destroy
    render json: { message: 'This bookmark was successfuly deleted!' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'bookmark was not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.errors }, status: :unprocessable_entity
  end

  private

  def bookmark_video_params
    params.require(:bookmark_video).permit(
      video_json: [
        :etag,
        :kind,
        { id: %i[kind video_id] },
        {
          snippet: [
            :channel_id,
            :channel_title,
            :description,
            :live_broadcast_content,
            :published_at,
            :title,
            {
              thumbnails: [
                {
                  default: %i[url width height],
                  medium: %i[url width height],
                  high: %i[url width height]
                }
              ]
            }
          ]
        }
      ]
    )
  end
end
