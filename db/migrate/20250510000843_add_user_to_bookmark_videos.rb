class AddUserToBookmarkVideos < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookmark_videos, :user, null: false, foreign_key: true
  end
end
