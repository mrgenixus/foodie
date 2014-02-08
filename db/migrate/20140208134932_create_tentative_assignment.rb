class CreateTentativeAssignment < ActiveRecord::Migration
  def change
    create_table :tentative_assignments do |t|
      t.string :user_name
      t.string :role
      t.integer :meal_id
      t.boolean :mail_send
      t.boolean :accepted
    end
  end
end
