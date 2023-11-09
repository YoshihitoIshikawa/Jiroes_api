class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :image
      t.text :caption
      t.integer :score
      t.string :sub, null: false
      t.integer :user_id, null: false
      t.references :shop, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :reviews, :users, column: :sub , primary_key: :sub
  end
end
