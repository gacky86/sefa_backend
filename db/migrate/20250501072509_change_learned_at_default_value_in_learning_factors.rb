class ChangeLearnedAtDefaultValueInLearningFactors < ActiveRecord::Migration[7.1]
  def change
    change_column_default :learning_factors, :input_learned_at, -> { 'CURRENT_DATE' }
    change_column_default :learning_factors, :output_learned_at, -> { 'CURRENT_DATE' }
  end
end
