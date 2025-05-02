class AddCardToLearningFactors < ActiveRecord::Migration[7.1]
  def change
    add_reference :learning_factors, :card, null: false, foreign_key: true
  end
end
