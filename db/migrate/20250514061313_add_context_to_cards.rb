class AddContextToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :context, :string
  end
end
