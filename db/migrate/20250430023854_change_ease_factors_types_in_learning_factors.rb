class ChangeEaseFactorsTypesInLearningFactors < ActiveRecord::Migration[7.1]
  def change
    change_column :learning_factors, :input_ease_factor, :integer
    change_column :learning_factors, :output_ease_factor, :integer
  end
end
