class ChangeDefaultValuesOnLearningFactor < ActiveRecord::Migration[7.1]
  def change
    change_column_default :learning_factors, :input_step, 0
    change_column_default :learning_factors, :input_ease_factor, 250
    change_column_default :learning_factors, :input_interval, 0
    change_column_default :learning_factors, :output_step, 0
    change_column_default :learning_factors, :output_ease_factor, 250
    change_column_default :learning_factors, :output_interval, 0
  end
end
