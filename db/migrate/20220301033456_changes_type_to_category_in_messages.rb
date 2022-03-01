class ChangesTypeToCategoryInMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :type, :category
  end
end
