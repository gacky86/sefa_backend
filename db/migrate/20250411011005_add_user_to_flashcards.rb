class AddUserToFlashcards < ActiveRecord::Migration[7.1]
  def change
    add_reference :flashcards, :user, null: false, foreign_key: true
  end
end
