class CreateReceipe < ActiveRecord::Migration
  def change
    create_table :receipes do |t|
      t.string :name
    end
  end
end
