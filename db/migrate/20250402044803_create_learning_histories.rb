class CreateLearningHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :learning_histories do |t|
      t.date :learned_date
      t.integer :learned_quantity

      t.timestamps
    end
  end
end
