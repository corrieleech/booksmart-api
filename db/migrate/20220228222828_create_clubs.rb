class CreateClubs < ActiveRecord::Migration[7.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :work_id
      t.integer :isbn
      t.boolean :is_active

      t.timestamps
    end
  end
end
