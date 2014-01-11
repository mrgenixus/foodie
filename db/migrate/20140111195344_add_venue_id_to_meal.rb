class AddVenueIdToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :venue_id, :integer
  end
end
