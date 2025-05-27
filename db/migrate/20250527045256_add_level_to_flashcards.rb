class AddLevelToFlashcards < ActiveRecord::Migration[7.1]
  def change
    add_column :flashcards, :level, :string
  end
end
