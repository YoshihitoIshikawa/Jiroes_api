class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.string :sub, null: false
      t.references :review, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :likes, :users, column: :sub , primary_key: :sub
  end
end
