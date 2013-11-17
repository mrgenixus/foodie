class CreateMeal < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.date :day
      t.string :meal
      t.string :chef
      
      t.text :description

      t.timestamps
    end
  end
end
