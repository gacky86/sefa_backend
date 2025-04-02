class CreateBookmarkVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmark_videos do |t|
      t.string :video_url

      t.timestamps
    end
  end
end
