class AddDishwasherToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :dishwasher, :string
  end
end
