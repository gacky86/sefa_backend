class AddTargetsToFlashcards < ActiveRecord::Migration[7.1]
  def change
    add_column :flashcards, :input_target, :integer
    add_column :flashcards, :output_target, :integer
  end
end
