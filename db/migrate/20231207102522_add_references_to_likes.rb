class AddReferencesToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :shop, null: false, foreign_key: true
  end
end
