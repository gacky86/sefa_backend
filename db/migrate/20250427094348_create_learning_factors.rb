class CreateLearningFactors < ActiveRecord::Migration[7.1]
  def change
    create_table :learning_factors do |t|
      t.integer :input_step
      t.float :input_ease_factor
      t.float :input_interval
      t.integer :output_step
      t.float :output_ease_factor
      t.float :output_interval
      t.date :input_learned_at
      t.date :output_learned_at

      t.timestamps
    end
  end
end
