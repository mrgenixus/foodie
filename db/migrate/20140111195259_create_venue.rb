class CreateVenue < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :address
    end
  end
end
