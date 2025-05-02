class ChangeIntervalTypesInLearningFactors < ActiveRecord::Migration[7.1]
  def change
    change_column :learning_factors, :input_interval, :integer
    change_column :learning_factors, :output_interval, :integer
  end
end
