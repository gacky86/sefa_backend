class ChangeVideoUrlTypeInBookmarkVideos < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookmark_videos, :video_url
    add_column :bookmark_videos, :video_json, :jsonb, default: {}, null: false
  end
end
