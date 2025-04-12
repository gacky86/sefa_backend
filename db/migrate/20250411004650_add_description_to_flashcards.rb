class AddDescriptionToFlashcards < ActiveRecord::Migration[7.1]
  def change
    add_column :flashcards, :description, :string
  end
end
