class ChangesIsbnToString < ActiveRecord::Migration[7.0]
  def change
    change_column :clubs, :isbn, :string
  end
end
