class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :club_id
      t.integer :user_id
      t.string :body
      t.string :attribute

      t.timestamps
    end
  end
end
