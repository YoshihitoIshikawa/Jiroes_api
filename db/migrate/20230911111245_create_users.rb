class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: false do |t|
      t.string :sub, null: false, primary_key: true
      t.timestamps
    end
  end
end
