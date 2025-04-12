class AddFlashcardToCards < ActiveRecord::Migration[7.1]
  def change
    add_reference :cards, :flashcard, null: false, foreign_key: true
  end
end
