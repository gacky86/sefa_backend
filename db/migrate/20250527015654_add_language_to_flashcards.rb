class AddLanguageToFlashcards < ActiveRecord::Migration[7.1]
  def change
    add_column :flashcards, :language, :string
  end
end
