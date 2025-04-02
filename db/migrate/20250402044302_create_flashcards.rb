class CreateFlashcards < ActiveRecord::Migration[7.1]
  def change
    create_table :flashcards do |t|
      t.string :title
      t.boolean :shared

      t.timestamps
    end
  end
end
