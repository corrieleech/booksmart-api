class ChangesAttributeNameInMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :attribute, :type
  end
end
