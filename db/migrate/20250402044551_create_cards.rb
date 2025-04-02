class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.integer :input_proficiency
      t.integer :output_proficiency
      t.string :english
      t.string :japanese
      t.string :source_video_url
      t.date :reviewed_date
      t.string :source_video_timestamp

      t.timestamps
    end
  end
end
