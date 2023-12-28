class AddSubToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :sub, :string
    add_foreign_key :shops, :users, column: :sub, primary_key: :sub
  end
end
